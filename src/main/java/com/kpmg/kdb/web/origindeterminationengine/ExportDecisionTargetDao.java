package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 수출판정 대상(이미 TARGET_FTA_CODE 가 세팅된 실제 매출) 조회. {@link ExportDecisionTargetService} 가
 * 사용한다.
 */
public interface ExportDecisionTargetDao {

	/** 이미 TARGET_FTA_CODE가 세팅된 실제 수출 매출을 대상으로 직접 조회한다(가상매출/그룹핑 불필요). */
	List<SalesTarget> selectPendingExportTargets(@Param("p") VirtualSalesGenerationParams params);
}
