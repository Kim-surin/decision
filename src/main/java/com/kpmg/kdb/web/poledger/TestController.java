package com.kpmg.kdb.web.poledger;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.function.Supplier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.coodecision.OriginDeterminationContext;
import com.kpmg.kdb.web.coodecision.OriginDeterminationMode;
import com.kpmg.kdb.web.coodecision.ExclusionRuleDecisionService;
import com.kpmg.kdb.web.coodecision.dto.MaterialOriginRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.coodecision.dto.OriginCriteria;
import com.kpmg.kdb.web.originbasis.HsCodeService;
import com.kpmg.kdb.web.originbasis.IncotermsRateService;
import com.kpmg.kdb.web.originbasis.ItemOriginRateService;
import com.kpmg.kdb.web.originbasis.ItemPriceService;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;
import com.kpmg.kdb.web.originbasis.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;

/**
 * Layer3(원산지판정 기초자료) 서비스 동작 확인용 임시 테스트 컨트롤러.
 * 운영 기능이 아니므로 검증이 끝나면 삭제할 것.
 *
 * 각 서비스 호출 결과를 하나의 변수에 덮어써서 디버거로 한 줄씩 확인하는 대신,
 * 5건 전체를 한 번의 호출로 실행하고 기대값과 비교해 PASS/FAIL 을 함께 반환한다.
 * BigDecimal 결과는 문자열 비교 대신 compareTo 로 비교해 소수 자릿수 표현 차이
 * (예: "1" vs "1.0000000000")로 인한 오탐을 막는다.
 */
@Controller
public class TestController extends GenericController {

	@Autowired
	private HsCodeService hsCodeService;
	@Autowired
	private ItemPriceService itemPriceService;
	@Autowired
	private IncotermsRateService incotermsRateService;
	@Autowired
	private ItemOriginRateService itemOriginRateService;
	@Autowired
	private ExclusionRuleDecisionService exclusionRuleDecisionService;

	@RequestMapping(value = "/origin/compliance/test/test")
	@ResponseBody
	public Result test() {
		Result result = new Result();
		List<TestCase> cases = new ArrayList<>();

		try {
			cases.add(runCase("HsCodeService.resolveHsCode",
					() -> hsCodeService.resolveHsCode(new HsCodeCriteria("FRT100", "FRT101", "1018116406",
							"091101R050", null, "PKRPH", "20260430")),
					"842549"));

			cases.add(runCase("ItemPriceService.resolveItemPrice",
					() -> itemPriceService
							.resolveItemPrice(new ItemPriceCriteria("FRT100", "FRT101", "091853X310", "PKRCO", "20260430")),
					"468"));

			cases.add(runCase("ItemPriceService.resolveItemPriceNote",
					() -> itemPriceService
							.resolveItemPriceNote(new ItemPriceCriteria("FRT100", "FRT101", "091853X310", "PKRCO", "20260430")),
					"구매 단가 (20260430,FRT101,1228177943)"));

			cases.add(runCase("IncotermsRateService.calculateChangeRate",
					() -> incotermsRateService.calculateChangeRate(
							new IncotermsChangeRateCriteria("2026", "FRT100", "FRT101", "D", "KR", "FOB", "EXW")),
					"1"));

			cases.add(runCase("ItemOriginRateService.resolveOriginRate",
					() -> itemOriginRateService.resolveOriginRate(
							new ItemOriginRateCriteria("FRT100", "FRT101", "091853X310", "PKRCO", "20260430")),
					"1"));

			// Layer2 서비스(OriginDeterminationSupportService 등) 테스트용 컨텍스트 준비 확인.
			// PRODUCT_CODE=091101R050 의 BOM 자재 14건을 OriginDeterminationContext.materialOriginRows 에 채운다.
			OriginDeterminationContext sampleContext = buildSampleContext();
			cases.add(runCase("OriginDeterminationContext.materialOriginRows 준비",
					() -> sampleContext.getMaterialOriginRows().size(),
					"14"));

			// 동일 매출건(SALES_SEQ=65)에 대해 FTA_CODE 25건(C_FCR_MST 커서 결과에 해당)을 준비하고,
			// materialOriginRows 와 FR_LIST 샘플(FTA_CODE=PKRAP) 범위를 맞추기 위해 그중 PKRAP 건을 ctx.fmData 로 설정한다.
			cases.add(runCase("OriginDeterminationContext.fmData 준비",
					() -> sampleContext.getFmData().getFtaCode() + ":" + sampleContext.getFmData().getSalesSeq(),
					"PKRAP:65"));

			// ExclusionRuleDecisionService.decide 호출.
			// materialOriginRows/fmData/FR_LIST 모두 FTA_CODE='PKRAP' 로 통일된 샘플이라 원본의
			// "FM_LIST.FTA_CODE 로 FR_LIST 를 조회" 전제가 성립한다. 다만 exclusionYn 의
			// 정답값(ground truth)은 아직 검증하지 않았으므로 배선 확인용 정보성 케이스로 둔다.
			OriginCriteria sampleRule = buildSampleOriginCriteria();
			exclusionRuleDecisionService.decide(sampleContext, sampleRule, OriginDeterminationMode.RVC_CTC);
			TestCase exclusionCase = new TestCase();
			exclusionCase.setName("ExclusionRuleDecisionService.decide (FTA_CODE=PKRAP, 배선 확인용, 기대값 미검증)");
			exclusionCase.setActual("exclusionYn=" + sampleContext.getFrdRec().getExclusionYn()
					+ ", exclusionCondition=" + sampleContext.getFrdRec().getExclusionCondition());
			exclusionCase.setExpected("(정보용, PASS/FAIL 판정 없음)");
			exclusionCase.setPassed(true);
			cases.add(exclusionCase);

			boolean allPassed = cases.stream().allMatch(TestCase::isPassed);
			result.setSuccess(allPassed);
			result.setMessage(allPassed ? "전체 통과" : "실패 항목 있음 - value 목록 확인");
		} catch (Exception e) {
			logger.error("테스트 실행 중 오류", e);
			result.setSuccess(false);
			result.setMessage("테스트 실행 중 오류: " + e.getMessage());
		}

		result.setValue(cases);
		return result;
	}

	private TestCase runCase(String name, Supplier<Object> invocation, String expected) {
		TestCase testCase = new TestCase();
		testCase.setName(name);
		testCase.setExpected(expected);
		try {
			Object actual = invocation.get();
			testCase.setActual(actual == null ? null : actual.toString());
			testCase.setPassed(matches(actual, expected));
		} catch (Exception e) {
			logger.error("테스트 케이스 실행 실패: {}", name, e);
			testCase.setActual("EXCEPTION: " + e);
			testCase.setPassed(false);
		}
		return testCase;
	}

	/**
	 * Layer2 테스트용 OriginDeterminationContext. PRODUCT_CODE=091101R050(FTA_CODE=PKRAP) 의
	 * BOM 자재 스냅샷을 materialOriginRows 에, 동일 매출건의 FTA_CODE=PKRAP 판정대상 라인을 fmData 에 채워서 반환한다.
	 * fmData 는 C_FCR_MST 커서가 FTA_CODE 별로 한 행씩 내려주는 것과 동일하게 25건 중 PKRAP 1건만 선택한다
	 * (materialOriginRows 샘플과 FR_LIST 샘플도 전부 PKRAP 기준으로 맞춰뒀다).
	 */
	private OriginDeterminationContext buildSampleContext() {
		OriginDeterminationContext ctx = new OriginDeterminationContext();
		ctx.setMaterialOriginRows(buildSampleMaterialOriginRows());
		ctx.setFmData(buildSampleFmList().stream()
				.filter(fm -> "PKRAP".equals(fm.getFtaCode()))
				.findFirst()
				.orElseThrow());
		return ctx;
	}

	/**
	 * 사용자가 제공한 FCR_MST 스냅샷(SALES_SEQ=65, FTA_CODE 25건, 탭 구분 텍스트 기준)을 그대로 옮긴 것.
	 * STANDARD/WEIGHT/BIZ_PROJECT_CODE 는 전 행 공란(null).
	 */
	private List<OriginDeterminationTarget> buildSampleFmList() {
		List<OriginDeterminationTarget> list = new ArrayList<>();
		// ftaCode, inkotermsType, deMinimisInkotermsType, originatingAmount, nonOriginatingAmount
		list.add(fcrMasterLine("PKRPH", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRIL", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRKH", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRRC", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRID", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRCN", "FOB", "FOB", "2157.39", "2074.6647"));
		list.add(fcrMasterLine("PKRNZ", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRVN", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRCR", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRAU", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRCA", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRCO", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRGB", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRPR", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRUS", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRIN", "FOB", "FOB", "2157.39", "2074.6647"));
		list.add(fcrMasterLine("PKREU", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRCL", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRAS", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKREF", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRAP", "FOB", "FOB", "2157.39", "2074.6647"));
		list.add(fcrMasterLine("PKRSI", "FOB", "FOB", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRTR", "EXW", "EXW", "3713.39", "518.6647"));
		list.add(fcrMasterLine("PKRGS", "FOB", "FOB", "1816", "2416.0547"));
		list.add(fcrMasterLine("PKRAE", "FOB", "EXW", "0", "4232.0547"));
		return list;
	}

	private OriginDeterminationTarget fcrMasterLine(String ftaCode, String inkotermsType, String deMinimisInkotermsType,
			String originatingAmount, String nonOriginatingAmount) {
		OriginDeterminationTarget fm = new OriginDeterminationTarget();
		fm.setFtaCode(ftaCode);
		fm.setSalesNo("1018116406FRT101202604");
		fm.setSalesSeq(65);
		fm.setDivisionCode("FRT101");
		fm.setCompanyCode("FRT100");
		fm.setProductCode("091101R050");
		fm.setInkotermsType(inkotermsType);
		fm.setDeMinimisInkotermsType(deMinimisInkotermsType);
		fm.setProductUnit("EA");
		fm.setProductAssetsType("P");
		fm.setHsCode("842549");
		fm.setAmount(toBigDecimal("4717"));
		fm.setNetCostAmount(toBigDecimal("0"));
		fm.setExworkAmount(toBigDecimal("4717"));
		fm.setFobAmount(toBigDecimal("4717"));
		fm.setOriginatingAmount(toBigDecimal(originatingAmount));
		fm.setNonOriginatingAmount(toBigDecimal(nonOriginatingAmount));
		fm.setSpCooYn("N");
		fm.setWoCooYn("N");
		fm.setHsCodeSubCategory("1");
		fm.setTariffYn("N");
		return fm;
	}

	/**
	 * 사용자가 제공한 FCR_INFO_TEMP 스냅샷(14건, 탭 구분 텍스트 기준)을 그대로 옮긴 것.
	 * WEIGHT/STANDARD 는 전 행 공란(null). EXCLUSION_RULE1~14 는 전 행 'N'(미적용)이라
	 * 기본값(false) 그대로 두었고, COO_NATION 도 전 행 공란이라 null 로 두었다.
	 */
	private List<MaterialOriginRow> buildSampleMaterialOriginRows() {
		List<MaterialOriginRow> rows = new ArrayList<>();
		// itemCode, hsCode, weight, requirementQty, inputAmount, originatingQty, originatingAmount, nonOriginatingQty, nonOriginatingAmount
		rows.add(fcrInfoRow("091271R050", "391910", null, "1", "40", "0", "0", "1", "40"));
		rows.add(fcrInfoRow("091853X310", "731829", null, "1", "468", "1", "468", "0", "0"));
		rows.add(fcrInfoRow("091272C001", "391910", null, "1", "29", "1", "29", "0", "0"));
		rows.add(fcrInfoRow("091363X200", "843110", null, "1", "816", "1", "816", "0", "0"));
		rows.add(fcrInfoRow("091853X400", "731829", null, "1", "463", "1", "463", "0", "0"));
		rows.add(fcrInfoRow("DNB11135600", "731822", null, "1", "47.39", "1", "47.39", "0", "0"));
		rows.add(fcrInfoRow("091853X400-SJ", "382499", null, "0.0732", "43.92", "0", "0", "0.0732", "43.92"));
		rows.add(fcrInfoRow("09136AW100", "843110", null, "1", "740", "1", "740", "0", "0"));
		rows.add(fcrInfoRow("091363X200-SI", "390730", null, "1", "197", "0", "0", "1", "197"));
		rows.add(fcrInfoRow("FRNB11135800-1", "848210", null, "1", "265", "1", "265", "0", "0"));
		rows.add(fcrInfoRow("091851M100", "731815", null, "1", "721", "1", "721", "0", "0"));
		rows.add(fcrInfoRow("091851M320", "730799", null, "1", "164", "1", "164", "0", "0"));
		rows.add(fcrInfoRow("09136AW100-SI", "382499", null, "1", "193", "0", "0", "1", "193"));
		rows.add(fcrInfoRow("091853X300-SJ", "382499", null, "0.11473", "44.7447", "0", "0", "0.11473", "44.7447"));
		return rows;
	}

	private MaterialOriginRow fcrInfoRow(String itemCode, String hsCode, String weight, String requirementQty,
			String inputAmount, String originatingQty, String originatingAmount, String nonOriginatingQty, String nonOriginatingAmount) {
		MaterialOriginRow row = new MaterialOriginRow();
		row.setFtaCode("PKRAP");
		row.setDivisionCode("FRT101");
		row.setCompanyCode("FRT100");
		row.setProductCode("091101R050");
		row.setItemCode(itemCode);
		row.setParentHsCode("842549");
		row.setHsCode(hsCode);
		row.setWeight(toBigDecimal(weight));
		row.setRequirementQty(toBigDecimal(requirementQty));
		row.setInputAmount(toBigDecimal(inputAmount));
		row.setOriginatingQty(toBigDecimal(originatingQty));
		row.setOriginatingAmount(toBigDecimal(originatingAmount));
		row.setNonOriginatingQty(toBigDecimal(nonOriginatingQty));
		row.setNonOriginatingAmount(toBigDecimal(nonOriginatingAmount));
		return row;
	}

	private static BigDecimal toBigDecimal(String value) {
		return value == null ? null : new BigDecimal(value);
	}

	/**
	 * 사용자가 FTA_RULE 에서 직접 조회해 제공한 FR_LIST 1건(RULE_ID=4168, FTA_CODE=PKRAP).
	 * DE_MINIMIS_UNIT/DE_MINIMIS_RATE 는 원본 데이터가 공란이라 null 로 둔다.
	 */
	private OriginCriteria buildSampleOriginCriteria() {
		OriginCriteria fr = new OriginCriteria();
		fr.setRuleId("4168");
		fr.setFtaCode("PKRAP");
		fr.setHsCode("8425");
		fr.setHsCodeSubCategory("1");
		fr.setRuleSeq("1");
		fr.setHsCodeDescription("철 또는 비합금강의 평판압연제품(폭이 600밀리미터 이상인 것으로서 열간압연한 것에 한하고, 클래드ㆍ도금 또는 도포한 것을 제외한다)");
		fr.setRuleDescription("해당 물품의 생산에 사용된 모든 비원산지재료의 가격이 해당 물품의 공장도거래가격의 55%를 초과하지 아니한 것");
		fr.setRuleContents("B55");
		fr.setSpRule("*");
		fr.setWoRule("*");
		fr.setCthRule("*");
		fr.setBdRule(toBigDecimal("0"));
		fr.setBuRule(toBigDecimal("0"));
		fr.setNcRule(toBigDecimal("0"));
		fr.setMcRule(toBigDecimal("55"));
		fr.setDeMinimisUnit(null);
		fr.setDeMinimisRate(null);
		fr.setExclusionRuleYn("N");
		return fr;
	}

	private boolean matches(Object actual, String expected) {
		if (actual == null) {
			return expected == null;
		}
		if (actual instanceof BigDecimal) {
			try {
				return ((BigDecimal) actual).compareTo(new BigDecimal(expected)) == 0;
			} catch (NumberFormatException e) {
				return false;
			}
		}
		return Objects.equals(actual.toString(), expected);
	}

	public static class TestCase {
		private String name;
		private String actual;
		private String expected;
		private boolean passed;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getActual() {
			return actual;
		}

		public void setActual(String actual) {
			this.actual = actual;
		}

		public String getExpected() {
			return expected;
		}

		public void setExpected(String expected) {
			this.expected = expected;
		}

		public boolean isPassed() {
			return passed;
		}

		public void setPassed(boolean passed) {
			this.passed = passed;
		}
	}
}
