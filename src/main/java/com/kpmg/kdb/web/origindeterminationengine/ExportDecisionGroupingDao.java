package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 수출판정 대상(이미 TARGET_FTA_CODE 가 세팅된 실제 매출) 조회. {@link ExportDecisionGroupingService} 가
 * 사용한다.
 */
public interface ExportDecisionGroupingDao {

	/**
	 * 판정대상 커서(C_SALES_MST, {@link AggregatedVirtualSalesDao#selectDecisionTargets})의 EXPORT_FLAG='E'
	 * 분기만 떼어 미리 조회한다 — 수출은 가상매출 생성이 필요 없어(이미 실제 SALES_NO 에 TARGET_FTA_CODE 가
	 * 세팅돼 있음) {@link DomesticDecisionGroupingDao#selectPendingDomesticGroups} 처럼 고객사/사업부 그룹
	 * 발견을 거칠 필요가 없다.
	 */
	List<SalesTarget> selectPendingExportTargets(@Param("p") VirtualSalesGenerationParams params);
}
