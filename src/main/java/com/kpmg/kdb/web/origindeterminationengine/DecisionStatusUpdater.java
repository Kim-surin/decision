package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.List;

/**
 * {@link OriginDecisionPipeline} "SALES_DTL STATUS 업데이트" 단계의 부품 인터페이스.
 * 기본 구현은 {@link SalesDecisionStatusUpdater} 참고.
 */
public interface DecisionStatusUpdater {

	void updateStatus(String companyCode, String salesNo, List<String> productCodes);
}
