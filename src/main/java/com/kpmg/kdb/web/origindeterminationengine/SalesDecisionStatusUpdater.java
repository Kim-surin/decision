package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * {@link DecisionStatusUpdater} 기본 구현. 레거시 MONTHLY_DECISION_PROC "5. 원산지판정" 말미의
 * 상태값 갱신(SALES_MST/SALES_DTL/FCR_MST 판정완료 갱신)을 그대로 이관한 {@link SalesDecisionStatusDao}
 * 쿼리를 순서대로 호출한다. 내수(가상 SALES_NO)/수출(실제 SALES_NO) 구분 없이 동일하게 동작한다
 * (SALES_MST 갱신 자체가 VIRTUAL_YN 값으로 그 둘을 구분해 처리한다).
 */
@Service
public class SalesDecisionStatusUpdater extends GeneralService implements DecisionStatusUpdater {

	@Override
	public void updateStatus(String companyCode, String salesNo, List<String> productCodes) {
		SalesDecisionStatusDao dao = sqlSession.getMapper(SalesDecisionStatusDao.class);

		dao.updateSalesMstDecisionComplete(companyCode, salesNo, productCodes);
		dao.updateSalesDtlDecisionComplete(companyCode, salesNo, productCodes);
		dao.updateFcrMstDecisionComplete(companyCode, salesNo, productCodes);
	}
}
