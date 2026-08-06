package com.kpmg.kdb.web.monthlydecision.dto;

/** 레거시 MONTHLY_DECISION_PROC 의 파라미터 목록(P_YYYYMMDD, P_COMPANY_CODE, ...) 대체 객체 */
public class MonthlyDecisionParams {

	/** YYYYMM 또는 YYYYMMDD 모두 가능(INVOICE_DATE LIKE 접두어 매칭 기준) */
	private String yyyymmdd;
	private String companyCode;
	private String divisionCode;
	private String customerCode;
	private String deliveryCustomerCode;
	private String productCode;
	private String exportFlag;

	public String getYyyymmdd() {
		return yyyymmdd;
	}

	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getDeliveryCustomerCode() {
		return deliveryCustomerCode;
	}

	public void setDeliveryCustomerCode(String deliveryCustomerCode) {
		this.deliveryCustomerCode = deliveryCustomerCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	/** V_YYYYMM = SUBSTR(P_YYYYMMDD, 1, 6) */
	public String getYyyymm() {
		return yyyymmdd == null || yyyymmdd.length() < 6 ? yyyymmdd : yyyymmdd.substring(0, 6);
	}
}
