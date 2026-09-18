package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.core.procedurelog.ProcedureLogService;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 내수 판정 진입점. DomesticOriginDeterminationTargetService로 대상 그룹((companyCode,divisionCode,customerCode) 조합)을
// 조회한 뒤, 그룹마다 OriginDeterminationPipeline을 새로 만들어 가상매출 생성-FCR 생성-원산지 판정-STATUS 업데이트 4단계를 수행한다.
@Service
public class DomesticOriginDeterminationService extends GeneralService
		implements BulkOriginDeterminationService<VirtualSalesGenerationParams> {

	@Autowired
	private OriginDeterminationPipelineFactory pipelineFactory;
	@Autowired
	private DomesticOriginDeterminationTargetService domesticOriginDeterminationTargetService;
	@Autowired
	private ProcedureLogService procedureLogService;

	@Override
	public BulkOriginDeterminationResult run(VirtualSalesGenerationParams filter) {
		// AS-IS MONTHLY_DECISION_PROC 대응 로그(내수 처리 범위 전체를 감싼다)
		Long logId = procedureLogService.batchLog("MONTHLY_DECISION_PROC", filter.getCompanyCode(),
				buildInputParameterLog(filter));

		try {
			List<VirtualSalesGenerationParams> groups = domesticOriginDeterminationTargetService.prepare(filter);

			BulkOriginDeterminationResult result = BulkPipelineRunner.run(groups,
					groupParams -> pipelineFactory
							.forDomestic(groupParams.getCompanyCode(), groupParams.getProductCodes(), logId)
							.generateVirtualSales(groupParams)
							.createFcr()
							.determineOrigin()
							.updateStatus(),
					(groupParams, e) -> logger.error(
							"내수 벌크판정 그룹 처리 실패. companyCode={}, divisionCode={}, customerCode={}, yyyymmdd={}",
							groupParams.getCompanyCode(), groupParams.getDivisionCode(), groupParams.getCustomerCode(),
							groupParams.getYyyymmdd(), e));

			logger.info("내수 벌크판정 완료. 그룹수={}, 대상건수={}, 실패건수={}", result.getGroupCount(), result.getTargets().size(),
					result.getFailedTargets().size());

			procedureLogService.batchLogDtl(logId, "***** END MONTHLY_DECISION_PROC");
			procedureLogService.batchLogLast(logId, "N", null, null);

			return result;
		} catch (Exception e) {
			procedureLogService.batchLogDtl(logId, "DBMS 에러가 발생 했습니다 " + e);
			procedureLogService.batchLogLast(logId, "E", "DBMS ERROR", null);
			throw e;
		}
	}

	private static String buildInputParameterLog(VirtualSalesGenerationParams filter) {
		return "COMPANY_CODE : " + filter.getCompanyCode()
				+ ", CUSTOMER_CODE : " + filter.getCustomerCode()
				+ ", DELIVERY_CUSTOMER_CODE : " + filter.getDeliveryCustomerCode()
				+ ", P_YYYYMM : " + filter.getYyyymmdd()
				+ ", DIVISION_CODE : " + filter.getDivisionCode();
	}
}
