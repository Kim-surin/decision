package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.PendingDomesticGroup;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 내수판정 대상 (companyCode,divisionCode,customerCode) 그룹 발견. {@link DomesticDecisionGroupingService}
 * 가 사용한다.
 */
public interface DomesticDecisionGroupingDao {

	/**
	 * {@link AggregatedVirtualSalesDao#mergeAggregatedSalesMst} 가 MERGE 문의 USING 서브쿼리(WHERE + GROUP BY)로
	 * 감춰서 처리하던 대상 그룹을, 그와 동일한 WHERE 조건으로 먼저 SELECT DISTINCT 조회한다 —
	 * mergeAggregatedSalesMst 의 WHERE 절과 반드시 같이 맞춰야 한다(둘 중 하나만 고치면 그룹 발견 결과와
	 * 실제 집계 대상이 어긋난다).
	 */
	List<PendingDomesticGroup> selectPendingDomesticGroups(@Param("p") VirtualSalesGenerationParams params);
}
