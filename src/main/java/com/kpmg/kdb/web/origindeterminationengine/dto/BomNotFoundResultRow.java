package com.kpmg.kdb.web.origindeterminationengine.dto;

/** CREATE_FCR 단계에서 BOM이 존재하지 않아 FCR_RESULT에 명시적으로 남기는 오류 1행 */
public class BomNotFoundResultRow {

	private String salesNo;
	private int salesSeq;
	private String ftaCode;
	private String divisionCode;
	private String companyCode;
	private String hsCode;
	private String productCode;
	private String standard;

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public int getSalesSeq() {
		return salesSeq;
	}

	public void setSalesSeq(int salesSeq) {
		this.salesSeq = salesSeq;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
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

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}
}
