package com.kpmg.kdb.web.ftabom.dto;

public class FtaBomMasterResponseDto {
	private String YYYYMM;
	private String DIVISION_NAME;
	private String PRODUCT_CODE;
	private String PRODUCT_NAME;
	private String HS_CODE;

	public String getYYYYMM() {
		return YYYYMM;
	}

	public void setYYYYMM(String YYYYMM) {
		this.YYYYMM = YYYYMM;
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

	public String getHS_CODE() {
		return HS_CODE;
	}

	public void setHS_CODE(String HS_CODE) {
		this.HS_CODE = HS_CODE;
	}
}
