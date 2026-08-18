package com.kpmg.kdb.web.origindecision;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;
import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 내수 벌크 판정(MONTHLY_DECISION_PROC 이관 확장) 진입점. {@link DomesticDecisionGroupingService} 로
 * 대상 그룹((companyCode,divisionCode,customerCode) 조합)을 먼저 조회한 뒤, 그룹마다
 * {@link OriginDecisionPipeline} 을 새로 만들어 가상매출 생성-&gt;FCR 생성-&gt;원산지 판정-&gt;STATUS
 * 업데이트 4단계를 순서대로 수행한다 — {@link IndividualBulkDecisionService} 와 동일한 구조다.
 *
 * <p>기존 {@link com.kpmg.kdb.web.monthlydecision.MonthlyDecisionService#run} 은 필터 파라미터 1건을
 * 그대로 {@code generateVirtualSales} 에 넘겨, 그 안의 MERGE 문 GROUP BY 가 여러 고객사 그룹을 한 번에
 * 집계하고 파이프라인 하나가 그 결과 target 전체를 처리했다(그룹별 결과가 하나의 targets/failedTargets
 * 로 뭉뚱그려짐). 이 서비스는 그룹을 미리 목록으로 뽑아 그룹마다 별도 파이프라인/결과를 갖도록
 * 재구성한 것으로, 개별판정 배치와 동일한 그룹 단위 처리·결과 취합 구조를 내수에도 적용한다.
 *
 * <p>{@link BulkDecisionService} 공통 인터페이스를 구현한다.
 */
@Service
public class DomesticBulkDecisionService extends GeneralService
		implements BulkDecisionService<VirtualSalesGenerationParams> {

	@Autowired
	private OriginDecisionPipelineFactory pipelineFactory;
	@Autowired
	private DomesticDecisionGroupingService groupingService;

	@Override
	public BulkDecisionResult run(VirtualSalesGenerationParams filter) {
		List<VirtualSalesGenerationParams> groups = groupingService.prepare(filter);

		List<SalesTarget> allTargets = new ArrayList<>();
		List<SalesTarget> allFailedTargets = new ArrayList<>();

		for (VirtualSalesGenerationParams groupParams : groups) {
			try {
				OriginDecisionPipeline pipeline = pipelineFactory
						.forDomestic(groupParams.getCompanyCode(), groupParams.getProductCodes())
						.generateVirtualSales(groupParams)
						.createFcr()
						.determineOrigin()
						.updateStatus();

				allTargets.addAll(pipeline.targets());
				allFailedTargets.addAll(pipeline.failedTargets());
			} catch (Exception e) {
				logger.error("내수 벌크판정 그룹 처리 실패. companyCode={}, divisionCode={}, customerCode={}, yyyymmdd={}",
						groupParams.getCompanyCode(), groupParams.getDivisionCode(), groupParams.getCustomerCode(),
						groupParams.getYyyymmdd(), e);
			}
		}

		logger.info("내수 벌크판정 완료. 그룹수={}, 대상건수={}, 실패건수={}", groups.size(), allTargets.size(),
				allFailedTargets.size());

		return new BulkDecisionResult(groups.size(), allTargets, allFailedTargets);
	}
}
