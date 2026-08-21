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

		dao.deleteAggregatedSalesDtl(params);
		// SALES_MST(가상매출 헤더)는 제품 단위로 좁힐 수 없다. productCodes 가 지정된 좁은 호출(개별/특정
		// 제품 판정)에서 이 헤더까지 지우고 mergeAggregatedSalesMst 로 재생성하면, 그 사이 다른 제품들의
		// SALES_DTL 이 참조하던 헤더가 잠깐 사라졌다 다시 생기는 것뿐이라 문제는 없지만 불필요하다 —
		// mergeAggregatedSalesMst 는 WHEN NOT MATCHED 절만 있어(WHEN MATCHED 없음) 헤더가 이미 있으면
		// 그냥 아무 것도 안 하고 넘어가므로, 굳이 지우지 않아도 안전하다. companyCode+기간 전체를 다루는
		// 월판정처럼 productCodes 가 없는 호출에서는 기존과 동일하게 삭제 후 재생성한다.
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			dao.deleteAggregatedSalesMst(params);
		}
		dao.mergeAggregatedSalesMst(params);
		dao.mergeAggregatedSalesDtl(params);

		return dao.selectDecisionTargets(params);
	}
}
