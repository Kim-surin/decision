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
	int deleteAggregatedSalesDtl(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_MST 삭제 */
	int deleteAggregatedSalesMst(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성": 고객사/사업부/월 단위로 집계한 가상 SALES_MST 를 MERGE 로 생성 */
	int mergeAggregatedSalesMst(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/**
	 * 가상 SALES_MST에 대응하는 집계 SALES_DTL을 MERGE로 생성.
	 */
	int mergeAggregatedSalesDtl(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/** "4. 판정대상 커서" (C_SALES_MST) */
	List<SalesTarget> selectDecisionTargets(@Param("p") VirtualSalesGenerationParams params);
}
