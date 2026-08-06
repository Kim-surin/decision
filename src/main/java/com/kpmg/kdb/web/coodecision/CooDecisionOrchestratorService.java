package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.coodecision.dto.FcrInfoRow;
import com.kpmg.kdb.web.coodecision.dto.FcrMasterLine;
import com.kpmg.kdb.web.coodecision.dto.FcrResultRecord;
import com.kpmg.kdb.web.coodecision.dto.FtaRule;

/**
 * 레거시 PKG99_COO_DECISION.COO_DECISION / PKG99_COO_CTC_DECISION.COO_DECISION 메인 프로시저 이관.
 *
 * 매출(SALES_NO) 1건에 대해 판정대상 FTA_CODE 후보(C_FCR_MST, FM_LIST)를 순회하고, 각 후보마다
 * 적용 가능한 룰(C_FTA_RULE, FR_LIST)을 순회하며 예외판정/세번변경기준/부가가치기준 서비스를 호출해
 * 최종 원산지 판정결과를 산출한다. FM_LIST 1건 = {@link CooDecisionContext} 1개(스레드 안전을 위해
 * 매번 새로 생성 — {@link CooDecisionContext} 클래스 주석 참고).
 *
 * RVC_CTC/CTC_ONLY 두 원본 패키지의 COO_DECISION 은 "RVC_CTC 모드에서만 재료비 0원 검사를 수행한다"는
 * 한 가지 차이를 제외하면 완전히 동일한 구조라 이 클래스 하나로 통합했다(그 한 가지 차이는
 * {@link #decideOneRule} 의 재료비 검사 분기에서 mode 로 처리).
 *
 * <p><b>이관되지 않은 부분:</b> FTA_CODE='PKRRC'(RCEP) 전용 자재 원산지(COO_NATION) 산정에 사용되는
 * 레거시 FC01_GET_ITEM_NATION 함수는 이번 이관 대상 PL/SQL 소스 목록(decision sql 폴더)에 포함되어
 * 있지 않아 실제 로직을 옮기지 못했다({@link #resolveItemCooNationForRcep} 참고). 이 값이 채워지지
 * 않으면 RCEP 판정이 부정확할 수 있으므로, 운영 반영 전 원본 함수 소스를 확보해 별도로 이관해야 한다.
 */
@Service
public class CooDecisionOrchestratorService extends GeneralService {

	/** APTA 신규 PSR 시행 기준일(V_APTA_STD_YYYYMMDD) */
	private static final String APTA_STANDARD_DATE = "20180701";

	@Autowired
	private CooDecisionSupportService supportService;
	@Autowired
	private ExclusionRuleDecisionService exclusionRuleDecisionService;
	@Autowired
	private CooDecisionForCtcService ctcService;
	@Autowired
	private CooDecisionForRvcService rvcService;

	/**
	 * 레거시 COO_DECISION(P_COMPANY_CODE, P_SALES_NO, O_RETURN_CODE) 이관.
	 * 원본과 동일하게 최상위에서 모든 예외를 흡수하고 로그만 남긴다(재발생 없음) — 호출자는 매출 1건
	 * 처리 실패가 배치 전체를 중단시키지 않는다는 것을 전제로 사용할 수 있다.
	 */
	public void decide(String companyCode, String salesNo, DecisionMode mode) {
		try {
			CooDecisionCursorDao dao = sqlSession.getMapper(CooDecisionCursorDao.class);

			String invoiceDate = dao.selectInvoiceDate(companyCode, salesNo);
			String newAptaPsrFlag = invoiceDate != null && invoiceDate.compareTo(APTA_STANDARD_DATE) < 0 ? "0" : "1";

			List<FcrMasterLine> fmListRows = dao.selectFcrMasterLines(companyCode, salesNo);
			for (FcrMasterLine fmList : fmListRows) {
				decideOneFtaLine(dao, fmList, newAptaPsrFlag, mode);
			}
		} catch (Exception e) {
			logger.error("COO_DECISION 실패. companyCode={}, salesNo={}", companyCode, salesNo, e);
		}
	}

	private void decideOneFtaLine(CooDecisionCursorDao dao, FcrMasterLine fmList, String newAptaPsrFlag,
			DecisionMode mode) {
		CooDecisionContext ctx = new CooDecisionContext();
		ctx.setFmList(fmList);

		supportService.loadBuffer(ctx, fmList.getCompanyCode(), fmList.getDivisionCode(), fmList.getFtaCode(),
				fmList.getProductCode());

		// 기판정된 결과가 있는 경우 삭제
		dao.deletePriorFcrResult(fmList.getSalesNo(), fmList.getSalesSeq(), fmList.getFtaCode(),
				fmList.getCompanyCode());

		// FCR_INFO_TEMP 대체: FM_LIST 1건당 1회만 조회해 메모리에 적재(반복 SQL 제거)
		ctx.setFcrInfoRows(dao.selectFcrInfoRows(fmList.getFtaCode(), fmList.getDivisionCode(),
				fmList.getCompanyCode(), fmList.getSalesNo(), fmList.getSalesSeq(), fmList.getHsCode()));

		if ("PKRRC".equals(fmList.getFtaCode())) {
			resolveItemCooNationForRcep(ctx);
		}

		List<FtaRule> ruleList = dao.selectApplicableFtaRules(fmList.getHsCode(), fmList.getFtaCode(),
				fmList.getHsCodeSubCategory(), newAptaPsrFlag);

		if (ruleList.isEmpty()) {
			// 원본 V_RULE_CNT=100 분기: 해당 HS코드에 적용가능한 FTA_RULE 이 전혀 없는 경우
			insertNoRuleFoundResult(ctx, fmList, mode);
		} else {
			for (FtaRule frList : ruleList) {
				decideOneRule(ctx, fmList, frList, mode);
			}
		}

		// 원본 VG_RULE_COUNT: C_FTA_RULE 루프는 룰이 없어도 phantom 1회가 실행되어 항상 1 로 설정된다.
		// UPDATE_FRM_PROCEDURE 의 "룰 없음(ruleCount<1)" 분기는 이 경로로는 사실상 도달하지 않는
		// 원본 동작을 그대로 재현한다.
		ctx.setRuleCount(1);
		supportService.updateFrm(ctx, mode);
	}

	private void insertNoRuleFoundResult(CooDecisionContext ctx, FcrMasterLine fmList, DecisionMode mode) {
		FcrResultRecord rec = ctx.getFrdRec();
		rec.setSalesNo(fmList.getSalesNo());
		rec.setSalesSeq(fmList.getSalesSeq());
		rec.setFtaCode(fmList.getFtaCode());
		rec.setDivisionCode(fmList.getDivisionCode());
		rec.setCompanyCode(fmList.getCompanyCode());
		rec.setProductCode(fmList.getProductCode());
		rec.setHsCode(fmList.getHsCode());
		rec.setStandard(fmList.getStandard());
		rec.setStatus("E");
		rec.setCompanyCooYn("N");
		rec.setFtaCooYn("N");
		rec.setErrorCode("MSG_DECISION_STANDARD_NOT_EXIST");
		rec.setErrorMsg("판정기준이 미 존재 합니다.");
		supportService.insertFrdAndReset(ctx, mode);
	}

	private void decideOneRule(CooDecisionContext ctx, FcrMasterLine fmList, FtaRule frList, DecisionMode mode) {
		FcrResultRecord rec = ctx.getFrdRec();
		rec.setSalesNo(fmList.getSalesNo());
		rec.setSalesSeq(fmList.getSalesSeq());
		rec.setFtaCode(fmList.getFtaCode());
		rec.setRuleSeq(frList.getRuleId());
		rec.setDivisionCode(fmList.getDivisionCode());
		rec.setCompanyCode(fmList.getCompanyCode());
		rec.setRuleCode(frList.getRuleContents());
		rec.setProductCode(fmList.getProductCode());
		rec.setHsCode(fmList.getHsCode());
		rec.setStandard(fmList.getStandard());
		rec.setStatus("N");

		// RVC_CTC 모드에서만 재료비(역내+역외) 금액이 0인 경우를 오류로 처리한다. CTC_ONLY 모드는
		// 원본에서 이 검사 블록 전체가 주석 처리되어 있어(값기준 계산 불가) 항상 통과시킨다.
		if (mode == DecisionMode.RVC_CTC && fmList.hasNoMaterialAmount()) {
			rec.setCompanyCooYn("N");
			rec.setFtaCooYn("N");
			rec.setStatus("E");
			rec.setErrorCode("MSG_FAILED_DECISION_QTY_AMOUNT");
			rec.setErrorMsg("소요량 또는 금액이 0 인 것이 존재합니다.");
			supportService.insertFrdAndReset(ctx, mode);
			return;
		}

		ctx.setNetWeight(fmList.getWeight());
		ctx.setNetCostAmount(fmList.getNetCostAmount());
		ctx.setInkotermsAmount(
				"EXW".equals(fmList.getInkotermsType()) ? fmList.getExworkAmount() : fmList.getFobAmount());
		ctx.setDeMinimisInkotermsAmount(
				"EXW".equals(fmList.getDeMinimisInkotermsType()) ? fmList.getExworkAmount() : fmList.getFobAmount());

		if ("SP".equals(frList.getSpRule())) {
			rec.setSpCooYn(fmList.getSpCooYn());
		}
		if ("WO".equals(frList.getWoRule())) {
			rec.setWoCooYn(fmList.getWoCooYn());
		}

		boolean stop = false;

		if ("Y".equals(frList.getExclusionRuleYn())) {
			exclusionRuleDecisionService.decide(ctx, frList, mode);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && !"*".equals(frList.getCthRule())) {
			ctcService.decide(ctx, frList, mode);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop && (positive(frList.getBdRule()) || positive(frList.getBuRule()) || positive(frList.getNcRule())
				|| positive(frList.getMcRule()))) {
			rvcService.decide(ctx, frList, mode);
			if (ctx.getReturnCode() < 0) {
				supportService.markError(ctx);
				supportService.insertFrdAndReset(ctx, mode);
				stop = true;
			}
		}

		if (!stop) {
			combineFinalResult(ctx, fmList, frList);
			supportService.insertFrdAndReset(ctx, mode);
		}

		if ("Y".equals(frList.getExclusionRuleYn())) {
			// 다음 룰(다른 협정의 예외판정)에 이번 결과가 이어붙지 않도록 초기화한다(원본: 매 룰 처리 후
			// FCR_INFO_TEMP.EXCLUSION_RULE1~14_YN 을 'N' 으로 리셋하는 UPDATE). 메모리 상의 리스트를
			// 직접 되돌리므로 DB 호출이 필요 없다.
			for (FcrInfoRow row : ctx.getFcrInfoRows()) {
				for (int i = 1; i <= 14; i++) {
					row.setExclusionRule(i, false);
				}
			}
		}
	}

	/** 레거시 COO_DECISION 메인루프 "룰 ID에 대한 최종 판정" 블록 이관 */
	private void combineFinalResult(CooDecisionContext ctx, FcrMasterLine fmList, FtaRule frList) {
		FcrResultRecord rec = ctx.getFrdRec();
		boolean loopFlag = false;

		if ("Y".equals(frList.getExclusionRuleYn())) {
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

		if ("PKRRC".equals(fmList.getFtaCode())) {
			applyRcepDetermination(ctx, fmList);
		}
	}

	/** 레거시 COO_DECISION 메인루프의 RCEP(FTA_CODE='PKRRC') 최대기여국 산정 블록 이관 */
	private void applyRcepDetermination(CooDecisionContext ctx, FcrMasterLine fmList) {
		FcrResultRecord rec = ctx.getFrdRec();
		String rcepNation = supportService.resolveRcepNation(ctx);

		if ("KR".equals(rcepNation)) {
			rec.setRcepCooNation("KR");
		} else if ("RCEP".equals(rcepNation)) {
			if ("Y".equals(fmList.getTariffYn())) {
				supportService.resolveRcepRvcNation(ctx, fmList.getAmount());
				rec.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : ctx.getRcepCooNation());
			} else {
				String mpItemYn = supportService.getMinimalProcessItemYn(fmList.getCompanyCode(),
						fmList.getDivisionCode(), fmList.getSalesNo(), fmList.getSalesSeq());
				if ("N".equals(mpItemYn)) {
					rec.setRcepCooNation("KR");
				} else {
					supportService.resolveRcepRvcNation(ctx, fmList.getAmount());
					rec.setRcepCooNation(ctx.getRcepCooNation());
				}
			}
		} else if ("Y".equals(fmList.getTariffYn()) && "Y".equals(rec.getCompanyCooYn()) && "ZZ".equals(rcepNation)) {
			// 원본 그대로 이관: 바깥 ELSIF 조건에 이미 TARIFF_YN='Y' 가 포함돼 있어 안쪽 ELSE 는
			// 실질적으로 도달 불가능한 원본의 중복 조건이다(보존).
			if ("Y".equals(fmList.getTariffYn())) {
				supportService.resolveRcepRvcNation(ctx, fmList.getAmount());
				rec.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : ctx.getRcepCooNation());
			} else {
				rec.setRcepCooNation("KR");
			}
		}
	}

	/**
	 * FC01_GET_ITEM_NATION 이관 미완료: RCEP(PKRRC) 판정에 필요한 자재별 원산지국가(COO_NATION) 산정
	 * 함수의 PL/SQL 소스가 이번 이관 대상에 포함되어 있지 않아 실제 로직을 옮기지 못했다. 이 메서드가
	 * 호출되는 한 INAREA_AMOUNT&gt;0 인 자재의 COO_NATION 은 계속 null 로 남아 이후 GET_RCEP_NATION 등
	 * RCEP 최대기여국 판정이 부정확할 수 있다 — 운영 반영 전 원본 함수 소스 확보 후 별도 이관 필요.
	 */
	private void resolveItemCooNationForRcep(CooDecisionContext ctx) {
		boolean needsResolution = ctx.getFcrInfoRows().stream()
				.anyMatch(r -> r.getInareaAmount() != null && r.getInareaAmount().signum() > 0);
		if (needsResolution) {
			logger.warn("FC01_GET_ITEM_NATION 미이관으로 PKRRC(RCEP) COO_NATION 산정을 건너뜁니다. salesNo={}, salesSeq={}",
					ctx.getFmList().getSalesNo(), ctx.getFmList().getSalesSeq());
		}
	}

	private static boolean ynOrDefaultY(String value) {
		return value == null || "Y".equals(value);
	}

	private static boolean positive(BigDecimal value) {
		return value != null && value.signum() > 0;
	}
}
