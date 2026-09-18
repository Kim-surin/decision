package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.core.procedurelog.ProcedureLogTemplate;

// 수출 판정 진입점. 가상매출 생성이 필요 없어 데이터 가공(그룹핑) 단계가 없고(호출측이 이미 확정된 대상 목록을
// 넘긴다), 대상마다 OriginDeterminationPipeline을 새로 만들어 FCR 생성-원산지 판정-STATUS 업데이트 3단계를 수행한다.
@Service
public class ExportOriginDeterminationService extends GeneralService implements BulkOriginDeterminationService<List<ExportOriginDeterminationTarget>> {

	@Autowired
	private OriginDeterminationPipelineFactory pipelineFactory;
	@Autowired
	private ProcedureLogTemplate procedureLogTemplate;

	@Override
	public BulkOriginDeterminationResult run(List<ExportOriginDeterminationTarget> targets) {
		// AS-IS MONTHLY_DECISION_PROC 대응 로그(수출 처리 범위 전체를 감싼다)
		int targetCount = targets == null ? 0 : targets.size();
		String companyCode = targetCount == 0 ? null : targets.get(0).getCompanyCode();

		return procedureLogTemplate.runLogged("MONTHLY_DECISION_PROC", companyCode,
				"EXPORT_TARGET_COUNT : " + targetCount, logId -> {
					BulkOriginDeterminationResult result = BulkPipelineRunner.run(targets,
							target -> pipelineFactory
									.forExport(target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(),
											target.getProductCodes(), logId)
									.createFcr()
									.determineOrigin()
									.updateStatus(),
							(target, e) -> logger.error("수출 개별판정 배치 대상 처리 실패. companyCode={}, divisionCode={}, salesNo={}",
									target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(), e));

					logger.info("수출 개별판정 배치 완료. 대상건수={}, 실패건수={}", result.getTargets().size(),
							result.getFailedTargets().size());

					return result;
				});
	}
}
