package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesGenerator} 기본 구현. 레거시 MONTHLY_DECISION_PROC "1. 내수 포괄 매출 생성" /
 * "2. 포괄 SALES_DTL 생성" / "4. 판정대상 커서(C_SALES_MST)" 를 그대로 이관한 {@link AggregatedVirtualSalesDao}
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
		AggregatedVirtualSalesDao dao = sqlSession.getMapper(AggregatedVirtualSalesDao.class);

		// 원본 레거시(개별판정 화면, OriginDeterminCoverDAO#insertSalesMstVirtual)는 DELETE 없이 MERGE
		// 만으로 가상매출을 갱신한다 — MERGE 의 WHEN MATCHED 가 기존 SALES_SEQ 를 유지한 채 값만 갱신
		// 하므로, 같은 제품을 반복 판정해도 SALES_SEQ 가 바뀌지 않아 FCR_MST/FCR_DTL/FCR_RESULT 가 계속
		// 같은 행을 가리킨다. DELETE-후-재생성은 MONTHLY_DECISION_PROC(월판정, productCodes 없음) 전용
		// 동작이었다 — productCodes 가 지정된(개별/특정 제품 한정) 호출까지 함께 삭제하면 그 제품의
		// SALES_SEQ 가 매번 새로 채번돼 예전 FCR_* 행이 고아로 남는다(AggregatedVirtualSalesDaoMapper.xml
		// 주석 참고). 그래서 productCodes 가 있을 때는 삭제를 건너뛰고 MERGE 만 수행한다.
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			dao.deleteAggregatedSalesDtl(params);
			dao.deleteAggregatedSalesMst(params);
		}
		dao.mergeAggregatedSalesMst(params);
		dao.mergeAggregatedSalesDtl(params);

		return dao.selectDecisionTargets(params);
	}
}
