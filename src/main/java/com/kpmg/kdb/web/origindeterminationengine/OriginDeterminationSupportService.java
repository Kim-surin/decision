package com.kpmg.kdb.web.origindeterminationengine;

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
import com.kpmg.kdb.web.origindeterminationengine.dto.BufferRates;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.UpdateFrmBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.UpdateFrmLookupRequest;

/**
 * 원산지 판정(COO_DECISION) 공용 헬퍼: 버퍼율/최소공정 판단, RCEP 최대기여국 산정, 판정결과
 * 저장, FCR_MST 최종 판정결과 갱신을 담당한다.
 */
@Service
public class OriginDeterminationSupportService extends GeneralService {

	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);
	/** RCEP 최대기여국(BD20) 판단 기준 비율 */
	private static final BigDecimal RCEP_BD20_THRESHOLD = BigDecimal.valueOf(20);
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private CooDecisionReferenceDataService referenceDataService;

	/** COMPANY_OPTION(OPTION_CODE='BF') 산정기준에 따라 회사/사업부/제품군/FTA 중 하나에서 버퍼율을 조회해 컨텍스트에 채운다. */
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
			ctx.setErrorCode("GET_BUFFER");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("GET_BUFFER 실패. companyCode={}", companyCode, e);
		}
	}

	/** 최소공정 제외 품목 해당 여부('Y'/'N'). FM_LIST 1건의 모든 룰에서 조회 키가 같아 ctx에 캐싱한다. */
	public String getMinimalProcessItemYn(OriginDeterminationContext ctx, String companyCode, String divisionCode,
			String salesNo, int salesSeq) {
		if (!ctx.isMinimalProcessItemYnLoaded()) {
			long count = sqlSession.getMapper(OriginDeterminationSupportDao.class)
					.selectMinimalProcessItemCount(companyCode, divisionCode, salesNo, salesSeq);
			ctx.setMinimalProcessItemYn(count > 0 ? "Y" : "N");
		}
		return ctx.getMinimalProcessItemYn();
	}

	/** RCEP 대상 자재의 원산지국 구성(KR/RCEP역내/역외)으로 KR·RCEP·ZZ 중 판정한다. */
	public String resolveRcepNation(OriginDeterminationContext ctx) {
		List<MaterialOriginRow> rows = ctx.getMaterialOriginRows();
		if (rows.isEmpty()) {
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
		throw new IllegalStateException("RCEP 원산지 판정 결과를 산출할 수 없습니다.");
	}

	/** RCEP 부가가치기준(RVC) 비율을 계산해 최대기여국을 컨텍스트에 채운다. */
	public void resolveRcepRvcNation(OriginDeterminationContext ctx, BigDecimal amount) {
		List<MaterialOriginRow> rows = ctx.getMaterialOriginRows();

		BigDecimal nonKrInputAmount = rows.stream()
				.filter(r -> !r.isKoreaOrigin())
				.map(MaterialOriginRow::getInputAmount)
				.filter(Objects::nonNull)
				.reduce(BigDecimal.ZERO, BigDecimal::add);

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
			ctx.setRcepCooNation("Y".equals(ctx.getRcepKrYn()) ? "KR" : "");
		}
	}

	/** 판정결과를 오류로 마킹하고 다음 판정을 위해 컨텍스트 오류 상태를 초기화한다. */
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

		ctx.setReturnCode(0);
		ctx.setErrorCode("");
	}

	/** 판정결과 1건을 저장 대기열에 담고 다음 룰 판정을 위해 레코드를 초기화한다. 실제 INSERT는 flushPendingResultsBatch가 배치로 처리한다. */
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
	 * 대기열에 쌓인 판정결과를 배치 INSERT로 저장한다. FM_LIST 루프가 끝난 뒤,
	 * resolveDeferredUpdateFrm보다 먼저 호출해야 한다(그쪽이 방금 저장한 결과를 재조회하므로).
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
	 * "룰 없음"/"재료비 0원" 오류를 검사해 즉시 확정하거나, 그 외에는 판정결과 재조회가 필요한 행으로
	 * deferredTargets에 등록한다. 실제 재조회는 resolveDeferredUpdateFrm이 배치로 처리한다.
	 *
	 * @param mode RVC_CTC일 때만 "재료비 0원" 오류를 검사한다(CTC 전용 모드는 값기준 계산이 없어 미검사).
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

	/** deferredTargets 전체(역내산 우선, 없으면 역외산만 존재 재조회)를 배치로 처리해 FCR_MST 갱신 행을 확정한다. */
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

	/** 배치 조회에 빠진 FM_LIST 행의 단건 폴백 조회 */
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

	/** 대기 중인 FCR_MST 갱신을 배치 UPDATE로 반영한다. */
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
