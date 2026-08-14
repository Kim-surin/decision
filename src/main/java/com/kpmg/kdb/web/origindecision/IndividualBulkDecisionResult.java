package com.kpmg.kdb.web.origindecision;

import java.util.List;

import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;

/** {@link IndividualBulkDecisionService#run} 결과. 그룹(가상 SALES_NO)별 파이프라인 실행을 취합한 값. */
public class IndividualBulkDecisionResult {

	private final int groupCount;
	private final List<SalesTarget> targets;
	private final List<SalesTarget> failedTargets;

	public IndividualBulkDecisionResult(int groupCount, List<SalesTarget> targets, List<SalesTarget> failedTargets) {
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
