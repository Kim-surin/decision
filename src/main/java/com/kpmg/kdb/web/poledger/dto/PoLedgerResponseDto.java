package com.kpmg.kdb.web.poledger.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PoLedgerResponseDto {
	String WAREHOUSING_NO;
	String ORDER_NO;
	String VENDOR_CODE;
	String VENDOR_NAME;
	String ITEM_CODE;
	String ITEM_NAME;
	String WAREHOUSING_DATE;
	String WAREHOUSING_AMOUNT;
	String WAREHOUSING_QTY;
	String UNIT_PRICE;
	String WAREHOUSING_TYPE;
	String COO_CERTIFY_YN;
	String DIVISION_NAME;
	String DIVISION_CODE;
}
