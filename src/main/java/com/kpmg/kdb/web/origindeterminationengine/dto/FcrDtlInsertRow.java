package com.kpmg.kdb.web.origindeterminationengine.dto;

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
	private BigDecimal originatingQty;
	private BigDecimal originatingAmount;
	private BigDecimal nonOriginatingQty;
	private BigDecimal nonOriginatingAmount;
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

	public BigDecimal getOriginatingQty() {
		return originatingQty;
	}

	public void setOriginatingQty(BigDecimal originatingQty) {
		this.originatingQty = originatingQty;
	}

	public BigDecimal getOriginatingAmount() {
		return originatingAmount;
	}

	public void setOriginatingAmount(BigDecimal originatingAmount) {
		this.originatingAmount = originatingAmount;
	}

	public BigDecimal getNonOriginatingQty() {
		return nonOriginatingQty;
	}

	public void setNonOriginatingQty(BigDecimal nonOriginatingQty) {
		this.nonOriginatingQty = nonOriginatingQty;
	}

	public BigDecimal getNonOriginatingAmount() {
		return nonOriginatingAmount;
	}

	public void setNonOriginatingAmount(BigDecimal nonOriginatingAmount) {
		this.nonOriginatingAmount = nonOriginatingAmount;
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
