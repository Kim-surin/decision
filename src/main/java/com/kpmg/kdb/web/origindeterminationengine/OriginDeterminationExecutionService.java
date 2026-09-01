package com.kpmg.kdb.web.origindeterminationengine;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.CreateFcrService;
import com.kpmg.kdb.web.origindeterminationengine.dto.BufferRates;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRowBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRowsRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginCriteria;
import com.kpmg.kdb.web.origindeterminationengine.ItemNationService;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemNationCriteria;

/**
 * "PKG99_COO_DECISION.COO_DECISION" 단계 (레거시 PKG99_COO_DECISION / PKG99_COO_CTC_DECISION).
 * {@link OriginDecisionPipeline} 이 사용한다.
 *
 * 매출(SALES_NO) 1건에 대해 판정대상 FTA_CODE 후보를 순회하고, 각 후보마다 적용 가능한 룰을
 * 순회하며 예외판정/세번변경기준/부가가치기준을 검사해 원산지 판정결과를 산출한다. 상품
 * (PRODUCT_ASSETS_TYPE M,R,B)과 제품(P,H)은 판정 방식이 달라 각각 별도 메서드로 처리한다.
 * RCEP(PKRRC)는 최대기여국 산정이 추가로 필요해 별도 처리한다.
 */
@Service
public class OriginDeterminationExecutionService extends GeneralService {

	/** APTA 신규 PSR 시행 기준일 */
	private static final String APTA_STANDARD_DATE = "20180701";
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
	 * 원산지 판정 1건 실행.
	 *
	 * <p>예외를 흡수하지 않고 그대로 던진다 — 매출 1건 처리 실패를 배치 전체 중단 없이 넘기면서도
	 * 그 대상을 판정실패로 표시하는 책임은 호출자({@link OriginDecisionPipeline})에 있다.
	 *
	 * @param productCodes 판정 대상 제품 코드. null/빈 리스트면 salesNo 전체(월 판정), 값이 있으면
	 *                      그 제품들만(개별 판정) 대상으로 한다.
	 */
	public void determineOrigin(String companyCode, String divisionCode, String salesNo, OriginDeterminationMode mode,
			List<String> productCodes) {
		OriginDeterminationScopeDao scopeDao = sqlSession.getMapper(OriginDeterminationScopeDao.class);

		List<String> assetTypes = scopeDao.selectDistinctProductAssetsTypes(companyCode, divisionCode, salesNo,
				productCodes);
		boolean hasCommodity = containsAny(assetTypes, "M", "R", "B");
		boolean hasProduct = containsAny(assetTypes, "P", "H");

		String invoiceDate = scopeDao.selectInvoiceDate(companyCode, salesNo);

		if (hasCommodity) {
			decideCommodityOrigin(companyCode, divisionCode, salesNo, invoiceDate, productCodes, mode);
		}

		if (hasProduct) {
			decideProductOrigin(companyCode, divisionCode, salesNo, invoiceDate, productCodes, mode);
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

	/** 상품(M,R,B) 원산지 판정. 구매처 원산지확인서/FTA_RULE 조회 결과를 FCR_MST/FCR_RESULT에 반영하는 집합 연산 2단계. */
	private void decideCommodityOrigin(String companyCode, String divisionCode, String salesNo, String invoiceDate,
			List<String> productCodes, OriginDeterminationMode mode) {
		CommodityOriginDeterminationDao dao = sqlSession.getMapper(CommodityOriginDeterminationDao.class);
		dao.mergeFcrMstOriginDetermination(salesNo, divisionCode, companyCode, invoiceDate, productCodes);
		dao.insertFcrResultForCommodities(salesNo, divisionCode, companyCode, productCodes, mode.getProcedureName());
	}
	
	/** 제품(P,H) 원산지 판정 */
	private void decideProductOrigin(String companyCode, String divisionCode, String salesNo, String invoiceDate,
			List<String> productCodes, OriginDeterminationMode mode) {
		ProductOriginDeterminationDao dao = sqlSession.getMapper(ProductOriginDeterminationDao.class);

		String newAptaPsrFlag = invoiceDate != null && invoiceDate.compareTo(APTA_STANDARD_DATE) < 0 ? "0" : "1";
		List<OriginDeterminationTarget> fmListRows = dao.selectOriginDeterminationTargets(companyCode, salesNo,
				productCodes);
		ExclusionRuleCache exclusionRuleCache = new ExclusionRuleCache(
				sqlSession.getMapper(ExclusionRuleDao.class));
		OriginCriteriaCache originCriteriaCache = OriginCriteriaCache.prefetch(dao, fmListRows, newAptaPsrFlag);
		Map<String, BufferRates> productLineBufferCache = new HashMap<>();

		// FM_LIST 전체분의 자재 원산지 목록(materialOriginRowsCache)을 한 번에 메모리에 올리면
		// BOM이 복잡한 매출은 한 그룹에서 수만 건까지도 쌓여(예: 15,104건 확인) GC 부담이 커진다.
		// fmListRows를 BATCH_CHUNK_SIZE 단위로 나눠, 자재 원산지 캐시/RCEP 캐시는 그 청크분만
		// 만들었다가 처리 후 버리도록 해서 한 번에 메모리에 남는 양을 제한한다.
		PendingBatch pending = new PendingBatch();
		for (int from = 0; from < fmListRows.size(); from += BATCH_CHUNK_SIZE) {
			List<OriginDeterminationTarget> chunk = fmListRows.subList(from,
					Math.min(from + BATCH_CHUNK_SIZE, fmListRows.size()));
			Map<String, List<MaterialOriginRow>> materialOriginRowsCache = prefetchMaterialOriginRows(dao,
					companyCode, salesNo, chunk);
			RcepCooNationCache rcepCache = prepareRcepCooNationCache(chunk, materialOriginRowsCache, invoiceDate);

			DeterminationRunContext runContext = new DeterminationRunContext(invoiceDate, newAptaPsrFlag, mode,
					exclusionRuleCache, originCriteriaCache, productLineBufferCache, materialOriginRowsCache,
					rcepCache);
			for (OriginDeterminationTarget fmData : chunk) {
				decideOneFtaLine(dao, fmData, runContext, pending);
			}
		}
		supportService.flushPendingResultsBatch(pending.results);
		supportService.resolveDeferredUpdateFrm(pending.deferredUpdateFrmTargets, pending.fcrMstUpdateBatch);
		supportService.flushFcrMstUpdates(pending.fcrMstUpdateBatch);
	}

	/** 제품(P,H) 1건의 FTA_CODE 후보 1건에 대해, 적용 가능한 룰을 모두 순회하며 판정한다. */
	private void decideOneFtaLine(ProductOriginDeterminationDao dao, OriginDeterminationTarget fmData,
			DeterminationRunContext runContext, PendingBatch pending) {
		OriginDeterminationContext ctx = new OriginDeterminationContext();
		ctx.setFmData(fmData);

		if (!supportService.loadBuffer(ctx, fmData.getCompanyCode(), fmData.getDivisionCode(), fmData.getFtaCode(),
				fmData.getProductCode(), runContext.productLineBufferCache)) {
			// 버퍼율 조회 실패 - 회사 버퍼가 없는 셈 치고(0) 자사기준 판정을 계속 진행하지 않고,
			// 이 FTA_CODE 후보 전체를 판정오류로 명시적으로 남긴다.
			insertBufferFailureResult(ctx, fmData, runContext.mode);
		} else {
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
				// 해당 HS코드에 적용 가능한 룰이 전혀 없는 경우
				insertNoRuleFoundResult(ctx, fmData, runContext.mode);
			} else {
				for (OriginCriteria frData : rules) {
					decideOneRule(ctx, fmData, frData, runContext.mode, runContext.exclusionRuleCache);
				}
			}
		}

		pending.results.addAll(ctx.getPendingResults());
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

	/** loadBuffer 실패 시 이 FTA_CODE 후보를 판정오류로 명시 처리. ctx.errorCode/errorMsg는 loadBuffer가 이미 채워뒀다(GET_BUFFER). */
	private void insertBufferFailureResult(OriginDeterminationContext ctx, OriginDeterminationTarget fmData, OriginDeterminationMode mode) {
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
		rec.setErrorCode(ctx.getErrorCode());
		rec.setErrorMsg(ctx.getErrorMsg());
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

		// RVC_CTC 모드에서만 재료비(역내+역외) 0원을 오류로 처리한다(CTC_ONLY는 값기준 계산이 없어 항상 통과)
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
			if (!exclusionRuleDecisionService.decide(ctx, frData, mode, exclusionRuleCache)) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && !"*".equals(frData.getCthRule())) {
			if (!ctcService.decide(ctx, frData, mode)) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && (positive(frData.getBdRule()) || positive(frData.getBuRule()) || positive(frData.getNcRule())
				|| positive(frData.getMcRule()))) {
			if (!rvcService.decide(ctx, frData, mode)) {
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
			// 다음 룰(다른 협정의 예외판정)에 이번 결과가 이어붙지 않도록 초기화
			for (MaterialOriginRow row : ctx.getMaterialOriginRows()) {
				for (int i = 1; i <= 14; i++) {
					row.setExclusionRule(i, false);
				}
			}
		}
	}

	/** 룰 1건에 대한 최종 판정(FTA_COO_YN/COMPANY_COO_YN) 결정 */
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
			// 기본룰 없이 예외룰만 있는 경우: 양허제외 HS코드는 무조건 역외처리
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

	/** RCEP(PKRRC) 최대기여국(RCEP_COO_NATION) 산정 */
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
				String mpItemYn = supportService.resolveMinimalProcessItemYn(ctx, fmData.getCompanyCode(),
						fmData.getDivisionCode(), fmData.getSalesNo(), fmData.getSalesSeq());
				if ("N".equals(mpItemYn)) {
					rec.setRcepCooNation("KR");
				} else {
					supportService.resolveRcepRvcNation(ctx, fmData.getAmount());
					rec.setRcepCooNation(ctx.getRcepCooNation());
				}
			}
		} else if ("Y".equals(fmData.getTariffYn()) && "Y".equals(rec.getCompanyCooYn()) && "ZZ".equals(rcepNation)) {
			supportService.resolveRcepRvcNation(ctx, fmData.getAmount());
			rec.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : ctx.getRcepCooNation());
		}
	}

	/** RCEP 자재 원산지(COO_NATION) 산정. 같은 (회사/사업부/품목/HS코드) 조합은 캐시로 중복 조회를 없앤다. */
	private void resolveItemCooNationForRcep(OriginDeterminationContext ctx, String invoiceDate, RcepCooNationCache rcepCache) {
		for (MaterialOriginRow row : ctx.getMaterialOriginRows()) {
			if (row.getOriginatingAmount() != null && row.getOriginatingAmount().signum() > 0) {
				String key = ItemNationService.resolveItemNationResultKey(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(),
						row.getHsCode());
				ItemNationCriteria criteria = rcepCache.distinctCriteria.computeIfAbsent(key,
						k -> new ItemNationCriteria(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(),
								row.getFtaCode(), row.getHsCode(), invoiceDate));
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

	/** determineOrigin() 1회 호출 범위의 모든 RCEP 후보가 공유하는 자재 원산지 캐시를 미리 준비한다. */
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
					String key = ItemNationService.resolveItemNationResultKey(row.getCompanyCode(), row.getDivisionCode(), row.getItemCode(),
						row.getHsCode());
					distinctCriteria.putIfAbsent(key, new ItemNationCriteria(row.getCompanyCode(), row.getDivisionCode(),
							row.getItemCode(), row.getFtaCode(), row.getHsCode(), invoiceDate));
				}
			}
		}

		Map<String, String> lastInputYyyyMmCache = itemNationService
				.prefetchLastInputYyyyMm(new ArrayList<>(distinctCriteria.values()));
		Map<String, String> cooNationBatchCache = itemNationService.prefetchCooNations(
				new ArrayList<>(distinctCriteria.values()), lastInputYyyyMmCache);
		return new RcepCooNationCache(distinctCriteria, lastInputYyyyMmCache, cooNationBatchCache);
	}

	/** FM_LIST 행별 자재 원산지 목록(FCR_INFO_TEMP 대체)을 배치로 미리 조회한다. */
	private Map<String, List<MaterialOriginRow>> prefetchMaterialOriginRows(ProductOriginDeterminationDao dao,
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
			BatchChunker.forEachChunk(requests, BATCH_CHUNK_SIZE, chunk -> {
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
			});
			return cache;
		} catch (Exception e) {
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

	/** RCEP 후보 전체가 공유하는 자재 원산지 캐시 묶음. */
	private static final class RcepCooNationCache {
		final Map<String, ItemNationCriteria> distinctCriteria;
		final Map<String, String> lastInputYyyyMmCache;
		final Map<String, String> cooNationBatchCache;
		/** 배치 사전조회에 없던 조합의 단건 폴백 결과 캐시 */
		final Map<String, String> cooNationCache = new HashMap<>();

		RcepCooNationCache(Map<String, ItemNationCriteria> distinctCriteria, Map<String, String> lastInputYyyyMmCache,
				Map<String, String> cooNationBatchCache) {
			this.distinctCriteria = distinctCriteria;
			this.lastInputYyyyMmCache = lastInputYyyyMmCache;
			this.cooNationBatchCache = cooNationBatchCache;
		}
	}

	/** determineOrigin() 1회 호출 동안 FM_LIST 행마다 반복해서 넘기는 컨텍스트/캐시 묶음. */
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

	/** FM_LIST 행마다 쌓는 배치 결과(판정결과/재조회대상/FCR_MST 갱신행) 묶음. */
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
