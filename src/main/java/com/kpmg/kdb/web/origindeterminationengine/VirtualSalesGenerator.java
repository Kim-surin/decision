package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * {@link OriginDecisionPipeline} "1. 가상매출 생성" 단계의 부품 인터페이스. 내수 전용 단계로, 회사/기간
 * 단위로 SALES_MST/SALES_DTL 가상(포괄) 매출을 만들고, 그 결과 판정 대상이 된 매출(SALES_NO) 목록을
 * 돌려준다. 기본 구현은 {@link AggregatedVirtualSalesGenerator}(레거시 MONTHLY_DECISION_PROC
 * "1.내수 포괄 매출 생성"/"2.포괄 SALES_DTL 생성"/"4.판정대상 커서") 참고.
 */
public interface VirtualSalesGenerator {

	List<SalesTarget> generate(VirtualSalesGenerationParams params);
}
