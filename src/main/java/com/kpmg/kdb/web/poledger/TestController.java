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
