package com.kpmg.kdb.web.origindetermination;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;

/**
 * 역내전환전략 팝업 - 세번변경기준(CTH)/부가가치기준 충족을 위해 원산지확인서 수취가 필요한
 * 원재료 목록을 계산한다. 부가가치기준 컷오프는 RvcCriteriaDecisionService.decideRvc와 동일한
 * BU/BD/NC/MC 산식·우선순위로 재계산해, 여기서 보여주는 목록이 실제 판정 재실행 결과와
 * 어긋나지 않도록 한다.
 */
@Service
public class ConversionStrategyService extends GeneralService {

	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	public Result retrieveConversionStrategyTargets(OriginDeterminationDetailResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			ConversionStrategyDao dao = sqlSession.getMapper(ConversionStrategyDao.class);
			List<Map<String, Object>> contextRows = dao.selectConversionStrategyRuleContext(param);
			Map<String, Object> ctx = contextRows.isEmpty() ? null : contextRows.get(0);

			List<Map<String, Object>> cthTargetList = new ArrayList<>();
			List<Map<String, Object>> valueTargetList = new ArrayList<>();

			if (ctx != null) {
				if (hasCthRule(ctx)) {
					cthTargetList = dao.selectCthCertifyTargetList(param);
				}
				if (hasValueRule(ctx)) {
					List<Map<String, Object>> candidates = dao.selectValueContentCertifyCandidateList(param);
					valueTargetList = resolveValueContentTargets(ctx, candidates);
				}
			}

			Map<String, Object> value = new LinkedHashMap<>();
			value.put("cthTargetList", cthTargetList);
			value.put("valueTargetList", valueTargetList);

			result.setValue(value);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	private boolean hasCthRule(Map<String, Object> ctx) {
		Object cthRule = ctx.get("cth_rule");
		return cthRule != null && !"*".equals(cthRule);
	}

	private boolean hasValueRule(Map<String, Object> ctx) {
		return positive(toBigDecimal(ctx.get("bu_rule"))) || positive(toBigDecimal(ctx.get("bd_rule")))
				|| positive(toBigDecimal(ctx.get("nc_rule"))) || positive(toBigDecimal(ctx.get("mc_rule")));
	}

	/**
	 * 역외 원재료를 재료비(outarea_amount) 비중이 큰 순서로 하나씩 역내로 전환한다고 가정하고,
	 * RvcCriteriaDecisionService.decideRvc와 동일한 산식(BU>BD>NC>MC 우선순위)으로 재계산해
	 * 기준을 충족하는 시점까지 필요한 원재료만 반환한다.
	 */
	private List<Map<String, Object>> resolveValueContentTargets(Map<String, Object> ctx, List<Map<String, Object>> candidates) {
		BigDecimal buRule = toBigDecimal(ctx.get("bu_rule"));
		BigDecimal bdRule = toBigDecimal(ctx.get("bd_rule"));
		BigDecimal ncRule = toBigDecimal(ctx.get("nc_rule"));
		BigDecimal mcRule = toBigDecimal(ctx.get("mc_rule"));
		BigDecimal inkotermsAmount = toBigDecimal(ctx.get("inkoterms_amount"));
		BigDecimal netCostAmount = toBigDecimal(ctx.get("net_cost_amount"));

		BigDecimal originatingAmount = toBigDecimal(ctx.get("inarea_amount"));
		BigDecimal nonOriginatingAmount = toBigDecimal(ctx.get("outarea_amount"));
		BigDecimal inputAmount = originatingAmount.add(nonOriginatingAmount);

		if (isSatisfied(buRule, bdRule, ncRule, mcRule, originatingAmount, nonOriginatingAmount, inputAmount,
				inkotermsAmount, netCostAmount)) {
			return new ArrayList<>();
		}

		List<Map<String, Object>> needed = new ArrayList<>();
		for (Map<String, Object> candidate : candidates) {
			BigDecimal flipAmount = toBigDecimal(candidate.get("outarea_amount"));
			originatingAmount = originatingAmount.add(flipAmount);
			nonOriginatingAmount = nonOriginatingAmount.subtract(flipAmount);
			needed.add(candidate);

			if (isSatisfied(buRule, bdRule, ncRule, mcRule, originatingAmount, nonOriginatingAmount, inputAmount,
					inkotermsAmount, netCostAmount)) {
				return needed;
			}
		}

		// 후보를 전부 전환해도 기준을 못 넘기면(이 원재료들만으로는 달성 불가) 조회된 후보 전체를 그대로 보여준다
		return needed;
	}

	/** RvcCriteriaDecisionService.decideRvc와 동일한 산식/우선순위(BU>BD>NC>MC)로 충족 여부를 계산한다. */
	private boolean isSatisfied(BigDecimal buRule, BigDecimal bdRule, BigDecimal ncRule, BigDecimal mcRule,
			BigDecimal originatingAmount, BigDecimal nonOriginatingAmount, BigDecimal inputAmount,
			BigDecimal inkotermsAmount, BigDecimal netCostAmount) {
		if (positive(buRule)) {
			BigDecimal rvcRate = ratio(originatingAmount, inkotermsAmount);
			return rvcRate.compareTo(buRule) >= 0;
		}
		if (positive(bdRule)) {
			BigDecimal rvcRate = ratio(inkotermsAmount.subtract(nonOriginatingAmount), inkotermsAmount);
			return rvcRate.compareTo(bdRule) >= 0;
		}
		if (positive(ncRule)) {
			BigDecimal rvcRate = ratio(inputAmount.subtract(nonOriginatingAmount), netCostAmount);
			return rvcRate.compareTo(ncRule) >= 0;
		}
		if (positive(mcRule)) {
			BigDecimal rvcRate = ratio(nonOriginatingAmount, inkotermsAmount);
			return rvcRate.compareTo(mcRule) <= 0;
		}
		return true;
	}

	private static BigDecimal ratio(BigDecimal numerator, BigDecimal denominator) {
		if (denominator == null || denominator.signum() == 0) {
			return BigDecimal.ZERO;
		}
		return numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
	}

	private static boolean positive(BigDecimal v) {
		return v != null && v.signum() > 0;
	}

	private static BigDecimal toBigDecimal(Object v) {
		if (v == null) {
			return BigDecimal.ZERO;
		}
		if (v instanceof BigDecimal) {
			return (BigDecimal) v;
		}
		if (v instanceof Number) {
			return BigDecimal.valueOf(((Number) v).doubleValue());
		}
		try {
			return new BigDecimal(String.valueOf(v));
		} catch (NumberFormatException e) {
			return BigDecimal.ZERO;
		}
	}
}
