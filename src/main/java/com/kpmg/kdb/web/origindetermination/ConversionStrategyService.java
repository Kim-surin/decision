package com.kpmg.kdb.web.origindetermination;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.ConversionStrategyRuleContextDto;
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

	// 판정 엔진(OriginDeterminationExecutionService)은 이 협정/HS코드에 적용 가능한 룰(RULE_SEQ)을
	// 전부 순회하며 각각 FCR_RESULT에 기록한다(하나가 통과하면 그걸 최종 결과로 채택). 즉 세번변경기준
	// 룰과 부가가치기준 룰이 서로 다른 RULE_SEQ(별개 대안)로 존재하는 경우가 흔하다. 예전에는
	// "실제 채택된 룰 1건"(FM.RULE_CONTENTS와 일치하는 것)만 봐서 세번변경/부가가치 중 어느 한쪽만
	// 잡혔는데, 사용자가 어느 기준으로 원산지확인서를 받을지 직접 고를 수 있어야 하므로 시도된 룰
	// 전체(selectConversionStrategyRuleContext가 이제 여러 행을 반환)를 보고 CTH/부가가치 각각
	// 존재 여부를 독립적으로 판단해야 한다.
	public Result retrieveConversionStrategyTargets(OriginDeterminationDetailResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			ConversionStrategyDao dao = sqlSession.getMapper(ConversionStrategyDao.class);
			List<ConversionStrategyRuleContextDto> contextRows = dao.selectConversionStrategyRuleContext(param);

			List<Map<String, Object>> cthTargetList = new ArrayList<>();
			List<Map<String, Object>> valueTargetList = new ArrayList<>();

			if (!contextRows.isEmpty()) {
				boolean hasCth = contextRows.stream().anyMatch(this::hasCthRule);
				ConversionStrategyRuleContextDto valueRuleCtx = contextRows.stream().filter(this::hasValueRule).findFirst().orElse(null);

				if (hasCth) {
					cthTargetList = dao.selectCthCertifyTargetList(param);
				}
				if (valueRuleCtx != null) {
					List<Map<String, Object>> candidates = dao.selectValueContentCertifyCandidateList(param);
					valueTargetList = resolveValueContentTargets(valueRuleCtx, candidates);
				}
			}

			Map<String, Object> value = new LinkedHashMap<>();
			value.put("header", buildHeader(contextRows));
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

	// 팝업 상단 요약(품번/품명/HS코드/판매가격/PSR). product_code, product_name, hs_code, amount는
	// FCR_MST/ITEM_MST 기준이라 조회된 룰 행마다 동일하게 반복되므로 첫 행에서 가져오면 되고,
	// PSR(세번변경/부가가치기준 요약)은 우측 AUI그리드에 결정기준별 행으로 뿌릴 수 있게 목록으로 내려준다.
	private Map<String, Object> buildHeader(List<ConversionStrategyRuleContextDto> contextRows) {
		Map<String, Object> header = new LinkedHashMap<>();

		if (contextRows.isEmpty()) {
			return header;
		}

		ConversionStrategyRuleContextDto first = contextRows.get(0);
		header.put("product_code", first.getProductCode());
		header.put("product_name", first.getProductName());
		header.put("hs_code", first.getHsCode());
		header.put("amount", first.getAmount());
		header.put("psr", buildPsrList(contextRows));

		return header;
	}

	// 시도된 룰 전체(contextRows)를 훑어서 룰 하나당 한 행을 만든다. RULE_CODE(예: "CTSH+BD45")는
	// 세번변경기준과 부가가치기준이 그 룰 안에서 AND로 함께 충족돼야 함을 나타내는 판정 엔진의 조합
	// 표기라, 판정 상세내용 결정기준 컬럼과 동일하게 이 값을 그대로 쓴다
	private List<Map<String, Object>> buildPsrList(List<ConversionStrategyRuleContextDto> contextRows) {
		Set<String> ruleCodes = new LinkedHashSet<>();

		for (ConversionStrategyRuleContextDto ctx : contextRows) {
			String ruleCode = ctx.getRuleCode();
			if (ruleCode != null && !ruleCode.isEmpty()) {
				ruleCodes.add(ruleCode);
			}
		}

		List<Map<String, Object>> rows = new ArrayList<>();
		for (String ruleCode : ruleCodes) {
			Map<String, Object> row = new LinkedHashMap<>();
			row.put("rule_code", ruleCode);
			rows.add(row);
		}

		return rows;
	}

	private boolean hasCthRule(ConversionStrategyRuleContextDto ctx) {
		String cthRule = ctx.getCthRule();
		return cthRule != null && !"*".equals(cthRule);
	}

	private boolean hasValueRule(ConversionStrategyRuleContextDto ctx) {
		return positive(ctx.getBuRule()) || positive(ctx.getBdRule())
				|| positive(ctx.getNcRule()) || positive(ctx.getMcRule());
	}

	/**
	 * 역외 원재료를 재료비(outarea_amount) 비중이 큰 순서로 하나씩 역내로 전환한다고 가정하고,
	 * RvcCriteriaDecisionService.decideRvc와 동일한 산식(BU>BD>NC>MC 우선순위)으로 재계산해
	 * 기준을 충족하는 시점까지 필요한 원재료만 반환한다.
	 */
	private List<Map<String, Object>> resolveValueContentTargets(ConversionStrategyRuleContextDto ctx, List<Map<String, Object>> candidates) {
		BigDecimal buRule = toBigDecimal(ctx.getBuRule());
		BigDecimal bdRule = toBigDecimal(ctx.getBdRule());
		BigDecimal ncRule = toBigDecimal(ctx.getNcRule());
		BigDecimal mcRule = toBigDecimal(ctx.getMcRule());
		BigDecimal inkotermsAmount = toBigDecimal(ctx.getInkotermsAmount());
		BigDecimal netCostAmount = toBigDecimal(ctx.getNetCostAmount());

		BigDecimal originatingAmount = toBigDecimal(ctx.getInareaAmount());
		BigDecimal nonOriginatingAmount = toBigDecimal(ctx.getOutareaAmount());
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
