package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * 레거시 CREATE_FCR 3-2(수출) 단계의 SALES×FTA_APPLY_NATION×FTA_MASTER 조인 결과 한 행
 * (FS03_GET_HS_CODE/GET_INCOTERMS_CHANGE_RATE 호출 전 원시 데이터. ftaCode 는 FTA_MASTER 매칭 결과)
 */
public class ExportSalesLine {

	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String productCode;
	private String divisionCode;
	private String companyCode;
	private String standard;
	private BigDecimal quantity;
	private BigDecimal amount;
	private String inkoterms;
	private String spCooYn;
	private String woCooYn;
	private String productUnit;
	private String productAssetsType;
	private String prodDivisionCode;
	private String exportFlag;
	private String arrivalNation;
	private String invoiceDate;
	private String deliveryCustomerCode;
	/** 3-2 INSERT 의 DECODE(V_BOM_TYPE,'F','F',DECODE(FM.INTERMEDIATE_YN,'Y','MF','F')) 계산용 */
	private String intermediateYn;

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

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getInkoterms() {
		return inkoterms;
	}

	public void setInkoterms(String inkoterms) {
		this.inkoterms = inkoterms;
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

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getArrivalNation() {
		return arrivalNation;
	}

	public void setArrivalNation(String arrivalNation) {
		this.arrivalNation = arrivalNation;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getDeliveryCustomerCode() {
		return deliveryCustomerCode;
	}

	public void setDeliveryCustomerCode(String deliveryCustomerCode) {
		this.deliveryCustomerCode = deliveryCustomerCode;
	}

	public String getIntermediateYn() {
		return intermediateYn;
	}

	public void setIntermediateYn(String intermediateYn) {
		this.intermediateYn = intermediateYn;
	}
}
