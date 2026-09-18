package com.kpmg.kdb.web.origindeterminationengine;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.core.procedurelog.ProcedureLogService;
import com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationMode;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyOriginDeterminationFlags;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;

// OriginDeterminationPipeline 생성. COMPANY.CTC_DECISION_ONLY_YN으로 판정 모드를 정해 forDomestic/forExport
// 양쪽(개별판정 포함, 레거시 트레이스로 확인)에 동일 적용한다. AUTO_MATERIAL_INV_BAL_PROC은 여기서 다루지 않는다.
@Service
public class OriginDeterminationPipelineFactory extends GeneralService {

	@Autowired
	private AggregatedVirtualSalesGenerator aggregatedVirtualSalesGenerator;
	@Autowired
	private CreateFcrService fcrCreator;
	@Autowired
	private OriginDeterminationExecutionService originDecider;
	@Autowired
	private SalesOriginDeterminationStatusUpdater statusUpdater;
	@Autowired
	private CompanyOriginDeterminationFlagsService companyOriginDeterminationFlagsService;
	@Autowired
	private ProcedureLogService procedureLogService;

	/** 월 판정 파이프라인. {@link OriginDeterminationPipeline#generateVirtualSales} 를 첫 단계로 호출해야 대상이 채워진다.
	 * logId는 호출측이 만든 AS-IS MONTHLY_DECISION_PROC 대응 로그로, 대상별 진행상황을 이어 붙이기 위해 전달한다. */
	public OriginDeterminationPipeline forDomestic(String companyCode, List<String> productCodes, Long logId) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		return new OriginDeterminationPipeline(Collections.emptyList(), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater, procedureLogService, logId);
	}

	// 수출 판정 파이프라인. 이미 존재하는 실제 SALES_NO 1건을 대상으로 확정해 돌려주므로
	// 가상매출 생성 단계 없이 바로 createFcr()부터 체인을 시작하면 된다.
	public OriginDeterminationPipeline forExport(String companyCode, String divisionCode, String salesNo,
			List<String> productCodes, Long logId) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		SalesTarget target = new SalesTarget();
		target.setCompanyCode(companyCode);
		target.setDivisionCode(divisionCode);
		target.setSalesNo(salesNo);
		return new OriginDeterminationPipeline(List.of(target), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater, procedureLogService, logId);
	}

	private OriginDeterminationMode resolveMode(String companyCode) {
		CompanyOriginDeterminationFlags flags = companyOriginDeterminationFlagsService.getDecisionFlags(companyCode);
		return "Y".equals(flags.getCtcDecisionOnlyYn()) ? OriginDeterminationMode.CTC_ONLY
				: OriginDeterminationMode.RVC_CTC;
	}
}
