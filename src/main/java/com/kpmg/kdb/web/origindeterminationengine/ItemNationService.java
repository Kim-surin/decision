package com.kpmg.kdb.web.origindeterminationengine;

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
import com.kpmg.kdb.web.origindeterminationengine.dto.CooNationBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.CooNationLookupRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.DivisionItemKey;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemNationCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.LastInputYyyyMmResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceRow;

/**
 * 레거시 FC01_GET_ITEM_NATION 이관 (RCEP 자재별 원산지국가(COO_NATION) 산정).
 *
 * 대상 품목의 BOM 원재료 + 대체(FUNGIBLE) 자재 목록(C_MAT 커서)을 순회하며, 각 자재의 수불부
 * 기초정보(기초재고/당월입고/재고회전기간)로 구매원장 조회 기간을 산정한 뒤, 그 기간 동안의
 * 구매원장·원산지확인서를 조회해 COO_NATION 을 구한다. C_MAT 커서와 최근 입고월 조회는
 * {@link ItemOriginRateService}(FC10_GET_ITEM_ORIGIN_RATE)의 로직과 완전히 동일한 SQL 이라
 * {@link ItemOriginRateDao} 를 그대로 재사용한다.
 *
 * <p>원본과 동일하게, 자재 여러 건(BOM 자재 + 대체자재)이 있으면 마지막으로 처리된 건의 결과가
 * 최종 반환값이 된다(원본 V_COO_NATION 이 루프마다 덮어써지는 동작을 그대로 보존). 재고회전기간이
 * 음수(계산 불능)인 자재를 만나면 원본처럼 즉시 "0"(문자열)을 반환한다 — 국가코드가 아닌 원본의
 * 특이 센티널 값을 그대로 재현한 것이다.
 */
@Service
public class ItemNationService extends GeneralService {

	private static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;
	/** 원본 V_MAX_MONTHS NUMBER := 6 */
	private static final int MAX_MONTHS = 6;
	/** {@link #prefetchLastInputYyyyMm} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private ItemOriginRateService itemOriginRateService;

	public String resolveItemNation(ItemNationCriteria criteria) {
		return resolveItemNation(criteria, Map.of());
	}

	/**
	 * @param lastInputYyyyMmCache {@link #prefetchLastInputYyyyMm} 로 미리 배치 조회해둔 결과. 캐시에
	 *                              없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 */
	public String resolveItemNation(ItemNationCriteria criteria, Map<String, String> lastInputYyyyMmCache) {
		ItemOriginRateDao materialDao = sqlSession.getMapper(ItemOriginRateDao.class);
		ItemNationDao nationDao = sqlSession.getMapper(ItemNationDao.class);

		LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
		YearMonth toMonth = YearMonth.from(baseDate);
		YearMonth fromMonth = toMonth.minusMonths(MAX_MONTHS);

		ItemOriginRateCriteria materialCriteria = new ItemOriginRateCriteria();
		materialCriteria.setCompanyCode(criteria.getCompanyCode());
		materialCriteria.setDivisionCode(criteria.getDivisionCode());
		materialCriteria.setItemCode(criteria.getItemCode());

		List<MaterialBalanceRow> materials = materialDao.selectMaterialCandidates(materialCriteria,
				fromMonth.format(YYYYMM), toMonth.format(YYYYMM));

		LookupWindow window = computeLookupWindow(materialDao, materials, toMonth, lastInputYyyyMmCache,
				criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode());
		if (window.isZeroSentinel()) {
			// 원본 RETURN 0(NUMBER) -> VARCHAR2 함수라 암묵적으로 "0" 문자열이 반환된다. 그대로 재현.
			return "0";
		}
		if (window.isEmpty()) {
			// 원본 V_COO_NATION 초기값(NULL) 그대로 반환: 유효한 조회구간을 만든 자재가 하나도 없었던 경우
			return null;
		}

		try {
			return nationDao.selectCooNation(criteria.getCompanyCode(), criteria.getItemCode(), criteria.getHsCode(),
					window.fromDate, window.toDate);
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN NO_DATA_FOUND / WHEN OTHERS 모두 V_COO_NATION := '' 과 동일하게 처리
			logger.warn("FC01_GET_ITEM_NATION COO_NATION 조회 실패, 빈 값으로 처리. criteria={}", criteria, e);
			return "";
		}
	}

	/**
	 * {@link #resolveItemNation} 의 배치 버전. determineOrigin() 1회 호출에서 PKRRC 후보로 모인 distinct
	 * (companyCode,divisionCode,itemCode,hsCode) 조합 전체에 대해, 자재 목록 배치조회
	 * ({@link ItemOriginRateService#prefetchMaterialCandidates} 재사용) -&gt; 조회구간 계산(순수 Java,
	 * DB 호출 없음) -&gt; selectCooNation 배치조회 순으로 처리해, 조합 수만큼 반복되던 selectMaterialCandidates
	 * + selectCooNation 왕복(조합당 최대 2회)을 청크 단위 상수 회로 줄인다.
	 *
	 * @param lastInputYyyyMmCache {@link #prefetchLastInputYyyyMm} 로 미리 배치 조회해둔 결과
	 * @return (companyCode,divisionCode,itemCode,hsCode) 키(={@link #resolveItemNationResultKey}) -&gt;
	 *         COO_NATION(원본 함수 반환값과 동일 — null/""/"0"/"TT"/실제 국가코드 모두 유효한 값)
	 */
	public Map<String, String> prefetchCooNations(List<ItemNationCriteria> criteriaList,
			Map<String, String> lastInputYyyyMmCache) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		try {
			List<ItemOriginRateCriteria> materialCriteriaList = new ArrayList<>(criteriaList.size());
			for (ItemNationCriteria c : criteriaList) {
				materialCriteriaList
						.add(new ItemOriginRateCriteria(c.getCompanyCode(), c.getDivisionCode(), c.getItemCode(),
								c.getFtaCode(), c.getBaseDate()));
			}
			Map<String, List<MaterialBalanceRow>> materialsCache = itemOriginRateService
					.prefetchMaterialCandidates(materialCriteriaList);

			ItemOriginRateDao materialDao = sqlSession.getMapper(ItemOriginRateDao.class);
			Map<String, String> resolved = new HashMap<>();
			List<CooNationLookupRequest> requests = new ArrayList<>();
			Set<String> seenKeys = new HashSet<>();

			for (ItemNationCriteria criteria : criteriaList) {
				String resultKey = resolveItemNationResultKey(criteria);
				if (!seenKeys.add(resultKey)) {
					continue;
				}

				LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
				YearMonth toMonth = YearMonth.from(baseDate);
				String materialsKey = ItemOriginRateService.precheckKey(criteria.getCompanyCode(),
						criteria.getDivisionCode(), criteria.getItemCode(), criteria.getBaseDate());
				List<MaterialBalanceRow> materials = materialsCache.getOrDefault(materialsKey, List.of());

				LookupWindow window = computeLookupWindow(materialDao, materials, toMonth, lastInputYyyyMmCache,
						criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode());
				if (window.isZeroSentinel()) {
					resolved.put(resultKey, "0");
				} else if (window.isEmpty()) {
					resolved.put(resultKey, null);
				} else {
					requests.add(new CooNationLookupRequest(resultKey, criteria.getCompanyCode(), criteria.getItemCode(),
							criteria.getHsCode(), window.fromDate, window.toDate));
				}
			}

			ItemNationDao nationDao = sqlSession.getMapper(ItemNationDao.class);
			for (int from = 0; from < requests.size(); from += BATCH_CHUNK_SIZE) {
				List<CooNationLookupRequest> chunk = requests.subList(from, Math.min(from + BATCH_CHUNK_SIZE, requests.size()));
				List<CooNationBatchResult> results = nationDao.selectCooNationBatch(chunk);
				for (CooNationBatchResult r : results) {
					resolved.put(r.getReqKey(), r.getCooNation());
				}
			}
			return resolved;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveItemCooNationForRcep 이 그 자리에서 단건 조회(resolveItemNation)로 대체한다.
			logger.error("RCEP 원산지국(COO_NATION) 배치조회 실패. itemCount={}", criteriaList.size(), e);
			return Map.of();
		}
	}

	/** {@link #prefetchCooNations} 결과 캐시 키. resolveItemCooNationForRcep 이 쓰는 itemNationKey 와 동일한 구성요소. */
	public static String resolveItemNationResultKey(ItemNationCriteria criteria) {
		return String.join("|", nz(criteria.getCompanyCode()), nz(criteria.getDivisionCode()), nz(criteria.getItemCode()),
				nz(criteria.getHsCode()));
	}

	/**
	 * 자재 목록(BOM + 대체자재)을 순회하며 조회구간(fromDate/toDate)을 계산한다 — {@link #resolveItemNation}
	 * 원본 루프에서 DB 호출(selectMaterialCandidates/selectCooNation)만 뺀 순수 계산 부분을 분리한
	 * 것으로, 단건 호출과 배치 사전조회({@link #prefetchCooNations}) 양쪽에서 공유한다.
	 *
	 * <p>selectLastInputYyyyMm 폴백만 예외적으로 DB 호출을 포함한다(lastInputYyyyMmCache 캐시 미스 시에만
	 * — {@link #prefetchLastInputYyyyMm} 이 이미 채워뒀다면 발생하지 않는다).
	 */
	private LookupWindow computeLookupWindow(ItemOriginRateDao materialDao, List<MaterialBalanceRow> materials,
			YearMonth toMonth, Map<String, String> lastInputYyyyMmCache, String companyCode, String divisionCode,
			String itemCode) {
		// selectLastInputYyyyMm 의 바인딩 파라미터(companyCode/divisionCode/itemCode/toMonth)는 자재(material)와
		// 무관하게 criteria 하나로 고정돼 있어 루프 안에서 매번 다시 조회해도 같은 값이 나온다. 자재가 여러 건
		// (BOM + 대체자재)이어도 최초 1회만 조회하도록 루프 밖으로 뺐다(지연 초기화 — 필요 없으면 아예 안 부른다).
		String lastInputYyyyMm = null;
		boolean lastInputYyyyMmLoaded = false;
		// COO_NATION 조회 결과는 원본에서도 루프마다 덮어써져 "마지막으로 유효 구간을 만든 자재"의 값만
		// 최종 반환값으로 남는다 — 중간 자재들의 조회 결과는 어차피 버려지므로, 조회 자체를 뒤로 미뤄
		// 마지막 유효 구간 하나만 기억해뒀다가 루프가 끝난 뒤 딱 1번만 조회한다(반환값은 동일, DB 호출은
		// 자재 건수와 무관하게 최대 1회로 줄어든다).
		String finalFromDate = null;
		String finalLookupEnd = null;

		for (MaterialBalanceRow material : materials) {
			String lookupStart = null;
			String lookupEnd = null;

			if (material.getMatYyyyMm() != null) {
				if (!lastInputYyyyMmLoaded) {
					String key = lastInputYyyyMmKey(companyCode, divisionCode, itemCode, toMonth.format(YYYYMM));
					if (lastInputYyyyMmCache.containsKey(key)) {
						lastInputYyyyMm = lastInputYyyyMmCache.get(key);
					} else {
						lastInputYyyyMm = materialDao.selectLastInputYyyyMm(companyCode, divisionCode, itemCode,
								toMonth.format(YYYYMM));
					}
					lastInputYyyyMmLoaded = true;
				}

				if (material.hasPositiveInitialQty()) {
					if (material.hasNegativeAgingPeriod()) {
						return LookupWindow.zeroSentinel();
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

			finalFromDate = earliest(plusDay01(lastInputYyyyMm), lookupStart);
			finalLookupEnd = lookupEnd;
		}

		return finalFromDate == null ? LookupWindow.empty() : LookupWindow.of(finalFromDate, finalLookupEnd);
	}

	/** {@link #computeLookupWindow} 결과. 세 가지 상태(정상 구간/즉시 "0" 반환/구간 없음=null 반환)를 구분한다. */
	private static final class LookupWindow {
		private static final LookupWindow ZERO_SENTINEL = new LookupWindow(null, null, true, false);
		private static final LookupWindow EMPTY = new LookupWindow(null, null, false, true);

		final String fromDate;
		final String toDate;
		private final boolean zeroSentinel;
		private final boolean empty;

		private LookupWindow(String fromDate, String toDate, boolean zeroSentinel, boolean empty) {
			this.fromDate = fromDate;
			this.toDate = toDate;
			this.zeroSentinel = zeroSentinel;
			this.empty = empty;
		}

		static LookupWindow of(String fromDate, String toDate) {
			return new LookupWindow(fromDate, toDate, false, false);
		}

		static LookupWindow zeroSentinel() {
			return ZERO_SENTINEL;
		}

		static LookupWindow empty() {
			return EMPTY;
		}

		boolean isZeroSentinel() {
			return zeroSentinel;
		}

		boolean isEmpty() {
			return empty;
		}
	}

	/**
	 * {@link ItemOriginRateDao#selectLastInputYyyyMm} 이 서로 다른 품목마다 반복 호출되던 것을 배치 조회
	 * 1회로 대체하기 위한 사전조회. companyCode 는 이 호출 범위(determineOrigin() 의 RCEP FM_LIST 행
	 * 1건)에서 항상 같은 값이라 (divisionCode,itemCode,uptoYyyyMm) 조합만 배치로 조회한다 —
	 * baseDate(=invoiceDate)가 criteria 마다 다를 수 있어 uptoYyyyMm 은 캐시 키에 포함한다.
	 */
	public Map<String, String> prefetchLastInputYyyyMm(List<ItemNationCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		String companyCode = criteriaList.get(0).getCompanyCode();
		Map<String, List<DivisionItemKey>> itemsByUptoYyyyMm = new HashMap<>();
		Set<String> seenKeys = new HashSet<>();
		for (ItemNationCriteria criteria : criteriaList) {
			LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
			String uptoYyyyMm = YearMonth.from(baseDate).format(YYYYMM);
			String key = lastInputYyyyMmKey(companyCode, criteria.getDivisionCode(), criteria.getItemCode(), uptoYyyyMm);
			if (seenKeys.add(key)) {
				itemsByUptoYyyyMm.computeIfAbsent(uptoYyyyMm, k -> new ArrayList<>())
						.add(new DivisionItemKey(criteria.getDivisionCode(), criteria.getItemCode()));
			}
		}

		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			Map<String, String> cache = new HashMap<>();
			for (Map.Entry<String, List<DivisionItemKey>> entry : itemsByUptoYyyyMm.entrySet()) {
				String uptoYyyyMm = entry.getKey();
				List<DivisionItemKey> items = entry.getValue();
				for (int from = 0; from < items.size(); from += BATCH_CHUNK_SIZE) {
					List<DivisionItemKey> chunk = items.subList(from, Math.min(from + BATCH_CHUNK_SIZE, items.size()));
					List<LastInputYyyyMmResult> results = dao.selectLastInputYyyyMmBatch(companyCode, uptoYyyyMm, chunk);
					for (LastInputYyyyMmResult r : results) {
						cache.put(lastInputYyyyMmKey(companyCode, r.getDivisionCode(), r.getItemCode(), uptoYyyyMm),
								r.getLastInputYyyyMm());
					}
					// 매칭되는 자재 원장이 없는 조합은 GROUP BY 결과에 아예 나타나지 않는다 — "조회 완료,
					// 결과 NULL"로 명시해둬야 resolveItemNation 이 불필요한 단건 폴백 조회를 다시 하지 않는다.
					for (DivisionItemKey requested : chunk) {
						cache.putIfAbsent(lastInputYyyyMmKey(companyCode, requested.getDivisionCode(),
								requested.getItemCode(), uptoYyyyMm), null);
					}
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveItemNation 이 그 자리에서 단건 조회로 대체한다.
			logger.error("최근 입고월 배치조회 실패. companyCode={}", companyCode, e);
			return Map.of();
		}
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
	 * V_LAST_YYYYMM || '01' 이관. Oracle 문자열 연결(||)은 NULL 을 빈 문자열로 취급하므로
	 * V_LAST_YYYYMM 이 NULL 이면 '01' 이 된다(원본의 알려진 특이 동작을 그대로 보존).
	 */
	private static String plusDay01(String yyyyMm) {
		return (yyyyMm == null ? "" : yyyyMm) + "01";
	}

	private static String earliest(String a, String b) {
		return a.compareTo(b) < 0 ? a : b;
	}
}
