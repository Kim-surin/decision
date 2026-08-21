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
 * {@link OriginDecisionPipeline} 을 만들어주는 진입점. companyCode 기준 COMPANY.CTC_DECISION_ONLY_YN
 * 을 조회해 판정 모드(RVC_CTC/CTC_ONLY)를 정하고, 기본 부품(기존 CreateFcrService/
 * OriginDeterminationExecutionService/AggregatedVirtualSalesDao 등 이관 코드)을 채운 파이프라인을 돌려준다.
 *
 * <p>내수/수출 모두 {@code COMPANY.MATERIAL_USE_YN='Y'} 인 회사에 대해 원본이 호출하는
 * PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC(원재료수불부 자동생성)은 이관 대상에 포함되어 있지 않아
 * 옮기지 못했다 — 경고 로그만 남기고 계속 진행한다.
 */
@Service
public class OriginDecisionPipelineFactory extends GeneralService {

	// AggregatedVirtualSalesGenerator/IndividualVirtualSalesGenerator 둘 다 VirtualSalesGenerator 를
	// 구현하므로, 인터페이스 타입으로 주입받으면 어느 구현체를 쓸지 모호해진다(빈 2개) — 그래서 구체
	// 타입으로 각각 주입받아 파이프라인 종류별로 명시적으로 골라 쓴다.
	@Autowired
	private AggregatedVirtualSalesGenerator aggregatedVirtualSalesGenerator;
	@Autowired
	private IndividualVirtualSalesGenerator individualVirtualSalesGenerator;
	@Autowired
	private FcrCreator fcrCreator;
	@Autowired
	private OriginDecider originDecider;
	@Autowired
	private DecisionStatusUpdater statusUpdater;
	@Autowired
	private CompanyDecisionFlagsService companyDecisionFlagsService;

	/**
	 * 월 판정 파이프라인. 판정 대상은 아직 비어 있으며, {@link OriginDecisionPipeline#generateVirtualSales}
	 * 를 체인 첫 단계로 호출해야 채워진다(params 는 yyyymmdd 범위 전체 실매출을 집계할 조건).
	 */
	public OriginDecisionPipeline forDomestic(String companyCode, List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		return new OriginDecisionPipeline(Collections.emptyList(), mode, productCodes, aggregatedVirtualSalesGenerator,
				fcrCreator, originDecider, statusUpdater);
	}

	/**
	 * 개별 판정 파이프라인. forDomestic 과 마찬가지로 판정 대상은 아직 비어 있으며,
	 * {@link OriginDecisionPipeline#generateVirtualSales} 를 체인 첫 단계로 호출해야 채워진다. 이 때
	 * 넘기는 params 에는 companyCode/divisionCode/customerCode/yyyymmdd(매출년월)/sourceSalesNo
	 * (헤더를 복사해올 실제 SALES_NO)/productCodes 를 모두 채워야 한다.
	 */
	public OriginDecisionPipeline forIndividual(String companyCode, List<String> productCodes) {
		OriginDeterminationMode mode = resolveMode(companyCode);
		return new OriginDecisionPipeline(Collections.emptyList(), mode, productCodes, individualVirtualSalesGenerator,
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
