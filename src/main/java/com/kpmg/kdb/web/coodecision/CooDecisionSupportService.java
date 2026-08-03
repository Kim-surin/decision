package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.coodecision.dto.BufferRates;
import com.kpmg.kdb.web.coodecision.dto.FcrInfoRow;
import com.kpmg.kdb.web.coodecision.dto.FcrMasterLine;
import com.kpmg.kdb.web.coodecision.dto.FcrResultRecord;

/**
 * PKG99_COO_DECISION / PKG99_COO_CTC_DECISION 두 패키지에 완전(또는 거의) 동일하게 존재하던
 * 공용 헬퍼 프로시저 이관:
 * GET_BUFFER, GET_MP_ITEM, GET_RCEP_NATION, GET_RCEP_RVC_NATION,
 * ERROR_MARKING_PROCESS, INSERT_FRD_PROCESS, UPDATE_FRM_PROCEDURE
 *
 * FCR_INFO_TEMP(임시테이블) 조회가 필요한 GET_RCEP_NATION / GET_RCEP_RVC_NATION 은
 * {@link CooDecisionContext#getFcrInfoRows()} (매출 1건당 1회 조회해 메모리에 올린 리스트)를
 * 스트림으로 집계해 원본의 반복 SQL 호출을 제거했다.
 */
@Service
public class CooDecisionSupportService extends GeneralService {

	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);
	/** GET_RCEP_RVC_NATION 의 로컬 상수(원본 V_COMPANY_RVC_RATE := 20). RCEP BD20 기준이며 회사버퍼율과 무관 */
	private static final BigDecimal RCEP_BD20_THRESHOLD = BigDecimal.valueOf(20);

	/**
	 * 레거시 GET_BUFFER 이관. COMPANY_OPTION.OPTION_CODE='BF' 산정기준에 따라
	 * 회사/사업부/제품군/FTA 4개 소스 중 하나에서 RVC·미소기준 버퍼율을 조회해 컨텍스트에 채운다.
	 */
	public void loadBuffer(CooDecisionContext ctx, String companyCode, String divisionCode, String ftaCode,
			String productCode) {
		try {
			CooDecisionSupportDao dao = sqlSession.getMapper(CooDecisionSupportDao.class);

			String optionValue = dao.selectBufferOptionValue(companyCode);
			ctx.setOptionValue(optionValue);

			BufferRates rates = switch (optionValue == null ? "" : optionValue) {
				case "COM" -> dao.selectCompanyBuffer(companyCode);
				case "DIV" -> dao.selectDivisionBuffer(companyCode, divisionCode);
				case "PRD" -> dao.selectProductLineBuffer(companyCode, productCode);
				case "FTA" -> dao.selectFtaBuffer(ftaCode);
				default -> null;
			};

			if (rates != null) {
				ctx.setCompanyRvcRate(rates.getRvcRate());
				ctx.setCompanyCtcRate(rates.getDeMinimisRate());
			}
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS 와 동일하게 예외를 흡수하고 오류 정보만 컨텍스트에 남긴다(재발생 없음)
			ctx.setErrorCode("GET_BUFFER");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("GET_BUFFER 실패. companyCode={}", companyCode, e);
		}
	}

	/** 레거시 GET_MP_ITEM 이관: 최소공정 제외 품목 해당 여부('Y'/'N') */
	public String getMinimalProcessItemYn(String companyCode, String divisionCode, String salesNo, String salesSeq) {
		long count = sqlSession.getMapper(CooDecisionSupportDao.class).selectMinimalProcessItemCount(companyCode,
				divisionCode, salesNo, salesSeq);
		return count > 0 ? "Y" : "N";
	}

	/**
	 * 레거시 GET_RCEP_NATION 이관. FCR_INFO_TEMP 를 매번 재조회하는 대신
	 * {@link CooDecisionContext#getFcrInfoRows()} 를 스트림으로 집계한다.
	 */
	public String resolveRcepNation(CooDecisionContext ctx) {
		List<FcrInfoRow> rows = ctx.getFcrInfoRows();
		if (rows.isEmpty()) {
			// 원본은 COUNT/SUM 이 모두 0/NULL 이 되어 3개 분기 중 어느것도 성립하지 않고
			// RETURN 없이 종료(ORA-06503, 함수가 값을 반환하지 않음)되는 상태를 그대로 반영한다.
			throw new IllegalStateException("RCEP 원산지 판정 대상 자재(FCR_INFO_TEMP)가 없습니다.");
		}

		Set<String> applyNations = new HashSet<>(
				sqlSession.getMapper(CooDecisionSupportDao.class).selectFtaApplyNations(ctx.getFmList().getFtaCode()));

		long itemCnt = rows.size();
		long krCnt = rows.stream().filter(FcrInfoRow::isKoreaOrigin).count();
		long rcepCnt = rows.stream().filter(r -> r.isKoreaOrigin() || applyNations.contains(r.getCooNation())).count();

		if (itemCnt == krCnt) {
			return "KR";
		}
		if (itemCnt == rcepCnt) {
			return "RCEP";
		}
		if (itemCnt > rcepCnt) {
			return "ZZ";
		}
		// itemCnt >= rcepCnt >= krCnt >= 0 항상 성립하므로 도달 불가(방어적 처리)
		throw new IllegalStateException("RCEP 원산지 판정 결과를 산출할 수 없습니다.");
	}

	/**
	 * 레거시 GET_RCEP_RVC_NATION(P_AMOUNT) 이관.
	 * 컨텍스트의 rcepKrYn / rcepCooNation 필드를 채운다(원본도 OUT 파라미터 없이 전역변수만 설정).
	 */
	public void resolveRcepRvcNation(CooDecisionContext ctx, BigDecimal amount) {
		List<FcrInfoRow> rows = ctx.getFcrInfoRows();

		BigDecimal nonKrInputAmount = rows.stream()
				.filter(r -> !r.isKoreaOrigin())
				.map(FcrInfoRow::getInputAmount)
				.filter(Objects::nonNull)
				.reduce(BigDecimal.ZERO, BigDecimal::add);

		// (P_AMOUNT - SUM(INPUT_AMOUNT)) / P_AMOUNT * 100 -- amount=0 이면 원본과 동일하게 예외 전파(ArithmeticException)
		BigDecimal rvcRate = amount.subtract(nonKrInputAmount).divide(amount, 8, RoundingMode.HALF_UP)
				.multiply(HUNDRED);

		ctx.setRcepKrYn(rvcRate.compareTo(RCEP_BD20_THRESHOLD) >= 0 ? "Y" : "N");

		Set<String> applyNations = new HashSet<>(
				sqlSession.getMapper(CooDecisionSupportDao.class).selectFtaApplyNations(ctx.getFmList().getFtaCode()));

		Map<String, BigDecimal> inareaAmountByNation = rows.stream()
				.filter(r -> r.getCooNation() != null)
				.filter(r -> r.getInareaQty() != null && r.getInareaQty().signum() > 0)
				.filter(r -> applyNations.contains(r.getCooNation()))
				.collect(Collectors.groupingBy(FcrInfoRow::getCooNation,
						Collectors.reducing(BigDecimal.ZERO, r -> nvl(r.getInareaAmount()), BigDecimal::add)));

		String topNation = inareaAmountByNation.entrySet().stream()
				.max(Map.Entry.comparingByValue())
				.map(Map.Entry::getKey)
				.orElse(null);

		if (topNation != null) {
			ctx.setRcepCooNation(topNation);
		} else {
			// 원본 EXCEPTION WHEN NO_DATA_FOUND 분기와 동일
			ctx.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : "");
		}
	}

	/** 레거시 ERROR_MARKING_PROCESS 이관 */
	public void markError(CooDecisionContext ctx) {
		FcrResultRecord rec = ctx.getFrdRec();
		rec.setSpCooYn("N");
		rec.setCtcYn("N");
		rec.setFtaDeMinimisYn("N");
		rec.setCompanyDeMinimisYn("N");
		rec.setFtaRvcYn("N");
		rec.setCompanyRvcYn("N");
		rec.setExclusionYn("N");
		rec.setExclusionCondition("AND");
		rec.setFtaCooYn("N");
		rec.setCompanyCooYn("N");

		rec.setStatus("E");
		rec.setErrorCode(ctx.getErrorCode());
		rec.setErrorMsg(ctx.getErrorMsg());

		// 다음 판정을 위하여 컨텍스트 오류 상태 초기화
		ctx.setReturnCode(0);
		ctx.setErrorCode("");
	}

	/** 레거시 INSERT_FRD_PROCESS 이관: 판정결과 1건 저장 후 다음 룰 판정을 위해 레코드를 초기화한다 */
	public void insertFrdAndReset(CooDecisionContext ctx, DecisionMode mode) {
		FcrResultRecord rec = ctx.getFrdRec();
		try {
			CooDecisionSupportDao dao = sqlSession.getMapper(CooDecisionSupportDao.class);

			rec.setSeq(dao.selectNextFcrResultSeq());
			rec.setBufferOption(ctx.getOptionValue());
			rec.setDeMinimisRate(ctx.getCompanyCtcRate());
			rec.setRvcRate(ctx.getCompanyRvcRate());
			rec.setDeleteYn("N");
			rec.setCreateBy(mode.getProcedureName());
			rec.setUpdateBy(mode.getProcedureName());

			dao.insertFcrResult(rec);
		} catch (Exception e) {
			ctx.setErrorCode("DECISION01");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("INSERT_FRD_PROCESS 실패. rec={}", rec, e);
		}

		ctx.setReturnCode(0);
		rec.resetForNextRule();
	}

	/**
	 * 레거시 UPDATE_FRM_PROCEDURE 이관: 매출 1건(FM_LIST)에 대한 모든 룰 판정이 끝난 뒤
	 * 최종 판정결과를 FCR_MST 에 반영한다.
	 *
	 * @param mode RVC_CTC 인 경우에만 "재료비가 없는 자재 존재" 오류를 검사한다(CTC 전용 모드에서는
	 *             원본에서 이 검사 블록 전체가 주석 처리되어 비활성화되어 있었다).
	 */
	public void updateFrm(CooDecisionContext ctx, DecisionMode mode) {
		FcrMasterLine fm = ctx.getFmList();
		// 원본은 이 프로시저 안에서 지역변수 V_FRD_REC(FCR_RESULT%ROWTYPE)를 새로 선언해 사용한다.
		// (판정 누적용 VG_FRD_REC 과는 별개의 변수)
		FcrResultRecord rec = new FcrResultRecord();

		try {
			CooDecisionSupportDao dao = sqlSession.getMapper(CooDecisionSupportDao.class);
			ctx.setReturnCode(0);

			if (ctx.getRuleCount() < 1) {
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("협정에 해당하는 HS RULE이 없습니다!!");
				ctx.setReturnCode(9);
			} else if (mode == DecisionMode.RVC_CTC && fm.hasNoMaterialAmount()) {
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("재료비가 없는 자재가 존재합니다.");
				ctx.setReturnCode(10);
			} else {
				String cooYn;
				List<FcrResultRecord> own = dao.selectOwnCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(),
						fm.getFtaCode(), fm.getDivisionCode(), fm.getCompanyCode());
				if (!own.isEmpty()) {
					rec = own.get(0);
					cooYn = "Y";
				} else {
					List<FcrResultRecord> nonCoo = dao.selectNonCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(),
							fm.getFtaCode(), fm.getDivisionCode(), fm.getCompanyCode());
					if (!nonCoo.isEmpty()) {
						rec = nonCoo.get(0);
						cooYn = "N";
					} else {
						cooYn = "E";
					}
				}

				if ("E".equals(cooYn)) {
					markAllNo(rec);
					rec.setStatus("E");
					rec.setErrorCode("ALL-ERROR");
					ctx.setReturnCode(8);
				}
			}

			dao.updateFcrMstDecisionResult(fm.getSalesNo(), fm.getSalesSeq(), fm.getFtaCode(), fm.getDivisionCode(),
					fm.getCompanyCode(), rec.getRuleCode(), rec.getFtaCooYn(), rec.getCompanyCooYn(),
					rec.getRcepCooNation());
		} catch (Exception e) {
			ctx.setErrorCode("FCRMST01");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("UPDATE_FRM_PROCEDURE 실패. salesNo={}, salesSeq={}", fm.getSalesNo(), fm.getSalesSeq(), e);
		}
	}

	private static void markAllNo(FcrResultRecord rec) {
		rec.setSpCooYn("N");
		rec.setWoCooYn("N");
		rec.setFtaCooYn("N");
		rec.setCompanyCooYn("N");
	}

	private static BigDecimal nvl(BigDecimal value) {
		return value == null ? BigDecimal.ZERO : value;
	}
}
