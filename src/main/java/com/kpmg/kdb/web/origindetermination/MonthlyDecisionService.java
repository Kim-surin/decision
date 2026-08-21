package com.kpmg.kdb.web.origindetermination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.OriginDeterminationExecutionService;
import com.kpmg.kdb.web.origindetermination.CreateFcrService;
import com.kpmg.kdb.web.origindetermination.dto.VirtualSalesGenerationParams;
import com.kpmg.kdb.web.origindetermination.OriginDecisionPipeline;
import com.kpmg.kdb.web.origindetermination.OriginDecisionPipelineFactory;

/**
 * 레거시 MONTHLY_DECISION_PROC 이관.
 *
 * 내수 포괄(가상) 매출 마스터/상세 생성부터 판정대상(SALES_NO) 커서 순회, 매출건마다
 * {@link CreateFcrService}(CREATE_FCR)로 FCR_MST/FCR_DTL 을 만들고 {@link OriginDeterminationExecutionService}
 * (COO_DECISION)로 원산지를 판정한 뒤 상태값을 갱신하는 전체 흐름은 이제 {@link OriginDecisionPipeline}
 * (내수용 메서드 체이닝: generateVirtualSales-&gt;createFcr-&gt;determineOrigin-&gt;updateStatus)에 위임한다.
 * 이 클래스는 배치 트리거가 호출하는 기존 진입점({@link #run})을 유지하기 위한 얇은 래퍼다.
 *
 * <p>대상 매출이 대량일 수 있는 배치 성격상, 판정대상 목록은 회사/기간 단위로 자연히 유한하게
 * 제한되는 조회 결과 하나만 메모리에 두고(SALES_NO 목록), 매출 1건에 대한 실제 무거운 데이터
 * (BOM 전개, FCR_INFO_TEMP 대체 리스트 등)는 파이프라인이 매출 1건 처리 후 즉시 버려지는 지역
 * 변수로만 다뤄 누적되지 않는다(OOM 방지).
 */
@Service
public class MonthlyDecisionService extends GeneralService {

	@Autowired
	private OriginDecisionPipelineFactory pipelineFactory;

	public void run(VirtualSalesGenerationParams params) {
		try {
			OriginDecisionPipeline pipeline = pipelineFactory.forDomestic(params.getCompanyCode(), null)
					.generateVirtualSales(params)
					.createFcr()
					.determineOrigin()
					.updateStatus();

			logger.info("MONTHLY_DECISION_PROC 판정 완료. companyCode={}, 대상건수={}, 실패건수={}",
					params.getCompanyCode(), pipeline.targets().size(), pipeline.failedTargets().size());
		} catch (Exception e) {
			logger.error("MONTHLY_DECISION_PROC 실패. companyCode={}, yyyymmdd={}", params.getCompanyCode(),
					params.getYyyymmdd(), e);
		}
	}
}
