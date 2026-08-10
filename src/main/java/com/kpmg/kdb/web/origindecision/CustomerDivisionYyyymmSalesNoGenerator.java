package com.kpmg.kdb.web.origindecision;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesNoGenerator} 기본 구현. 레거시 "SELECT customerCode||divisionCode||yyyymm FROM
 * DUAL" 과 동일하게 CUSTOMER_CODE+DIVISION_CODE+YYYYMM 문자열을 그대로 이어붙인다. DB 조회가 필요
 * 없다.
 */
@Service
public class CustomerDivisionYyyymmSalesNoGenerator implements VirtualSalesNoGenerator {

	@Override
	public String generate(VirtualSalesGenerationParams params) {
		return params.getCustomerCode() + params.getDivisionCode() + params.getYyyymm();
	}
}
