package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 월판정(MONTHLY_DECISION_PROC 이관) 전체 진입점. 레거시 판정대상 커서(C_SALES_MST)가
 * EXPORT_FLAG='D'(가상매출 집계 후 판정)와 EXPORT_FLAG='E'(이미 TARGET_FTA_CODE 가 세팅된 실제 매출
 * 판정)를 한 커서에서 함께 순회하던 것과 동일한 범위를 재현하기 위해, {@link DomesticBulkDecisionService}
 * (내수)와 {@link ExportBulkDecisionService}(수출)를 순서대로 호출해 결과를 하나로 합친다.
 *
 * <p>{@link DomesticBulkDecisionService} 는 고객사/사업부 그룹마다 가상매출을 새로 만들어야 해서 그룹
 * 단위 파이프라인 구조를 쓰지만, 수출은 가상매출 생성이 필요 없어(대상 SALES_NO 가 이미 실제로 존재)
 * 고객사/사업부 그룹 발견과 무관하게 회사+기간 조건만으로 직접 대상을 뽑는다
 * ({@link ExportDecisionGroupingService} 참고) — 그래서 내수처럼 그룹핑 서비스를 공유하지 않고 별도
 * 흐름으로 둔다.
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

	@Override
	public BulkDecisionResult run(VirtualSalesGenerationParams filter) {
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
	}
}
