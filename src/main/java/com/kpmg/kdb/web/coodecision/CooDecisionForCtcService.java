package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.coodecision.dto.FcrInfoRow;
import com.kpmg.kdb.web.coodecision.dto.FcrResultRecord;
import com.kpmg.kdb.web.coodecision.dto.FtaRule;

/**
 * 레거시 COO_DECISION_FOR_CTC(세번변경기준 + 미소기준 판정) 이관.
 *
 * RVC_CTC(PKG99_COO_DECISION)와 CTC_ONLY(PKG99_COO_CTC_DECISION)의 실제 계산 로직이
 * 상당히 달라(미소기준/버퍼 계산 인프라가 CTC_ONLY 에는 아예 없음) 하나의 메서드로 억지로
 * 통합하지 않고 모드별로 분리했다. HS코드 누락 체크만 두 모드에 완전히 동일하게 존재한다.
 *
 * 이 프로시저는 FCR_INFO_TEMP(=CooDecisionContext.fcrInfoRows, 매출 1건당 1회 조회한 값)만
 * 읽으므로 DB 접근이 전혀 필요 없다 — 전량 Java 스트림 연산으로 처리한다.
 */
@Service
public class CooDecisionForCtcService {

	private static final Logger logger = LoggerFactory.getLogger(CooDecisionForCtcService.class);
	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	public void decide(CooDecisionContext ctx, FtaRule frList, DecisionMode mode) {
		try {
			if (hasMissingHsCode(ctx.getFcrInfoRows())) {
				FcrResultRecord rec = ctx.getFrdRec();
				rec.setStatus("E");
				rec.setErrorCode("TXT_HSCODE_INCLUDE_MISSING");
				rec.setErrorMsg("HS 코드 누락 포함");
				return;
			}

			if (mode == DecisionMode.CTC_ONLY) {
				decideCtcOnly(ctx, frList);
			} else {
				decideRvcCtc(ctx, frList);
			}
		} catch (Exception e) {
			ctx.setErrorCode("CTC ERROR");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("COO_DECISION_FOR_CTC 실패. ftaCode={}, hsCode={}", frList.getFtaCode(), frList.getHsCode(), e);
		}
	}

	/** 레거시 V_NO_HSCODE_CNT 체크. HS_CODE 가 정확히 공백(' ') 하나인 자재가 있는지 확인 */
	private boolean hasMissingHsCode(List<FcrInfoRow> rows) {
		return rows.stream().anyMatch(r -> " ".equals(r.getHsCode()));
	}

	// ===================== RVC_CTC 모드 (PKG99_COO_DECISION) =====================

	private void decideRvcCtc(CooDecisionContext ctx, FtaRule frList) {
		List<FcrInfoRow> scoped = ctx.getFcrInfoRows().stream().filter(r -> !r.isExclusionRule(7)).toList();
		List<FcrInfoRow> outareaCandidates = scoped.stream()
				.filter(r -> positive(r.getOutareaQty()) || positive(r.getOutareaAmount())).toList();

		TariffChangeAggregate agg = new TariffChangeAggregate();
		for (FcrInfoRow r : outareaCandidates) {
			agg.accumulate(r);
		}

		long totalCount = outareaCandidates.size(); // 원본 OFI.CNT
		long zeroAmountCnt = scoped.stream().filter(r -> isZero(r.getInputAmount())).count();
		BigDecimal totalOutareaAmount = scoped.stream().map(FcrInfoRow::getOutareaAmount)
				.map(CooDecisionForCtcService::nvl).reduce(BigDecimal.ZERO, BigDecimal::add);
		long matchCount = scoped.stream()
				.filter(r -> positive(r.getOutareaAmount()) && prefixEquals(r.getHsCode(), r.getParentHsCode(), 6))
				.count();

		String ccYn = totalCount == agg.ccCnt ? "Y" : "N";
		String cthYn = totalCount == agg.cthCnt ? "Y" : "N";
		String ctshYn = totalCount == agg.ctshCnt ? "Y" : "N";

		FcrResultRecord rec = ctx.getFrdRec();

		if (zeroAmountCnt > 0) {
			rec.setFtaDeMinimisYn("N");
			rec.setCompanyDeMinimisYn("N");
			rec.setCtcYn("N");
			rec.setStatus("E");
			rec.setErrorCode("MSG_FAILED_DECISION_QTY_AMOUNT");
			rec.setErrorMsg("소요량 또는 금액이 0 인 것이 존재합니다.");
			return;
		}

		BigDecimal weightRate = null;
		BigDecimal amountRate = null;
		String cthRule = frList.getCthRule();
		if ("CTSH".equals(cthRule)) {
			rec.setCtcYn(ctshYn);
			if (positive(ctx.getNetWeight())) {
				weightRate = ratio(agg.ctshWeight, ctx.getNetWeight());
			}
			amountRate = ratio(agg.ctshAmount, ctx.getDeMinimisInkotermsAmount());
		} else if ("CTH".equals(cthRule)) {
			rec.setCtcYn(cthYn);
			if (positive(ctx.getNetWeight())) {
				weightRate = ratio(agg.cthWeight, ctx.getNetWeight());
			}
			amountRate = ratio(agg.cthAmount, ctx.getDeMinimisInkotermsAmount());
		} else if ("CC".equals(cthRule)) {
			rec.setCtcYn(ccYn);
			if (positive(ctx.getNetWeight())) {
				weightRate = ratio(agg.ccWeight, ctx.getNetWeight());
			}
			amountRate = ratio(agg.ccAmount, ctx.getDeMinimisInkotermsAmount());
		}
		// cthRule 이 CTSH/CTH/CC 어느것도 아니면 원본처럼 CTC_YN 을 이전 값 그대로 둔다(재설정하지 않음)

		if (!"N".equals(rec.getCtcYn())) {
			return;
		}

		String unit = frList.getDeMinimisUnit();
		if ("W".equals(unit)) {
			if (!positive(ctx.getNetWeight())) {
				rec.setFtaDeMinimisYn("N");
				rec.setCompanyDeMinimisYn("N");
				rec.setStatus("E");
				rec.setErrorCode("DE_MINIMIS01");
				rec.setErrorMsg("Product Weight Not found!!");
			} else {
				applyDeMinimisResult(ctx, rec, weightRate, frList);
			}
		} else if ("A".equals(unit)) {
			applyDeMinimisResult(ctx, rec, amountRate, frList);
		} else if ("B".equals(unit)) {
			BigDecimal resultRate = totalOutareaAmount.compareTo(ctx.getInkotermsAmount()) > 0 ? HUNDRED
					: ratio(totalOutareaAmount, ctx.getInkotermsAmount());
			rec.setCtcResultRate(resultRate);

			if (frList.getDeMinimisRate() == null) {
				// Oracle NULL 전파 규칙과 동일: 기준율이 없으면 비교가 불가하므로 미충족(N) 처리
				rec.setCtcFtaResultRate(null);
				rec.setCtcCompanyResultRate(null);
				rec.setFtaDeMinimisYn("N");
				rec.setCompanyDeMinimisYn("N");
			} else {
				rec.setCtcFtaResultRate(frList.getDeMinimisRate());
				rec.setCtcCompanyResultRate(frList.getDeMinimisRate().subtract(nvl(ctx.getCompanyCtcRate())));

				if (matchCount > 0) {
					rec.setFtaDeMinimisYn("N");
					rec.setCompanyDeMinimisYn("N");
				} else {
					rec.setFtaDeMinimisYn(resultRate.compareTo(rec.getCtcFtaResultRate()) <= 0 ? "Y" : "N");
					if (resultRate.compareTo(rec.getCtcCompanyResultRate()) <= 0) {
						rec.setCompanyDeMinimisYn("Y");
						rec.setCtcYn("Y");
					} else {
						rec.setCompanyDeMinimisYn("N");
					}
				}
			}
		} else {
			rec.setCtcFtaResultRate(null);
			rec.setCtcCompanyResultRate(null);
		}
	}

	/**
	 * DE_MINIMIS_UNIT 'W'/'A' 공용: 협정기준/회사기준 충족여부 판정.
	 * frList.deMinimisRate 가 NULL 이면 Oracle의 NULL 전파 규칙(NULL 사칙연산/비교는 항상 NULL=거짓)과
	 * 동일하게 두 결과율을 NULL로, 두 충족여부를 모두 'N'으로 처리한다.
	 */
	private void applyDeMinimisResult(CooDecisionContext ctx, FcrResultRecord rec, BigDecimal rate, FtaRule frList) {
		rec.setCtcResultRate(rate);

		if (frList.getDeMinimisRate() == null) {
			rec.setCtcFtaResultRate(null);
			rec.setCtcCompanyResultRate(null);
			rec.setFtaDeMinimisYn("N");
			rec.setCompanyDeMinimisYn("N");
			return;
		}

		rec.setCtcFtaResultRate(frList.getDeMinimisRate());
		rec.setCtcCompanyResultRate(frList.getDeMinimisRate().subtract(nvl(ctx.getCompanyCtcRate())));

		rec.setFtaDeMinimisYn(rate.compareTo(rec.getCtcFtaResultRate()) <= 0 ? "Y" : "N");
		if (rate.compareTo(rec.getCtcCompanyResultRate()) <= 0) {
			rec.setCompanyDeMinimisYn("Y");
			rec.setCtcYn("Y");
		} else {
			rec.setCompanyDeMinimisYn("N");
		}
	}

	private static final class TariffChangeAggregate {
		long ccCnt, cthCnt, ctshCnt;
		BigDecimal ccAmount = BigDecimal.ZERO, cthAmount = BigDecimal.ZERO, ctshAmount = BigDecimal.ZERO;
		BigDecimal ccWeight = BigDecimal.ZERO, cthWeight = BigDecimal.ZERO, ctshWeight = BigDecimal.ZERO;

		void accumulate(FcrInfoRow r) {
			BigDecimal outareaAmount = nvl(r.getOutareaAmount());
			BigDecimal weightQty = nvl(r.getWeight()).multiply(nvl(r.getOutareaQty()));

			if (prefixEquals(r.getHsCode(), r.getParentHsCode(), 2)) {
				ccAmount = ccAmount.add(outareaAmount);
				ccWeight = ccWeight.add(weightQty);
			} else {
				ccCnt++;
			}
			if (prefixEquals(r.getHsCode(), r.getParentHsCode(), 4)) {
				cthAmount = cthAmount.add(outareaAmount);
				cthWeight = cthWeight.add(weightQty);
			} else {
				cthCnt++;
			}
			if (prefixEquals(r.getHsCode(), r.getParentHsCode(), 6)) {
				ctshAmount = ctshAmount.add(outareaAmount);
				ctshWeight = ctshWeight.add(weightQty);
			} else {
				ctshCnt++;
			}
		}
	}

	// ===================== CTC_ONLY 모드 (PKG99_COO_CTC_DECISION) =====================

	private void decideCtcOnly(CooDecisionContext ctx, FtaRule frList) {
		List<FcrInfoRow> scoped = ctx.getFcrInfoRows().stream().filter(r -> !r.isExclusionRule(7)).toList();

		// CTC_ONLY 모드는 원본에 OUTAREA_QTY/AMOUNT 필터가 없다(전체 자재 대상)
		long ccMatch = scoped.stream().filter(r -> prefixEquals(r.getHsCode(), r.getParentHsCode(), 2)).count();
		long cthMatch = scoped.stream().filter(r -> prefixEquals(r.getHsCode(), r.getParentHsCode(), 4)).count();
		long ctshMatch = scoped.stream().filter(r -> prefixEquals(r.getHsCode(), r.getParentHsCode(), 6)).count();

		String ccYn = ccMatch > 0 ? "N" : "Y";
		String cthYn = cthMatch > 0 ? "N" : "Y";
		String ctshYn = ctshMatch > 0 ? "N" : "Y";

		FcrResultRecord rec = ctx.getFrdRec();
		String cthRule = frList.getCthRule();
		if ("CTSH".equals(cthRule)) {
			rec.setCtcYn(ctshYn);
		} else if ("CTH".equals(cthRule)) {
			rec.setCtcYn(cthYn);
		} else if ("CC".equals(cthRule)) {
			rec.setCtcYn(ccYn);
		}
		// CTC_ONLY 모드는 미소기준(de-minimis) 적용 로직 자체가 원본에 존재하지 않는다
	}

	// ===================== 공통 헬퍼 =====================

	private static boolean prefixEquals(String hsCode, String parentHsCode, int len) {
		return safeSubstr(hsCode, len).equals(safeSubstr(parentHsCode, len));
	}

	private static String safeSubstr(String s, int len) {
		if (s == null) {
			return "";
		}
		return s.length() <= len ? s : s.substring(0, len);
	}

	private static boolean positive(BigDecimal v) {
		return v != null && v.signum() > 0;
	}

	private static boolean isZero(BigDecimal v) {
		return v == null || v.signum() == 0;
	}

	private static BigDecimal nvl(BigDecimal v) {
		return v == null ? BigDecimal.ZERO : v;
	}

	private static BigDecimal ratio(BigDecimal numerator, BigDecimal denominator) {
		// denominator 가 0 이면 원본과 동일하게 예외 전파(ArithmeticException)
		return numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
	}
}
