package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.coodecision.dto.MaterialOriginRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.coodecision.dto.OriginCriteria;

/**
 * 레거시 COO_DECISION_FOR_RVC(부가가치기준 원산지 판정) 이관.
 *
 * CTC_ONLY(PKG99_COO_CTC_DECISION) 모드는 원본에서 이 프로시저의 실제 계산 로직 전체가
 * 비활성화되어 있고 FTA_RVC_YN/COMPANY_RVC_YN을 무조건 'N'으로 설정하는 스텁만 남아있다
 * (CTC 전용 판정에서는 부가가치기준을 사용하지 않기 때문). 그대로 이관했다.
 *
 * 이 프로시저도 FCR_INFO_TEMP(=OriginDeterminationContext.materialOriginRows)만 읽으므로 DB 접근이 필요 없다.
 */
@Service
public class RvcCriteriaDecisionService {

	private static final Logger logger = LoggerFactory.getLogger(RvcCriteriaDecisionService.class);
	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	public void decide(OriginDeterminationContext ctx, OriginCriteria frData, OriginDeterminationMode mode) {
		try {
			if (mode == OriginDeterminationMode.CTC_ONLY) {
				// CTC 전용 모드는 RVC 판정을 사용하지 않는다(원본 스텁과 동일)
				OriginDeterminationResult rec = ctx.getFrdRec();
				rec.setFtaRvcYn("N");
				rec.setCompanyRvcYn("N");
				return;
			}
			decideRvc(ctx, frData);
		} catch (Exception e) {
			ctx.setErrorCode("RVC ERROR");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("COO_DECISION_FOR_RVC 실패. ftaCode={}, hsCode={}", frData.getFtaCode(), frData.getHsCode(), e);
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
			rec.setErrorMsg("소요량 또는 금액이 0 인 것이 존재합니다.");
			return;
		}

		// 원본은 이 블록에서 예외가 발생해도 로그만 남기고 조용히 넘어간다(상위 RVC ERROR 처리로
		// 전파하지 않음) - 판정결과가 부분적으로 미설정된 채로 다음 단계로 넘어갈 수 있다.
		try {
			boolean mcRule = positive(frData.getMcRule());
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
			} else if (positive(frData.getNcRule())) {
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
			logger.warn("COO_DECISION_FOR_RVC 비율 계산 실패(무시하고 계속 진행). "
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

	private static BigDecimal sum(List<MaterialOriginRow> rows, java.util.function.Function<MaterialOriginRow, BigDecimal> extractor) {
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
		// denominator 가 0 이면 원본과 동일하게 예외 전파(ArithmeticException, 위 inner try/catch가 흡수)
		return numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
	}
}
