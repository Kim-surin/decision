package com.kpmg.kdb.web.originbasis;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.common.CompanySettingService;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.originbasis.dto.StandardCostRow;

/**
 * 레거시 FC10_GET_ITEM_PRICE / FC10_GET_ITEM_PRICE_NOTE 이관.
 *
 * 두 원본 함수는 "재료 단가"와 "그 근거"를 각각 독립적으로 4단계 fallback(수불부-자기PLANT →
 * 수불부-타PLANT → 구매단가 → 표준원가)으로 조회한다. 조회 조건/공식이 완전히 동일하지 않아(코드 주석 참고)
 * 하나의 쿼리로 강제 통합하지 않고 각 단계를 그대로 이관했다. 다만 3단계(구매단가)는 두 함수가 완전히
 * 동일한 조회이므로 쿼리를 공유해 중복 호출을 없앴다.
 */
@Service
public class ItemPriceService extends GeneralService {

	private static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;

	@Autowired
	private CompanySettingService companySettingService;

	@Cacheable(cacheNames = "itemPrice", key = "#criteria.companyCode + ':' + #criteria.divisionCode + ':' "
			+ "+ #criteria.itemCode + ':' + #criteria.resolvedBaseDate")
	public BigDecimal resolveItemPrice(ItemPriceCriteria criteria) {
		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			LookupWindow window = LookupWindow.of(criteria, maxMonths(criteria));

			BigDecimal price = firstNonZero(dao.selectOwnDivisionBalanceForPrice(criteria, window.fromYyyyMm, window.toYyyyMm),
					MaterialBalanceTierRow::calculatePriceForPrice);
			if (price != null) {
				return price;
			}

			price = firstNonZero(dao.selectOtherDivisionBalanceForPrice(criteria, window.fromYyyyMm, window.toYyyyMm),
					MaterialBalanceTierRow::calculatePriceForPrice);
			if (price != null) {
				return price;
			}

			price = firstNonZero(dao.selectRecentPurchasePrice(criteria, window.fromYyyyMmdd, window.toYyyyMmdd),
					PoLedgerPriceRow::getUnitPrice);
			if (price != null) {
				return price;
			}

			price = firstNonZero(dao.selectStandardCostByDivision(criteria), StandardCostRow::getStandardCostAmount);
			if (price != null) {
				return price;
			}

			price = firstNonZero(dao.selectStandardCostAnyDivision(criteria), StandardCostRow::getStandardCostAmount);
			return price;
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN NULL; 과 동일
			logger.error("재료비 조회 실패. criteria={}", criteria, e);
			return null;
		}
	}

	@Cacheable(cacheNames = "itemPriceNote", key = "#criteria.companyCode + ':' + #criteria.divisionCode + ':' "
			+ "+ #criteria.itemCode + ':' + #criteria.resolvedBaseDate")
	public String resolveItemPriceNote(ItemPriceCriteria criteria) {
		try {
			ItemPriceDao dao = sqlSession.getMapper(ItemPriceDao.class);
			LookupWindow window = LookupWindow.of(criteria, maxMonths(criteria));

			List<MaterialBalanceTierRow> own = dao.selectOwnDivisionBalanceForNote(criteria, window.fromYyyyMm, window.toYyyyMm);
			if (!own.isEmpty() && isPositive(own.get(0).calculatePriceForNote())) {
				return own.get(0).buildPriceNoteText();
			}

			List<MaterialBalanceTierRow> other = dao.selectOtherDivisionBalanceForNote(criteria, window.fromYyyyMm, window.toYyyyMm);
			if (!other.isEmpty() && isPositive(other.get(0).calculatePriceForNote())) {
				return other.get(0).buildPriceNoteText();
			}

			List<PoLedgerPriceRow> purchase = dao.selectRecentPurchasePrice(criteria, window.fromYyyyMmdd, window.toYyyyMmdd);
			if (!purchase.isEmpty() && isPositive(purchase.get(0).getUnitPrice())) {
				return purchase.get(0).buildPriceNoteText();
			}

			List<StandardCostRow> standard = dao.selectStandardCostByDivision(criteria);
			if (!standard.isEmpty() && isPositive(standard.get(0).getStandardCostAmount())) {
				return standard.get(0).buildPriceNoteText();
			}

			// 원본에는 division 필터 없는 4b 단계가 존재하지 않는다(FC10_GET_ITEM_PRICE 에만 있음)
			return null;
		} catch (Exception e) {
			logger.error("재료비 근거(NOTE) 조회 실패. criteria={}", criteria, e);
			return null;
		}
	}

	private int maxMonths(ItemPriceCriteria criteria) {
		// NVL(FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'MA'), 12)
		return companySettingService.getIntSettingValue(criteria.getCompanyCode(), "MA", 12);
	}

	private static <T> BigDecimal firstNonZero(List<T> rows, java.util.function.Function<T, BigDecimal> priceFn) {
		if (rows.isEmpty()) {
			return null;
		}
		BigDecimal price = priceFn.apply(rows.get(0));
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
