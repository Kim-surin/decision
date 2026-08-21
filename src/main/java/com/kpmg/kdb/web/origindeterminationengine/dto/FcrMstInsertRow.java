package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/** 레거시 CREATE_FCR 3-2 단계에서 FCR_MST 에 INSERT 할 1행(HS코드/인코텀즈 환산 계산이 끝난 완성 데이터) */
public class FcrMstInsertRow {

	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String productCode;
	private String divisionCode;
	private String companyCode;
	private String hsCode;
	private String standard;
	private BigDecimal amount;
	private BigDecimal netCostAmount;
	private BigDecimal exworkAmount;
	private BigDecimal fobAmount;
	private String spCooYn;
	private String woCooYn;
	private String productUnit;
	private String productAssetsType;
	private String prodDivisionCode;
	private String imApplyYn;

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

	public BigDecimal getNetCostAmount() {
		return netCostAmount;
	}

	public void setNetCostAmount(BigDecimal netCostAmount) {
		this.netCostAmount = netCostAmount;
	}

	public BigDecimal getExworkAmount() {
		return exworkAmount;
	}

	public void setExworkAmount(BigDecimal exworkAmount) {
		this.exworkAmount = exworkAmount;
	}

	public BigDecimal getFobAmount() {
		return fobAmount;
	}

	public void setFobAmount(BigDecimal fobAmount) {
		this.fobAmount = fobAmount;
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

	public String getImApplyYn() {
		return imApplyYn;
	}

	public void setImApplyYn(String imApplyYn) {
		this.imApplyYn = imApplyYn;
	}
}
