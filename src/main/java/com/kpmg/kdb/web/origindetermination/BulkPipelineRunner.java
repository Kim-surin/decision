package com.kpmg.kdb.web.origindetermination;

import java.util.ArrayList;
import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.Function;

import com.kpmg.kdb.web.origindetermination.dto.SalesTarget;

/**
 * "그룹(또는 대상)마다 {@link OriginDecisionPipeline} 을 새로 만들어 실행하고 targets/failedTargets 를
 * 취합"하는 루프를 {@link IndividualBulkDecisionService}/{@link DomesticBulkDecisionService}/{@link
 * ExportBulkDecisionService} 가 각자 거의 동일하게 반복하고 있어 한 곳으로 뽑았다. 항목 1건 처리 중
 * 예외가 나도 그 항목만 건너뛰고 나머지는 계속 진행하는 규칙(원본 C_SALES_MST 커서 루프와 동일)은 그대로
 * 유지한다.
 *
 * <p>groupCount/성공-실패 로그 메시지 형식은 서비스마다 달라 호출측이 그대로 갖고 있고, 이 클래스는
 * 순회-실행-취합 부분만 담당한다.
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
