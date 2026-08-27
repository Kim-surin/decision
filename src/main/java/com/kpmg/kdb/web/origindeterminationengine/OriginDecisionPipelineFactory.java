package com.kpmg.kdb.web.origindeterminationengine;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationMode;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyDecisionFlags;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;

/**
 * {@link OriginDecisionPipeline} 을 만들어주는 진입점. COMPANY.CTC_DECISION_ONLY_YN 으로 판정 모드
 * (RVC_CTC/CTC_ONLY)를 정하고 기본 부품을 채운 파이프라인을 돌려준다.
 *
 * <p>COMPANY.MATERIAL_USE_YN='Y' 인 회사가 원본에서 호출하던 PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC
 * (원재료수불부 자동생성)은 이관 대상이 아니라 경고 로그만 남기고 계속 진행한다.
 */
@Service
public class OriginDecisionPipelineFactory extends GeneralService {

	@Autowired
	private AggregatedVirtualSalesGenerator aggregatedVirtualSalesGenerator;
	@Autowired
	private FcrCreator fcrCreator;
	@Autowired
	private OriginDecider originDecider;
	@Autowired
	private DecisionStatusUpdater statusUpdater;
	@Autowired
	private CompanyDecisionFlagsService companyDecisionFlagsService;

	/** 월 판정 파이프라인. {@link OriginDecisionPipeline#generateVirtualSales} 를 첫 단계로 호출해야 대상이 채워진다. */
	public OriginDecisionPipeline forDomestic(String companyCode, List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		return new OriginDecisionPipeline(Collections.emptyList(), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater);
	}

	/**
	 * 수출 판정 파이프라인. 이미 존재하는 실제 SALES_NO 1건을 대상으로 확정해 돌려주므로 가상매출
	 * 생성 단계 없이 바로 createFcr() 부터 체인을 시작하면 된다.
	 */
	public OriginDecisionPipeline forExport(String companyCode, String divisionCode, String salesNo,
			List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		SalesTarget target = new SalesTarget();
		target.setCompanyCode(companyCode);
		target.setDivisionCode(divisionCode);
		target.setSalesNo(salesNo);
		return new OriginDecisionPipeline(List.of(target), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater);
	}

	private OriginDeterminationMode resolveMode(String companyCode) {
		CompanyDecisionFlags flags = companyDecisionFlagsService.getDecisionFlags(companyCode);

		if ("Y".equals(flags.getMaterialUseYn())) {
			logger.warn(
					"PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC 미이관: 원재료수불부(자동생성) 로드 단계를 건너뜁니다. companyCode={}",
					companyCode);
		}

		return "Y".equals(flags.getCtcDecisionOnlyYn()) ? OriginDeterminationMode.CTC_ONLY
				: OriginDeterminationMode.RVC_CTC;
	}
}
