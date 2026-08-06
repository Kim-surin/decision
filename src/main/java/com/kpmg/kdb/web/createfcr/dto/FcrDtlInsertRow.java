package com.kpmg.kdb.web.createfcr.dto;

import java.math.BigDecimal;

/** 레거시 CREATE_FCR 3-3/3-4 단계에서 FCR_DTL 에 INSERT 할 1행(집계/계산이 끝난 완성 데이터) */
public class FcrDtlInsertRow {

	private String itemCode;
	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String productCode;
	private String divisionCode;
	private String companyCode;
	private String hsCode;
	private BigDecimal requirementQty;
	private BigDecimal inputAmount;
	private BigDecimal inareaQty;
	private BigDecimal inareaAmount;
	private BigDecimal outareaQty;
	private BigDecimal outareaAmount;
	private String hsCodeYn;
	/** 3-4(상품/부산물) 행은 원본에 이 컬럼이 없어 항상 null */
	private String priceNote;

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

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

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
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

	public BigDecimal getRequirementQty() {
		return requirementQty;
	}

	public void setRequirementQty(BigDecimal requirementQty) {
		this.requirementQty = requirementQty;
	}

	public BigDecimal getInputAmount() {
		return inputAmount;
	}

	public void setInputAmount(BigDecimal inputAmount) {
		this.inputAmount = inputAmount;
	}

	public BigDecimal getInareaQty() {
		return inareaQty;
	}

	public void setInareaQty(BigDecimal inareaQty) {
		this.inareaQty = inareaQty;
	}

	public BigDecimal getInareaAmount() {
		return inareaAmount;
	}

	public void setInareaAmount(BigDecimal inareaAmount) {
		this.inareaAmount = inareaAmount;
	}

	public BigDecimal getOutareaQty() {
		return outareaQty;
	}

	public void setOutareaQty(BigDecimal outareaQty) {
		this.outareaQty = outareaQty;
	}

	public BigDecimal getOutareaAmount() {
		return outareaAmount;
	}

	public void setOutareaAmount(BigDecimal outareaAmount) {
		this.outareaAmount = outareaAmount;
	}

	public String getHsCodeYn() {
		return hsCodeYn;
	}

	public void setHsCodeYn(String hsCodeYn) {
		this.hsCodeYn = hsCodeYn;
	}

	public String getPriceNote() {
		return priceNote;
	}

	public void setPriceNote(String priceNote) {
		this.priceNote = priceNote;
	}
}
