package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * "1. 가상매출 생성" 단계(내수 전용). 내수(고객사/사업부 그룹) 단위로 가상 SALES_MST/SALES_DTL을
 * 만들고 판정대상 커서를 조회하는 {@link AggregatedVirtualSalesDao} 쿼리를 순서대로 호출한다.
 * {@link OriginDecisionPipeline} 이 사용한다.
 */
@Service
public class AggregatedVirtualSalesGenerator extends GeneralService {

	@Autowired
	private VirtualSalesNoGenerator salesNoGenerator;

	public List<SalesTarget> generate(VirtualSalesGenerationParams params) {
		AggregatedVirtualSalesDao dao = sqlSession.getMapper(AggregatedVirtualSalesDao.class);
		params.setExportFlag("D");

		// 1. 가상 매출 번호 채번
		String virtualSalesNo = salesNoGenerator.generate(params);

		// 2. (월판정인 경우 진행하는 로직) 판정 대상 품목이 존재하지 않으면 가상 매출 전체 삭제
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			dao.deleteAggregatedSalesDtl(virtualSalesNo, params);
			dao.deleteAggregatedSalesMst(virtualSalesNo, params);
		}
		
		// 3. 가상 매출 생성
		dao.mergeAggregatedSalesMst(virtualSalesNo, params);
		dao.mergeAggregatedSalesDtl(virtualSalesNo, params);

		return dao.selectDecisionTargets(params);
	}
}
