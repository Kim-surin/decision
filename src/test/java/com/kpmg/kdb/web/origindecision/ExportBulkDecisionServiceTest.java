package com.kpmg.kdb.web.origindecision;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.groups.Tuple.tuple;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;

/**
 * 개별수출판정({@link ExportBulkDecisionService}) 통합 테스트. {@code TestController} 의
 * {@code /origin/compliance/test/export-bulk-decision} 엔드포인트가 쓰던 것과 동일한 mock 대상
 * (companyCode=MRV100, divisionCode=MRV101, salesNo=2026040858)으로 실제 DB 까지 타는 통합 테스트다.
 * 수출은 이미 존재하는 실제 SALES_NO 를 그대로 대상으로 삼아 가상매출 생성 단계가 없다({@link
 * ExportDecisionTarget} 클래스 주석 참고).
 *
 * <p>{@link Transactional} 로 감싸 테스트가 끝나면 자동 롤백되므로, 여러 번 반복 실행해도 DB 에
 * 테스트로 인한 변경이 남지 않는다.
 */
@SpringBootTest
@Transactional
class ExportBulkDecisionServiceTest {

	private static final String COMPANY_CODE = "MRV100";
	private static final String DIVISION_CODE = "MRV101";
	private static final String SALES_NO = "2026040858";

	@Autowired
	private ExportBulkDecisionService exportBulkDecisionService;

	@Test
	void 수출_판정대상_1건이_성공한다() {
		List<ExportDecisionTarget> targets = List
				.of(new ExportDecisionTarget(COMPANY_CODE, DIVISION_CODE, SALES_NO, null));

		BulkDecisionResult result = exportBulkDecisionService.run(targets);

		assertThat(result.getGroupCount()).isEqualTo(1);
		assertThat(result.getFailedTargets()).isEmpty();
		assertThat(result.getTargets()).hasSize(1);
		assertThat(result.getTargets())
				.extracting(SalesTarget::getCompanyCode, SalesTarget::getDivisionCode, SalesTarget::getSalesNo)
				.containsExactly(tuple(COMPANY_CODE, DIVISION_CODE, SALES_NO));
	}
}
