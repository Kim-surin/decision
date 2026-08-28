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
 * RCEP 자재별 원산지국가(COO_NATION) 산정 (레거시 FC01_GET_ITEM_NATION).
 *
 * 품목의 BOM 원재료/대체(FUNGIBLE) 자재별로 수불부 기초정보로 구매원장 조회 기간을 산정한 뒤,
 * 그 기간의 구매원장·원산지확인서를 조회해 COO_NATION을 구한다. 자재가 여러 건이면 마지막으로
 * 처리된 건의 결과가 최종 반환값이 된다. 재고회전기간이 음수(계산 불능)면 "0"을 반환한다(국가코드가
 * 아닌 원본의 특이 센티널 값).
 */
@Service
public class ItemNationService extends GeneralService {

	private static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;
	private static final int MAX_MONTHS = 6;
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private ItemOriginRateService itemOriginRateService;

	public String resolveItemNation(ItemNationCriteria criteria) {
		return resolveItemNation(criteria, Map.of());
	}

	/** @param lastInputYyyyMmCache 미리 조회해둔 최근 입고월 캐시(없으면 단건 조회로 대체) */
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
			return "0";
		}
		if (window.isEmpty()) {
			return null;
		}

		try {
			return nationDao.selectCooNation(criteria.getCompanyCode(), criteria.getItemCode(), criteria.getHsCode(),
					window.fromDate, window.toDate);
		} catch (Exception e) {
			logger.warn("FC01_GET_ITEM_NATION COO_NATION 조회 실패, 빈 값으로 처리. criteria={}", criteria, e);
			return "";
		}
	}

	/**
	 * resolveItemNation의 배치 버전. distinct (회사/사업부/품목/HS코드) 조합 전체에 대해 자재 목록/조회구간을
	 * 먼저 계산하고 COO_NATION 조회만 한 번의 배치로 처리한다.
	 *
	 * @return 키(resolveItemNationResultKey) -&gt; COO_NATION(null/""/"0"/실제 국가코드 모두 유효한 값)
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
			logger.error("RCEP 원산지국(COO_NATION) 배치조회 실패. itemCount={}", criteriaList.size(), e);
			return Map.of();
		}
	}

	public static String resolveItemNationResultKey(ItemNationCriteria criteria) {
		return String.join("|", nz(criteria.getCompanyCode()), nz(criteria.getDivisionCode()), nz(criteria.getItemCode()),
				nz(criteria.getHsCode()));
	}

	/** 자재 목록(BOM+대체자재)을 순회하며 조회구간(fromDate/toDate)을 계산한다. */
	private LookupWindow computeLookupWindow(ItemOriginRateDao materialDao, List<MaterialBalanceRow> materials,
			YearMonth toMonth, Map<String, String> lastInputYyyyMmCache, String companyCode, String divisionCode,
			String itemCode) {
		String lastInputYyyyMm = null;
		boolean lastInputYyyyMmLoaded = false;
		// COO_NATION은 원본에서도 자재 루프마다 덮어써져 "마지막으로 유효 구간을 만든 자재"의 값만 남는다
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

	/** 세 가지 상태(정상 구간/즉시 "0" 반환/구간 없음=null 반환)를 구분한다. */
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

	/** 최근 입고월을 (사업부,품목,기준월) 조합 전체에 대해 배치로 미리 조회한다. */
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
					// 매칭되는 원장이 없는 조합도 null로 명시해둬야 폴백 단건 조회를 다시 하지 않는다
					for (DivisionItemKey requested : chunk) {
						cache.putIfAbsent(lastInputYyyyMmKey(companyCode, requested.getDivisionCode(),
								requested.getItemCode(), uptoYyyyMm), null);
					}
				}
			}
			return cache;
		} catch (Exception e) {
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

	/** 최근 입고월이 없으면(NULL) '01'만 남는 원본(Oracle NULL||문자열) 동작을 그대로 보존한다. */
	private static String plusDay01(String yyyyMm) {
		return (yyyyMm == null ? "" : yyyyMm) + "01";
	}

	private static String earliest(String a, String b) {
		return a.compareTo(b) < 0 ? a : b;
	}
}
