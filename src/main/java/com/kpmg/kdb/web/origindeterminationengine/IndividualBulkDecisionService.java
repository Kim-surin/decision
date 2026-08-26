package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 개별판정 배치 처리 진입점. {@link IndividualDecisionGroupingService} 로 원본 (SALES_NO,
 * PRODUCT_CODE) 입력을 CUSTOMER_CODE+DIVISION_CODE+YYYYMM+COMPANY_CODE 기준으로 그룹핑한 뒤, 그룹마다
 * {@link OriginDecisionPipeline} 을 새로 만들어 가상매출 생성-&gt;FCR 생성-&gt;원산지 판정-&gt;STATUS
 * 업데이트 4단계를 수행한다. 그룹마다 productCodes 구성이 달라 파이프라인을 그룹별로 새로 만든다.
 *
 * <p>{@link BulkDecisionService} 를 구현하며, companyCode+원본 행 목록은
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
