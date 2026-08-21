package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * {@link MaterialOriginRowsRequest} 1건(FM_LIST 행 1건)에 대응하는 배치 조회 결과 행. 원본 FCR_INFO_TEMP
 * 적재처럼 요청 1건당 0~N 행(BOM 자재 수만큼)이 나올 수 있어, 매칭되는 자재가 하나도 없으면 그 요청은
 * 결과에 아예 나타나지 않는다(단건 조회가 빈 리스트를 반환하던 것과 동일 — 호출자가 Map 조회 결과 없으면
 * 빈 리스트로 처리).
 */
public class MaterialOriginRowBatchResult {

	private String reqFtaCode;
	private String reqDivisionCode;
	private int reqSalesSeq;
	private String ftaCode;
	private String divisionCode;
	private String companyCode;
	private String productCode;
	private String itemCode;
	private String parentHsCode;
	private String hsCode;
	private String standard;
	private BigDecimal weight;
	private BigDecimal requirementQty;
	private BigDecimal inputAmount;
	private BigDecimal originatingQty;
	private BigDecimal originatingAmount;
	private BigDecimal nonOriginatingQty;
	private BigDecimal nonOriginatingAmount;

	public String getReqFtaCode() {
		return reqFtaCode;
	}

	public void setReqFtaCode(String reqFtaCode) {
		this.reqFtaCode = reqFtaCode;
	}

	public String getReqDivisionCode() {
		return reqDivisionCode;
	}

	public void setReqDivisionCode(String reqDivisionCode) {
		this.reqDivisionCode = reqDivisionCode;
	}

	public int getReqSalesSeq() {
		return reqSalesSeq;
	}

	public void setReqSalesSeq(int reqSalesSeq) {
		this.reqSalesSeq = reqSalesSeq;
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

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getParentHsCode() {
		return parentHsCode;
	}

	public void setParentHsCode(String parentHsCode) {
		this.parentHsCode = parentHsCode;
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

	public MaterialOriginRow toMaterialOriginRow() {
		MaterialOriginRow row = new MaterialOriginRow();
		row.setFtaCode(ftaCode);
		row.setDivisionCode(divisionCode);
		row.setCompanyCode(companyCode);
		row.setProductCode(productCode);
		row.setItemCode(itemCode);
		row.setParentHsCode(parentHsCode);
		row.setHsCode(hsCode);
		row.setStandard(standard);
		row.setWeight(weight);
		row.setRequirementQty(requirementQty);
		row.setInputAmount(inputAmount);
		row.setOriginatingQty(originatingQty);
		row.setOriginatingAmount(originatingAmount);
		row.setNonOriginatingQty(nonOriginatingQty);
		row.setNonOriginatingAmount(nonOriginatingAmount);
		return row;
	}
}
