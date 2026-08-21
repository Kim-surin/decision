package com.kpmg.kdb.web.origindeterminationexecution;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationexecution.CreateFcrService;
import com.kpmg.kdb.web.origindeterminationexecution.dto.BufferRates;
import com.kpmg.kdb.web.origindeterminationexecution.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.origindeterminationexecution.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationexecution.dto.MaterialOriginRowBatchResult;
import com.kpmg.kdb.web.origindeterminationexecution.dto.MaterialOriginRowsRequest;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginCriteria;
import com.kpmg.kdb.web.origindeterminationexecution.ItemNationService;
import com.kpmg.kdb.web.origindeterminationexecution.dto.ItemNationCriteria;
import com.kpmg.kdb.web.origindeterminationexecution.OriginDecider;

/**
 * 레거시 PKG99_COO_DECISION.COO_DECISION / PKG99_COO_CTC_DECISION.COO_DECISION 메인 프로시저 이관.
 *
 * 매출(SALES_NO) 1건에 대해 판정대상 FTA_CODE 후보(C_FCR_MST, FM_LIST)를 순회하고, 각 후보마다
 * 적용 가능한 룰(C_FTA_RULE, FR_LIST)을 순회하며 예외판정/세번변경기준/부가가치기준 서비스를 호출해
 * 최종 원산지 판정결과를 산출한다. FM_LIST 1건 = {@link OriginDeterminationContext} 1개(스레드 안전을 위해
 * 매번 새로 생성 — {@link OriginDeterminationContext} 클래스 주석 참고).
 *
 * RVC_CTC/CTC_ONLY 두 원본 패키지의 COO_DECISION 은 "RVC_CTC 모드에서만 재료비 0원 검사를 수행한다"는
 * 한 가지 차이를 제외하면 완전히 동일한 구조라 이 클래스 하나로 통합했다(그 한 가지 차이는
 * {@link #decideOneRule} 의 재료비 검사 분기에서 mode 로 처리).
 *
 * <p>FTA_CODE='PKRRC'(RCEP) 전용 자재 원산지(COO_NATION) 산정은 {@link ItemNationService}
 * (FC01_GET_ITEM_NATION 이관)로 위임한다({@link #resolveItemCooNationForRcep} 참고).
 */
@Service
public class OriginDeterminationExecutionService extends GeneralService implements OriginDecider {

	/** APTA 신규 PSR 시행 기준일(V_APTA_STD_YYYYMMDD) */
	private static final String APTA_STANDARD_DATE = "20180701";
	/** {@link #prefetchMaterialOriginRows} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private OriginDeterminationSupportService supportService;
	@Autowired
	private ExclusionRuleDecisionService exclusionRuleDecisionService;
	@Autowired
	private CtcCriteriaDecisionService ctcService;
	@Autowired
	private RvcCriteriaDecisionService rvcService;
	@Autowired
	private ItemNationService itemNationService;

	/**
	 * 레거시 COO_DECISION(P_COMPANY_CODE, P_SALES_NO, O_RETURN_CODE) 이관 + 원본에서 CREATE_FCR 안에
	 * 있던 상품(PRODUCT_ASSETS_TYPE IN ('M','R','B')) 원산지 판정(과거 3-5/3-6 단계, {@link
	 * CommodityOriginDeterminationDao} 참고)까지 함께 수행한다 — 판정 관련 로직을 한 곳에 모으기 위해
	 * 이관 시 재구성했다. 원본과 동일하게 최상위에서 모든 예외를 흡수하고 로그만 남긴다(재발생 없음)
	 * — 호출자는 매출 1건 처리 실패가 배치 전체를 중단시키지 않는다는 것을 전제로 사용할 수 있다(상품
	 * 판정 쪽 SQL 오류도 이제 이 예외 흡수 정책을 그대로 따른다 — CREATE_FCR 안에 있을 때는 흡수되지
	 * 않고 호출자까지 전파됐던 것과 달라진 부분이니 유의).
	 *
	 * <p>FCR_MST 에 실제로 존재하는 PRODUCT_ASSETS_TYPE 을 먼저 확인해, 상품(M,R,B) 대상이 없으면
	 * 상품 판정 쿼리 2개를, 제품(P,H) 대상이 없으면 제품 판정 커서 조회 자체를 건너뛴다 — 판정대상이
	 * 한쪽 자산유형뿐인 매출건(대부분)에서 불필요한 조회/쓰기를 없앤다.
	 *
	 * @param productCodes 판정 대상 제품 코드 목록. null/빈 리스트면 salesNo 전체 제품(월 판정),
	 *                      값이 있으면 그 제품들만(개별 판정) 대상으로 한다. {@link CreateFcrService}
	 *                      호출 시 넘긴 것과 같은 값을 넘겨야 같은 스코프의 FCR_MST 를 판정한다.
	 */
	@Override
	public void determineOrigin(String companyCode, String divisionCode, String salesNo, OriginDeterminationMode mode,
			List<String> productCodes) {
		try {
			OriginDeterminationCursorDao dao = sqlSession.getMapper(OriginDeterminationCursorDao.class);

			List<String> assetTypes = dao.selectDistinctProductAssetsTypes(companyCode, divisionCode, salesNo,
					productCodes);
			boolean hasCommodity = containsAny(assetTypes, "M", "R", "B");
			boolean hasProduct = containsAny(assetTypes, "P", "H");

			String invoiceDate = dao.selectInvoiceDate(companyCode, salesNo);

			if (hasCommodity) {
				decideCommodityOrigin(companyCode, divisionCode, salesNo, invoiceDate, productCodes, mode);
			}

			if (hasProduct) {
				String newAptaPsrFlag = invoiceDate != null && invoiceDate.compareTo(APTA_STANDARD_DATE) < 0 ? "0" : "1";
				List<OriginDeterminationTarget> fmListRows = dao.selectOriginDeterminationTargets(companyCode, salesNo,
						productCodes);
				ExclusionRuleCache exclusionRuleCache = new ExclusionRuleCache(
						sqlSession.getMapper(ExclusionRuleDao.class));
				// 같은 (hsCode,ftaCode,hsCodeSubCategory) 조합이 FM_LIST 행마다(제품 × FTA 후보 ~25개) 반복되므로
				// FTA_RULE 조회를 이 호출 시작 시점에 한 번의 배치 쿼리로 전부 가져온다(OriginCriteriaCache 참고).
				OriginCriteriaCache originCriteriaCache = OriginCriteriaCache.prefetch(dao, fmListRows, newAptaPsrFlag);
				// GET_BUFFER 의 PRD(제품군) 소스는 ITEM_MST 를 조인해 품목 수만큼 고카디널리티라 전역
				// 캐싱은 부적합하지만, 같은 제품이 FTA 후보 수만큼 반복되므로 이 호출 범위에서만 메모이즈한다.
				Map<String, BufferRates> productLineBufferCache = new HashMap<>();
				// FCR_INFO_TEMP 대체 조회(selectMaterialOriginRows)도 FM_LIST 행마다 반복 호출되던 것을
				// 루프 시작 전에 한 번의 배치 쿼리로 전부 가져온다(prefetchMaterialOriginRows 참고).
				Map<String, List<MaterialOriginRow>> materialOriginRowsCache = prefetchMaterialOriginRows(dao,
						companyCode, salesNo, fmListRows);
				// RCEP(FTA_CODE='PKRRC') COO_NATION 산정 캐시도 FM_LIST 행마다(PKRRC 후보 수만큼) 새로
				// 만들지 않고 이 호출 범위 전체에서 공유한다(prepareRcepCooNationCache 참고).
				RcepCooNationCache rcepCache = prepareRcepCooNationCache(fmListRows, materialOriginRowsCache, invoiceDate);

				// FM_LIST 행마다 즉시 실행하던 FCR_RESULT INSERT/UPDATE_FRM 재조회/FCR_MST 최종결과 UPDATE
				// 를 모두 모았다가 루프가 끝난 뒤 한 번씩 배치로 반영한다(OriginDeterminationSupportService
				// #flushPendingResultsBatch/#resolveDeferredUpdateFrm/#flushFcrMstUpdates 참고).
				DeterminationRunContext runContext = new DeterminationRunContext(invoiceDate, newAptaPsrFlag, mode,
						exclusionRuleCache, originCriteriaCache, productLineBufferCache, materialOriginRowsCache,
						rcepCache);
				PendingBatch pending = new PendingBatch();
				for (OriginDeterminationTarget fmData : fmListRows) {
					decideOneFtaLine(dao, fmData, runContext, pending);
				}
				supportService.flushPendingResultsBatch(pending.results);
				supportService.resolveDeferredUpdateFrm(pending.deferredUpdateFrmTargets, pending.fcrMstUpdateBatch);
				supportService.flushFcrMstUpdates(pending.fcrMstUpdateBatch);
			}
		} catch (Exception e) {
			logger.error("COO_DECISION 실패. companyCode={}, salesNo={}", companyCode, salesNo, e);
		}
	}

	private static boolean containsAny(List<String> assetTypes, String... candidates) {
		for (String candidate : candidates) {
			if (assetTypes.contains(candidate)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 상품(M,R,B) 원산지 판정. 제품(P,H)과 달리 FTA_CODE 후보/룰을 하나씩 순회하는 대신, 구매처
	 * 원산지확인서·FTA_RULE 조회 결과를 FCR_MST 에 반영한 뒤 그 결과를 FCR_RESULT 에 그대로 기록하는
	 * 집합 연산 2단계로 끝난다({@link CommodityOriginDeterminationDao} 클래스 주석 참고).
	 */
	private void decideCommodityOrigin(String companyCode, String divisionCode, String salesNo, String invoiceDate,
			List<String> productCodes, OriginDeterminationMode mode) {
		CommodityOriginDeterminationDao dao = sqlSession.getMapper(CommodityOriginDeterminationDao.class);
		dao.mergeFcrMstOriginDetermination(salesNo, divisionCode, companyCode, invoiceDate, productCodes);
		dao.insertFcrResultForProducts(salesNo, divisionCode, companyCode, productCodes, mode.getProcedureName());
	}

	private void decideOneFtaLine(OriginDeterminationCursorDao dao, OriginDeterminationTarget fmData,
			DeterminationRunContext runContext, PendingBatch pending) {
		OriginDeterminationContext ctx = new OriginDeterminationContext();
		ctx.setFmData(fmData);

		supportService.loadBuffer(ctx, fmData.getCompanyCode(), fmData.getDivisionCode(), fmData.getFtaCode(),
				fmData.getProductCode(), runContext.productLineBufferCache);

		// 원본에는 "기판정된 결과가 있는 경우 삭제"가 FM_LIST 1건당 1회(FTA_CODE 후보 수만큼) 있었으나,
		// determineOrigin() 은 항상 CreateFcrService.createFcr() 직후에 호출되고 그 안에서 이미
		// FTA_CODE 무관하게 이 salesNo/스코프의 FCR_RESULT 를 통째로 지운다(CreateFcrDao.deleteFcrResult).
		// FCR_RESULT 는 이 메서드(및 상품판정)만 기록하므로 같은 determineOrigin() 호출 안에서는
		// FM_LIST 행별 삭제가 지울 대상이 이미 없다 — 완전히 중복된 반복 쿼리라 제거했다.

		// FCR_INFO_TEMP 대체: prefetchMaterialOriginRows 로 미리 배치 조회해둔 결과를 재사용한다. 캐시에
		// 없는 조합(배치 실패 등)은 그 자리에서 바로 단건 조회로 대체한다.
		String materialKey = materialOriginRowsKey(fmData.getFtaCode(), fmData.getDivisionCode(), fmData.getSalesSeq());
		List<MaterialOriginRow> materialOriginRows = runContext.materialOriginRowsCache.containsKey(materialKey)
				? runContext.materialOriginRowsCache.get(materialKey)
				: dao.selectMaterialOriginRows(fmData.getFtaCode(), fmData.getDivisionCode(), fmData.getCompanyCode(),
						fmData.getSalesNo(), fmData.getSalesSeq(), fmData.getHsCode());
		ctx.setMaterialOriginRows(materialOriginRows);

		if ("PKRRC".equals(fmData.getFtaCode())) {
			resolveItemCooNationForRcep(ctx, runContext.invoiceDate, runContext.rcepCache);
		}

		List<OriginCriteria> rules = runContext.originCriteriaCache.get(fmData.getHsCode(), fmData.getFtaCode(),
				fmData.getHsCodeSubCategory(), runContext.newAptaPsrFlag);

		if (rules.isEmpty()) {
			// 원본 V_RULE_CNT=100 분기: 해당 HS코드에 적용가능한 FTA_RULE 이 전혀 없는 경우
			insertNoRuleFoundResult(ctx, fmData, runContext.mode);
		} else {
			for (OriginCriteria frData : rules) {
				decideOneRule(ctx, fmData, frData, runContext.mode, runContext.exclusionRuleCache);
			}
		}

		// 이 FM_LIST 행(FTA 후보) 처리 중 쌓인 판정결과를 determineOrigin() 전체 배치 목록으로 옮겨 담는다
		// — 더 이상 행 단위로 즉시 flush 하지 않고, 루프 전체가 끝난 뒤 한 번에 저장한다
		// (OriginDeterminationSupportService#flushPendingResultsBatch 참고).
		pending.results.addAll(ctx.getPendingResults());

		// 원본 VG_RULE_COUNT: C_FTA_RULE 루프는 룰이 없어도 phantom 1회가 실행되어 항상 1 로 설정된다.
		// UPDATE_FRM_PROCEDURE 의 "룰 없음(ruleCount<1)" 분기는 이 경로로는 사실상 도달하지 않는
		// 원본 동작을 그대로 재현한다.
		ctx.setRuleCount(1);
		supportService.prepareUpdateFrm(ctx, runContext.mode, pending.fcrMstUpdateBatch, pending.deferredUpdateFrmTargets);
	}

	private void insertNoRuleFoundResult(OriginDeterminationContext ctx, OriginDeterminationTarget fmData, OriginDeterminationMode mode) {
		OriginDeterminationResult rec = ctx.getFrdRec();
		rec.setSalesNo(fmData.getSalesNo());
		rec.setSalesSeq(fmData.getSalesSeq());
		rec.setFtaCode(fmData.getFtaCode());
		rec.setDivisionCode(fmData.getDivisionCode());
		rec.setCompanyCode(fmData.getCompanyCode());
		rec.setProductCode(fmData.getProductCode());
		rec.setHsCode(fmData.getHsCode());
		rec.setStandard(fmData.getStandard());
		rec.setStatus("E");
		rec.setCompanyCooYn("N");
		rec.setFtaCooYn("N");
		rec.setErrorCode("MSG_DECISION_STANDARD_NOT_EXIST");
		rec.setErrorMsg("판정기준이 미 존재 합니다.");
		supportService.insertFrdAndReset(ctx, mode);
	}

	private void decideOneRule(OriginDeterminationContext ctx, OriginDeterminationTarget fmData, OriginCriteria frData, OriginDeterminationMode mode,
			ExclusionRuleCache exclusionRuleCache) {
		OriginDeterminationResult rec = ctx.getFrdRec();
		rec.setSalesNo(fmData.getSalesNo());
		rec.setSalesSeq(fmData.getSalesSeq());
		rec.setFtaCode(fmData.getFtaCode());
		rec.setRuleSeq(frData.getRuleId());
		rec.setDivisionCode(fmData.getDivisionCode());
		rec.setCompanyCode(fmData.getCompanyCode());
		rec.setRuleCode(frData.getRuleContents());
		rec.setProductCode(fmData.getProductCode());
		rec.setHsCode(fmData.getHsCode());
		rec.setStandard(fmData.getStandard());
		rec.setStatus("N");

		// RVC_CTC 모드에서만 재료비(역내+역외) 금액이 0인 경우를 오류로 처리한다. CTC_ONLY 모드는
		// 원본에서 이 검사 블록 전체가 주석 처리되어 있어(값기준 계산 불가) 항상 통과시킨다.
		if (mode == OriginDeterminationMode.RVC_CTC && fmData.hasNoMaterialAmount()) {
			rec.setCompanyCooYn("N");
			rec.setFtaCooYn("N");
			rec.setStatus("E");
			rec.setErrorCode("MSG_FAILED_DECISION_QTY_AMOUNT");
			rec.setErrorMsg("소요량 또는 금액이 0 인 것이 존재합니다.");
			supportService.insertFrdAndReset(ctx, mode);
			return;
		}

		ctx.setNetWeight(fmData.getWeight());
		ctx.setNetCostAmount(fmData.getNetCostAmount());
		ctx.setInkotermsAmount(
				"EXW".equals(fmData.getInkotermsType()) ? fmData.getExworkAmount() : fmData.getFobAmount());
		ctx.setDeMinimisInkotermsAmount(
				"EXW".equals(fmData.getDeMinimisInkotermsType()) ? fmData.getExworkAmount() : fmData.getFobAmount());

		if ("SP".equals(frData.getSpRule())) {
			rec.setSpCooYn(fmData.getSpCooYn());
		}
		if ("WO".equals(frData.getWoRule())) {
			rec.setWoCooYn(fmData.getWoCooYn());
		}

		boolean stop = false;

		if ("Y".equals(frData.getExclusionRuleYn())) {
			exclusionRuleDecisionService.decide(ctx, frData, mode, exclusionRuleCache);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && !"*".equals(frData.getCthRule())) {
			ctcService.decide(ctx, frData, mode);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && (positive(frData.getBdRule()) || positive(frData.getBuRule()) || positive(frData.getNcRule())
				|| positive(frData.getMcRule()))) {
			rvcService.decide(ctx, frData, mode);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop) {
			combineFinalResult(ctx, fmData, frData);
			supportService.insertFrdAndReset(ctx, mode);
		}

		if ("Y".equals(frData.getExclusionRuleYn())) {
			// 다음 룰(다른 협정의 예외판정)에 이번 결과가 이어붙지 않도록 초기화한다(원본: 매 룰 처리 후
			// FCR_INFO_TEMP.EXCLUSION_RULE1~14_YN 을 'N' 으로 리셋하는 UPDATE). 메모리 상의 리스트를
			// 직접 되돌리므로 DB 호출이 필요 없다.
			for (MaterialOriginRow row : ctx.getMaterialOriginRows()) {
				for (int i = 1; i <= 14; i++) {
					row.setExclusionRule(i, false);
				}
			}
		}
	}

	/** 레거시 COO_DECISION 메인루프 "룰 ID에 대한 최종 판정" 블록 이관 */
	private void combineFinalResult(OriginDeterminationContext ctx, OriginDeterminationTarget fmData, OriginCriteria frData) {
		OriginDeterminationResult rec = ctx.getFrdRec();
		boolean loopFlag = false;

		if ("Y".equals(frData.getExclusionRuleYn())) {
			if ("N".equals(rec.getExclusionYn()) && "AND".equals(rec.getExclusionCondition())) {
				rec.setFtaCooYn("N");
				rec.setCompanyCooYn("N");
				loopFlag = true;
			} else if ("Y".equals(rec.getExclusionYn()) && "E16".equals(rec.getExclusionCondition())) {
				rec.setFtaCooYn("Y");
				rec.setCompanyCooYn("Y");
				rec.setExclusionCondition("AND");
				loopFlag = true;
			} else if ("N".equals(rec.getExclusionYn()) && "E16".equals(rec.getExclusionCondition())) {
				rec.setFtaCooYn("N");
				rec.setCompanyCooYn("N");
				rec.setExclusionCondition("AND");
				loopFlag = true;
			}
		}

		if (loopFlag) {
			return;
		}

		if ("-".equals(rec.getRuleCode())) {
			// 기본룰 없이 예외룰만 존재하는 경우: 예외판정 결과로만 처리한다(양허제외 HS코드로 인한 제외는
			// 무조건 역외처리, 2016.12.12 추가)
			if ("Y".equals(rec.getExclusionYn())) {
				rec.setFtaCooYn(rec.getExclusionYn());
				rec.setCompanyCooYn(rec.getExclusionYn());
			} else {
				rec.setFtaCooYn("N");
				rec.setCompanyCooYn("N");
			}
		} else {
			boolean ftaOk = ynOrDefaultY(rec.getSpCooYn()) && ynOrDefaultY(rec.getWoCooYn())
					&& (ynOrDefaultY(rec.getCtcYn()) || "Y".equals(rec.getFtaDeMinimisYn()))
					&& ynOrDefaultY(rec.getFtaRvcYn());
			if (ftaOk) {
				rec.setFtaCooYn("Y");
				boolean companyOk = ynOrDefaultY(rec.getCompanyDeMinimisYn()) && ynOrDefaultY(rec.getCompanyRvcYn());
				rec.setCompanyCooYn(companyOk ? "Y" : "N");
			} else {
				rec.setFtaCooYn("N");
				rec.setCompanyCooYn("N");
			}
		}

		if ("PKRRC".equals(fmData.getFtaCode())) {
			applyRcepDetermination(ctx, fmData);
		}
	}

	/** 레거시 COO_DECISION 메인루프의 RCEP(FTA_CODE='PKRRC') 최대기여국 산정 블록 이관 */
	private void applyRcepDetermination(OriginDeterminationContext ctx, OriginDeterminationTarget fmData) {
		OriginDeterminationResult rec = ctx.getFrdRec();
		String rcepNation = supportService.resolveRcepNation(ctx);

		if ("KR".equals(rcepNation)) {
			rec.setRcepCooNation("KR");
		} else if ("RCEP".equals(rcepNation)) {
			if ("Y".equals(fmData.getTariffYn())) {
				supportService.resolveRcepRvcNation(ctx, fmData.getAmount());
				rec.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : ctx.getRcepCooNation());
			} else {
				String mpItemYn = supportService.getMinimalProcessItemYn(ctx, fmData.getCompanyCode(),
						fmData.getDivisionCode(), fmData.getSalesNo(), fmData.getSalesSeq());
				if ("N".equals(mpItemYn)) {
					rec.setRcepCooNation("KR");
				} else {
					supportService.resolveRcepRvcNation(ctx, fmData.getAmount());
					rec.setRcepCooNation(ctx.getRcepCooNation());
				}
			}
		} else if ("Y".equals(fmData.getTariffYn()) && "Y".equals(rec.getCompanyCooYn()) && "ZZ".equals(rcepNation)) {
			// 원본 그대로 이관: 바깥 ELSIF 조건에 이미 TARIFF_YN='Y' 가 포함돼 있어 안쪽 ELSE 는
			// 실질적으로 도달 불가능한 원본의 중복 조건이다(보존).
			if ("Y".equals(fmData.getTariffYn())) {
				supportService.resolveRcepRvcNation(ctx, fmData.getAmount());
				rec.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : ctx.getRcepCooNation());
			} else {
				rec.setRcepCooNation("KR");
			}
		}
	}

	/**
	 * 레거시 "IF FM_LIST.FTA_CODE = 'PKRRC' THEN UPDATE FCR_INFO_TEMP SET COO_NATION = FC01_GET_ITEM_NATION(...)
	 * WHERE ... INAREA_AMOUNT &gt; 0" 이관. {@link ItemNationService} 호출은 자재 1건당 SQL 여러 번을
	 * 유발할 수 있어(구매원장/원산지확인서 조회), 같은 (회사/사업부/품목/HS코드) 조합의 중복 호출을
	 * {@code rcepCache} 로 제거한다 — {@link #prepareRcepCooNationCache} 가 만든 캐시를 determineOrigin()
	 * 1회 호출의 모든 PKRRC 후보 FM_LIST 행이 공유한다(FM_LIST 행마다 새로 만들지 않음).
	 */
	private void resolveItemCooNationForRcep(OriginDeterminationContext ctx, String invoiceDate, RcepCooNationCache rcepCache) {
		for (MaterialOriginRow row : ctx.getMaterialOriginRows()) {
			if (row.getOriginatingAmount() != null && row.getOriginatingAmount().signum() > 0) {
				String key = itemNationKey(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(), row.getHsCode());
				// prepareRcepCooNationCache 가 이미 채워뒀을 것이므로 보통은 그대로 조회되지만,
				// materialOriginRowsCache 가 배치 실패 등으로 이 자재를 못 봤던 경우를 대비해
				// computeIfAbsent 로 그 자리에서 새로 만드는 방어적 폴백을 겸한다.
				ItemNationCriteria criteria = rcepCache.distinctCriteria.computeIfAbsent(key,
						k -> new ItemNationCriteria(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(),
								row.getFtaCode(), row.getHsCode(), invoiceDate));
				// cooNationBatchCache 는 prepareRcepCooNationCache 가 선조회해둔 배치 결과라, null 도
				// "조회 완료, 결과 없음"이라는 유효한 값이다(containsKey 로 확인 — computeIfAbsent 는
				// null 저장이 안 돼 캐시 히트를 매번 놓치므로 쓸 수 없다). 배치 사전조회가 이 조합을
				// 못 봤을 때만(배치 실패 등) 단건 조회로 대체한다.
				String cooNation;
				if (rcepCache.cooNationBatchCache.containsKey(key)) {
					cooNation = rcepCache.cooNationBatchCache.get(key);
				} else {
					cooNation = rcepCache.cooNationCache.computeIfAbsent(key,
							k -> itemNationService.resolveItemNation(criteria, rcepCache.lastInputYyyyMmCache));
				}
				row.setCooNation(cooNation);
			}
		}
	}

	/**
	 * {@link #resolveItemCooNationForRcep} 가 FM_LIST 행(PKRRC 후보)마다 새로 로컬 캐시를 만들어 같은
	 * 자재를 반복 조회하던 것을, determineOrigin() 1회 호출 범위에서 공유하는 캐시로 끌어올린다.
	 * {@link #prefetchMaterialOriginRows} 로 이미 배치 조회해둔 materialOriginRowsCache 를 그대로 써서
	 * PKRRC 후보 FM_LIST 행 전체에 걸친 distinct 자재 조합을 먼저 모으고, selectLastInputYyyyMm 배치
	 * 조회를 한 번만 수행한다.
	 */
	private RcepCooNationCache prepareRcepCooNationCache(List<OriginDeterminationTarget> fmListRows,
			Map<String, List<MaterialOriginRow>> materialOriginRowsCache, String invoiceDate) {
		Map<String, ItemNationCriteria> distinctCriteria = new HashMap<>();
		for (OriginDeterminationTarget fmData : fmListRows) {
			if (!"PKRRC".equals(fmData.getFtaCode())) {
				continue;
			}
			String materialKey = materialOriginRowsKey(fmData.getFtaCode(), fmData.getDivisionCode(), fmData.getSalesSeq());
			for (MaterialOriginRow row : materialOriginRowsCache.getOrDefault(materialKey, List.of())) {
				if (row.getOriginatingAmount() != null && row.getOriginatingAmount().signum() > 0) {
					String key = itemNationKey(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(), row.getHsCode());
					distinctCriteria.putIfAbsent(key, new ItemNationCriteria(row.getCompanyCode(), row.getDivisionCode(),
							row.getItemCode(), row.getFtaCode(), row.getHsCode(), invoiceDate));
				}
			}
		}

		// resolveItemNation 내부에서 자재 건별로 반복되던 selectLastInputYyyyMm 을 determineOrigin() 1회
		// 호출 범위 전체(PKRRC 후보가 여러 FM_LIST 행에 걸쳐 있어도)에서 한 번만 배치 조회해둔다. 목록이
		// 비어있으면 prefetchLastInputYyyyMm 이 그 자리에서 빈 Map 을 돌려주므로 별도 분기가 필요 없다.
		Map<String, String> lastInputYyyyMmCache = itemNationService
				.prefetchLastInputYyyyMm(new ArrayList<>(distinctCriteria.values()));
		// resolveItemNation 이 조합마다 개별 호출하던 selectMaterialCandidates+selectCooNation(최대 2회
		// 왕복)도 여기서 determineOrigin() 1회 호출 범위 전체를 한 번에 배치 선조회한다 —
		// ItemNationService#prefetchCooNations 참고.
		Map<String, String> cooNationBatchCache = itemNationService.prefetchCooNations(
				new ArrayList<>(distinctCriteria.values()), lastInputYyyyMmCache);
		return new RcepCooNationCache(distinctCriteria, lastInputYyyyMmCache, cooNationBatchCache);
	}

	/**
	 * {@link OriginDeterminationCursorDao#selectMaterialOriginRows}(FCR_INFO_TEMP 대체)가 FM_LIST 행마다
	 * 반복 호출되던 것을 배치 조회 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #decideOneFtaLine} 에서
	 * (ftaCode,divisionCode,salesSeq) 키로 조회해 재사용한다. 매칭되는 자재가 하나도 없는 FM_LIST 행도
	 * 빈 리스트로 명시적으로 캐싱해 "조회 완료, 결과 없음"과 "아직 조회 안 함"을 구분한다.
	 */
	private Map<String, List<MaterialOriginRow>> prefetchMaterialOriginRows(OriginDeterminationCursorDao dao,
			String companyCode, String salesNo, List<OriginDeterminationTarget> fmListRows) {
		if (fmListRows.isEmpty()) {
			return Map.of();
		}

		List<MaterialOriginRowsRequest> requests = new ArrayList<>(fmListRows.size());
		for (OriginDeterminationTarget fmData : fmListRows) {
			requests.add(new MaterialOriginRowsRequest(fmData.getFtaCode(), fmData.getDivisionCode(),
					fmData.getSalesSeq(), fmData.getHsCode()));
		}

		try {
			Map<String, List<MaterialOriginRow>> cache = new HashMap<>();
			for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
				List<MaterialOriginRowsRequest> chunk = requests.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
				List<MaterialOriginRowBatchResult> results = dao.selectMaterialOriginRowsBatch(companyCode, salesNo, chunk);
				for (MaterialOriginRowBatchResult r : results) {
					String key = materialOriginRowsKey(r.getReqFtaCode(), r.getReqDivisionCode(), r.getReqSalesSeq());
					cache.computeIfAbsent(key, k -> new ArrayList<>()).add(r.toMaterialOriginRow());
				}
				for (MaterialOriginRowsRequest requested : chunk) {
					String key = materialOriginRowsKey(requested.getFtaCode(), requested.getDivisionCode(),
							requested.getSalesSeq());
					cache.putIfAbsent(key, List.of());
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// decideOneFtaLine 이 그 자리에서 단건 조회로 대체한다.
			logger.error("FCR_INFO_TEMP(자재) 배치조회 실패. companyCode={}, salesNo={}, count={}", companyCode, salesNo,
					requests.size(), e);
			return Map.of();
		}
	}

	private static String materialOriginRowsKey(String ftaCode, String divisionCode, int salesSeq) {
		return String.join("|", nz(ftaCode), nz(divisionCode), String.valueOf(salesSeq));
	}

	private static String itemNationKey(String companyCode, String divisionCode, String itemCode, String hsCode) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(hsCode));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}

	/**
	 * {@link #prepareRcepCooNationCache} 가 만들어 determineOrigin() 1회 호출의 모든 PKRRC 후보 FM_LIST
	 * 행이 공유하는 캐시 묶음. distinctCriteria/lastInputYyyyMmCache 는 사전 준비 단계에서 한 번만
	 * 채워지고(cooNationCache 만 실제 조회 시점에 점진적으로 채워짐), FM_LIST 행마다 새로 만들지 않는다.
	 */
	private static final class RcepCooNationCache {
		final Map<String, ItemNationCriteria> distinctCriteria;
		final Map<String, String> lastInputYyyyMmCache;
		/** {@link #prepareRcepCooNationCache} 가 선조회해둔 배치 결과(정적, 조회 이후 변경 없음). */
		final Map<String, String> cooNationBatchCache;
		/** 배치 사전조회가 못 본 조합을 위한 단건 폴백 결과 캐시(동적, resolveItemCooNationForRcep 가 채움). */
		final Map<String, String> cooNationCache = new HashMap<>();

		RcepCooNationCache(Map<String, ItemNationCriteria> distinctCriteria, Map<String, String> lastInputYyyyMmCache,
				Map<String, String> cooNationBatchCache) {
			this.distinctCriteria = distinctCriteria;
			this.lastInputYyyyMmCache = lastInputYyyyMmCache;
			this.cooNationBatchCache = cooNationBatchCache;
		}
	}

	/**
	 * determineOrigin() 1회 호출 동안 FM_LIST 행(FTA 후보)마다 {@link #decideOneFtaLine} 에 반복해서
	 * 넘기던 컨텍스트를 한 데 묶었다(묶기 전엔 파라미터가 13개였다) — 전부 이 호출 범위에서 한 번만
	 * 만들어지는 읽기 전용 값/캐시라 필드로 노출해도 안전하다.
	 */
	private static final class DeterminationRunContext {
		final String invoiceDate;
		final String newAptaPsrFlag;
		final OriginDeterminationMode mode;
		final ExclusionRuleCache exclusionRuleCache;
		final OriginCriteriaCache originCriteriaCache;
		final Map<String, BufferRates> productLineBufferCache;
		final Map<String, List<MaterialOriginRow>> materialOriginRowsCache;
		final RcepCooNationCache rcepCache;

		DeterminationRunContext(String invoiceDate, String newAptaPsrFlag, OriginDeterminationMode mode,
				ExclusionRuleCache exclusionRuleCache, OriginCriteriaCache originCriteriaCache,
				Map<String, BufferRates> productLineBufferCache,
				Map<String, List<MaterialOriginRow>> materialOriginRowsCache, RcepCooNationCache rcepCache) {
			this.invoiceDate = invoiceDate;
			this.newAptaPsrFlag = newAptaPsrFlag;
			this.mode = mode;
			this.exclusionRuleCache = exclusionRuleCache;
			this.originCriteriaCache = originCriteriaCache;
			this.productLineBufferCache = productLineBufferCache;
			this.materialOriginRowsCache = materialOriginRowsCache;
			this.rcepCache = rcepCache;
		}
	}

	/** {@link #decideOneFtaLine} 이 FM_LIST 행마다 쌓는 배치 결과 3종(판정결과/재조회대상/FCR_MST 갱신행)을 묶었다. */
	private static final class PendingBatch {
		final List<OriginDeterminationResult> results = new ArrayList<>();
		final List<OriginDeterminationTarget> deferredUpdateFrmTargets = new ArrayList<>();
		final List<FcrMstDecisionUpdateRow> fcrMstUpdateBatch = new ArrayList<>();
	}

	private static boolean ynOrDefaultY(String value) {
		return value == null || "Y".equals(value);
	}

	private static boolean positive(BigDecimal value) {
		return value != null && value.signum() > 0;
	}
}
