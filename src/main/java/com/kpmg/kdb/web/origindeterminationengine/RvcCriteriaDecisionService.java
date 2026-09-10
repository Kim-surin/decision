package com.kpmg.kdb.web.origindeterminationengine;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.function.Function;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginCriteria;

// 부가가치기준(RVC) 원산지 판정(레거시 COO_DECISION_FOR_RVC). CTC_ONLY 모드는 부가가치기준을 쓰지 않아
// FTA_RVC_YN/COMPANY_RVC_YN을 무조건 'N'으로 설정한다.
@Service
public class RvcCriteriaDecisionService {

	private static final Logger logger = LoggerFactory.getLogger(RvcCriteriaDecisionService.class);
	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	/** @return 판정 성공 여부. 실패(예외 발생) 시 false — 호출자가 이 대상을 판정오류로 처리해야 한다. */
	public boolean decide(OriginDeterminationContext ctx, OriginCriteria frData, OriginDeterminationMode mode) {
		try {
			if (mode == OriginDeterminationMode.CTC_ONLY) {
				// CTC 전용 모드는 RVC 판정을 사용하지 않는다(원본 스텁과 동일)
				OriginDeterminationResult rec = ctx.getFrdRec();
				rec.setFtaRvcYn("N");
				rec.setCompanyRvcYn("N");
				return true;
			}
			decideRvc(ctx, frData);
			return true;
		} catch (Exception e) {
			ctx.setErrorCode("RVC ERROR");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			logger.error("COO_DECISION_FOR_RVC 실패. ftaCode={}, hsCode={}", frData.getFtaCode(), frData.getHsCode(), e);
			return false;
		}
	}

	private void decideRvc(OriginDeterminationContext ctx, OriginCriteria frData) {
		List<MaterialOriginRow> rows = ctx.getMaterialOriginRows();

		BigDecimal originatingAmount = sum(rows, MaterialOriginRow::getOriginatingAmount);
		BigDecimal nonOriginatingAmount = sum(rows, MaterialOriginRow::getNonOriginatingAmount);
		BigDecimal inputAmount = sum(rows, MaterialOriginRow::getInputAmount);
		long zeroAmountCnt = rows.stream().filter(r -> isZero(r.getInputAmount())).count();

		OriginDeterminationResult rec = ctx.getFrdRec();

		if (zeroAmountCnt > 0) {
			rec.setFtaRvcYn("N");
			rec.setCompanyRvcYn("N");
			rec.setStatus("E");
			rec.setErrorCode("MSG_FAILED_DECISION_QTY_AMOUNT");
			rec.setErrorMsg("금액이 0 인 것이 존재합니다.");
			return;
		}

		boolean mcRule = positive(frData.getMcRule());
		boolean ncRule = positive(frData.getNcRule());
		BigDecimal ratioBase = nvl(ncRule ? ctx.getNetCostAmount() : ctx.getInkotermsAmount());

		if ((positive(frData.getBuRule()) || positive(frData.getBdRule()) || ncRule || mcRule)
				&& ratioBase.signum() <= 0) {
			// FOB/EXW 금액(또는 NC 기준의 순원가 금액)이 0 이하이면 비율을 계산할 수 없다.
			// 원본(PL/SQL)은 이 경우 0으로 나누기 예외가 나서 WHEN OTHERS에 조용히 삼켜지고
			// FTA_RVC_YN/COMPANY_RVC_YN이 미설정(NULL)인 채로 남아, 최종 판정에서 NVL(..., 'Y')로
			// "충족"처럼 오인되는 버그가 있었다. 판정불가 상태를 명시적인 오류로 남긴다.
			rec.setFtaRvcYn("N");
			rec.setCompanyRvcYn("N");
			rec.setStatus("E");
			rec.setErrorCode("MSG_FAILED_DECISION_QTY_AMOUNT");
			rec.setErrorMsg("RVC 판정 기준금액(FOB/EXW 또는 순원가)이 0 이하여서 비율을 계산할 수 없습니다.");
			return;
		}

		try {
			BigDecimal rvcRate;
			BigDecimal ftaRvcRate;
			BigDecimal companyRvcRate;

			if (positive(frData.getBuRule())) {
				rvcRate = originatingAmount.compareTo(ctx.getInkotermsAmount()) > 0 ? BigDecimal.ZERO
						: ratio(originatingAmount, ctx.getInkotermsAmount());
				ftaRvcRate = frData.getBuRule();
				companyRvcRate = ftaRvcRate.add(nvl(ctx.getCompanyRvcRate()));
			} else if (positive(frData.getBdRule())) {
				rvcRate = nonOriginatingAmount.compareTo(ctx.getInkotermsAmount()) > 0 ? BigDecimal.ZERO
						: ratio(ctx.getInkotermsAmount().subtract(nonOriginatingAmount), ctx.getInkotermsAmount());
				ftaRvcRate = frData.getBdRule();
				companyRvcRate = ftaRvcRate.add(nvl(ctx.getCompanyRvcRate()));
			} else if (ncRule) {
				rvcRate = ratio(inputAmount.subtract(nonOriginatingAmount), ctx.getNetCostAmount());
				ftaRvcRate = frData.getNcRule();
				companyRvcRate = ftaRvcRate.add(nvl(ctx.getCompanyRvcRate()));
			} else if (mcRule) {
				rvcRate = nonOriginatingAmount.compareTo(ctx.getInkotermsAmount()) > 0 ? HUNDRED
						: ratio(nonOriginatingAmount, ctx.getInkotermsAmount());
				ftaRvcRate = frData.getMcRule();
				// MC기준은 회사버퍼를 더하지 않고 뺀다
				companyRvcRate = ftaRvcRate.subtract(nvl(ctx.getCompanyRvcRate()));
			} else {
				// BU/BD/NC/MC 어느 것도 적용되지 않으면 원본 로컬변수 초기값(0)이 그대로 유지된다
				rvcRate = BigDecimal.ZERO;
				ftaRvcRate = BigDecimal.ZERO;
				companyRvcRate = BigDecimal.ZERO;
			}

			rec.setRvcResultRate(rvcRate);
			rec.setRvcFtaResultRate(ftaRvcRate);
			rec.setRvcCompanyResultRate(companyRvcRate);

			// 협정기준 충족여부: MC 는 이하(<=), 그 외(BU/BD/NC)는 이상(>=) 기준
			rec.setFtaRvcYn(compareBySide(rvcRate, ftaRvcRate, mcRule));
			rec.setCompanyRvcYn(compareBySide(rvcRate, companyRvcRate, mcRule));
		} catch (Exception e) {
			// 예상치 못한 예외도 명시적인 판정오류로 남긴다 - NULL로 남겨 최종 판정에서 "충족"으로
			// 오인되지 않도록 한다(위 원본 버그와 동일한 이유).
			rec.setFtaRvcYn("N");
			rec.setCompanyRvcYn("N");
			rec.setStatus("E");
			rec.setErrorCode("RVC ERROR");
			rec.setErrorMsg(String.valueOf(e.getMessage()));
			logger.warn("COO_DECISION_FOR_RVC 비율 계산 실패. "
					+ "BU={}, BD={}, NC={}, MC={}, 역내금액={}, 역외금액={}, FOB/EX={}", frData.getBuRule(),
					frData.getBdRule(), frData.getNcRule(), frData.getMcRule(), originatingAmount, nonOriginatingAmount,
					ctx.getInkotermsAmount(), e);
		}
	}

	private static String compareBySide(BigDecimal rvcRate, BigDecimal threshold, boolean mcRule) {
		int cmp = rvcRate.compareTo(threshold);
		boolean satisfied = mcRule ? cmp <= 0 : cmp >= 0;
		return satisfied ? "Y" : "N";
	}

	private static BigDecimal sum(List<MaterialOriginRow> rows, Function<MaterialOriginRow, BigDecimal> extractor) {
		return rows.stream().map(extractor).map(RvcCriteriaDecisionService::nvl).reduce(BigDecimal.ZERO, BigDecimal::add);
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
		// denominator(FOB/EXW 또는 순원가 금액)는 decideRvc()에서 0 이하이면 이미 걸러진다.
		return numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
	}
}
