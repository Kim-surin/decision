package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;

/**
 * 그룹(가상 SALES_NO 또는 실제 SALES_NO)별 파이프라인 실행을 취합한 결과. {@link IndividualBulkDecisionService},
 * {@link DomesticBulkDecisionService}, {@link ExportBulkDecisionService}, {@link MonthlyBulkDecisionService}
 * 가 공용으로 쓴다.
 */
public class BulkDecisionResult {

	private final int groupCount;
	private final List<SalesTarget> targets;
	private final List<SalesTarget> failedTargets;

	public BulkDecisionResult(int groupCount, List<SalesTarget> targets, List<SalesTarget> failedTargets) {
		this.groupCount = groupCount;
		this.targets = targets;
		this.failedTargets = failedTargets;
	}

	public int getGroupCount() {
		return groupCount;
	}

	public List<SalesTarget> getTargets() {
		return targets;
	}

	public List<SalesTarget> getFailedTargets() {
		return failedTargets;
	}
}
