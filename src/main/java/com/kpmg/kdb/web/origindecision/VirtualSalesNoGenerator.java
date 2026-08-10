package com.kpmg.kdb.web.origindecision;

import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 개별 판정 "1. 가상 매출 번호 채번" 단계의 부품 인터페이스. 기본 구현({@link
 * CustomerDivisionYyyymmSalesNoGenerator})은 CUSTOMER_CODE+DIVISION_CODE+YYYYMM 문자열 조합이지만,
 * 다른 정보를 기준으로 채번해야 하는 경우가 생기면 이 인터페이스의 구현체만 갈아끼우면 된다.
 */
public interface VirtualSalesNoGenerator {

	String generate(VirtualSalesGenerationParams params);
}
