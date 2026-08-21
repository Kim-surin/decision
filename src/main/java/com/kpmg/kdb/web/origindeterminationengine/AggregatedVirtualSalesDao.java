package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 내수(고객사/사업부 그룹) 포괄 가상매출(SALES_MST/SALES_DTL) 생성과 판정대상 커서 조회.
 * {@link AggregatedVirtualSalesGenerator} 가 사용한다.
 */
public interface AggregatedVirtualSalesDao {

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_DTL 삭제 */
	int deleteAggregatedSalesDtl(@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_MST 삭제 */
	int deleteAggregatedSalesMst(@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성": 고객사/사업부/월 단위로 집계한 가상 SALES_MST 를 MERGE 로 생성 */
	int mergeAggregatedSalesMst(@Param("p") VirtualSalesGenerationParams params);

	/**
	 * "2. 포괄 SALES_DTL 생성": 가상 SALES_MST 에 대응하는 집계 SALES_DTL 을 MERGE 로 생성.
	 * 원본의 ROWNUM 기반 SALES_SEQ 채번(스캔 순서에 의존, DB 이식성 없음)을 ROW_NUMBER() OVER(...)
	 * 기반의 그룹별(CUSTOMER_CODE, DIVISION_CODE) 결정적 채번으로 교체했다(동작 개선 + 이식성 확보,
	 * 사용자 요청에 따라 이 부분은 원본을 그대로 재현하지 않고 의도적으로 고쳤다 — 업무팀 확인 권장).
	 */
	int mergeAggregatedSalesDtl(@Param("p") VirtualSalesGenerationParams params);

	/** "4. 판정대상 커서" (C_SALES_MST) */
	List<SalesTarget> selectDecisionTargets(@Param("p") VirtualSalesGenerationParams params);
}
