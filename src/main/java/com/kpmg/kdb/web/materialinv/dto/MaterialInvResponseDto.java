package com.kpmg.kdb.web.materialinv.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MaterialInvResponseDto {
	String YYYYMM;
	String DIVISION_CODE;
	String DIVISION_NAME;
	String ITEM_CODE;
	String ITEM_NAME;
	String UNIT;
	String AGING_PERIOD;
	String INITIAL_QTY;
	String INITIAL_AMOUNT;
	String INPUT_QTY;
	String INPUT_AMOUNT;
	String EXTRA_INPUT_QTY;
	String EXTRA_INPUT_AMOUNT;
	String ISSUE_QTY;
	String ISSUE_AMOUNT;
	String EXTRA_ISSUE_QTY;
	String EXTRA_ISSUE_AMOUNT;
	String INVENTORY_QTY;
	String INVENTORY_AMOUNT;
}
