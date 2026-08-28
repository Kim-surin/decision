package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 월판정 전체 진입점. 내수+수출을 함께 판정하기 위해 {@link DomesticDecisionService}(내수)와
 * {@link ExportDecisionService}(수출)를 순서대로 호출해 결과를 하나로 합친다.
 */
@Service
public class MonthlyDecisionService extends GeneralService
		implements BulkDecisionService<VirtualSalesGenerationParams> {

	@Autowired
	private DomesticDecisionService domesticDecisionService;
	@Autowired
	private ExportDecisionTargetService exportDecisionTargetService;
	@Autowired
	private ExportDecisionService exportDecisionService;

	@Override
	public BulkDecisionResult run(VirtualSalesGenerationParams filter) {
		BulkDecisionResult domesticResult = domesticDecisionService.run(filter);

		List<ExportDecisionTarget> exportTargets = exportDecisionTargetService.prepare(filter);
		BulkDecisionResult exportResult = exportDecisionService.run(exportTargets);

		List<SalesTarget> allTargets = new ArrayList<>(domesticResult.getTargets());
		allTargets.addAll(exportResult.getTargets());
		List<SalesTarget> allFailedTargets = new ArrayList<>(domesticResult.getFailedTargets());
		allFailedTargets.addAll(exportResult.getFailedTargets());

		logger.info("월판정(내수+수출) 배치 완료. 내수 그룹수={}, 수출 대상건수={}, 총대상건수={}, 실패건수={}",
				domesticResult.getGroupCount(), exportResult.getGroupCount(), allTargets.size(),
				allFailedTargets.size());

		return new BulkDecisionResult(domesticResult.getGroupCount() + exportResult.getGroupCount(), allTargets,
				allFailedTargets);
	}
}
