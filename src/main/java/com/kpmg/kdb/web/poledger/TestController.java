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
import com.kpmg.kdb.web.coodecision.CooDecisionContext;
import com.kpmg.kdb.web.coodecision.dto.FcrInfoRow;
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

			// Layer2 서비스(CooDecisionSupportService 등) 테스트용 컨텍스트 준비 확인.
			// PRODUCT_CODE=091101R050 의 BOM 자재 14건을 CooDecisionContext.fcrInfoRows 에 채운다.
			CooDecisionContext sampleContext = buildSampleContext();
			cases.add(runCase("CooDecisionContext.fcrInfoRows 준비",
					() -> sampleContext.getFcrInfoRows().size(),
					"14"));

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
	 * Layer2 테스트용 CooDecisionContext. PRODUCT_CODE=091101R050(FTA_CODE=PKRPH) 의
	 * BOM 자재 스냅샷을 fcrInfoRows 에 채워서 반환한다.
	 */
	private CooDecisionContext buildSampleContext() {
		CooDecisionContext ctx = new CooDecisionContext();
		ctx.setFcrInfoRows(buildSampleFcrInfoRows());
		return ctx;
	}

	/**
	 * 사용자가 제공한 FCR_INFO_TEMP 스냅샷(14건, 탭 구분 텍스트 기준)을 그대로 옮긴 것.
	 * WEIGHT/STANDARD 는 전 행 공란(null). EXCLUSION_RULE1~14 는 전 행 'N'(미적용)이라
	 * 기본값(false) 그대로 두었고, COO_NATION 도 전 행 공란이라 null 로 두었다.
	 */
	private List<FcrInfoRow> buildSampleFcrInfoRows() {
		List<FcrInfoRow> rows = new ArrayList<>();
		// itemCode, hsCode, weight, requirementQty, inputAmount, inareaQty, inareaAmount, outareaQty, outareaAmount
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

	private FcrInfoRow fcrInfoRow(String itemCode, String hsCode, String weight, String requirementQty,
			String inputAmount, String inareaQty, String inareaAmount, String outareaQty, String outareaAmount) {
		FcrInfoRow row = new FcrInfoRow();
		row.setFtaCode("PKRPH");
		row.setDivisionCode("FRT101");
		row.setCompanyCode("FRT100");
		row.setProductCode("091101R050");
		row.setItemCode(itemCode);
		row.setParentHsCode("842549");
		row.setHsCode(hsCode);
		row.setWeight(toBigDecimal(weight));
		row.setRequirementQty(toBigDecimal(requirementQty));
		row.setInputAmount(toBigDecimal(inputAmount));
		row.setInareaQty(toBigDecimal(inareaQty));
		row.setInareaAmount(toBigDecimal(inareaAmount));
		row.setOutareaQty(toBigDecimal(outareaQty));
		row.setOutareaAmount(toBigDecimal(outareaAmount));
		return row;
	}

	private static BigDecimal toBigDecimal(String value) {
		return value == null ? null : new BigDecimal(value);
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
