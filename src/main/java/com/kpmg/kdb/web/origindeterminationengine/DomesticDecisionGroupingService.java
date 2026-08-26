package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.PendingDomesticGroup;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 내수 벌크 판정 "1. 데이터 가공" 단계. {@link DomesticDecisionGroupingDao#selectPendingDomesticGroups}
 * 로 (회사,사업부,고객사) 그룹을 뽑아 그룹마다 {@link VirtualSalesGenerationParams} 1건을 만든다 —
 * 개별판정 배치({@link IndividualDecisionGroupingService})와 동일하게 "그룹마다 파이프라인 1개"로
 * 처리하기 위함이다({@link DomesticBulkDecisionService} 참고).
 *
 * <p>filter 의 companyCode/yyyymmdd 는 필수, divisionCode/customerCode/deliveryCustomerCode/
 * productCodes 는 선택값이다 — 지정하면 그룹 조회 범위를 좁히고 그룹별 params 에도 그대로 이어붙인다.
 */
@Service
public class DomesticDecisionGroupingService extends GeneralService {

	public List<VirtualSalesGenerationParams> prepare(VirtualSalesGenerationParams filter) {
		DomesticDecisionGroupingDao dao = sqlSession.getMapper(DomesticDecisionGroupingDao.class);
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
