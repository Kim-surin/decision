package com.kpmg.kdb.web.originbasis;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.common.CompanySettingService;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceRow;
import com.kpmg.kdb.web.originbasis.dto.NonCertifiedOriginSummaryRequest;
import com.kpmg.kdb.web.originbasis.dto.NonCertifiedOriginSummaryResult;
import com.kpmg.kdb.web.originbasis.dto.OriginRatePrecheck;
import com.kpmg.kdb.web.originbasis.dto.OriginRateStage;
import com.kpmg.kdb.web.originbasis.dto.PurchaseLedgerSummary;

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
		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);

			LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
			YearMonth toMonth = YearMonth.from(baseDate);
			YearMonth fromMonth = toMonth.minusMonths(MAX_MONTHS);

			List<MaterialBalanceRow> materials = dao.selectMaterialCandidates(criteria, fromMonth.format(YYYYMM),
					toMonth.format(YYYYMM));

			List<OriginRateStage> stages = new ArrayList<>();
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
						lastInputYyyyMm = dao.selectLastInputYyyyMm(criteria.getCompanyCode(), criteria.getDivisionCode(),
								criteria.getItemCode(), toMonth.format(YYYYMM));
						lastInputYyyyMmLoaded = true;
					}

					if (material.hasPositiveInitialQty()) {
						if (material.hasNegativeAgingPeriod()) {
							return OriginRatePrecheck.zero(); // 재고회전 계산 불능 -> 역외 확정
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

				PurchaseLedgerSummary poSummary = dao.selectPurchaseLedgerSummary(criteria.getCompanyCode(),
						material.getItemCode(), fromDate, lookupEnd);
				if (poSummary.getPoCount() == 0) {
					return OriginRatePrecheck.zero();
				}

				stages.add(new OriginRateStage(material.getItemCode(), fromDate, lookupEnd, poSummary));
			}

			return OriginRatePrecheck.stages(stages);
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN 0; 과 동일
			logger.error("원재료 역내산 비율 사전조회 실패. criteria={}", criteria, e);
			return OriginRatePrecheck.zero();
		}
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
		List<NonCertifiedOriginSummaryRequest> requests = new ArrayList<>();
		Set<String> seenRequestKeys = new HashSet<>();

		for (ItemOriginRateCriteria criteria : criteriaList) {
			String precheckKey = precheckKey(criteria.getCompanyCode(), criteria.getDivisionCode(),
					criteria.getItemCode(), criteria.getBaseDate());
			OriginRatePrecheck precheck = precheckCache.computeIfAbsent(precheckKey, k -> precheckOriginRate(criteria));
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

	/** {@link #prefetchNonCertifiedOriginSummaries} 와 {@link #resolveOriginRate} 가 공유하는 캐시 키 규칙. */
	public static String precheckKey(String companyCode, String divisionCode, String itemCode, String baseDate) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
	}

	private static String summaryKey(String itemCode, String ftaCode, String fromDate, String toDate) {
		return String.join("|", nz(itemCode), nz(ftaCode), nz(fromDate), nz(toDate));
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
}
