package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.Function;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;

/**
 * 그룹(또는 대상)마다 {@link OriginDecisionPipeline} 을 새로 만들어 실행하고 targets/failedTargets 를
 * 취합하는 공통 루프. 항목 1건에서 예외가 나도 그 항목만 건너뛰고 나머지는 계속 진행한다. 로그 메시지는
 * 호출측이 그대로 갖고, 이 클래스는 순회-실행-취합만 담당한다.
 */
final class BulkPipelineRunner {

	private BulkPipelineRunner() {
	}

	static <T> BulkDecisionResult run(List<T> items, Function<T, OriginDecisionPipeline> execute,
			BiConsumer<T, Exception> onFailure) {
		List<SalesTarget> allTargets = new ArrayList<>();
		List<SalesTarget> allFailedTargets = new ArrayList<>();

		for (T item : items) {
			try {
				OriginDecisionPipeline pipeline = execute.apply(item);
				allTargets.addAll(pipeline.targets());
				allFailedTargets.addAll(pipeline.failedTargets());
			} catch (Exception e) {
				onFailure.accept(item, e);
			}
		}

		return new BulkDecisionResult(items.size(), allTargets, allFailedTargets);
	}
}
