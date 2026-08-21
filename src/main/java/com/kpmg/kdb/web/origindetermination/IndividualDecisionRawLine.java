package com.kpmg.kdb.web.origindetermination;

/**
 * 개별판정 배치 처리 원본 입력 1행(예: 업로드/요청 payload 의 SALES_NO+PRODUCT_CODE 조합).
 * CUSTOMER_CODE+DIVISION_CODE+YYYYMM(INVOICE_DATE 앞 6자리)+COMPANY_CODE 로 그룹핑되어 그룹당
 * 가상매출 1건(=SALES_NO 1건)으로 합쳐진다({@link IndividualDecisionGroupingService} 참고).
 */
public class IndividualDecisionRawLine {

	private String salesNo;
	private String divisionCode;
	private String companyCode;
	private String customerCode;
	private String exportFlag;
	private String invoiceDate;
	private String productCode;

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
}
