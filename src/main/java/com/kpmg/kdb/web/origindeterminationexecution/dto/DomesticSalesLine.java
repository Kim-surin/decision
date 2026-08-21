package com.kpmg.kdb.web.origindeterminationexecution.dto;

import java.math.BigDecimal;

/** 레거시 CREATE_FCR 3-2(내수) 단계의 SALES 서브쿼리 한 행 (FS03_GET_HS_CODE/GET_INCOTERMS_CHANGE_RATE 호출 전 원시 데이터) */
public class DomesticSalesLine {

	private String salesNo;
	private int salesSeq;
	private String productCode;
	private String divisionCode;
	private String companyCode;
	private String standard;
	private BigDecimal amount;
	private String spCooYn;
	private String woCooYn;
	private String productUnit;
	private String productAssetsType;
	private String prodDivisionCode;
	private String invoiceDate;
	private String exportFlag;
	private String deliveryCustomerCode;
	private String arrivalNation;

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

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getSpCooYn() {
		return spCooYn;
	}

	public void setSpCooYn(String spCooYn) {
		this.spCooYn = spCooYn;
	}

	public String getWoCooYn() {
		return woCooYn;
	}

	public void setWoCooYn(String woCooYn) {
		this.woCooYn = woCooYn;
	}

	public String getProductUnit() {
		return productUnit;
	}

	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
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

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getDeliveryCustomerCode() {
		return deliveryCustomerCode;
	}

	public void setDeliveryCustomerCode(String deliveryCustomerCode) {
		this.deliveryCustomerCode = deliveryCustomerCode;
	}

	public String getArrivalNation() {
		return arrivalNation;
	}

	public void setArrivalNation(String arrivalNation) {
		this.arrivalNation = arrivalNation;
	}
}
