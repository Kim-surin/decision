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

	/** 판정 대상 (회사,사업부,고객사) 그룹을 조회한다. mergeAggregatedSalesMst의 WHERE 조건과 반드시 일치해야 한다. */
	List<PendingDomesticGroup> selectPendingDomesticGroups(@Param("p") VirtualSalesGenerationParams params);
}
