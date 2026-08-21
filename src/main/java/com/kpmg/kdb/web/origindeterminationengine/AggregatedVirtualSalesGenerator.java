package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationexecution.MonthlyDecisionDao;
import com.kpmg.kdb.web.origindeterminationexecution.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationexecution.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesGenerator} 기본 구현. 레거시 MONTHLY_DECISION_PROC "1. 내수 포괄 매출 생성" /
 * "2. 포괄 SALES_DTL 생성" / "4. 판정대상 커서(C_SALES_MST)" 를 그대로 이관한 {@link MonthlyDecisionDao}
 * 쿼리를 순서대로 호출한다.
 *
 * <p>{@code params.getExportFlag()} 를 지정하지 않으면 판정 대상 커서는 내수(가상매출)와 이미
 * TARGET_FTA_CODE 가 세팅된 수출 건을 함께 반환한다 — 내수 파이프라인 전용으로 쓰려면 호출측에서
 * {@code params.setExportFlag("D")} 로 스코프를 좁혀야 한다.
 */
@Service
public class AggregatedVirtualSalesGenerator extends GeneralService implements VirtualSalesGenerator {

	@Override
	public List<SalesTarget> generate(VirtualSalesGenerationParams params) {
		MonthlyDecisionDao dao = sqlSession.getMapper(MonthlyDecisionDao.class);

		dao.deleteAggregatedSalesDtl(params);
		dao.deleteAggregatedSalesMst(params);
		dao.mergeAggregatedSalesMst(params);
		dao.mergeAggregatedSalesDtl(params);

		return dao.selectDecisionTargets(params);
	}
}
