package com.kpmg.kdb.web.origindetermination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.VirtualSalesGenerationParams;

/**
 * 개별판정 배치 처리 진입점(Option A). {@link IndividualDecisionGroupingService} 로 원본 (SALES_NO,
 * PRODUCT_CODE) 입력을 CUSTOMER_CODE+DIVISION_CODE+YYYYMM+COMPANY_CODE 기준으로 그룹핑한 뒤, 그룹마다
 * {@link OriginDecisionPipeline} 을 새로 만들어 가상매출 생성-&gt;FCR 생성-&gt;원산지 판정-&gt;STATUS
 * 업데이트 4단계를 순서대로 수행한다.
 *
 * <p>그룹마다 PRODUCT_CODE 구성이 달라질 수 있는데, {@link OriginDecisionPipeline} 은 인스턴스 생성
 * 시점에 productCodes 스코프가 고정돼(모든 target 에 동일 적용) 여러 그룹을 파이프라인 하나로 누적
 * 처리할 수 없다 — 그래서 그룹마다 파이프라인 인스턴스를 새로 만드는 방식을 택했다(기존 파이프라인/
 * DTO/하위 인터페이스는 전혀 건드리지 않음).
 *
 * <p>{@link BulkDecisionService} 공통 인터페이스를 구현하며, companyCode+원본 행 목록은
 * {@link IndividualBulkDecisionRequest} 로 묶어서 받는다.
 */
@Service
public class IndividualBulkDecisionService extends GeneralService
		implements BulkDecisionService<IndividualBulkDecisionRequest> {

	@Autowired
	private OriginDecisionPipelineFactory pipelineFactory;
	@Autowired
	private IndividualDecisionGroupingService groupingService;

	@Override
	public BulkDecisionResult run(IndividualBulkDecisionRequest request) {
		String companyCode = request.getCompanyCode();
		List<VirtualSalesGenerationParams> groups = groupingService.prepare(request.getRawLines());

		BulkDecisionResult result = BulkPipelineRunner.run(groups,
				groupParams -> pipelineFactory.forIndividual(companyCode, groupParams.getProductCodes())
						.generateVirtualSales(groupParams)
						.createFcr()
						.determineOrigin()
						.updateStatus(),
				(groupParams, e) -> logger.error(
						"개별판정 배치 그룹 처리 실패. companyCode={}, customerCode={}, divisionCode={}, yyyymm={}",
						groupParams.getCompanyCode(), groupParams.getCustomerCode(), groupParams.getDivisionCode(),
						groupParams.getYyyymm(), e));

		logger.info("개별판정 배치 완료. 그룹수={}, 대상건수={}, 실패건수={}", result.getGroupCount(), result.getTargets().size(),
				result.getFailedTargets().size());

		return result;
	}
}
