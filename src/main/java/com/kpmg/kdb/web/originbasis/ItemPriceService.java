package com.kpmg.kdb.web.originbasis;

import java.math.BigDecimal;
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
import com.kpmg.kdb.web.originbasis.dto.DivisionItemKey;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceWithNote;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierBatchResult;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceBatchResult;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.originbasis.dto.StandardCostBatchResult;
import com.kpmg.kdb.web.originbasis.dto.StandardCostRow;

/**
 * 레거시 FC10_GET_ITEM_PRICE 이관. FC10_GET_ITEM_PRICE_NOTE(근거 텍스트)는 별도로 조회하지 않는다.
 *
 * 원본은 "재료 단가"(FC10_GET_ITEM_PRICE)와 "그 근거"(FC10_GET_ITEM_PRICE_NOTE)가 각각 독립적으로
 * 4단계 fallback(수불부-자기PLANT → 수불부-타PLANT → 구매단가 → 표준원가)을 조회하는 별개 함수였고,
 * 단계별 조회조건/공식이 완전히 같지는 않았다(예: 수불부 단계의 MAX(YYYYMM) 판단 기준이 서로 다름).
 * 이 이관에서는 근거 텍스트를 위한 별도 조회를 하지 않고, {@link #resolveItemPriceWithNote} 가
 * FC10_GET_ITEM_PRICE 쪽 조회에서 가격(price &gt; 0)을 찾은 바로 그 행의 데이터로 근거 텍스트를
 * 함께 만든다 — 쿼리 결과가 원본 NOTE 함수의 것과 정확히 일치하지 않을 수 있음을 감수한 단순화다.
 *
 * <p>1~2단계(자기 PLANT/전체 PLANT)는 {@link ItemPriceDao#selectDivisionBalanceForPrice} 단일 쿼리로
 * 통합했다(왕복 1회로 축소 — ItemPriceDaoMapper.xml 의 쿼리 주석 참고). 3단계(구매단가)는 원본에서도
 * 두 함수가 완전히 동일한 조회였다.
 */
@Service
public class ItemPriceService extends GeneralService {

	private static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;

	/** {@link #prefetchRecentPurchasePrices} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

	@Autowired
	private CompanySettingService companySettingService;

	public BigDecimal resolveItemPrice(ItemPriceCriteria criteria) {
		return resolveItemPrice(criteria, Map.of(), Map.of(), Map.of());
	}

	/**
	 * @param divisionBalanceCache {@link #prefetchDivisionBalanceForPrice} 로 미리 배치 조회해둔 1단계(수불부)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 * @param purchasePriceCache   {@link #prefetchRecentPurchasePrices} 로 미리 배치 조회해둔 3단계(구매단가)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 * @param standardCostCache    {@link #prefetchStandardCostByDivision} 로 미리 배치 조회해둔 4단계(표준원가)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 */
	public BigDecimal resolveItemPrice(ItemPriceCriteria criteria, Map<String, MaterialBalanceTierRow> divisionBalanceCache,
			Map<String, PoLedgerPriceRow> purchasePriceCache, Map<String, StandardCostRow> standardCostCache) {
		return resolveItemPriceWithNote(criteria, divisionBalanceCache, purchasePriceCache, standardCostCache).getPrice();
	}

	public ItemPriceWithNote resolveItemPriceWithNote(ItemPriceCriteria criteria) {
		return resolveItemPriceWithNote(criteria, Map.of(), Map.of(), Map.of());
	}

	/**
	 * FC10_GET_ITEM_PRICE 4단계 fallback(수불부-자기/전체PLANT → 구매단가 → 표준원가-division → 표준원가-전체)을
	 * 순서대로 조회하다 가격(price &gt; 0)을 찾으면, 별도 조회 없이 그 행의 데이터로 근거 텍스트(NOTE)도
	 * 함께 만들어 돌려준다 — 클래스 주석 참고.
	 *
	 * @param divisionBalanceCache {@link #prefetchDivisionBalanceForPrice} 로 미리 배치 조회해둔 1단계(수불부)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 * @param purchasePriceCache   {@link #prefetchRecentPurchasePrices} 로 미리 배치 조회해둔 3단계(구매단가)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 * @param standardCostCache    {@link #prefetchStandardCostByDivision} 로 미리 배치 조회해둔 4단계(표준원가)
	 *                              결과. 캐시에 없는 조합은 그 자리에서 바로 단건 조회로 대체한다.
	 */
	public ItemPriceWithNote resolveItemPriceWithNote(ItemPriceCriteria criteria,
			Map<String, MaterialBalanceTierRow> divisionBalanceCache, Map<String, PoLedgerPriceRow> purchasePriceCache,
			Map<String, StandardCostRow> standardCostCache) {
		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			LookupWindow window = LookupWindow.of(criteria, maxMonths(criteria));

			MaterialBalanceTierRow division = lookupDivisionBalance(dao, criteria, window, divisionBalanceCache);
			BigDecimal price = priceIfPositive(division, MaterialBalanceTierRow::calculatePriceForPrice);
			if (price != null) {
				return new ItemPriceWithNote(price, division.buildPriceNoteText());
			}

			PoLedgerPriceRow purchase = lookupRecentPurchasePrice(dao, criteria, window, purchasePriceCache);
			price = priceIfPositive(purchase, PoLedgerPriceRow::getUnitPrice);
			if (price != null) {
				return new ItemPriceWithNote(price, purchase.buildPriceNoteText());
			}

			StandardCostRow standard = lookupStandardCostByDivision(dao, criteria, standardCostCache);
			price = priceIfPositive(standard, StandardCostRow::getStandardCostAmount);
			if (price != null) {
				return new ItemPriceWithNote(price, standard.buildPriceNoteText());
			}

			StandardCostRow anyDivision = dao.selectStandardCostAnyDivision(criteria);
			price = priceIfPositive(anyDivision, StandardCostRow::getStandardCostAmount);
			if (price != null) {
				return new ItemPriceWithNote(price, anyDivision.buildPriceNoteText());
			}

			return new ItemPriceWithNote(null, null);
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN NULL; 과 동일
			logger.error("재료비 조회 실패. criteria={}", criteria, e);
			return new ItemPriceWithNote(null, null);
		}
	}

	private MaterialBalanceTierRow lookupDivisionBalance(ItemPriceDao dao, ItemPriceCriteria criteria, LookupWindow window,
			Map<String, MaterialBalanceTierRow> divisionBalanceCache) {
		String key = divisionBalanceKey(criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode(),
				window.fromYyyyMm, window.toYyyyMm);
		if (divisionBalanceCache.containsKey(key)) {
			return divisionBalanceCache.get(key);
		}
		return dao.selectDivisionBalanceForPrice(criteria, window.fromYyyyMm, window.toYyyyMm);
	}

	private PoLedgerPriceRow lookupRecentPurchasePrice(ItemPriceDao dao, ItemPriceCriteria criteria, LookupWindow window,
			Map<String, PoLedgerPriceRow> purchasePriceCache) {
		String key = purchasePriceKey(criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode(),
				window.fromYyyyMmdd, window.toYyyyMmdd);
		if (purchasePriceCache.containsKey(key)) {
			return purchasePriceCache.get(key);
		}
		return dao.selectRecentPurchasePrice(criteria, window.fromYyyyMmdd, window.toYyyyMmdd);
	}

	private StandardCostRow lookupStandardCostByDivision(ItemPriceDao dao, ItemPriceCriteria criteria,
			Map<String, StandardCostRow> standardCostCache) {
		String key = standardCostKey(criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getItemCode(),
				criteria.getResolvedBaseDate());
		if (standardCostCache.containsKey(key)) {
			return standardCostCache.get(key);
		}
		return dao.selectStandardCostByDivision(criteria);
	}

	/**
	 * {@link ItemPriceDao#selectDivisionBalanceForPrice} 가 BOM 리프 자재마다 반복 호출되던 것을 배치 조회
	 * 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #resolveItemPrice(ItemPriceCriteria, Map, Map, Map)}/
	 * {@link #resolveItemPriceWithNote(ItemPriceCriteria, Map, Map, Map)} 에 그대로 넘기면 그 안에서 추가
	 * DB 호출 없이 값을 재사용한다. 1단계(수불부)는 항상(무조건) 시도되는 첫 단계라 대상 자재 전체가
	 * 그대로 배치 조회 대상이다(3~4단계 사전조회처럼 "어디까지 내려올지 몰라 전체를 미리 조회"하는
	 * 것과 달리, 여기는 전량이 확실히 필요하다).
	 */
	public Map<String, MaterialBalanceTierRow> prefetchDivisionBalanceForPrice(List<ItemPriceCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		ItemPriceCriteria first = criteriaList.get(0);
		String companyCode = first.getCompanyCode();
		LookupWindow window = LookupWindow.of(first, maxMonths(first));

		List<DivisionItemKey> items = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (ItemPriceCriteria criteria : criteriaList) {
			String key = divisionBalanceKey(companyCode, criteria.getDivisionCode(), criteria.getItemCode(),
					window.fromYyyyMm, window.toYyyyMm);
			if (seenKeys.add(key)) {
				items.add(new DivisionItemKey(criteria.getDivisionCode(), criteria.getItemCode()));
			}
		}

		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			Map<String, MaterialBalanceTierRow> cache = new HashMap<>();
			for (int from = 0; from < items.size(); from += BATCH_CHUNK_SIZE) {
				List<DivisionItemKey> chunk = items.subList(from, Math.min(from + BATCH_CHUNK_SIZE, items.size()));
				List<MaterialBalanceTierBatchResult> results = dao.selectDivisionBalanceForPriceBatch(companyCode,
						window.fromYyyyMm, window.toYyyyMm, chunk);
				for (MaterialBalanceTierBatchResult r : results) {
					cache.put(divisionBalanceKey(companyCode, r.getReqDivisionCode(), r.getReqItemCode(),
							window.fromYyyyMm, window.toYyyyMm), r.toRowOrNull());
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveItemPrice/resolveItemPriceWithNote 가 그 자리에서 단건 조회로 대체한다.
			logger.error("수불부 단가(1단계) 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/**
	 * {@link ItemPriceDao#selectRecentPurchasePrice} 가 BOM 리프 자재마다 반복 호출되던 것을 배치 조회
	 * 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #resolveItemPrice(ItemPriceCriteria, Map, Map, Map)}/
	 * {@link #resolveItemPriceWithNote(ItemPriceCriteria, Map, Map, Map)} 에 그대로 넘기면 그 안에서 추가 DB
	 * 호출 없이 값을 재사용한다.
	 *
	 * <p>이 조회는 1~2단계(수불부)에서 이미 가격을 찾은 자재에는 필요 없지만, 어떤 자재가 거기서 실패해
	 * 3단계까지 내려올지는 그 단계를 먼저 실행해봐야 알 수 있다. 그래서 대상 자재 전체에 대해 미리
	 * 한 번에 조회해두고, 실제로 3단계까지 내려온 자재만 캐시에서 값을 꺼내 쓴다 — 쓰이지 않는 조회
	 * 결과가 일부 섞이더라도, 자재 수만큼 반복되던 왕복을 통째로 없애는 효과가 더 크다.
	 */
	public Map<String, PoLedgerPriceRow> prefetchRecentPurchasePrices(List<ItemPriceCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		ItemPriceCriteria first = criteriaList.get(0);
		String companyCode = first.getCompanyCode();
		LookupWindow window = LookupWindow.of(first, maxMonths(first));

		List<DivisionItemKey> items = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (ItemPriceCriteria criteria : criteriaList) {
			String key = purchasePriceKey(companyCode, criteria.getDivisionCode(), criteria.getItemCode(),
					window.fromYyyyMmdd, window.toYyyyMmdd);
			if (seenKeys.add(key)) {
				items.add(new DivisionItemKey(criteria.getDivisionCode(), criteria.getItemCode()));
			}
		}

		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			Map<String, PoLedgerPriceRow> cache = new HashMap<>();
			for (int from = 0; from < items.size(); from += BATCH_CHUNK_SIZE) {
				List<DivisionItemKey> chunk = items.subList(from, Math.min(from + BATCH_CHUNK_SIZE, items.size()));
				List<PoLedgerPriceBatchResult> results = dao.selectRecentPurchasePriceBatch(companyCode,
						window.fromYyyyMmdd, window.toYyyyMmdd, chunk);
				for (PoLedgerPriceBatchResult r : results) {
					cache.put(purchasePriceKey(companyCode, r.getReqDivisionCode(), r.getReqItemCode(),
							window.fromYyyyMmdd, window.toYyyyMmdd), r.toRowOrNull());
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveItemPrice/resolveItemPriceWithNote 가 그 자리에서 단건 조회로 대체한다.
			logger.error("최근 구매단가 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/**
	 * {@link ItemPriceDao#selectStandardCostByDivision} 이 BOM 리프 자재마다 반복 호출되던 것을 배치 조회
	 * 1회로 대체하기 위한 사전조회. 반환된 맵을 {@link #resolveItemPrice(ItemPriceCriteria, Map, Map)}/
	 * {@link #resolveItemPriceWithNote(ItemPriceCriteria, Map, Map)} 에 그대로 넘기면 그 안에서 추가 DB
	 * 호출 없이 값을 재사용한다.
	 *
	 * <p>{@link #prefetchRecentPurchasePrices} 와 동일한 이유로(1~3단계에서 이미 가격을 찾은 자재에는
	 * 이 4단계 조회가 애초에 필요 없지만, 어떤 자재가 거기까지 내려올지는 먼저 실행해봐야 안다) 대상
	 * 자재 전체에 대해 미리 한 번에 조회해두고, 실제로 4단계까지 내려온 자재만 캐시에서 값을 꺼내 쓴다.
	 */
	public Map<String, StandardCostRow> prefetchStandardCostByDivision(List<ItemPriceCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		ItemPriceCriteria first = criteriaList.get(0);
		String companyCode = first.getCompanyCode();
		String baseDate = first.getResolvedBaseDate();

		List<DivisionItemKey> items = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (ItemPriceCriteria criteria : criteriaList) {
			String key = standardCostKey(companyCode, criteria.getDivisionCode(), criteria.getItemCode(), baseDate);
			if (seenKeys.add(key)) {
				items.add(new DivisionItemKey(criteria.getDivisionCode(), criteria.getItemCode()));
			}
		}

		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			Map<String, StandardCostRow> cache = new HashMap<>();
			for (int from = 0; from < items.size(); from += BATCH_CHUNK_SIZE) {
				List<DivisionItemKey> chunk = items.subList(from, Math.min(from + BATCH_CHUNK_SIZE, items.size()));
				List<StandardCostBatchResult> results = dao.selectStandardCostByDivisionBatch(companyCode, baseDate,
						chunk);
				for (StandardCostBatchResult r : results) {
					cache.put(standardCostKey(companyCode, r.getReqDivisionCode(), r.getReqItemCode(), baseDate),
							r.toRowOrNull());
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveItemPrice/resolveItemPriceWithNote 가 그 자리에서 단건 조회로 대체한다.
			logger.error("표준원가 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	private static String divisionBalanceKey(String companyCode, String divisionCode, String itemCode, String fromYyyyMm,
			String toYyyyMm) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(fromYyyyMm), nz(toYyyyMm));
	}

	private static String purchasePriceKey(String companyCode, String divisionCode, String itemCode, String fromYyyyMmdd,
			String toYyyyMmdd) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(fromYyyyMmdd), nz(toYyyyMmdd));
	}

	private static String standardCostKey(String companyCode, String divisionCode, String itemCode, String baseDate) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}

	private int maxMonths(ItemPriceCriteria criteria) {
		// NVL(FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'MA'), 12)
		return companySettingService.getIntSettingValue(criteria.getCompanyCode(), "MA", 12);
	}

	private static <T> BigDecimal priceIfPositive(T row, java.util.function.Function<T, BigDecimal> priceFn) {
		if (row == null) {
			return null;
		}
		BigDecimal price = priceFn.apply(row);
		return isPositive(price) ? price : null;
	}

	private static boolean isPositive(BigDecimal value) {
		return value != null && value.signum() > 0;
	}

	/** 조회 기간(YYYYMM/YYYYMMDD 범위) 계산. 원본의 ADD_MONTHS/TO_CHAR/TO_DATE 를 대체 */
	private static final class LookupWindow {
		final String fromYyyyMm;
		final String toYyyyMm;
		final String fromYyyyMmdd;
		final String toYyyyMmdd;

		private LookupWindow(String fromYyyyMm, String toYyyyMm, String fromYyyyMmdd, String toYyyyMmdd) {
			this.fromYyyyMm = fromYyyyMm;
			this.toYyyyMm = toYyyyMm;
			this.fromYyyyMmdd = fromYyyyMmdd;
			this.toYyyyMmdd = toYyyyMmdd;
		}

		static LookupWindow of(ItemPriceCriteria criteria, int maxMonths) {
			LocalDate baseDate = LocalDate.parse(criteria.getResolvedBaseDate(), YYYYMMDD);
			YearMonth toMonth = YearMonth.from(baseDate);
			YearMonth fromMonth = toMonth.minusMonths(maxMonths);
			LocalDate fromDate = baseDate.minusMonths(maxMonths);

			return new LookupWindow(fromMonth.format(YYYYMM), toMonth.format(YYYYMM), fromDate.format(YYYYMMDD),
					baseDate.format(YYYYMMDD));
		}
	}
}
