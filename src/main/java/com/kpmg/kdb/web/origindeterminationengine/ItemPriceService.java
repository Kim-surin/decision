package com.kpmg.kdb.web.origindeterminationengine;

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
import com.kpmg.kdb.web.origindeterminationengine.dto.DivisionItemKey;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemPriceWithNote;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceTierBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.PoLedgerPriceBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.StandardCostBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.StandardCostRow;

/**
 * 자재 단가 조회 (레거시 FC10_GET_ITEM_PRICE).
 *
 * 수불부(자기 PLANT → 전체 PLANT) → 최근 구매단가 → 표준원가(사업부 → 전체) 순으로 4단계
 * fallback 조회하며, 가격(price &gt; 0)을 찾으면 그 즉시 근거 텍스트와 함께 반환한다.
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

	/** @param divisionBalanceCache/purchasePriceCache/standardCostCache 각 단계 배치 사전조회 캐시(없으면 단건 조회로 대체) */
	public BigDecimal resolveItemPrice(ItemPriceCriteria criteria, Map<String, MaterialBalanceTierRow> divisionBalanceCache,
			Map<String, PoLedgerPriceRow> purchasePriceCache, Map<String, StandardCostRow> standardCostCache) {
		return resolveItemPriceWithNote(criteria, divisionBalanceCache, purchasePriceCache, standardCostCache).getPrice();
	}

	public ItemPriceWithNote resolveItemPriceWithNote(ItemPriceCriteria criteria) {
		return resolveItemPriceWithNote(criteria, Map.of(), Map.of(), Map.of());
	}

	/** 4단계 fallback을 순서대로 조회하다 가격을 찾으면 그 행 데이터로 근거 텍스트(NOTE)도 함께 만든다. */
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

	/** 1단계(수불부) 단가를 자재 목록 전체에 대해 배치로 미리 조회한다. 1단계는 항상 조회되므로 전량이 대상이다. */
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
			logger.error("수불부 단가(1단계) 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/** 3단계(최근 구매단가)를 자재 목록 전체에 대해 배치로 미리 조회한다(어떤 자재가 여기까지 내려올지는 실행 전엔 알 수 없어 전체 대상). */
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
			logger.error("최근 구매단가 배치조회 실패. companyCode={}, itemCount={}", companyCode, items.size(), e);
			return Map.of();
		}
	}

	/** 4단계(표준원가)를 자재 목록 전체에 대해 배치로 미리 조회한다. */
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
