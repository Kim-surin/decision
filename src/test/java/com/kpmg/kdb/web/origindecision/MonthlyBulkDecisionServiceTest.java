package com.kpmg.kdb.web.origindecision;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 월판정({@link MonthlyBulkDecisionService}) 통합 테스트. {@code TestController} 의
 * {@code /origin/compliance/test/monthly-decision} 엔드포인트가 쓰던 것과 동일한 필터
 * (companyCode=FRT100, yyyymmdd=202604)로 실제 DB 까지 타는 통합 테스트다. 내수(EXPORT_FLAG='D',
 * {@link DomesticBulkDecisionService})와 수출(EXPORT_FLAG='E', {@link ExportBulkDecisionService})
 * 대상을 모두 처리한다.
 *
 * <p>다른 두 테스트({@link IndividualBulkDecisionServiceTest}, {@link ExportBulkDecisionServiceTest})
 * 와 달리 고정된 mock 행 목록이 아니라 "그 시점에 FRT100/202604 로 걸리는 실매출 전체"를 대상으로 하므로
 * (다른 테스트/사용자가 그 사이 데이터를 추가하면 그룹수가 달라질 수 있음) 그룹수를 특정 값으로
 * 고정하지 않고, "처리 중 실패한 대상이 없다"는 불변조건만 검증한다 — groupCount/targets 등 구체적인
 * 값을 확인하고 싶다면 이 테스트 실행 시점의 DB 상태를 먼저 확인해야 한다.
 *
 * <p>{@link Transactional} 로 감싸 테스트가 끝나면 자동 롤백되므로, 여러 번 반복 실행해도 DB 에
 * 테스트로 인한 변경이 남지 않는다.
 */
@SpringBootTest
@Transactional
class MonthlyBulkDecisionServiceTest {

	@Autowired
	private MonthlyBulkDecisionService monthlyBulkDecisionService;

	@Test
	void FRT100_202604_월판정이_실패없이_끝난다() {
		VirtualSalesGenerationParams filter = new VirtualSalesGenerationParams();
		filter.setCompanyCode("FRT100");
		filter.setYyyymmdd("202604");

		BulkDecisionResult result = monthlyBulkDecisionService.run(filter);

		assertThat(result.getFailedTargets()).isEmpty();
		assertThat(result.getTargets()).hasSize(result.getGroupCount());
	}
}
