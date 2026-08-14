package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.kpmg.kdb.web.coodecision.dto.UpdateFrmBatchResult;
import com.kpmg.kdb.web.coodecision.dto.UpdateFrmLookupRequest;

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
	/** {@link #flushPendingResultsBatch}/{@link #resolveDeferredUpdateFrm} 배치 조회 1회당 최대 요청 건수 */
	private static final int BATCH_CHUNK_SIZE = 500;

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
				case "FTA" -> referenceDataService.getFtaBuffer(companyCode, ftaCode);
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
	 * 레거시 INSERT_FRD_PROCESS 이관: 판정결과 1건을 저장 대기열(ctx)에 담아두고 다음 룰 판정을 위해
	 * 레코드를 초기화한다. 실제 INSERT 는 즉시 실행하지 않고 {@link #flushPendingResultsBatch} 가
	 * determineOrigin() 의 FM_LIST 루프 전체가 끝난 시점에 한 번에 배치로 실행한다 — 원본은 룰마다 단건
	 * INSERT였지만, 여러 룰의 결과를 모았다가 한 번에 저장해도 (INSERT 순서에 의미가 없어) 최종 저장
	 * 결과는 같다.
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
	 * {@link #insertFrdAndReset} 이 determineOrigin() 1회 호출의 FM_LIST 행 전체에 걸쳐 쌓아둔 판정결과를
	 * 한 번에 배치 INSERT 로 저장한다. FM_LIST 루프 전체가 끝난 뒤, {@link #resolveDeferredUpdateFrm}
	 * 호출 전에 반드시 먼저 실행해야 한다 — resolveDeferredUpdateFrm 이 방금 저장한 FCR_RESULT 를 다시
	 * 조회해 사용하기 때문이다.
	 *
	 * <p>원본/이전 구현은 FM_LIST 1건(FTA 후보) 처리가 끝날 때마다 즉시 flush 했지만(그래야 바로 이어지는
	 * UPDATE_FRM_PROCEDURE 의 재조회가 방금 쓴 값을 볼 수 있으므로), 그 재조회 자체도 이제
	 * {@link #resolveDeferredUpdateFrm} 로 미뤄 FM_LIST 루프 전체가 끝난 뒤 한 번에 처리하므로, INSERT 도
	 * 같이 미뤄 determineOrigin() 1회당 왕복 횟수를 FM_LIST 행 수만큼에서 청크 단위로 줄인다.
	 */
	public void flushPendingResultsBatch(List<OriginDeterminationResult> allPendingResults) {
		if (allPendingResults.isEmpty()) {
			return;
		}
		try {
			OriginDeterminationSupportDao dao = sqlSession.getMapper(OriginDeterminationSupportDao.class);
			for (int from = 0; from < allPendingResults.size(); from += BATCH_CHUNK_SIZE) {
				List<OriginDeterminationResult> chunk = allPendingResults.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, allPendingResults.size()));
				dao.insertFcrResults(chunk);
			}
		} catch (Exception e) {
			logger.error("INSERT_FRD_PROCESS(배치) 실패. count={}", allPendingResults.size(), e);
		} finally {
			allPendingResults.clear();
		}
	}

	/**
	 * 레거시 UPDATE_FRM_PROCEDURE 앞부분(DB 조회가 필요 없는 "룰 없음"/"재료비 0원" 오류 검사)만 수행한다.
	 * 둘 중 하나에 해당하면 그 자리에서 FCR_MST 갱신 행을 바로 확정해 pendingFcrMstUpdates 에 담고, 아니면
	 * 역내산/역외산 판정결과 재조회(원본 UPDATE_FRM_PROCEDURE 뒷부분)가 필요한 FM_LIST 행으로 판단해
	 * deferredTargets 에 등록한다 — 실제 재조회는 {@link #resolveDeferredUpdateFrm} 이 FM_LIST 루프 전체가
	 * 끝난 뒤 한 번에 배치로 처리한다.
	 *
	 * @param mode RVC_CTC 인 경우에만 "재료비가 없는 자재 존재" 오류를 검사한다(CTC 전용 모드에서는
	 *             원본에서 이 검사 블록 전체가 주석 처리되어 비활성화되어 있었다).
	 */
	public void prepareUpdateFrm(OriginDeterminationContext ctx, OriginDeterminationMode mode,
			List<FcrMstDecisionUpdateRow> pendingFcrMstUpdates, List<OriginDeterminationTarget> deferredTargets) {
		OriginDeterminationTarget fm = ctx.getFmData();
		try {
			if (ctx.getRuleCount() < 1) {
				OriginDeterminationResult rec = new OriginDeterminationResult();
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("협정에 해당하는 HS RULE이 없습니다!!");
				pendingFcrMstUpdates.add(buildFcrMstUpdateRow(fm, rec));
			} else if (mode == OriginDeterminationMode.RVC_CTC && fm.hasNoMaterialAmount()) {
				OriginDeterminationResult rec = new OriginDeterminationResult();
				markAllNo(rec);
				rec.setStatus("E");
				rec.setErrorMsg("재료비가 없는 자재가 존재합니다.");
				pendingFcrMstUpdates.add(buildFcrMstUpdateRow(fm, rec));
			} else {
				deferredTargets.add(fm);
			}
		} catch (Exception e) {
			logger.error("UPDATE_FRM_PROCEDURE(사전 검사) 실패. salesNo={}, salesSeq={}", fm.getSalesNo(), fm.getSalesSeq(), e);
		}
	}

	/**
	 * {@link #prepareUpdateFrm} 이 DB 조회가 필요하다고 표시한 FM_LIST 행 전체(원본 UPDATE_FRM_PROCEDURE
	 * 뒷부분: 역내산 우선, 없으면 역외산만 존재 재조회)를 한 번의 배치 쿼리로 처리해 FCR_MST 갱신 행을
	 * 확정한다. {@link #flushPendingResultsBatch} 로 이 determineOrigin() 호출의 FCR_RESULT INSERT 가
	 * 전부 반영된 뒤에 호출해야 한다(방금 저장한 값을 재조회하므로).
	 */
	public void resolveDeferredUpdateFrm(List<OriginDeterminationTarget> deferredTargets,
			List<FcrMstDecisionUpdateRow> pendingFcrMstUpdates) {
		if (deferredTargets.isEmpty()) {
			return;
		}
		String companyCode = deferredTargets.get(0).getCompanyCode();
		String salesNo = deferredTargets.get(0).getSalesNo();
		OriginDeterminationSupportDao dao = sqlSession.getMapper(OriginDeterminationSupportDao.class);

		Map<String, UpdateFrmBatchResult> resultsByKey = new HashMap<>();
		try {
			List<UpdateFrmLookupRequest> requests = new ArrayList<>(deferredTargets.size());
			for (OriginDeterminationTarget fm : deferredTargets) {
				requests.add(new UpdateFrmLookupRequest(fm.getSalesSeq(), fm.getFtaCode(), fm.getDivisionCode()));
			}
			for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
				List<UpdateFrmLookupRequest> chunk = requests.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
				List<UpdateFrmBatchResult> results = dao.selectOwnOrNonCooFcrResultBatch(companyCode, salesNo, chunk);
				for (UpdateFrmBatchResult r : results) {
					resultsByKey.put(updateFrmKey(r.getReqSalesSeq(), r.getReqFtaCode(), r.getReqDivisionCode()), r);
				}
			}
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — resultsByKey 가 비어있으면
			// 아래에서 각 FM_LIST 행이 전부 단건 폴백 조회(selectOwnCooFcrResult/selectNonCooFcrResult)로
			// 대체된다.
			logger.error("UPDATE_FRM_PROCEDURE(배치 재조회) 실패. count={}", deferredTargets.size(), e);
		}

		for (OriginDeterminationTarget fm : deferredTargets) {
			try {
				String key = updateFrmKey(fm.getSalesSeq(), fm.getFtaCode(), fm.getDivisionCode());
				OriginDeterminationResult rec;
				if (resultsByKey.containsKey(key)) {
					UpdateFrmBatchResult r = resultsByKey.get(key);
					if (r.getMatchTier() == null) {
						rec = new OriginDeterminationResult();
						markAllNo(rec);
						rec.setStatus("E");
						rec.setErrorCode("ALL-ERROR");
					} else {
						rec = r;
					}
				} else {
					rec = resolveOwnOrNonCooFallback(dao, fm);
				}
				pendingFcrMstUpdates.add(buildFcrMstUpdateRow(fm, rec));
			} catch (Exception e) {
				logger.error("UPDATE_FRM_PROCEDURE 실패. salesNo={}, salesSeq={}", fm.getSalesNo(), fm.getSalesSeq(), e);
			}
		}
	}

	/** {@link #resolveDeferredUpdateFrm} 배치 조회에 빠진(=배치 자체가 실패한) FM_LIST 행의 단건 폴백. */
	private OriginDeterminationResult resolveOwnOrNonCooFallback(OriginDeterminationSupportDao dao, OriginDeterminationTarget fm) {
		List<OriginDeterminationResult> own = dao.selectOwnCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(), fm.getFtaCode(),
				fm.getDivisionCode(), fm.getCompanyCode());
		if (!own.isEmpty()) {
			return own.get(0);
		}
		List<OriginDeterminationResult> nonCoo = dao.selectNonCooFcrResult(fm.getSalesNo(), fm.getSalesSeq(), fm.getFtaCode(),
				fm.getDivisionCode(), fm.getCompanyCode());
		if (!nonCoo.isEmpty()) {
			return nonCoo.get(0);
		}
		OriginDeterminationResult rec = new OriginDeterminationResult();
		markAllNo(rec);
		rec.setStatus("E");
		rec.setErrorCode("ALL-ERROR");
		return rec;
	}

	private static FcrMstDecisionUpdateRow buildFcrMstUpdateRow(OriginDeterminationTarget fm, OriginDeterminationResult rec) {
		return new FcrMstDecisionUpdateRow(fm.getSalesNo(), fm.getSalesSeq(), fm.getFtaCode(), fm.getDivisionCode(),
				fm.getCompanyCode(), rec.getRuleCode(), rec.getFtaCooYn(), rec.getCompanyCooYn(), rec.getRcepCooNation());
	}

	private static String updateFrmKey(int salesSeq, String ftaCode, String divisionCode) {
		return salesSeq + "|" + nz(ftaCode) + "|" + nz(divisionCode);
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}

	/**
	 * {@link #prepareUpdateFrm}/{@link #resolveDeferredUpdateFrm} 이 쌓아둔 FCR_MST 갱신을 한 번의
	 * 배치 UPDATE 로 반영한다. determineOrigin() 의 FM_LIST 루프 전체가 끝난 뒤 한 번만 호출한다.
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
