package com.kpmg.kdb.web.createfcr.dto;

import java.math.BigDecimal;

/** 레거시 CREATE_FCR 3-4(상품/부산물 FCR_DTL) 단계의 원시 행(FC10_GET_ITEM_ORIGIN_RATE 호출 전) */
public class ProductFcrDtlSourceRow {

	private String productCode;
	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String divisionCode;
	private String companyCode;
	private String hsCode;
	private String itemHsCode;
	private BigDecimal unitPrice;
	private String productAssetsType;
	private String prodDivisionCode;
	private String invoiceDate;

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
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

	public String getItemHsCode() {
		return itemHsCode;
	}

	public void setItemHsCode(String itemHsCode) {
		this.itemHsCode = itemHsCode;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getProductAssetsType() {
		return productAssetsType;
	}

	public void setProductAssetsType(String productAssetsType) {
		this.productAssetsType = productAssetsType;
	}

	public String getProdDivisionCode() {
		return prodDivisionCode;
	}

	public void setProdDivisionCode(String prodDivisionCode) {
		this.prodDivisionCode = prodDivisionCode;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
}
