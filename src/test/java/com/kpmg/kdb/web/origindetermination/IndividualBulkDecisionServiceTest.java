package com.kpmg.kdb.web.origindetermination;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.web.origindetermination.dto.SalesTarget;
import com.kpmg.kdb.web.origindetermination.testsupport.IndividualBulkMockData;

/**
 * 개별내수판정({@link IndividualBulkDecisionService}) 통합 테스트. {@code TestController} 의
 * {@code /origin/compliance/test/individual-bulk-decision} 엔드포인트가 쓰던 것과 동일한 501행 mock
 * 데이터({@link IndividualBulkMockData})로, 실제 DB(가상 SALES_MST/SALES_DTL, FCR_MST/FCR_DTL/FCR_RESULT
 * 생성)까지 타는 통합 테스트라 {@code application.properties} 에 설정된 DB 에 연결할 수 있어야 실행된다.
 *
 * <p>{@link Transactional} 로 감싸 테스트가 끝나면 자동 롤백되므로, 여러 번 반복 실행해도 DB 에
 * 테스트 데이터가 누적되지 않는다.
 */
@SpringBootTest
@Transactional
class IndividualBulkDecisionServiceTest {

	@Autowired
	private IndividualBulkDecisionService individualBulkDecisionService;

	@Test
	void 그룹핑기준으로_23개_그룹으로_나뉘고_전부_성공한다() {
		List<IndividualDecisionRawLine> rawLines = IndividualBulkMockData.buildRawLines();

		BulkDecisionResult result = individualBulkDecisionService
				.run(new IndividualBulkDecisionRequest(IndividualBulkMockData.COMPANY_CODE, rawLines));

		assertThat(result.getGroupCount()).isEqualTo(IndividualBulkMockData.EXPECTED_GROUP_COUNT);
		assertThat(result.getFailedTargets()).isEmpty();
		assertThat(result.getTargets()).hasSize(IndividualBulkMockData.EXPECTED_GROUP_COUNT);
	}

	@Test
	void 판정대상_가상매출번호는_고객사_사업부_년월_조합이다() {
		List<IndividualDecisionRawLine> rawLines = IndividualBulkMockData.buildRawLines();

		BulkDecisionResult result = individualBulkDecisionService
				.run(new IndividualBulkDecisionRequest(IndividualBulkMockData.COMPANY_CODE, rawLines));

		// customerCode=1248533444, divisionCode=FRT101, yyyymm=202604 그룹 -> 가상 SALES_NO
		// "1248533444FRT101202604" (CustomerDivisionYyyymmSalesNoGenerator 참고)
		assertThat(result.getTargets())
				.extracting(SalesTarget::getSalesNo)
				.contains("1248533444FRT101202604");
	}
}
