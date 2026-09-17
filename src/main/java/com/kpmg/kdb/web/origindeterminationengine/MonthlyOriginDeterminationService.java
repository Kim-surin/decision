package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyOriginDeterminationFlags;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 월판정 진입점 - 내수+수출을 순서대로 호출해 결과를 합친다. 개별판정에는 없던 원재료수불부 자동생성
// (AUTO_MATERIAL_INV_BAL_PROC)을 여기서만 1회 수행하고, 공유 서비스인 도메스틱/수출 서비스는 이 단계를 모른다.
@Service
public class MonthlyOriginDeterminationService extends GeneralService
		implements BulkOriginDeterminationService<VirtualSalesGenerationParams> {

	@Autowired
	private DomesticOriginDeterminationService domesticOriginDeterminationService;
	@Autowired
	private ExportOriginDeterminationTargetService exportOriginDeterminationTargetService;
	@Autowired
	private ExportOriginDeterminationService exportOriginDeterminationService;
	@Autowired
	private CompanyOriginDeterminationFlagsService companyOriginDeterminationFlagsService;

	@Override
	public BulkOriginDeterminationResult run(VirtualSalesGenerationParams filter) {
		runMaterialInvBalIfNeeded(filter.getCompanyCode());

		BulkOriginDeterminationResult domesticResult = domesticOriginDeterminationService.run(filter);

		List<ExportOriginDeterminationTarget> exportTargets = exportOriginDeterminationTargetService.prepare(filter);
		BulkOriginDeterminationResult exportResult = exportOriginDeterminationService.run(exportTargets);

		List<SalesTarget> allTargets = new ArrayList<>(domesticResult.getTargets());
		allTargets.addAll(exportResult.getTargets());
		List<SalesTarget> allFailedTargets = new ArrayList<>(domesticResult.getFailedTargets());
		allFailedTargets.addAll(exportResult.getFailedTargets());

		logger.info("월판정(내수+수출) 배치 완료. 내수 그룹수={}, 수출 대상건수={}, 총대상건수={}, 실패건수={}",
				domesticResult.getGroupCount(), exportResult.getGroupCount(), allTargets.size(),
				allFailedTargets.size());

		return new BulkOriginDeterminationResult(domesticResult.getGroupCount() + exportResult.getGroupCount(), allTargets,
				allFailedTargets);
	}

	/** AS-IS PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC 대응. 아직 이관 대상이 아니라 경고 로그만 남긴다. */
	private void runMaterialInvBalIfNeeded(String companyCode) {
		CompanyOriginDeterminationFlags flags = companyOriginDeterminationFlagsService.getDecisionFlags(companyCode);
		if ("Y".equals(flags.getMaterialUseYn())) {
			logger.warn(
					"PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC 미이관: 원재료수불부(자동생성) 로드 단계를 건너뜁니다. companyCode={}",
					companyCode);
		}
	}
}
