package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * 수출 개별판정 배치 처리 진입점. 내수 개별판정({@link IndividualBulkDecisionService})과 달리 데이터
 * 가공(그룹핑) 단계가 없다 — 수출은 이미 존재하는 실제 SALES_NO 를 그대로 판정 대상으로 삼아 가상매출을
 * 새로 만들 필요가 없으므로, SALES_NO/PRODUCT_CODE 를 합산·그룹핑하는 로직 자체가 필요 없다
 * ({@link ExportDecisionTarget} 참고 — 호출측이 이미 확정된 대상 목록을 그대로 넘긴다).
 *
 * <p>대상마다 {@link OriginDecisionPipeline} 을 새로 만들어 CREATE_FCR-&gt;COO_DECISION-&gt;STATUS
 * 업데이트 3단계(가상매출 생성 단계 없음)를 순서대로 수행한다 — {@link OriginDecisionPipelineFactory#forExport}
 * 참고.
 *
 * <p>{@link BulkDecisionService} 공통 인터페이스를 구현한다.
 */
@Service
public class ExportBulkDecisionService extends GeneralService implements BulkDecisionService<List<ExportDecisionTarget>> {

	@Autowired
	private OriginDecisionPipelineFactory pipelineFactory;

	@Override
	public BulkDecisionResult run(List<ExportDecisionTarget> targets) {
		BulkDecisionResult result = BulkPipelineRunner.run(targets,
				target -> pipelineFactory
						.forExport(target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(),
								target.getProductCodes())
						.createFcr()
						.determineOrigin()
						.updateStatus(),
				(target, e) -> logger.error("수출 개별판정 배치 대상 처리 실패. companyCode={}, divisionCode={}, salesNo={}",
						target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(), e));

		logger.info("수출 개별판정 배치 완료. 대상건수={}, 실패건수={}", result.getTargets().size(), result.getFailedTargets().size());

		return result;
	}
}
