package com.kpmg.kdb.web.origindeterminationengine;

import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.YYYYMM;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.YYYYMMDD;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.earliest;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.firstDay;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.firstDayMinusMonths;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.firstDayMinusOneDay;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.lastDay;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.lastInputYyyyMmKey;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.nz;
import static com.kpmg.kdb.web.origindeterminationengine.MaterialLookupPeriodSupport.plusDay01;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.common.CompanySettingService;
import com.kpmg.kdb.web.origindeterminationengine.dto.DivisionItemKey;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.LastInputYyyyMmResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialCandidatesBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialCandidatesRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.NonCertifiedOriginSummaryRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.NonCertifiedOriginSummaryResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginRatePrecheck;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginRateStage;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummary;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummaryBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummaryRequest;

/**
 * 원재료 역내산 비율 조회 (레거시 FC10_GET_ITEM_ORIGIN_RATE).
 *
 * 품목의 BOM 원재료/대체(FUNGIBLE) 자재별로 구매원장을 조회해 역내산 비율을 계산하고,
 * 역외산(0)이 확인되면 즉시 반환한다. FTA_CODE와 무관한 계산(precheck)과 FTA_CODE에
 * 의존하는 마지막 단계(resolveOriginRate)를 분리해, 같은 품목을 여러 FTA_CODE로 반복
 * 조회할 때 앞단을 재사용할 수 있다.
 */
@Service
public class ItemOriginRateService extends GeneralService {

	/** 조회 대상 기간(개월 수). 원본 V_MAX_MONTHS 고정값 */
	private static final int MAX_MONTHS = 6;
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private CompanySettingService companySettingService;

	public BigDecimal resolveOriginRate(ItemOriginRateCriteria criteria) {
		return resolveOriginRate(criteria, precheckOriginRate(criteria));
	}

	/** FTA_CODE와 무관한 부분만 미리 계산한다. */
	public OriginRatePrecheck precheckOriginRate(ItemOriginRateCriteria criteria) {
		return precheckOriginRate(criteria, Map.of());
	}

	/** @param lastInputYyyyMmCache 미리 조회해둔 최근 입고월 캐시(없으면 단건 조회로 대체) */
	public OriginRatePrecheck precheckOriginRate(ItemOriginRateCriteria criteria, Map<String, String> lastInputYyyyMmCache) {
		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);

			LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
			YearMonth toMonth = YearMonth.from(baseDate);
			YearMonth fromMonth = toMonth.minusMonths(MAX_MONTHS);

			List<MaterialBalanceRow> materials = dao.selectMaterialCandidates(criteria, fromMonth.format(YYYYMM),
					toMonth.format(YYYYMM));

			LookupPlan plan = buildLookupPlan(dao, criteria, materials, toMonth, lastInputYyyyMmCache);
			return assemblePrecheck(dao, criteria, plan, Map.of());
		} catch (Exception e) {
			logger.error("원재료 역내산 비율 사전조회 실패. criteria={}", criteria, e);
			return OriginRatePrecheck.zero();
		}
	}

	/** 자재별 구매원장 조회 구간을 계산한다. 재고회전 계산이 불가능하면 즉시 역외(0)로 확정한다. */
	private LookupPlan buildLookupPlan(ItemOriginRateDao dao, ItemOriginRateCriteria criteria,
			List<MaterialBalanceRow> materials, YearMonth toMonth, Map<String, String> lastInputYyyyMmCache) {
		List<StageCandidate> candidates = new ArrayList<>();
		String lastInputYyyyMm = null;
		boolean lastInputYyyyMmLoaded = false;

		for (MaterialBalanceRow material : materials) {
			String lookupStart = null;
			String lookupEnd = null;

			if (material.getMatYyyyMm() != null) {
				if (!lastInputYyyyMmLoaded) {
					String key = lastInputYyyyMmKey(criteria.getCompanyCode(), criteria.getDivisionCode(),
							criteria.getItemCode(), toMonth.format(YYYYMM));
					if (lastInputYyyyMmCache.containsKey(key)) {
						lastInputYyyyMm = lastInputYyyyMmCache.get(key);
					} else {
						lastInputYyyyMm = dao.selectLastInputYyyyMm(criteria.getCompanyCode(),
								criteria.getDivisionCode(), criteria.getItemCode(), toMonth.format(YYYYMM));
					}
					lastInputYyyyMmLoaded = true;
				}

				if (material.hasPositiveInitialQty()) {
					if (material.hasNegativeAgingPeriod()) {
						return LookupPlan.zero(); // 재고회전 계산 불능 -> 역외 확정
					}
					lookupStart = firstDayMinusMonths(material.getMatYyyyMm(), material.getMatAgingPeriod() + 1);
				}

				if (material.hasPositiveInputQty()) {
					if (lookupStart == null) {
						lookupStart = firstDay(material.getMatYyyyMm());
					}
					lookupEnd = lastDay(material.getMatYyyyMm());
				} else if (material.hasPositiveInitialQty()) {
					lookupEnd = firstDayMinusOneDay(material.getMatYyyyMm());
				} else if (material.hasPositiveAgingPeriod()) {
					lookupStart = firstDayMinusMonths(material.getMatYyyyMm(), material.getMatAgingPeriod() + 1);
					lookupEnd = firstDayMinusOneDay(material.getMatYyyyMm());
				}
			}

			if (lookupStart == null || lookupEnd == null) {
				continue;
			}

			String fromDate = earliest(plusDay01(lastInputYyyyMm), lookupStart);
			candidates.add(new StageCandidate(material.getItemCode(), fromDate, lookupEnd));
		}

		return LookupPlan.of(candidates);
	}

	/** 구매원장 집계 결과가 0건(poCount==0)인 자재를 만나면 즉시 역외(0)로 확정한다. */
	private OriginRatePrecheck assemblePrecheck(ItemOriginRateDao dao, ItemOriginRateCriteria criteria,
			LookupPlan plan, Map<String, PurchaseLedgerSummary> poSummaryCache) {
		if (plan.isZero()) {
			return OriginRatePrecheck.zero();
		}

		List<OriginRateStage> stages = new ArrayList<>();
		for (StageCandidate candidate : plan.getCandidates()) {
			String key = poSummaryKey(criteria.getCompanyCode(), candidate.getItemCode(), candidate.getFromDate(),
					candidate.getLookupEnd());
			PurchaseLedgerSummary poSummary = poSummaryCache.get(key);
			if (poSummary == null) {
				poSummary = dao.selectPurchaseLedgerSummary(criteria.getCompanyCode(), candidate.getItemCode(),
						candidate.getFromDate(), candidate.getLookupEnd());
			}
			if (poSummary.getPoCount() == 0) {
				return OriginRatePrecheck.zero();
			}

			stages.add(new OriginRateStage(candidate.getItemCode(), candidate.getFromDate(), candidate.getLookupEnd(),
					poSummary));
		}

		return OriginRatePrecheck.stages(stages);
	}

	/** FTA_CODE에 의존하는 마지막 단계. precheck는 같은 (회사/사업부/품목/기준일) 조합이면 재사용 가능. */
	public BigDecimal resolveOriginRate(ItemOriginRateCriteria criteria, OriginRatePrecheck precheck) {
		return resolveOriginRate(criteria, precheck, Map.of());
	}

	/** @param summaryCache 미리 조회해둔 비인증 원산지 구매 집계 캐시(없으면 단건 조회로 대체) */
	public BigDecimal resolveOriginRate(ItemOriginRateCriteria criteria, OriginRatePrecheck precheck,
			Map<String, PurchaseLedgerSummary> summaryCache) {
		if (precheck.isZero()) {
			return BigDecimal.ZERO;
		}
		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			BigDecimal originRate = BigDecimal.ZERO;

			for (OriginRateStage stage : precheck.getStages()) {
				String key = summaryKey(stage.getItemCode(), criteria.getFtaCode(), stage.getFromDate(), stage.getLookupEnd());
				PurchaseLedgerSummary nonCertified = summaryCache.get(key);
				if (nonCertified == null) {
					nonCertified = dao.selectNonCertifiedOriginSummary(criteria.getCompanyCode(), stage.getItemCode(),
							criteria.getFtaCode(), stage.getFromDate(), stage.getLookupEnd());
				}

				// 회사 설정(ME/IA)에 따라 금액기준(비원산지 금액 비율)/건수기준(비원산지 구매 존재 여부) 중 하나로 계산
				boolean amountBasedCalc = companySettingService.isSettingValue(criteria.getCompanyCode(), "ME", "IA");
				if (amountBasedCalc) {
					BigDecimal nonOriginAmount = nonCertified.getWarehousingAmountSum();
					BigDecimal totalAmount = stage.getPoSummary().getWarehousingAmountSum();
					if (nonOriginAmount.signum() == 0 || totalAmount.signum() == 0) {
						originRate = BigDecimal.ONE;
					} else {
						BigDecimal ratio = nonOriginAmount.divide(totalAmount, 2, RoundingMode.HALF_UP);
						originRate = BigDecimal.ONE.subtract(ratio);
					}
				} else {
					originRate = nonCertified.getPoCount() == 0 ? BigDecimal.ONE : BigDecimal.ZERO;
				}

				if (originRate.signum() == 0) {
					return BigDecimal.ZERO;
				}
			}

			return originRate;
		} catch (Exception e) {
			logger.error("원재료 역내산 비율 조회 실패. criteria={}", criteria, e);
			return BigDecimal.ZERO;
		}
	}

	/**
	 * 비인증 원산지 구매 집계를 (품목,FTA_CODE) 조합 전체에 대해 배치로 미리 조회한다.
	 * 반환된 맵을 resolveOriginRate에 그대로 넘기면 추가 DB 호출 없이 재사용한다.
	 */
	public Map<String, PurchaseLedgerSummary> prefetchNonCertifiedOriginSummaries(
			List<ItemOriginRateCriteria> criteriaList, Map<String, OriginRatePrecheck> precheckCache) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		String companyCode = criteriaList.get(0).getCompanyCode();
		Map<String, String> lastInputYyyyMmCache = prefetchLastInputYyyyMm(criteriaList);
		prefetchPurchaseLedgerSummaries(criteriaList, lastInputYyyyMmCache, precheckCache);

		List<NonCertifiedOriginSummaryRequest> requests = new ArrayList<>();
		Set<String> seenRequestKeys = new HashSet<>();

		for (ItemOriginRateCriteria criteria : criteriaList) {
			String precheckKey = precheckKey(criteria.getCompanyCode(), criteria.getDivisionCode(),
					criteria.getItemCode(), criteria.getBaseDate());
			OriginRatePrecheck precheck = precheckCache.computeIfAbsent(precheckKey,
					k -> precheckOriginRate(criteria, lastInputYyyyMmCache));
			if (precheck.isZero()) {
				continue;
			}
			for (OriginRateStage stage : precheck.getStages()) {
				String requestKey = summaryKey(stage.getItemCode(), criteria.getFtaCode(), stage.getFromDate(),
						stage.getLookupEnd());
				if (seenRequestKeys.add(requestKey)) {
					requests.add(new NonCertifiedOriginSummaryRequest(stage.getItemCode(), criteria.getFtaCode(),
							stage.getFromDate(), stage.getLookupEnd()));
				}
			}
		}

		if (requests.isEmpty()) {
			return Map.of();
		}

		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			Map<String, PurchaseLedgerSummary> summaryCache = new HashMap<>();
			BatchChunker.forEachChunk(requests, BATCH_CHUNK_SIZE, chunk -> {
				List<NonCertifiedOriginSummaryResult> results = dao.selectNonCertifiedOriginSummaryBatch(companyCode,
						chunk);
				for (NonCertifiedOriginSummaryResult r : results) {
					summaryCache.put(summaryKey(r.getItemCode(), r.getFtaCode(), r.getFromDate(), r.getToDate()),
							r.toSummary());
				}
			});
			return summaryCache;
		} catch (Exception e) {
			logger.error("비인증 원산지 구매 집계 배치조회 실패. requestCount={}", requests.size(), e);
			return Map.of();
		}
	}

	/** 자재별 최근 입고월을 (사업부,품목) 조합 전체에 대해 배치로 미리 조회한다. */
	public Map<String, String> prefetchLastInputYyyyMm(List<ItemOriginRateCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		String companyCode = criteriaList.get(0).getCompanyCode();
		LocalDate baseDate = LocalDate.parse(criteriaList.get(0).getResolvedBaseDate(), YYYYMMDD);
		String uptoYyyyMm = YearMonth.from(baseDate).format(YYYYMM);

		List<DivisionItemKey> items = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (ItemOriginRateCriteria criteria : criteriaList) {
			String key = lastInputYyyyMmKey(companyCode, criteria.getDivisionCode(), criteria.getItemCode(), uptoYyyyMm);
			if (seenKeys.add(key)) {
				items.add(new DivisionItemKey(criteria.getDivisionCode(), criteria.getItemCode()));
			}
		}

		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			Map<String, String> cache = new HashMap<>();
			BatchChunker.forEachChunk(items, BATCH_CHUNK_SIZE, chunk -> {
				List<LastInputYyyyMmResult> results = dao.selectLastInputYyyyMmBatch(companyCode, uptoYyyyMm, chunk);
				for (LastInputYyyyMmResult r : results) {
					cache.put(lastInputYyyyMmKey(companyCode, r.getDivisionCode(), r.getItemCode(), uptoYyyyMm),
							r.getLastInputYyyyMm());
				}
				// 매칭되는 원장이 없는 조합도 null로 명시해둬야 폴백 단건 조회를 다시 하지 않는다
				for (DivisionItemKey requested : chunk) {
					cache.putIfAbsent(lastInputYyyyMmKey(companyCode, requested.getDivisionCode(), requested.getItemCode(),
							uptoYyyyMm), null);
				}
			});
			return cache;
		} catch (Exception e) {
			logger.error("최근 입고월 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/** BOM 원재료/대체(FUNGIBLE) 자재 후보를 (사업부,품목,기준일) 조합 전체에 대해 배치로 미리 조회한다. */
	public Map<String, List<MaterialBalanceRow>> prefetchMaterialCandidates(List<ItemOriginRateCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		String companyCode = criteriaList.get(0).getCompanyCode();
		Map<String, MaterialCandidatesRequest> distinctRequests = new LinkedHashMap<>();
		for (ItemOriginRateCriteria criteria : criteriaList) {
			String key = precheckKey(criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode(),
					criteria.getBaseDate());
			if (!distinctRequests.containsKey(key)) {
				LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
				YearMonth toMonth = YearMonth.from(baseDate);
				YearMonth fromMonth = toMonth.minusMonths(MAX_MONTHS);
				distinctRequests.put(key, new MaterialCandidatesRequest(criteria.getDivisionCode(),
						criteria.getItemCode(), criteria.getBaseDate(), fromMonth.format(YYYYMM), toMonth.format(YYYYMM)));
			}
		}

		List<MaterialCandidatesRequest> requests = new ArrayList<>(distinctRequests.values());

		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			Map<String, List<MaterialBalanceRow>> cache = new HashMap<>();
			BatchChunker.forEachChunk(requests, BATCH_CHUNK_SIZE, chunk -> {
				List<MaterialCandidatesBatchResult> results = dao.selectMaterialCandidatesBatch(companyCode, chunk);
				for (MaterialCandidatesBatchResult r : results) {
					String key = precheckKey(companyCode, r.getReqDivisionCode(), r.getReqItemCode(), r.getReqBaseDate());
					cache.computeIfAbsent(key, k -> new ArrayList<>()).add(r.toMaterialBalanceRow());
				}
				// 매칭 자재가 없는 요청도 빈 리스트로 명시해둬야 폴백 단건 조회를 다시 하지 않는다
				for (MaterialCandidatesRequest requested : chunk) {
					String key = precheckKey(companyCode, requested.getDivisionCode(), requested.getItemCode(),
							requested.getBaseDate());
					cache.putIfAbsent(key, List.of());
				}
			});
			return cache;
		} catch (Exception e) {
			logger.error("BOM/대체자재 후보 배치조회 실패. companyCode={}, itemCount={}", companyCode, requests.size(), e);
			return Map.of();
		}
	}

	/**
	 * 구매원장 집계를 배치로 미리 조회한다. 자재 순회 도중 역외(0)로 확정되면 이후 자재는 조회하지
	 * 않는 원본 단락평가를 재현하기 위해, 먼저 조회 없이 계획(필요한 조회 후보)만 세운 뒤 그 후보들을
	 * 한 번에 배치 조회하고, 마지막에 원본과 동일한 순서로 결과를 조립한다.
	 */
	public void prefetchPurchaseLedgerSummaries(List<ItemOriginRateCriteria> criteriaList,
			Map<String, String> lastInputYyyyMmCache, Map<String, OriginRatePrecheck> precheckCache) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return;
		}

		ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
		String companyCode = criteriaList.get(0).getCompanyCode();

		Map<String, ItemOriginRateCriteria> distinctCriteria = new LinkedHashMap<>();
		for (ItemOriginRateCriteria criteria : criteriaList) {
			String precheckKey = precheckKey(criteria.getCompanyCode(), criteria.getDivisionCode(),
					criteria.getItemCode(), criteria.getBaseDate());
			distinctCriteria.putIfAbsent(precheckKey, criteria);
		}

		Map<String, List<MaterialBalanceRow>> materialCandidatesCache = prefetchMaterialCandidates(
				new ArrayList<>(distinctCriteria.values()));

		Map<String, LookupPlan> plans = new HashMap<>();
		List<PurchaseLedgerSummaryRequest> requests = new ArrayList<>();
		Set<String> seenRequestKeys = new HashSet<>();

		for (Map.Entry<String, ItemOriginRateCriteria> entry : distinctCriteria.entrySet()) {
			String precheckKey = entry.getKey();
			ItemOriginRateCriteria criteria = entry.getValue();
			try {
				LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
				YearMonth toMonth = YearMonth.from(baseDate);
				YearMonth fromMonth = toMonth.minusMonths(MAX_MONTHS);
				List<MaterialBalanceRow> materials = materialCandidatesCache.containsKey(precheckKey)
						? materialCandidatesCache.get(precheckKey)
						: dao.selectMaterialCandidates(criteria, fromMonth.format(YYYYMM), toMonth.format(YYYYMM));
				LookupPlan plan = buildLookupPlan(dao, criteria, materials, toMonth, lastInputYyyyMmCache);
				plans.put(precheckKey, plan);

				if (!plan.isZero()) {
					for (StageCandidate candidate : plan.getCandidates()) {
						String requestKey = poSummaryKey(companyCode, candidate.getItemCode(), candidate.getFromDate(),
								candidate.getLookupEnd());
						if (seenRequestKeys.add(requestKey)) {
							requests.add(new PurchaseLedgerSummaryRequest(candidate.getItemCode(), candidate.getFromDate(),
									candidate.getLookupEnd()));
						}
					}
				}
			} catch (Exception e) {
				// 이 조합만 계획 수립 실패 -> precheckCache에 안 채워지고, 호출자가 단건 조회로 재시도한다
				logger.error("구매원장 집계 사전조회 계획 수립 실패. precheckKey={}", precheckKey, e);
			}
		}

		Map<String, PurchaseLedgerSummary> poSummaryCache = new HashMap<>();
		if (!requests.isEmpty()) {
			try {
				BatchChunker.forEachChunk(requests, BATCH_CHUNK_SIZE, chunk -> {
					List<PurchaseLedgerSummaryBatchResult> results = dao.selectPurchaseLedgerSummaryBatch(companyCode,
							chunk);
					for (PurchaseLedgerSummaryBatchResult r : results) {
						poSummaryCache.put(poSummaryKey(companyCode, r.getItemCode(), r.getFromDate(), r.getToDate()),
								r.toSummary());
					}
				});
			} catch (Exception e) {
				logger.error("구매원장 집계 배치조회 실패. requestCount={}", requests.size(), e);
			}
		}

		for (Map.Entry<String, LookupPlan> entry : plans.entrySet()) {
			String precheckKey = entry.getKey();
			ItemOriginRateCriteria criteria = distinctCriteria.get(precheckKey);
			try {
				precheckCache.put(precheckKey, assemblePrecheck(dao, criteria, entry.getValue(), poSummaryCache));
			} catch (Exception e) {
				logger.error("원재료 역내산 비율 사전조회(배치 조립) 실패. precheckKey={}", precheckKey, e);
				precheckCache.put(precheckKey, OriginRatePrecheck.zero());
			}
		}
	}

	public static String precheckKey(String companyCode, String divisionCode, String itemCode, String baseDate) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
	}

	private static String summaryKey(String itemCode, String ftaCode, String fromDate, String toDate) {
		return String.join("|", nz(itemCode), nz(ftaCode), nz(fromDate), nz(toDate));
	}

	private static String poSummaryKey(String companyCode, String itemCode, String fromDate, String toDate) {
		return String.join("|", nz(companyCode), nz(itemCode), nz(fromDate), nz(toDate));
	}

	/** buildLookupPlan 결과: 역외(0)로 확정됐는지, 아니면 구매원장 조회가 필요한 자재별 후보 목록인지. */
	private static final class LookupPlan {

		private static final LookupPlan ZERO = new LookupPlan(true, List.of());

		private final boolean zero;
		private final List<StageCandidate> candidates;

		private LookupPlan(boolean zero, List<StageCandidate> candidates) {
			this.zero = zero;
			this.candidates = candidates;
		}

		static LookupPlan zero() {
			return ZERO;
		}

		static LookupPlan of(List<StageCandidate> candidates) {
			return new LookupPlan(false, candidates);
		}

		boolean isZero() {
			return zero;
		}

		List<StageCandidate> getCandidates() {
			return candidates;
		}
	}

	/** 자재 1건이 필요로 하는 구매원장 조회 키(품목코드, 조회구간). */
	private static final class StageCandidate {

		private final String itemCode;
		private final String fromDate;
		private final String lookupEnd;

		StageCandidate(String itemCode, String fromDate, String lookupEnd) {
			this.itemCode = itemCode;
			this.fromDate = fromDate;
			this.lookupEnd = lookupEnd;
		}

		String getItemCode() {
			return itemCode;
		}

		String getFromDate() {
			return fromDate;
		}

		String getLookupEnd() {
			return lookupEnd;
		}
	}
}
