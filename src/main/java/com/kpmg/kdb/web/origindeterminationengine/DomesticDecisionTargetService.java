package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.PendingDomesticGroup;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 내수 판정 "1. 데이터 가공" 단계. selectPendingDomesticGroups로 그룹을 뽑아 그룹마다 VirtualSalesGenerationParams
// 1건을 만든다("그룹마다 파이프라인 1개"). filter의 companyCode/yyyymmdd는 필수, 나머지는 선택값(지정 시 범위를 좁힌다).
@Service
public class DomesticDecisionTargetService extends GeneralService {

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
