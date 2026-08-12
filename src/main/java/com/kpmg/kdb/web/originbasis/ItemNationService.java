package com.kpmg.kdb.web.originbasis;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.DivisionItemKey;
import com.kpmg.kdb.web.originbasis.dto.ItemNationCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.LastInputYyyyMmResult;
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
	/** {@link #prefetchLastInputYyyyMm} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

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
					String key = lastInputYyyyMmKey(criteria.getCompanyCode(), criteria.getDivisionCode(),
							criteria.getItemCode(), toMonth.format(YYYYMM));
					if (lastInputYyyyMmCache.containsKey(key)) {
						lastInputYyyyMm = lastInputYyyyMmCache.get(key);
					} else {
						lastInputYyyyMm = materialDao.selectLastInputYyyyMm(criteria.getCompanyCode(),
								criteria.getDivisionCode(), criteria.getItemCode(), toMonth.format(YYYYMM));
					}
					lastInputYyyyMmLoaded = true;
				}

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

			finalFromDate = earliest(plusDay01(lastInputYyyyMm), lookupStart);
			finalLookupEnd = lookupEnd;
		}

		if (finalFromDate == null) {
			// 원본 V_COO_NATION 초기값(NULL) 그대로 반환: 유효한 조회구간을 만든 자재가 하나도 없었던 경우
			return null;
		}

		try {
			return nationDao.selectCooNation(criteria.getCompanyCode(), criteria.getItemCode(), criteria.getHsCode(),
					finalFromDate, finalLookupEnd);
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN NO_DATA_FOUND / WHEN OTHERS 모두 V_COO_NATION := '' 과 동일하게 처리
			logger.warn("FC01_GET_ITEM_NATION COO_NATION 조회 실패, 빈 값으로 처리. criteria={}", criteria, e);
			return "";
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
