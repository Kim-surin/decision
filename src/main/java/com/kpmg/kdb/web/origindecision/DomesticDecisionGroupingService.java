package com.kpmg.kdb.web.origindecision;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.monthlydecision.MonthlyDecisionDao;
import com.kpmg.kdb.web.monthlydecision.dto.PendingDomesticGroup;
import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 내수 벌크 판정(MONTHLY_DECISION_PROC 이관 확장) "1. 데이터 가공" 단계. 레거시 MONTHLY_DECISION_PROC 는
 * "1. 내수 포괄 매출 생성"(mergeAggregatedSalesMst)의 MERGE 문 안에서 GROUP BY(COMPANY_CODE,
 * DIVISION_CODE, CUSTOMER_CODE)로 대상 그룹을 감춰서 한 번에 처리했는데, 여기서는 그 그룹을
 * {@link MonthlyDecisionDao#selectPendingDomesticGroups} 로 먼저 목록으로 뽑아, 그룹마다
 * {@link VirtualSalesGenerationParams} 1건(고객사/사업부를 특정 그룹으로 좁힌 값)을 만든다 —
 * 개별판정 배치({@link IndividualDecisionGroupingService})와 동일하게 "그룹마다 파이프라인 1개"로
 * 처리할 수 있도록 하기 위함이다({@link DomesticBulkDecisionService} 참고).
 *
 * <p>filter 의 companyCode/yyyymmdd 는 필수이고, divisionCode/customerCode/deliveryCustomerCode/
 * productCodes 는 레거시 MONTHLY_DECISION_PROC 의 선택 파라미터(P_DIVISION_CODE 등)와 동일하게
 * 선택값이다 — 지정하면 해당 조건으로 그룹 조회 범위를 좁히고, 그룹별 params 에도 그대로 이어붙인다
 * (deliveryCustomerCode/productCodes 는 SALES_MST 그룹 구분 자체에는 쓰이지 않고 실매출을 좁히는
 * 필터라 그룹마다 동일하게 전달한다 — mergeAggregatedSalesMst 의 GROUP BY 대상과 동일한 이유).
 */
@Service
public class DomesticDecisionGroupingService extends GeneralService {

	public List<VirtualSalesGenerationParams> prepare(VirtualSalesGenerationParams filter) {
		MonthlyDecisionDao dao = sqlSession.getMapper(MonthlyDecisionDao.class);
		List<PendingDomesticGroup> groups = dao.selectPendingDomesticGroups(filter);

		List<VirtualSalesGenerationParams> result = new ArrayList<>(groups.size());
		for (PendingDomesticGroup group : groups) {
			VirtualSalesGenerationParams params = new VirtualSalesGenerationParams();
			params.setCompanyCode(group.getCompanyCode());
			params.setDivisionCode(group.getDivisionCode());
			params.setCustomerCode(group.getCustomerCode());
			params.setDeliveryCustomerCode(filter.getDeliveryCustomerCode());
			params.setProductCodes(filter.getProductCodes());
			params.setYyyymmdd(filter.getYyyymmdd());
			params.setExportFlag("D");
			result.add(params);
		}
		return result;
	}
}
