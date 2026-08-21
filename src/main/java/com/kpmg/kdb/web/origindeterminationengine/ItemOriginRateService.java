package com.kpmg.kdb.web.origindeterminationengine;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
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
 * 레거시 FC10_GET_ITEM_ORIGIN_RATE 이관 (원재료 역내산 비율 조회).
 *
 * 원본은 대상 품목의 BOM 원재료 + 대체(FUNGIBLE) 자재 목록을 커서로 순회하며, 각 자재별로 구매원장을
 * 조회해 역내산 비율을 계산하고 0(역외산)을 만나는 즉시 반환하는 단락평가(short-circuit) 구조다.
 * 자재 목록은 품목당 소량(BOM 구성 수준)이므로 청크 분할 없이 한 번의 쿼리로 전량 조회한 뒤
 * 단순 반복문으로 처리한다. (대용량 分할 처리는 다수의 판정대상 매출 건을 순회하는 상위 배치 계층에서 적용)
 *
 * <p>이 조회는 {@link ItemOriginRateCriteria#getFtaCode()} 를 마지막 단계(비인증 원산지 구매 집계,
 * {@link ItemOriginRateDao#selectNonCertifiedOriginSummary}) 에서만 쓴다. 그 앞단(대상 자재 목록,
 * 자재별 조회구간, 구매원장 집계, 그 과정에서의 0 확정)은 FTA_CODE 와 무관하다. 같은 품목을 FTA_CODE 만
 * 바꿔가며 반복 조회하는 CREATE_FCR 3-3 단계(BOM 리프 자재 × 협정 수)에서 이 앞단을 반복하지 않도록
 * {@link #precheckOriginRate}/{@link #resolveOriginRate(ItemOriginRateCriteria, OriginRatePrecheck)}
 * 로 분리해뒀다 — 호출자가 precheck 결과를 (회사/사업부/품목/기준일) 단위로 캐싱해 재사용할 수 있다.
 */
@Service
public class ItemOriginRateService extends GeneralService {

	private static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;
	/** 원본 V_MAX_MONTHS NUMBER := 6; (다른 FC10_* 함수와 달리 회사설정값이 아닌 고정값) */
	private static final int MAX_MONTHS = 6;
	/** {@link #prefetchNonCertifiedOriginSummaries} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private CompanySettingService companySettingService;

	public BigDecimal resolveOriginRate(ItemOriginRateCriteria criteria) {
		return resolveOriginRate(criteria, precheckOriginRate(criteria));
	}

	/** FTA_CODE 와 무관한 부분만 미리 계산. {@link OriginRatePrecheck} 클래스 주석 참고. */
	public OriginRatePrecheck precheckOriginRate(ItemOriginRateCriteria criteria) {
		return precheckOriginRate(criteria, Map.of());
	}

	/**
	 * @param lastInputYyyyMmCache {@link #prefetchLastInputYyyyMm} 로 미리 배치 조회해둔 결과. 캐시에 없는
	 *                              조합(호출자가 미리 넘기지 않았거나 비어있는 맵인 경우)은 그 자리에서 바로
	 *                              단건 조회로 대체한다.
	 */
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
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN 0; 과 동일
			logger.error("원재료 역내산 비율 사전조회 실패. criteria={}", criteria, e);
			return OriginRatePrecheck.zero();
		}
	}

	/**
	 * precheckOriginRate 의 순수 계산부(DB 는 selectLastInputYyyyMm 캐시 폴백만 필요하면 호출)만 떼어낸 것.
	 * {@link #prefetchPurchaseLedgerSummaries} 가 구매원장 배치 조회 전에 "어떤 (itemCode,조회구간) 조합이
	 * 필요한지"를 실제 조회 없이 먼저 계산(dry run)하기 위해 쓴다 — 자재 루프의 단락평가(재고회전 계산
	 * 불능 -> 즉시 0 확정)만 여기서 그대로 재현하고, selectPurchaseLedgerSummary 호출 자체는 하지 않는다.
	 */
	private LookupPlan buildLookupPlan(ItemOriginRateDao dao, ItemOriginRateCriteria criteria,
			List<MaterialBalanceRow> materials, YearMonth toMonth, Map<String, String> lastInputYyyyMmCache) {
		List<StageCandidate> candidates = new ArrayList<>();
		// selectLastInputYyyyMm 의 바인딩 파라미터(companyCode/divisionCode/itemCode/toMonth)는 자재(material)와
		// 무관하게 criteria 하나로 고정돼 있어 루프 안에서 매번 다시 조회해도 같은 값이 나온다. 자재가 여러 건
		// (BOM + 대체자재)이어도 최초 1회만 조회하도록 루프 밖으로 뺐다(지연 초기화 — 필요 없으면 아예 안 부른다).
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

	/**
	 * {@link #buildLookupPlan} 이 세운 계획을 실제 구매원장 집계(poSummaryCache 우선, 없으면 단건 폴백 조회)로
	 * 채워 최종 {@link OriginRatePrecheck} 를 조립한다 — 원본의 자재 순회 순서/단락평가(poCount==0 -> 즉시
	 * 0 확정)를 그대로 재현한다.
	 */
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

	/** FTA_CODE 에 의존하는 마지막 단계. precheck 는 같은 (회사/사업부/품목/기준일) 조합이면 재사용 가능. */
	public BigDecimal resolveOriginRate(ItemOriginRateCriteria criteria, OriginRatePrecheck precheck) {
		return resolveOriginRate(criteria, precheck, Map.of());
	}

	/**
	 * @param summaryCache {@link #prefetchNonCertifiedOriginSummaries} 로 미리 배치 조회해둔 결과.
	 *                      캐시에 없는 조합(호출자가 미리 넘기지 않았거나 비어있는 맵인 경우)은 그 자리에서
	 *                      바로 단건 조회로 대체한다 — 배치 사전조회는 성능 최적화일 뿐이라 누락돼도 결과가
	 *                      틀려지지 않는다.
	 */
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
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN 0; 과 동일
			logger.error("원재료 역내산 비율 조회 실패. criteria={}", criteria, e);
			return BigDecimal.ZERO;
		}
	}

	/**
	 * {@link ItemOriginRateDao#selectNonCertifiedOriginSummary} 가 (품목,FTA_CODE) 조합마다 반복 호출되던
	 * 것(예: CreateFcrService 의 BOM 리프 자재 루프 — 자재 수 × FTA_CODE 후보 수만큼 반복)을 배치 조회
	 * 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #resolveOriginRate(ItemOriginRateCriteria,
	 * OriginRatePrecheck, Map)} 에 그대로 넘기면 그 안에서 추가 DB 호출 없이 값을 재사용한다.
	 *
	 * <p>precheck 는 FTA_CODE 와 무관하므로 (companyCode,divisionCode,itemCode,baseDate) 조합별로 1회만
	 * 계산해 precheckCache 에 채운다 — 호출자가 이후 resolveOriginRateCached 등에서 같은 맵을 계속
	 * 재사용할 수 있도록 호출자가 만든 맵을 그대로 받는다. 이미 0으로 확정된(precheck.isZero()) 조합은
	 * 배치 요청에서 제외한다(어차피 FTA_CODE 조회 없이 0이 확정되므로).
	 *
	 * <p>기존 단건 경로는 자재의 여러 단계(stages) 중 앞 단계에서 이미 비율이 0으로 확정되면 뒤 단계는
	 * 조회를 건너뛰는 단락평가를 했지만, 이 배치 조회는 어차피 한 번의 SQL 호출로 묶이므로 그 단락평가로
	 * 아낄 수 있었던 개별 쿼리 1~2건보다 (품목×FTA_CODE) 조합 수만큼의 왕복을 통째로 없애는 효과가 훨씬
	 * 크다고 판단해 모든 단계를 한 번에 조회한다 — 최종 계산 결과(originRate)는 어느 단계를 조회했는지가
	 * 아니라 단계별 결과를 어떻게 조합하는지로 결정되므로 동일하다.
	 */
	public Map<String, PurchaseLedgerSummary> prefetchNonCertifiedOriginSummaries(
			List<ItemOriginRateCriteria> criteriaList, Map<String, OriginRatePrecheck> precheckCache) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		// 배치 호출 1회는 항상 같은 회사 스코프(createFcr() 1회 호출)에서만 이뤄지므로 첫 건의 companyCode 를 사용한다.
		String companyCode = criteriaList.get(0).getCompanyCode();
		// precheckOriginRate 내부에서 자재(material) 건별로 반복 조회되던 selectLastInputYyyyMm 도
		// 여기서 미리 한 번에 배치 조회해둔다(자재와 무관하게 (company,division,item,baseDate) 조합
		// 하나로 고정된 값이라 자재 루프 안에서는 최초 1회만 쓰이지만, 서로 다른 품목끼리는 여전히
		// 품목 수만큼 반복 호출되고 있었다).
		Map<String, String> lastInputYyyyMmCache = prefetchLastInputYyyyMm(criteriaList);
		// precheckOriginRate 안에서 자재(material) 건별로 반복 조회되던 selectPurchaseLedgerSummary 도 여기서
		// 미리 배치 조회해 precheckCache 를 채운다 — 아래 루프의 computeIfAbsent 는 이미 채워진 항목에 대해
		// 폴백 단건 호출 없이 바로 캐시를 재사용하게 된다(prefetchPurchaseLedgerSummaries 클래스 주석 참고).
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
			// 요청 건수가 아주 많은 경우(대량 BOM 자재 x 다수 FTA_CODE)를 대비해 CreateFcrService 의 다건
			// INSERT 청크 크기(500)와 동일한 단위로 나눠 호출한다(바인드 파라미터 수 상한 방지).
			for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
				List<NonCertifiedOriginSummaryRequest> chunk = requests.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
				List<NonCertifiedOriginSummaryResult> results = dao.selectNonCertifiedOriginSummaryBatch(companyCode,
						chunk);
				for (NonCertifiedOriginSummaryResult r : results) {
					summaryCache.put(summaryKey(r.getItemCode(), r.getFtaCode(), r.getFromDate(), r.getToDate()),
							r.toSummary());
				}
			}
			return summaryCache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveOriginRate 가 그 자리에서 단건 조회로 대체한다(클래스 상단 summaryCache 파라미터 설명 참고).
			logger.error("비인증 원산지 구매 집계 배치조회 실패. requestCount={}", requests.size(), e);
			return Map.of();
		}
	}

	/**
	 * {@link ItemOriginRateDao#selectLastInputYyyyMm} 이 서로 다른 품목마다(BOM 리프 자재 종류 수만큼)
	 * 반복 호출되던 것을 배치 조회 1회로 대체하기 위한 사전조회. companyCode/uptoYyyyMm(기준월)은 이
	 * 호출 범위(createFcr() 1회 호출, 단일 salesNo)에서 항상 같은 값이라 (divisionCode,itemCode)
	 * 조합만 배치로 조회한다.
	 */
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
			for (int from = 0; from < items.size(); from += BATCH_CHUNK_SIZE) {
				List<DivisionItemKey> chunk = items.subList(from, Math.min(from + BATCH_CHUNK_SIZE, items.size()));
				List<LastInputYyyyMmResult> results = dao.selectLastInputYyyyMmBatch(companyCode, uptoYyyyMm, chunk);
				for (LastInputYyyyMmResult r : results) {
					cache.put(lastInputYyyyMmKey(companyCode, r.getDivisionCode(), r.getItemCode(), uptoYyyyMm),
							r.getLastInputYyyyMm());
				}
				// 매칭되는 자재 원장이 없는 (divisionCode,itemCode) 는 GROUP BY 결과에 아예 나타나지 않는다.
				// 그 값도 "조회 완료, 결과 NULL"로 명시해둬야 precheckOriginRate 가 불필요한 단건 폴백
				// 조회를 다시 하지 않는다(원본 MAX(...)=NULL 1행과 동등한 결과이므로 null 로 채운다).
				for (DivisionItemKey requested : chunk) {
					cache.putIfAbsent(lastInputYyyyMmKey(companyCode, requested.getDivisionCode(), requested.getItemCode(),
							uptoYyyyMm), null);
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// precheckOriginRate 가 그 자리에서 단건 조회로 대체한다.
			logger.error("최근 입고월 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/**
	 * {@link ItemOriginRateDao#selectMaterialCandidates}(C_MAT 커서)가 precheckOriginRate/
	 * {@link #prefetchPurchaseLedgerSummaries} 안에서 distinct 품목마다 반복 호출되던 것을 배치 조회
	 * 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #buildLookupPlan} 호출 전에 조회해 넘기면 그 안에서
	 * 추가 DB 호출 없이 값을 재사용한다.
	 *
	 * <p>단건 조회는 요청 1건당 0~N 행(BOM 자재 0/1건 + 대체(FUNGIBLE) 자재 0..N건)을 돌려주는 다중행
	 * 커서라, 다른 배치 조회들(top-1 LATERAL 방식)과 달리 {@link ItemOriginRateDao#selectMaterialCandidatesBatch}
	 * 는 요청받은 (divisionCode,itemCode,조회구간) 조합 전체를 UNION ALL 파생 테이블로 넘겨 원본과 동일한
	 * JOIN 구조로 다중행을 그대로 받는다(ItemOriginRateDaoMapper.xml 의 쿼리 주석 참고). 매칭되는 자재가
	 * 하나도 없는 요청은 결과에 나타나지 않으므로, 그 경우도 빈 리스트로 명시적으로 채워 "조회 완료, 결과
	 * 없음"과 "아직 조회 안 함"을 구분한다.
	 */
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
			for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
				List<MaterialCandidatesRequest> chunk = requests.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
				List<MaterialCandidatesBatchResult> results = dao.selectMaterialCandidatesBatch(companyCode, chunk);
				for (MaterialCandidatesBatchResult r : results) {
					String key = precheckKey(companyCode, r.getReqDivisionCode(), r.getReqItemCode(), r.getReqBaseDate());
					cache.computeIfAbsent(key, k -> new ArrayList<>()).add(r.toMaterialBalanceRow());
				}
				// 매칭되는 자재가 하나도 없는 요청은 결과에 아예 나타나지 않는다 — "조회 완료, 결과 없음"을
				// 명시적으로 빈 리스트로 채워둬야 호출자가 불필요한 단건 폴백 조회를 다시 하지 않는다.
				for (MaterialCandidatesRequest requested : chunk) {
					String key = precheckKey(companyCode, requested.getDivisionCode(), requested.getItemCode(),
							requested.getBaseDate());
					cache.putIfAbsent(key, List.of());
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// prefetchPurchaseLedgerSummaries 가 그 자리에서 단건 조회로 대체한다.
			logger.error("BOM/대체자재 후보 배치조회 실패. companyCode={}, itemCount={}", companyCode, requests.size(), e);
			return Map.of();
		}
	}

	/**
	 * {@link ItemOriginRateDao#selectPurchaseLedgerSummary} 가 precheckOriginRate 의 자재(material) 루프
	 * 안에서 자재별로(그리고 서로 다른 품목끼리는 품목 수만큼) 반복 호출되던 것을 배치 조회 1회로 대체하기
	 * 위한 사전조회.
	 *
	 * <p>이 조회는 자재 루프 도중 poCount==0 을 만나면 즉시 0으로 확정하고 뒤 자재는 조회조차 하지 않는
	 * 단락평가 구조라(precheckOriginRate 주석 참고), 무엇을 조회해야 하는지 자체가 "먼저 조회해봐야" 알 수
	 * 있는 순서 의존적 구조다. 이를 3단계로 나눠 해결한다.
	 * <ol>
	 *   <li>계획 수립(dry run): distinct (company,division,item,baseDate) 조합마다 {@link #buildLookupPlan}
	 *       으로 실제 구매원장 조회 없이 "필요한 (itemCode,조회구간) 후보 목록"만 계산한다(재고회전 계산
	 *       불능으로 인한 0 확정은 이 단계에서 이미 반영됨).</li>
	 *   <li>배치 조회: 모든 조합의 후보를 합집합으로 모아 {@link ItemOriginRateDao#selectPurchaseLedgerSummaryBatch}
	 *       로 한 번에 조회한다.</li>
	 *   <li>조립(assemble): {@link #assemblePrecheck} 로 원본과 동일한 자재 순회 순서 및 단락평가
	 *       (poCount==0 을 만나는 자재에서 즉시 0 확정, 그 뒤 자재는 결과에 반영하지 않음)를 그대로
	 *       재현해 최종 {@link OriginRatePrecheck} 를 만든다.</li>
	 * </ol>
	 *
	 * <p>원래 단락평가로 아낄 수 있었던 건 조합당 자재 후반부의 개별 쿼리 몇 건인데, 이 배치 조회는 그
	 * 자재들의 조회구간도 (어차피 한 번의 SQL 호출에 묶이므로) 함께 조회해버린다 — 소량 추가 조회를
	 * 대가로 (품목 수)만큼의 왕복 자체를 없애는 효과가 훨씬 크다고 판단했다(다른 배치화 지점과 동일한
	 * 트레이드오프).
	 *
	 * <p>결과는 {@code precheckCache} 에 (계획을 세울 수 있었던 조합에 한해) 직접 채워 넣는다 — 이 맵은
	 * {@link #prefetchNonCertifiedOriginSummaries} 가 이어서 쓰는 것과 같은 맵이라, 그쪽의
	 * {@code computeIfAbsent} 호출이 이미 채워진 항목에 대해 폴백 단건 조회 없이 캐시를 그대로 재사용하게
	 * 된다(계획 수립 단계에서 예외가 나 caching 되지 못한 조합만 그 폴백 경로로 처리됨 — defensive).
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

		// selectMaterialCandidates(C_MAT 커서) 도 distinct 품목 수만큼 반복 호출되던 것을 여기서 미리
		// 배치 조회해둔다 — prefetchMaterialCandidates 클래스 주석 참고.
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
				// 이 조합만 계획 수립 실패 -> plans 에 없으므로 아래 조립 단계에서 precheckCache 에 채워지지
				// 않고, prefetchNonCertifiedOriginSummaries 의 computeIfAbsent 가 단건 precheckOriginRate 로
				// 재시도한다(defensive fallback).
				logger.error("구매원장 집계 사전조회 계획 수립 실패. precheckKey={}", precheckKey, e);
			}
		}

		Map<String, PurchaseLedgerSummary> poSummaryCache = new HashMap<>();
		if (!requests.isEmpty()) {
			try {
				// CreateFcrService 의 다건 INSERT 청크 크기(500)와 동일한 단위로 나눠 호출한다(바인드
				// 파라미터 수 상한 방지).
				for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
					List<PurchaseLedgerSummaryRequest> chunk = requests.subList(from,
							Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
					List<PurchaseLedgerSummaryBatchResult> results = dao.selectPurchaseLedgerSummaryBatch(companyCode,
							chunk);
					for (PurchaseLedgerSummaryBatchResult r : results) {
						poSummaryCache.put(poSummaryKey(companyCode, r.getItemCode(), r.getFromDate(), r.getToDate()),
								r.toSummary());
					}
				}
			} catch (Exception e) {
				// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — poSummaryCache 가
				// 비어있으면 assemblePrecheck 가 그 자리에서 단건 조회로 대체한다.
				logger.error("구매원장 집계 배치조회 실패. requestCount={}", requests.size(), e);
			}
		}

		for (Map.Entry<String, LookupPlan> entry : plans.entrySet()) {
			String precheckKey = entry.getKey();
			ItemOriginRateCriteria criteria = distinctCriteria.get(precheckKey);
			try {
				precheckCache.put(precheckKey, assemblePrecheck(dao, criteria, entry.getValue(), poSummaryCache));
			} catch (Exception e) {
				// 원본 EXCEPTION WHEN OTHERS THEN RETURN 0; 과 동일
				logger.error("원재료 역내산 비율 사전조회(배치 조립) 실패. precheckKey={}", precheckKey, e);
				precheckCache.put(precheckKey, OriginRatePrecheck.zero());
			}
		}
	}

	/** {@link #prefetchNonCertifiedOriginSummaries} 와 {@link #resolveOriginRate} 가 공유하는 캐시 키 규칙. */
	public static String precheckKey(String companyCode, String divisionCode, String itemCode, String baseDate) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
	}

	private static String summaryKey(String itemCode, String ftaCode, String fromDate, String toDate) {
		return String.join("|", nz(itemCode), nz(ftaCode), nz(fromDate), nz(toDate));
	}

	private static String poSummaryKey(String companyCode, String itemCode, String fromDate, String toDate) {
		return String.join("|", nz(companyCode), nz(itemCode), nz(fromDate), nz(toDate));
	}

	private static String lastInputYyyyMmKey(String companyCode, String divisionCode, String itemCode, String uptoYyyyMm) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(uptoYyyyMm));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}

	private static String firstDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).format(YYYYMMDD);
	}

	private static String firstDayMinusMonths(String yyyyMm, int months) {
		return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).minusMonths(months).format(YYYYMMDD);
	}

	private static String firstDayMinusOneDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).minusDays(1).format(YYYYMMDD);
	}

	private static String lastDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atEndOfMonth().format(YYYYMMDD);
	}

	/**
	 * V_LAST_YYYYMM || '01' 을 이관한 값. Oracle 의 문자열 연결(||)은 NULL 을 빈 문자열로 취급하므로
	 * V_LAST_YYYYMM 이 NULL 이면 '01' 이 된다(원본의 알려진 특이 동작을 그대로 보존).
	 */
	private static String plusDay01(String yyyyMm) {
		return (yyyyMm == null ? "" : yyyyMm) + "01";
	}

	private static String earliest(String a, String b) {
		return a.compareTo(b) < 0 ? a : b;
	}

	/**
	 * {@link #buildLookupPlan} 결과: 이미 0(역외산)으로 확정됐는지, 아니면 구매원장 조회가 필요한 자재별
	 * 후보(candidates) 목록인지. {@link OriginRatePrecheck} 와 형태는 비슷하지만 구매원장 집계값이 아직
	 * 채워지지 않은 "조회 계획" 단계라는 점이 다르다 — dto 패키지로 옮기지 않고 이 클래스 내부 구현
	 * 상세로만 쓴다.
	 */
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

	/** {@link LookupPlan} 1건(자재 1건)이 필요로 하는 구매원장 조회 키(itemCode, 조회구간). */
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
