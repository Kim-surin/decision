package com.kpmg.kdb.web.origindeterminationengine;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationMode;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyOriginDeterminationFlags;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;

// OriginDeterminationPipeline을 만들어주는 진입점. COMPANY.CTC_DECISION_ONLY_YN으로 판정 모드(RVC_CTC/CTC_ONLY)를 정해
// 기본 부품을 채운 파이프라인을 돌려준다. AS-IS MONTHLY_DECISION_PROC의 V_CTC_DECISION_ONLY_YN 분기는 그 프로시저를
// 거치지 않고 CREATE_FCR/PKG99_COO_DECISION을 직접 호출하던 개별판정에서도 동일하게 존재했으므로(레거시 트레이스 확인)
// forDomestic/forExport 양쪽 다 그대로 적용한다. 반면 MATERIAL_USE_YN 원재료수불부 자동생성(PKG01_IF_LOAD.
// AUTO_MATERIAL_INV_BAL_PROC)은 MONTHLY_DECISION_PROC 프로시저 몸체에만 있던 단계라 여기서는 다루지 않는다
// (MonthlyOriginDeterminationService.run()이 월판정 진입 시 1회만 처리한다).
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

	/** 월 판정 파이프라인. {@link OriginDeterminationPipeline#generateVirtualSales} 를 첫 단계로 호출해야 대상이 채워진다. */
	public OriginDeterminationPipeline forDomestic(String companyCode, List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		return new OriginDeterminationPipeline(Collections.emptyList(), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater);
	}

	// 수출 판정 파이프라인. 이미 존재하는 실제 SALES_NO 1건을 대상으로 확정해 돌려주므로
	// 가상매출 생성 단계 없이 바로 createFcr()부터 체인을 시작하면 된다.
	public OriginDeterminationPipeline forExport(String companyCode, String divisionCode, String salesNo,
			List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		SalesTarget target = new SalesTarget();
		target.setCompanyCode(companyCode);
		target.setDivisionCode(divisionCode);
		target.setSalesNo(salesNo);
		return new OriginDeterminationPipeline(List.of(target), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater);
	}

	private OriginDeterminationMode resolveMode(String companyCode) {
		CompanyOriginDeterminationFlags flags = companyOriginDeterminationFlagsService.getDecisionFlags(companyCode);
		return "Y".equals(flags.getCtcDecisionOnlyYn()) ? OriginDeterminationMode.CTC_ONLY
				: OriginDeterminationMode.RVC_CTC;
	}
}
