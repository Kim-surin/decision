package com.kpmg.kdb.web.sales.dto;

public class SalesResponseDto {
	private String INVOICE_NO;
	private String DIVISION_NAME;
	private String PRODUCT_CODE;
	private String PRODUCT_NAME;
	private String CUSTOMER_NAME;
	private String UNIT_PRICE;
	private String QUANTITY;
	private String AMOUNT;
	private String INVOICE_DATE;
	private String EXPORT_FLAG;

	public String getINVOICE_NO() {
		return INVOICE_NO;
	}

	public void setINVOICE_NO(String INVOICE_NO) {
		this.INVOICE_NO = INVOICE_NO;
	}

	public String getDIVISION_NAME() {
		return DIVISION_NAME;
	}

	public void setDIVISION_NAME(String DIVISION_NAME) {
		this.DIVISION_NAME = DIVISION_NAME;
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

	public String getCUSTOMER_NAME() {
		return CUSTOMER_NAME;
	}

	public void setCUSTOMER_NAME(String CUSTOMER_NAME) {
		this.CUSTOMER_NAME = CUSTOMER_NAME;
	}

	public String getUNIT_PRICE() {
		return UNIT_PRICE;
	}

	public void setUNIT_PRICE(String UNIT_PRICE) {
		this.UNIT_PRICE = UNIT_PRICE;
	}

	public String getQUANTITY() {
		return QUANTITY;
	}

	public void setQUANTITY(String QUANTITY) {
		this.QUANTITY = QUANTITY;
	}

	public String getAMOUNT() {
		return AMOUNT;
	}

	public void setAMOUNT(String AMOUNT) {
		this.AMOUNT = AMOUNT;
	}

	public String getINVOICE_DATE() {
		return INVOICE_DATE;
	}

	public void setINVOICE_DATE(String INVOICE_DATE) {
		this.INVOICE_DATE = INVOICE_DATE;
	}

	public String getEXPORT_FLAG() {
		return EXPORT_FLAG;
	}

	public void setEXPORT_FLAG(String EXPORT_FLAG) {
		this.EXPORT_FLAG = EXPORT_FLAG;
	}
}
