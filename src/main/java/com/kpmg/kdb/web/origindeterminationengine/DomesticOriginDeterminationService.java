package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 내수 판정 진입점. DomesticOriginDeterminationTargetService로 대상 그룹((companyCode,divisionCode,customerCode) 조합)을
// 조회한 뒤, 그룹마다 OriginDeterminationPipeline을 새로 만들어 가상매출 생성-FCR 생성-원산지 판정-STATUS 업데이트 4단계를 수행한다.
@Service
public class DomesticOriginDeterminationService extends GeneralService
		implements BulkOriginDeterminationService<VirtualSalesGenerationParams> {

	@Autowired
	private OriginDeterminationPipelineFactory pipelineFactory;
	@Autowired
	private DomesticOriginDeterminationTargetService domesticOriginDeterminationTargetService;

	@Override
	public BulkOriginDeterminationResult run(VirtualSalesGenerationParams filter) {
		List<VirtualSalesGenerationParams> groups = domesticOriginDeterminationTargetService.prepare(filter);

		BulkOriginDeterminationResult result = BulkPipelineRunner.run(groups,
				groupParams -> pipelineFactory.forDomestic(groupParams.getCompanyCode(), groupParams.getProductCodes())
						.generateVirtualSales(groupParams)
						.createFcr()
						.determineOrigin()
						.updateStatus(),
				(groupParams, e) -> logger.error(
						"내수 벌크판정 그룹 처리 실패. companyCode={}, divisionCode={}, customerCode={}, yyyymmdd={}",
						groupParams.getCompanyCode(), groupParams.getDivisionCode(), groupParams.getCustomerCode(),
						groupParams.getYyyymmdd(), e));

		logger.info("내수 벌크판정 완료. 그룹수={}, 대상건수={}, 실패건수={}", result.getGroupCount(), result.getTargets().size(),
				result.getFailedTargets().size());

		return result;
	}
}
