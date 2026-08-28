package com.kpmg.kdb.web.origindeterminationengine;

import java.time.DateTimeException;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

/**
 * {@link ItemOriginRateService}와 {@link ItemNationService}가 공통으로 쓰는 자재 조회구간 날짜 계산.
 * 두 서비스 모두 같은 BOM/대체(FUNGIBLE) 자재 수불부를 순회하며 구매원장 조회구간(fromDate/lookupEnd)을
 * 산정하는데, 이 계산 자체는 완전히 동일해서 한 곳에 모아둔다.
 */
final class MaterialLookupPeriodSupport {

	static final DateTimeFormatter YYYYMM = DateTimeFormatter.ofPattern("yyyyMM");
	static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.BASIC_ISO_DATE;

	private MaterialLookupPeriodSupport() {
	}

	static String firstDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).format(YYYYMMDD);
	}

	/** 자재 재고회전 기간이 비정상적으로 크면 연산 결과가 표현 범위를 벗어날 수 있어 최소값으로 클램프한다. */
	static String firstDayMinusMonths(String yyyyMm, int months) {
		try {
			return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).minusMonths(months).format(YYYYMMDD);
		} catch (DateTimeException e) {
			return "00010101";
		}
	}

	static String firstDayMinusOneDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atDay(1).minusDays(1).format(YYYYMMDD);
	}

	static String lastDay(String yyyyMm) {
		return YearMonth.parse(yyyyMm, YYYYMM).atEndOfMonth().format(YYYYMMDD);
	}

	/** 최근 입고월이 없으면(NULL) '01'만 남는 원본(Oracle NULL||문자열) 동작을 그대로 보존한다. */
	static String plusDay01(String yyyyMm) {
		return (yyyyMm == null ? "" : yyyyMm) + "01";
	}

	static String earliest(String a, String b) {
		return a.compareTo(b) < 0 ? a : b;
	}

	static String nz(String value) {
		return value == null ? "" : value;
	}

	static String lastInputYyyyMmKey(String companyCode, String divisionCode, String itemCode, String uptoYyyyMm) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(uptoYyyyMm));
	}
}
