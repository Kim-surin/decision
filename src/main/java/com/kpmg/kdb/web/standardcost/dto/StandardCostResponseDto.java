package com.kpmg.kdb.web.standardcost.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StandardCostResponseDto {
	String ITEM_CODE;
	String ITEM_NAME;
	String DIVISION_NAME;
	String APPLY_DATE;
	String END_DATE;
	String STANDARD_COST_AMOUNT;
}
