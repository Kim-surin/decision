package com.kpmg.kdb.web.origindeterminationexecution.dto;

/** 레거시 CURSOR C_SALES_MST(MONTHLY_DECISION_PROC "4. 판정대상 커서") 한 행 */
public class SalesTarget {

	private String companyCode;
	private String divisionCode;
	private String salesNo;

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

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}
}
