package com.kpmg.kdb.web.standardcost.dto;

public class StandardCostResponseDto {
	private String ITEM_CODE;
	private String ITEM_NAME;
	private String DIVISION_NAME;
	private String APPLY_DATE;
	private String END_DATE;
	private String STANDARD_COST_AMOUNT;

	public String getITEM_CODE() {
		return ITEM_CODE;
	}

	public void setITEM_CODE(String ITEM_CODE) {
		this.ITEM_CODE = ITEM_CODE;
	}

	public String getITEM_NAME() {
		return ITEM_NAME;
	}

	public void setITEM_NAME(String ITEM_NAME) {
		this.ITEM_NAME = ITEM_NAME;
	}

	public String getDIVISION_NAME() {
		return DIVISION_NAME;
	}

	public void setDIVISION_NAME(String DIVISION_NAME) {
		this.DIVISION_NAME = DIVISION_NAME;
	}

	public String getAPPLY_DATE() {
		return APPLY_DATE;
	}

	public void setAPPLY_DATE(String APPLY_DATE) {
		this.APPLY_DATE = APPLY_DATE;
	}

	public String getEND_DATE() {
		return END_DATE;
	}

	public void setEND_DATE(String END_DATE) {
		this.END_DATE = END_DATE;
	}

	public String getSTANDARD_COST_AMOUNT() {
		return STANDARD_COST_AMOUNT;
	}

	public void setSTANDARD_COST_AMOUNT(String STANDARD_COST_AMOUNT) {
		this.STANDARD_COST_AMOUNT = STANDARD_COST_AMOUNT;
	}
}
