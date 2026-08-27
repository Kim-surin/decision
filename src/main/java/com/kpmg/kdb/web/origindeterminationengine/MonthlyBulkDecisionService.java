package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 월판정 전체 진입점. 내수+수출을 함께 판정하기 위해 {@link DomesticBulkDecisionService}(내수)와
 * {@link ExportBulkDecisionService}(수출)를 순서대로 호출해 결과를 하나로 합친다. 수출은 가상매출
 * 생성이 필요 없어 별도 그룹핑 흐름({@link ExportDecisionGroupingService})을 쓴다.
 */
@Service
public class MonthlyBulkDecisionService extends GeneralService
		implements BulkDecisionService<VirtualSalesGenerationParams> {

	@Autowired
	private DomesticBulkDecisionService domesticBulkDecisionService;
	@Autowired
	private ExportDecisionGroupingService exportGroupingService;
	@Autowired
	private ExportBulkDecisionService exportBulkDecisionService;

	/** 이 값이 MDC에 설정된 동안의 로그(같은 스레드에서 호출되는 하위 서비스/SQL 로그 포함)는
	 * logback-spring.xml의 MONTHLY_DECISION_FILE 로 별도로도 남는다. */
	private static final String MDC_KEY_DECISION_RUN = "decisionRun";
	private static final String MDC_VALUE_MONTHLY = "monthly";

	@Override
	public BulkDecisionResult run(VirtualSalesGenerationParams filter) {
		MDC.put(MDC_KEY_DECISION_RUN, MDC_VALUE_MONTHLY);
		try {
			BulkDecisionResult domesticResult = domesticBulkDecisionService.run(filter);

			List<ExportDecisionTarget> exportTargets = exportGroupingService.prepare(filter);
			BulkDecisionResult exportResult = exportBulkDecisionService.run(exportTargets);

			List<SalesTarget> allTargets = new ArrayList<>(domesticResult.getTargets());
			allTargets.addAll(exportResult.getTargets());
			List<SalesTarget> allFailedTargets = new ArrayList<>(domesticResult.getFailedTargets());
			allFailedTargets.addAll(exportResult.getFailedTargets());

			logger.info("월판정(내수+수출) 배치 완료. 내수 그룹수={}, 수출 대상건수={}, 총대상건수={}, 실패건수={}",
					domesticResult.getGroupCount(), exportResult.getGroupCount(), allTargets.size(),
					allFailedTargets.size());

			return new BulkDecisionResult(domesticResult.getGroupCount() + exportResult.getGroupCount(), allTargets,
					allFailedTargets);
		} finally {
			MDC.remove(MDC_KEY_DECISION_RUN);
		}
	}
}
