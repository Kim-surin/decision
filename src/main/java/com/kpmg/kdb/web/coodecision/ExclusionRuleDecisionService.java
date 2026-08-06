package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.coodecision.dto.ExclusionRuleDetail;
import com.kpmg.kdb.web.coodecision.dto.ExclusionRuleHeader;
import com.kpmg.kdb.web.coodecision.dto.FcrInfoRow;
import com.kpmg.kdb.web.coodecision.dto.FcrMasterLine;
import com.kpmg.kdb.web.coodecision.dto.FtaRule;

/**
 * 레거시 EXCLUTION_RULE_DECISION 이관.
 *
 * 판정 대상 룰(FR_LIST)에 걸린 예외타입(FTA_EXCLUSION_RULE, 타입 1~16)을 순서대로 평가해
 * VG_FRD_REC.EXCLUSION_YN / EXCLUSION_CONDITION 을 결정한다. FCR_INFO_TEMP 조회는 매번 SQL을
 * 던지는 대신 {@link CooDecisionContext#getFcrInfoRows()}(매출 1건당 1회 조회한 리스트)를
 * 스트림으로 집계해 처리한다.
 *
 * <p><b>원본 결함 수정(TYPE 17):</b> 원본 소스에서는 "예외 TYPE 17" 처리 블록이 실수로 TYPE 16
 * 처리 안의 CTH_RULE 분기(CC/CTH/CTSH) 체인의 4번째 ELSIF 로 잘못 중첩되어 있었다.
 * FER_LIST.EXCLUSION_TYPE 은 그 분기에 진입한 시점에 이미 '16' 으로 고정되어 있어
 * "ELSIF FER_LIST.EXCLUSION_TYPE = '17'" 조건이 그 문맥에서 항상 거짓이 되고, TYPE 17 로
 * 등록된 예외룰은 실제로는 전혀 평가되지 않은 채 V_EXCLUSION_YN 이 직전 반복 값을 그대로
 * 유지하고 다음 단계로 넘어가는 결함이 있었다. 이 메서드는 해당 결함을 수정해 TYPE 17 을 실제로
 * 평가한다. 판정 로직은 TYPE 4 / TYPE 16 2단계와 동일하게 "비역내산 재료비 비율이 예외HS코드별
 * 최대 기준율 미만인지"를 계산하는 공용 패턴을 사용한다({@link #outareaAmountRatioBelowMaxRate}
 * 참고). 원본에서 TYPE 17 코드가 도달 불가능했던 탓에 이 로직은 실제 운영 데이터로 검증된 적이
 * 없으므로, TYPE 17 예외룰이 등록된 협정(예: 캐나다 FTA)에 대해서는 판정 결과를 업무팀이 별도
 * 검증할 필요가 있다.
 */
@Service
public class ExclusionRuleDecisionService extends GeneralService {

	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);
	/**
	 * CTC 전용 모드에서 값기준(RVC성) 예외타입은 평가 자체가 불가능해 무조건 'N' 처리한다(원본 주석
	 * 처리 블록과 동일). TYPE 17 은 원본에서 도달 불가능한 코드였던 탓에 이 목록에 포함된 적이 없었지만,
	 * TYPE 4/16-2단계와 동일하게 VG_INKOTERMS_AMOUNT(값기준) 를 분모로 사용하는 패턴이므로 결함 수정과
	 * 함께 동일하게 강제 'N' 처리 대상에 포함했다.
	 */
	private static final java.util.Set<String> CTC_ONLY_FORCED_N_TYPES = java.util.Set.of("4", "6", "13", "15", "16",
			"17");

	public void decide(CooDecisionContext ctx, FtaRule frList, DecisionMode mode) {
		try {
			ctx.setReturnCode(0);
			ctx.getFrdRec().setExclusionCondition("000");

			ExclusionRuleDao dao = sqlSession.getMapper(ExclusionRuleDao.class);
			List<ExclusionRuleHeader> headers = dao.selectExclusionRuleHeaders(frList.getFtaCode(), frList.getHsCode(),
					frList.getHsCodeSubCategory(), frList.getRuleSeq());

			String exclusionYn = "Y"; // 원본 V_EXCLUSION_YN 초기값, 루프 내에서 재설정되지 않으면 이전 값을 유지
			String andHold = null; // 원본 V_AND_HOLD_EXCLUSION_YN (NULL == NVL(...,'NO')='NO')
			String orHold = null; // 원본 V_OR_HOLD_EXCLUSION_YN

			for (ExclusionRuleHeader header : headers) {
				exclusionYn = evaluateType(ctx, frList, header, mode, dao, exclusionYn);

				if ("16".equals(header.getExclusionType()) && !"N16".equals(ctx.getFrdRec().getExclusionCondition())) {
					ctx.getFrdRec().setExclusionCondition("E16");
				}

				if ("AND".equals(header.getJoinCondition()) || "IF".equals(header.getJoinCondition())) {
					if (andHold == null) {
						andHold = exclusionYn;
					} else if ("Y".equals(andHold)) {
						andHold = exclusionYn;
					}
				} else {
					if (orHold == null) {
						orHold = exclusionYn;
					}
					orHold = ("Y".equals(orHold) || "Y".equals(exclusionYn)) ? "Y" : "N";
				}

				if (!"16".equals(header.getExclusionType())) {
					ctx.getFrdRec().setExclusionCondition("N16");
				}
			}

			if (!"E16".equals(ctx.getFrdRec().getExclusionCondition())) {
				ctx.getFrdRec().setExclusionCondition("AND");
			}

			String finalExclusionYn;
			if (andHold == null) {
				finalExclusionYn = "N".equals(orHold) ? "N" : "Y";
			} else if ("N".equals(andHold)) {
				finalExclusionYn = "N";
			} else {
				finalExclusionYn = (orHold == null || "Y".equals(orHold)) ? "Y" : "N";
			}
			ctx.getFrdRec().setExclusionYn(finalExclusionYn);
		} catch (Exception e) {
			ctx.setErrorCode("EXCLUSION99");
			ctx.setErrorMsg(String.valueOf(e.getMessage()));
			ctx.setReturnCode(-1);
			logger.error("EXCLUTION_RULE_DECISION 실패. ftaCode={}, hsCode={}", frList.getFtaCode(), frList.getHsCode(), e);
		}
	}

	private String evaluateType(CooDecisionContext ctx, FtaRule frList, ExclusionRuleHeader header, DecisionMode mode,
			ExclusionRuleDao dao, String currentValue) {
		String type = header.getExclusionType();

		if (mode == DecisionMode.CTC_ONLY && CTC_ONLY_FORCED_N_TYPES.contains(type)) {
			return "N";
		}

		List<FcrInfoRow> rows = ctx.getFcrInfoRows();
		FcrMasterLine fmList = ctx.getFmList();

		switch (type) {
			case "1":
				return evaluateType1(rows, frList, header, dao);
			case "2":
				return fmList.getWoCooYn();
			case "3":
				return existsMatch(rows, details(dao, frList, type)) ? "Y" : "N";
			case "4":
				return evaluateType4(ctx, rows, frList, header, dao, type);
			case "5":
				return fmList.getSpCooYn();
			case "6":
				return evaluateType6(rows, frList, dao, type);
			case "7":
				return evaluateType7(rows, frList, dao, type);
			case "8":
				return evaluateOutareaCandidates(rows).stream().noneMatch(r -> matches(r, details(dao, frList, type)))
						? "Y" : "N";
			case "9":
				return "N";
			case "10":
				return rows.stream().filter(r -> !"4017001000".equals(r.getHsCode())).count() == 0 ? "Y" : "N";
			case "11":
				return existsMatch(rows, details(dao, frList, type)) ? "Y" : "N";
			case "12":
				return "N";
			case "13":
				return evaluateType13(rows);
			case "14":
				return evaluateType14(rows, frList, dao, type);
			case "15":
				return evaluateType15(rows, frList, header, dao);
			case "16":
				return evaluateType16(ctx, rows, frList, header, dao, type, currentValue);
			// TYPE 17: 원본에서는 도달 불가능한 코드였던 결함을 수정(클래스 주석 참고).
			// TYPE 4 / TYPE 16 2단계와 동일한 값기준 비율 판정 패턴을 사용한다.
			case "17":
				return outareaAmountRatioBelowMaxRate(ctx, rows, details(dao, frList, type));
			default:
				return currentValue;
		}
	}

	// ===== TYPE 1 =====
	private String evaluateType1(List<FcrInfoRow> rows, FtaRule frList, ExclusionRuleHeader header,
			ExclusionRuleDao dao) {
		List<ExclusionRuleDetail> details = details(dao, frList, "1");
		BigDecimal numerator = BigDecimal.ZERO;
		BigDecimal denominator = BigDecimal.ZERO;
		for (FcrInfoRow r : evaluateOutareaCandidates(rows)) {
			if (matches(r, details)) {
				numerator = numerator.add(trunc(weight(r).multiply(qty(r.getOutareaQty())), 3));
				denominator = denominator.add(trunc(weight(r).multiply(nvl(r.getRequirementQty())), 3));
			}
		}
		BigDecimal ratio = denominator.signum() == 0 ? BigDecimal.ZERO
				: numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
		return ratio.compareTo(nvl(header.getExclusionRate())) < 0 ? "Y" : "N";
	}

	// ===== TYPE 4 (TYPE 16/17 2단계와 동일 패턴이라 공용 메서드로 분리) =====
	private String evaluateType4(CooDecisionContext ctx, List<FcrInfoRow> rows, FtaRule frList,
			ExclusionRuleHeader header, ExclusionRuleDao dao, String type) {
		List<ExclusionRuleDetail> details = details(dao, frList, type);
		return outareaAmountRatioBelowMaxRate(ctx, rows, details);
	}

	/** SUM(matches ? OUTAREA_AMOUNT : 0) / VG_INKOTERMS_AMOUNT * 100 < MAX(detail.rate) 패턴 (TYPE 4, 16-2단계, 17) */
	private String outareaAmountRatioBelowMaxRate(CooDecisionContext ctx, List<FcrInfoRow> rows,
			List<ExclusionRuleDetail> details) {
		BigDecimal numerator = evaluateOutareaCandidates(rows).stream()
				.filter(r -> matches(r, details))
				.map(FcrInfoRow::getOutareaAmount)
				.map(ExclusionRuleDecisionService::nvl)
				.reduce(BigDecimal.ZERO, BigDecimal::add);

		BigDecimal maxRate = details.stream().map(ExclusionRuleDetail::getExclusionRate).filter(java.util.Objects::nonNull)
				.max(BigDecimal::compareTo).orElse(BigDecimal.ZERO);

		// VG_INKOTERMS_AMOUNT = 0 이면 원본과 동일하게 예외 전파(ArithmeticException, 상위 catch에서 흡수)
		BigDecimal ratio = numerator.divide(ctx.getInkotermsAmount(), 10, RoundingMode.HALF_UP).multiply(HUNDRED);
		return ratio.compareTo(maxRate) < 0 ? "Y" : "N";
	}

	// ===== TYPE 6 =====
	private String evaluateType6(List<FcrInfoRow> rows, FtaRule frList, ExclusionRuleDao dao, String type) {
		List<ExclusionRuleDetail> details = details(dao, frList, type);
		BigDecimal sum = evaluateOutareaCandidates(rows).stream()
				.filter(r -> matches(r, details))
				.map(FcrInfoRow::getOutareaQty)
				.map(ExclusionRuleDecisionService::nvl)
				.reduce(BigDecimal.ZERO, BigDecimal::add);
		return sum.signum() <= 0 ? "Y" : "N";
	}

	// ===== TYPE 7 =====
	private String evaluateType7(List<FcrInfoRow> rows, FtaRule frList, ExclusionRuleDao dao, String type) {
		List<ExclusionRuleDetail> details = details(dao, frList, type);
		for (FcrInfoRow r : rows) {
			if (matches(r, details)) {
				r.setExclusionRule(7, true);
			}
		}
		return "Y"; // 세번변경 판정 단계에서 사용하도록 데이터만 마킹, 현재 예외판정 결과는 항상 역내산 취급
	}

	// ===== TYPE 13 =====
	private String evaluateType13(List<FcrInfoRow> rows) {
		BigDecimal outareaSum = rows.stream().map(FcrInfoRow::getOutareaAmount).map(ExclusionRuleDecisionService::nvl)
				.reduce(BigDecimal.ZERO, BigDecimal::add);
		BigDecimal inareaSum = rows.stream().map(FcrInfoRow::getInareaAmount).map(ExclusionRuleDecisionService::nvl)
				.reduce(BigDecimal.ZERO, BigDecimal::add);
		return outareaSum.compareTo(inareaSum) <= 0 ? "Y" : "N";
	}

	// ===== TYPE 14 (미국 협정 하드코딩 특례) =====
	private String evaluateType14(List<FcrInfoRow> rows, FtaRule frList, ExclusionRuleDao dao, String type) {
		List<ExclusionRuleDetail> details = details(dao, frList, type);
		String ruleHsCode = frList.getHsCode();

		long matchCount = rows.stream().filter(r -> matchesType14(r, details, ruleHsCode)).count();
		long totalCount = rows.size();
		return matchCount >= totalCount ? "Y" : "N";
	}

	private boolean matchesType14(FcrInfoRow r, List<ExclusionRuleDetail> details, String ruleHsCode) {
		String hsCode = r.getHsCode();
		if (hsCode == null) {
			return false;
		}
		if (hsCode.startsWith("200990")) {
			return false;
		}
		if (matches(r, details)) {
			return true;
		}
		// 룰 제품세번이 2106/220290 이고 자재세번이 2009/220290/210690 인 경우를 원산지로 인정하는 하드코딩 특례
		if ("2106".equals(ruleHsCode)) {
			return hsCode.startsWith("2009") || safeSubstr(hsCode, 6).equals("220290");
		}
		if ("220290".equals(ruleHsCode)) {
			return hsCode.startsWith("2009") || safeSubstr(hsCode, 6).equals("210690");
		}
		return false;
	}

	// ===== TYPE 15 =====
	// 분자: HS코드가 '39'로 시작하며 예외HS코드 목록에 매칭되는 자재의 weight*outareaQty 합
	// 분모: HS코드가 '39'로 시작하는 전체 자재(매칭 여부 무관)의 weight*requirementQty 합
	// (분자만 매칭 대상으로 제한되고 분모는 39%대 전체가 기준이 되는 것이 원본의 실제 동작이다)
	private String evaluateType15(List<FcrInfoRow> rows, FtaRule frList, ExclusionRuleHeader header,
			ExclusionRuleDao dao) {
		List<ExclusionRuleDetail> details = details(dao, frList, "15");
		List<FcrInfoRow> hs39Rows = rows.stream().filter(r -> r.getHsCode() != null && r.getHsCode().startsWith("39"))
				.toList();

		BigDecimal numerator = BigDecimal.ZERO;
		BigDecimal denominator = BigDecimal.ZERO;
		for (FcrInfoRow r : hs39Rows) {
			if (matches(r, details)) {
				numerator = numerator.add(round(weight(r).multiply(qty(r.getOutareaQty())), 8));
			}
			denominator = denominator.add(weight(r).multiply(nvl(r.getRequirementQty())));
		}
		denominator = round(denominator, 8);

		BigDecimal ratio = denominator.signum() == 0 ? BigDecimal.ZERO
				: numerator.divide(denominator, 10, RoundingMode.HALF_UP).multiply(HUNDRED);
		return ratio.compareTo(nvl(header.getExclusionRate())) < 0 ? "Y" : "N";
	}

	// ===== TYPE 16 (3단계 복합 판정) =====
	private String evaluateType16(CooDecisionContext ctx, List<FcrInfoRow> rows, FtaRule frList,
			ExclusionRuleHeader header, ExclusionRuleDao dao, String type, String currentValue) {
		List<ExclusionRuleDetail> details = details(dao, frList, type);

		// 1단계: 특정 HS코드 자재 투입 여부
		boolean step1 = existsMatch(rows, details);
		if (!step1) {
			return "N";
		}

		// 2단계: 비역내산 재료비 비율이 기준 미만인지
		String step2 = outareaAmountRatioBelowMaxRate(ctx, rows, details);
		if (!"Y".equals(step2)) {
			return "N";
		}

		// 3단계: 세번변경기준(CC/CTH/CTSH)별 미소기준 적용
		Integer prefixLen = switch (frList.getCthRule() == null ? "" : frList.getCthRule()) {
			case "CC" -> 2;
			case "CTH" -> 4;
			case "CTSH" -> 6;
			default -> null;
		};
		if (prefixLen == null) {
			// 원본: CC/CTH/CTSH 어느 것도 아니면 3단계 SELECT 자체가 실행되지 않아 2단계 결과('Y')가 유지된다
			return step2;
		}

		BigDecimal numerator = BigDecimal.ZERO;
		for (FcrInfoRow r : evaluateOutareaCandidates(rows)) {
			if (matches(r, details)) {
				continue; // NOT EXISTS(예외HS코드 매칭) 조건 -> 매칭되는 자재는 3단계 분자에서 제외
			}
			if (safeSubstr(r.getHsCode(), prefixLen).equals(safeSubstr(r.getParentHsCode(), prefixLen))) {
				numerator = numerator.add(nvl(r.getOutareaAmount()));
			}
		}
		BigDecimal ratio = numerator.divide(ctx.getInkotermsAmount(), 10, RoundingMode.HALF_UP).multiply(HUNDRED);
		return ratio.compareTo(nvl(frList.getDeMinimisRate())) < 0 ? "Y" : "N";
	}

	// ===== 공통 헬퍼 =====

	private List<ExclusionRuleDetail> details(ExclusionRuleDao dao, FtaRule frList, String exclusionType) {
		return dao.selectExclusionRuleDetails(frList.getFtaCode(), frList.getHsCode(), frList.getHsCodeSubCategory(),
				frList.getRuleSeq(), exclusionType);
	}

	private static List<FcrInfoRow> evaluateOutareaCandidates(List<FcrInfoRow> rows) {
		return rows.stream().filter(r -> positive(r.getOutareaQty()) || positive(r.getOutareaAmount())).toList();
	}

	private static boolean existsMatch(List<FcrInfoRow> rows, List<ExclusionRuleDetail> details) {
		return rows.stream().anyMatch(r -> matches(r, details));
	}

	private static boolean matches(FcrInfoRow row, List<ExclusionRuleDetail> details) {
		String hsCode = row.getHsCode();
		if (hsCode == null) {
			return false;
		}
		return details.stream().anyMatch(d -> d.getExclusionHsCode() != null && hsCode.startsWith(d.getExclusionHsCode()));
	}

	private static boolean positive(BigDecimal v) {
		return v != null && v.signum() > 0;
	}

	private static BigDecimal weight(FcrInfoRow r) {
		return nvl(r.getWeight());
	}

	private static BigDecimal qty(BigDecimal v) {
		return nvl(v);
	}

	private static BigDecimal nvl(BigDecimal v) {
		return v == null ? BigDecimal.ZERO : v;
	}

	private static BigDecimal trunc(BigDecimal v, int scale) {
		return v.setScale(scale, RoundingMode.DOWN);
	}

	private static BigDecimal round(BigDecimal v, int scale) {
		return v.setScale(scale, RoundingMode.HALF_UP);
	}

	private static String safeSubstr(String s, int len) {
		if (s == null) {
			return "";
		}
		return s.length() <= len ? s : s.substring(0, len);
	}
}
