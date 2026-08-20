package com.kpmg.kdb.web.origindetermination.dto;

public class OriginDeterminationDetailResponseDto {
	private String SALES_NO;
	private String SALES_SEQ;
	private String PRODUCT_CODE;
	private String PRODUCT_NAME;
	private String HS_CODE;
	private String QUANTITY;
	private String UNIT;
	private String UNIT_PRICE;
	private String AMOUNT;

	public String getSALES_NO() {
		return SALES_NO;
	}

	public void setSALES_NO(String SALES_NO) {
		this.SALES_NO = SALES_NO;
	}

	public String getSALES_SEQ() {
		return SALES_SEQ;
	}

	public void setSALES_SEQ(String SALES_SEQ) {
		this.SALES_SEQ = SALES_SEQ;
	}

	public String getPRODUCT_CODE() {
		return PRODUCT_CODE;
	}

	public void setPRODUCT_CODE(String PRODUCT_CODE) {
		this.PRODUCT_CODE = PRODUCT_CODE;
	}

	public String getPRODUCT_NAME() {
		return PRODUCT_NAME;
	}

	public void setPRODUCT_NAME(String PRODUCT_NAME) {
		this.PRODUCT_NAME = PRODUCT_NAME;
	}

	public String getHS_CODE() {
		return HS_CODE;
	}

	public void setHS_CODE(String HS_CODE) {
		this.HS_CODE = HS_CODE;
	}

	public String getQUANTITY() {
		return QUANTITY;
	}

	public void setQUANTITY(String QUANTITY) {
		this.QUANTITY = QUANTITY;
	}

	public String getUNIT() {
		return UNIT;
	}

	public void setUNIT(String UNIT) {
		this.UNIT = UNIT;
	}

	public String getUNIT_PRICE() {
		return UNIT_PRICE;
	}

	public void setUNIT_PRICE(String UNIT_PRICE) {
		this.UNIT_PRICE = UNIT_PRICE;
	}

	public String getAMOUNT() {
		return AMOUNT;
	}

	public void setAMOUNT(String AMOUNT) {
		this.AMOUNT = AMOUNT;
	}
}
