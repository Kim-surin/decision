package com.kpmg.kdb.web.sales.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SalesResponseDto {
	String INVOICE_NO;
	String DIVISION_NAME;
	String PRODUCT_CODE;
	String PRODUCT_NAME;
	String CUSTOMER_NAME;
	String UNIT_PRICE;
	String QUANTITY;
	String AMOUNT;
	String INVOICE_DATE;
	String EXPORT_FLAG;
}
