package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * 수출 판정 진입점. 가상매출 생성이 필요 없으므로 데이터 가공(그룹핑) 단계가 없다({@link ExportDecisionTarget} — 호출측이 이미
 * 확정된 대상 목록을 넘긴다). 대상마다 {@link OriginDecisionPipeline} 을 새로 만들어 
 * FCR 생성-원산지 판정-STATUS 업데이트 3단계를 수행한다. {@link BulkDecisionService} 를 구현한다.
 */
@Service
public class ExportDecisionService extends GeneralService implements BulkDecisionService<List<ExportDecisionTarget>> {

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
