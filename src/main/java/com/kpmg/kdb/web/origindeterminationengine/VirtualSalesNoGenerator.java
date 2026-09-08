package com.kpmg.kdb.web.origindeterminationengine;

import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 내수 판정(월판정/개별판정 공용) "1. 가상 매출 번호 채번" 단계의 부품 인터페이스. AggregatedVirtualSalesGenerator가
// 사용하며, 기본 구현(CustomerDivisionYyyymmSalesNoGenerator)은 CUSTOMER_CODE+DIVISION_CODE+YYYYMM 조합이지만 구현체만 갈아끼우면 된다.
public interface VirtualSalesNoGenerator {

	String generate(VirtualSalesGenerationParams params);
}
