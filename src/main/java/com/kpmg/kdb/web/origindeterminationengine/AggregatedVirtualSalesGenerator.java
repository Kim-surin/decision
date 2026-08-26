package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesGenerator} 기본 구현. 내수(고객사/사업부 그룹) 단위로 가상 SALES_MST/SALES_DTL을
 * 만들고 판정대상 커서를 조회하는 {@link AggregatedVirtualSalesDao} 쿼리를 순서대로 호출한다.
 *
 * <p>{@code params.getExportFlag()} 를 지정하지 않으면 판정 대상 커서는 내수(가상매출)와 이미
 * TARGET_FTA_CODE 가 세팅된 수출 건을 함께 반환한다 — 내수 전용으로 쓰려면 {@code params.setExportFlag("D")}
 * 로 스코프를 좁혀야 한다.
 */
@Service
public class AggregatedVirtualSalesGenerator extends GeneralService implements VirtualSalesGenerator {

	@Autowired
	private VirtualSalesNoGenerator salesNoGenerator;

	@Override
	public List<SalesTarget> generate(VirtualSalesGenerationParams params) {
		AggregatedVirtualSalesDao dao = sqlSession.getMapper(AggregatedVirtualSalesDao.class);

		// 1. 가상 매출 번호 채번
		String virtualSalesNo = salesNoGenerator.generate(params);

		// productCodes 지정 호출(개별/특정 제품 한정)까지 삭제하면 MERGE의 SALES_SEQ 유지 효과가 깨져
		// 예전 FCR_* 행이 고아로 남는다 — DELETE-후-재생성은 월판정(productCodes 없음) 전용 동작.
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			dao.deleteAggregatedSalesDtl(virtualSalesNo, params);
			dao.deleteAggregatedSalesMst(virtualSalesNo, params);
		}
		dao.mergeAggregatedSalesMst(virtualSalesNo, params);
		dao.mergeAggregatedSalesDtl(virtualSalesNo, params);

		return dao.selectDecisionTargets(params);
	}
}
