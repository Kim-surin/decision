package com.kpmg.kdb.web.coodecision.dto;

import java.math.BigDecimal;

/**
 * 레거시 PKG99_COO_DECISION.COO_DECISION 의 커서 변수 FM_LIST(CURSOR C_FCR_MST) 한 행.
 * 판정 대상이 되는 FCR_MST(+SALES_MST/FTA_MASTER 등 조인) 한 건을 표현한다.
 */
public class FcrMasterLine {

	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String divisionCode;
	private String companyCode;
	private String productCode;
	private String bizProjectCode;
	/** 분모값의 유형을 정의하는 구분자(FTA_MASTER.INKOTERMS_TYPE) */
	private String inkotermsType;
	/** 미소기준 상품가격 계상기준(UAE 등) */
	private String deMinimisInkotermsType;
	private String productUnit;
	private String productAssetsType;
	private String hsCode;
	private String standard;
	private BigDecimal weight;
	private BigDecimal amount;
	private BigDecimal netCostAmount;
	private BigDecimal exworkAmount;
	private BigDecimal fobAmount;
	private BigDecimal inareaAmount;
	private BigDecimal outareaAmount;
	private String spCooYn;
	private String woCooYn;
	/** 가목/나목 처리를 위한 HS 세부분류. NULL 이면 '1' */
	private String hsCodeSubCategory;
	private String tariffYn;

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

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getBizProjectCode() {
		return bizProjectCode;
	}

	public void setBizProjectCode(String bizProjectCode) {
		this.bizProjectCode = bizProjectCode;
	}

	public String getInkotermsType() {
		return inkotermsType;
	}

	public void setInkotermsType(String inkotermsType) {
		this.inkotermsType = inkotermsType;
	}

	public String getDeMinimisInkotermsType() {
		return deMinimisInkotermsType;
	}

	public void setDeMinimisInkotermsType(String deMinimisInkotermsType) {
		this.deMinimisInkotermsType = deMinimisInkotermsType;
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

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
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

	public BigDecimal getInareaAmount() {
		return inareaAmount;
	}

	public void setInareaAmount(BigDecimal inareaAmount) {
		this.inareaAmount = inareaAmount;
	}

	public BigDecimal getOutareaAmount() {
		return outareaAmount;
	}

	public void setOutareaAmount(BigDecimal outareaAmount) {
		this.outareaAmount = outareaAmount;
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

	public String getHsCodeSubCategory() {
		return hsCodeSubCategory;
	}

	public void setHsCodeSubCategory(String hsCodeSubCategory) {
		this.hsCodeSubCategory = hsCodeSubCategory;
	}

	public String getTariffYn() {
		return tariffYn;
	}

	public void setTariffYn(String tariffYn) {
		this.tariffYn = tariffYn;
	}

	/** IF I_FM_LIST.INAREA_AMOUNT + I_FM_LIST.OUTAREA_AMOUNT <= 0 */
	public boolean hasNoMaterialAmount() {
		BigDecimal in = inareaAmount == null ? BigDecimal.ZERO : inareaAmount;
		BigDecimal out = outareaAmount == null ? BigDecimal.ZERO : outareaAmount;
		return in.add(out).signum() <= 0;
	}
}
