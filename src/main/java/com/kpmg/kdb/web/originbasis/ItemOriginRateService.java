package com.kpmg.kdb.web.originbasis;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.common.CompanySettingService;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceRow;
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

			for (MaterialBalanceRow material : materials) {
				String lookupStart = null;
				String lookupEnd = null;
				String lastInputYyyyMm = null;

				if (material.getMatYyyyMm() != null) {
					lastInputYyyyMm = dao.selectLastInputYyyyMm(criteria.getCompanyCode(), criteria.getDivisionCode(),
							criteria.getItemCode(), toMonth.format(YYYYMM));

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
		if (precheck.isZero()) {
			return BigDecimal.ZERO;
		}
		try {
			ItemOriginRateDao dao = sqlSession.getMapper(ItemOriginRateDao.class);
			BigDecimal originRate = BigDecimal.ZERO;

			for (OriginRateStage stage : precheck.getStages()) {
				PurchaseLedgerSummary nonCertified = dao.selectNonCertifiedOriginSummary(criteria.getCompanyCode(),
						stage.getItemCode(), criteria.getFtaCode(), stage.getFromDate(), stage.getLookupEnd());

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
