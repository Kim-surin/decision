package com.kpmg.kdb.web.originbasis;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.ItemNationCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceRow;

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

	public String resolveItemNation(ItemNationCriteria criteria) {
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

		String cooNation = null;

		for (MaterialBalanceRow material : materials) {
			String lookupStart = null;
			String lookupEnd = null;
			String lastInputYyyyMm = null;

			if (material.getMatYyyyMm() != null) {
				lastInputYyyyMm = materialDao.selectLastInputYyyyMm(criteria.getCompanyCode(),
						criteria.getDivisionCode(), criteria.getItemCode(), toMonth.format(YYYYMM));

				if (material.hasPositiveInitialQty()) {
					if (material.hasNegativeAgingPeriod()) {
						// 원본 RETURN 0(NUMBER) -> VARCHAR2 함수라 암묵적으로 "0" 문자열이 반환된다. 그대로 재현.
						return "0";
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

			try {
				cooNation = nationDao.selectCooNation(criteria.getCompanyCode(), criteria.getItemCode(),
						criteria.getHsCode(), fromDate, lookupEnd);
			} catch (Exception e) {
				// 원본 EXCEPTION WHEN NO_DATA_FOUND / WHEN OTHERS 모두 V_COO_NATION := '' 과 동일하게 처리
				logger.warn("FC01_GET_ITEM_NATION COO_NATION 조회 실패, 빈 값으로 처리. criteria={}", criteria, e);
				cooNation = "";
			}
		}

		return cooNation;
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
