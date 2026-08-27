package com.kpmg.kdb.web.ftabom.dto;

public class FtaBomDetailResponseDto {
	private String ITEM_CODE;
	private String ITEM_NAME;
	private String UNIT;
	private String HS_CODE;
	private String INPUT_QTY;

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

	public String getUNIT() {
		return UNIT;
	}

	public void setUNIT(String UNIT) {
		this.UNIT = UNIT;
	}

	public String getHS_CODE() {
		return HS_CODE;
	}

	public void setHS_CODE(String HS_CODE) {
		this.HS_CODE = HS_CODE;
	}

	public String getINPUT_QTY() {
		return INPUT_QTY;
	}

	public void setINPUT_QTY(String INPUT_QTY) {
		this.INPUT_QTY = INPUT_QTY;
	}
}
