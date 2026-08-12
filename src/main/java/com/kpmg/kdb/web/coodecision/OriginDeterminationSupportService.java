package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.coodecision.dto.BufferRates;
import com.kpmg.kdb.web.coodecision.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.coodecision.dto.MaterialOriginRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationResult;

/**
 * PKG99_COO_DECISION / PKG99_COO_CTC_DECISION 두 패키지에 완전(또는 거의) 동일하게 존재하던
 * 공용 헬퍼 프로시저 이관:
 * GET_BUFFER, GET_MP_ITEM, GET_RCEP_NATION, GET_RCEP_RVC_NATION,
 * ERROR_MARKING_PROCESS, INSERT_FRD_PROCESS, UPDATE_FRM_PROCEDURE
 *
 * FCR_INFO_TEMP(임시테이블) 조회가 필요한 GET_RCEP_NATION / GET_RCEP_RVC_NATION 은
 * {@link OriginDeterminationContext#getMaterialOriginRows()} (매출 1건당 1회 조회해 메모리에 올린 리스트)를
 * 스트림으로 집계해 원본의 반복 SQL 호출을 제거했다.
 */
@Service
public class OriginDeterminationSupportService extends GeneralService {

	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);
	/** GET_RCEP_RVC_NATION 의 로컬 상수(원본 V_COMPANY_RVC_RATE := 20). RCEP BD20 기준이며 회사버퍼율과 무관 */
	private static final BigDecimal RCEP_BD20_THRESHOLD = BigDecimal.valueOf(20);

	@Autowired
	private CooDecisionReferenceDataService referenceDataService;

	/**
	 * 레거시 GET_BUFFER 이관. COMPANY_OPTION.OPTION_CODE='BF' 산정기준에 따라
	 * 회사/사업부/제품군/FTA 4개 소스 중 하나에서 RVC·미소기준 버퍼율을 조회해 컨텍스트에 채운다.
	 *
	 * <p>PRD(제품군) 소스만 {@link CooDecisionReferenceDataService} 의 {@code @Cacheable} 을 타지 않는다
	 * — ITEM_MST 를 조인해 조회 키(productCode)가 품목 수만큼 고카디널리티라 전역 캐시에 담기엔
	 * 부적합하기 때문이다(클래스 상단 COM/DIV/FTA 와의 비교 참고). 대신 determineOrigin() 1회 호출
	 * 범위에서만 유효한 productLineBufferCache 로 그 안에서의 반복 조회만 없앤다 — 같은 제품이 FTA
	 * 후보 수만큼(FM_LIST 행) 반복되는 경우가 대상이다.
	 */
	public void loadBuffer(OriginDeterminationContext ctx, String companyCode, String divisionCode, String ftaCode,
			String productCode, Map<String, BufferRates> productLineBufferCache) {
		try {
			String optionValue = referenceDataService.getBufferOptionValue(companyCode);
			ctx.setOptionValue(optionValue);

			BufferRates rates = switch (optionValue == null ? "" : optionValue) {
				case "COM" -> referenceDataService.getCompanyBuffer(companyCode);
				case "DIV" -> referenceDataService.getDivisionBuffer(companyCode, divisionCode);
				case "PRD" -> productLineBufferCache.computeIfAbsent(companyCode + ":" + productCode,
						k -> sqlSession.getMapper(OriginDeterminationSupportDao.class)
								.selectProductLineBuffer(companyCode, productCode));
				case "FTA" -> referenceDataService.getFtaBuffer(ftaCode);
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

	/**
	 * 레거시 GET_MP_ITEM 이관: 최소공정 제외 품목 해당 여부('Y'/'N'). 조회 키(companyCode/divisionCode/
	 * salesNo/salesSeq)가 FM_LIST 1건(=ctx)의 모든 룰에서 항상 동일해, ctx 에 결과를 캐싱해 룰마다
	 * 반복 조회하지 않는다(원본은 PKRRC 후보의 매 룰 판정마다 다시 조회했다).
	 */
	public String getMinimalProcessItemYn(OriginDeterminationContext ctx, String companyCode, String divisionCode,
			String salesNo, int salesSeq) {
		if (!ctx.isMinimalProcessItemYnLoaded()) {
			long count = sqlSession.getMapper(OriginDeterminationSupportDao.class)
					.selectMinimalProcessItemCount(companyCode, divisionCode, salesNo, salesSeq);
			ctx.setMinimalProcessItemYn(count > 0 ? "Y" : "N");
		}
		return ctx.getMinimalProcessItemYn();
	}

	/**
	 * 레거시 GET_RCEP_NATION 이관. FCR_INFO_TEMP 를 매번 재조회하는 대신
	 * {@link OriginDeterminationContext#getMaterialOriginRows()} 를 스트림으로 집계한다.
	 */
	public String resolveRcepNation(OriginDeterminationContext ctx) {
		List<MaterialOriginRow> rows = ctx.getMaterialOriginRows();
		if (rows.isEmpty()) {
			// 원본은 COUNT/SUM 이 모두 0/NULL 이 되어 3개 분기 중 어느것도 성립하지 않고
			// RETURN 없이 종료(ORA-06503, 함수가 값을 반환하지 않음)되는 상태를 그대로 반영한다.
			throw new IllegalStateException("RCEP 원산지 판정 대상 자재(FCR_INFO_TEMP)가 없습니다.");
		}

		Set<String> applyNations = new HashSet<>(referenceDataService.getFtaApplyNations(ctx.getFmData().getFtaCode()));

		long itemCnt = rows.size();
		long krCnt = rows.stream().filter(MaterialOriginRow::isKoreaOrigin).count();
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
	public void resolveRcepRvcNation(OriginDeterminationContext ctx, BigDecimal amount) {
		List<MaterialOriginRow> rows = ctx.getMaterialOriginRows();

		BigDecimal nonKrInputAmount = rows.stream()
				.filter(r -> !r.isKoreaOrigin())
				.map(MaterialOriginRow::getInputAmount)
				.filter(Objects::nonNull)
				.reduce(BigDecimal.ZERO, BigDecimal::add);

		// (P_AMOUNT - SUM(INPUT_AMOUNT)) / P_AMOUNT * 100 -- amount=0 이면 원본과 동일하게 예외 전파(ArithmeticException)
		BigDecimal rvcRate = amount.subtract(nonKrInputAmount).divide(amount, 8, RoundingMode.HALF_UP)
				.multiply(HUNDRED);

		ctx.setRcepKrYn(rvcRate.compareTo(RCEP_BD20_THRESHOLD) >= 0 ? "Y" : "N");

		Set<String> applyNations = new HashSet<>(referenceDataService.getFtaApplyNations(ctx.getFmData().getFtaCode()));

		Map<String, BigDecimal> originatingAmountByNation = rows.stream()
				.filter(r -> r.getCooNation() != null)
				.filter(r -> r.getOriginatingQty() != null && r.getOriginatingQty().signum() > 0)
				.filter(r -> applyNations.contains(r.getCooNation()))
				.collect(Collectors.groupingBy(MaterialOriginRow::getCooNation,
						Collectors.reducing(BigDecimal.ZERO, r -> nvl(r.getOriginatingAmount()), BigDecimal::add)));

		String topNation = originatingAmountByNation.entrySet().stream()
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
	public void markError(OriginDeterminationContext ctx) {
		OriginDeterminationResult rec = ctx.getFrdRec();
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

	/**
	 * 레거시 INSERT_FRD_PROCESS 이관: 판정결과 1건을 저장 대기열에 담아두고 다음 룰 판정을 위해
	 * 레코드를 초기화한다. 실제 INSERT 는 즉시 실행하지 않고 {@link #flushPendingResults} 가
	 * FM_LIST 1건(=ctx) 처리가 끝난 시점에 한 번에 배치로 실행한다 — 원본은 룰마다 단건 INSERT였지만,
	 * 여러 룰의 결과를 모았다가 한 번에 저장해도 (INSERT 순서에 의미가 없어) 최종 저장 결과는 같다.
	 */
	public void insertFrdAndReset(OriginDeterminationContext ctx, OriginDeterminationMode mode) {
		OriginDeterminationResult rec = ctx.getFrdRec();
		try {
			rec.setBufferOption(ctx.getOptionValue());
			rec.setDeMinimisRate(ctx.getCompanyCtcRate());
			rec.setRvcRate(ctx.getCompanyRvcRate());
			rec.setDeleteYn("N");
			rec.setCreateBy(mode.getProcedureName());
			rec.setUpdateBy(mode.getProcedureName());

			ctx.addPendingResult(rec.copy());
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
	 * {@link #insertFrdAndReset} 이 쌓아둔 판정결과를 한 번의 배치 INSERT 로 저장한다. FM_LIST 1건에
	 * 대한 모든 룰 판정이 끝난 뒤, {@link #updateFrm} 호출 전에 반드시 먼저 실행해야 한다 — updateFrm
	 * 이 방금 저장한 FCR_RESULT 를 SELECT 로 재조회해 사용하기 때문이다(salesNo 전체가 아니라 FM_LIST
	 * 1건 단위로 flush 해야 하는 이유).
	 */
	public void flushPendingResults(OriginDeterminationContext ctx) {
		List<OriginDeterminationResult> pending = ctx.getPendingResults();
		if (pending.isEmpty()) {
			return;
		}
		try {
			sqlSession.getMapper(OriginDeterminationSupportDao.class).insertFcrResults(pending);
		} catch (Exception e) {
			ctx.setErrorCode("DECISION01");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("INSERT_FRD_PROCESS(배치) 실패. count={}", pending.size(), e);
		} finally {
			pending.clear();
		}
	}

	/**
	 * 레거시 UPDATE_FRM_PROCEDURE 이관: 매출 1건(FM_LIST)에 대한 모든 룰 판정이 끝난 뒤
	 * 최종 판정결과를 FCR_MST 에 반영할 갱신 1건을 확정한다. 실제 UPDATE 는 즉시 실행하지 않고
	 * {@link #flushFcrMstUpdates} 가 determineOrigin() 1회 호출이 끝난 시점에 한 번에 배치로
	 * 실행한다 — FM_LIST 행마다 서로 다른 FCR_MST 행을 갱신해 행 사이에 순서 의존성이 없으므로
	 * 모아뒀다 배치로 반영해도 결과는 동일하다.
	 *
	 * @param mode RVC_CTC 인 경우에만 "재료비가 없는 자재 존재" 오류를 검사한다(CTC 전용 모드에서는
	 *             원본에서 이 검사 블록 전체가 주석 처리되어 비활성화되어 있었다).
	 */
	public void updateFrm(OriginDeterminationContext ctx, OriginDeterminationMode mode,
			List<FcrMstDecisionUpdateRow> pendingFcrMstUpdates) {
		OriginDeterminationTarget fm = ctx.getFmData();
		// 원본은 이 프로시저 안에서 지역변수 V_FRD_REC(FCR_RESULT%ROWTYPE)를 새로 선언해 사용한다.
		// (판정 누적용 VG_FRD_REC 과는 별개의 변수)
		OriginDeterminationResult rec = new OriginDeterminationResult();

		try {
			OriginDeterminationSupportDao dao = sqlSession.getMapper(OriginDeterminationSupportDao.class);
			ctx.setReturnCode(0);

			if (ctx.getRuleCount() < 1) {
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("협정에 해당하는 HS RULE이 없습니다!!");
				ctx.setReturnCode(9);
			} else if (mode == OriginDeterminationMode.RVC_CTC && fm.hasNoMaterialAmount()) {
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("재료비가 없는 자재가 존재합니다.");
				ctx.setReturnCode(10);
			} else {
				String cooYn;
				List<OriginDeterminationResult> own = dao.selectOwnCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(),
						fm.getFtaCode(), fm.getDivisionCode(), fm.getCompanyCode());
				if (!own.isEmpty()) {
					rec = own.get(0);
					cooYn = "Y";
				} else {
					List<OriginDeterminationResult> nonCoo = dao.selectNonCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(),
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

			pendingFcrMstUpdates.add(new FcrMstDecisionUpdateRow(fm.getSalesNo(), fm.getSalesSeq(), fm.getFtaCode(),
					fm.getDivisionCode(), fm.getCompanyCode(), rec.getRuleCode(), rec.getFtaCooYn(),
					rec.getCompanyCooYn(), rec.getRcepCooNation()));
		} catch (Exception e) {
			ctx.setErrorCode("FCRMST01");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("UPDATE_FRM_PROCEDURE 실패. salesNo={}, salesSeq={}", fm.getSalesNo(), fm.getSalesSeq(), e);
		}
	}

	/**
	 * {@link #updateFrm} 이 쌓아둔 FCR_MST 갱신을 한 번의 배치 UPDATE 로 반영한다. determineOrigin()
	 * 의 FM_LIST 루프 전체가 끝난 뒤 한 번만 호출한다.
	 */
	public void flushFcrMstUpdates(List<FcrMstDecisionUpdateRow> pendingFcrMstUpdates) {
		if (pendingFcrMstUpdates.isEmpty()) {
			return;
		}
		try {
			sqlSession.getMapper(OriginDeterminationSupportDao.class).updateFcrMstDecisionResults(pendingFcrMstUpdates);
		} catch (Exception e) {
			logger.error("UPDATE_FRM_PROCEDURE(배치) 실패. count={}", pendingFcrMstUpdates.size(), e);
		} finally {
			pendingFcrMstUpdates.clear();
		}
	}

	private static void markAllNo(OriginDeterminationResult rec) {
		rec.setSpCooYn("N");
		rec.setWoCooYn("N");
		rec.setFtaCooYn("N");
		rec.setCompanyCooYn("N");
	}

	private static BigDecimal nvl(BigDecimal value) {
		return value == null ? BigDecimal.ZERO : value;
	}
}
