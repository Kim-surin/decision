package com.kpmg.kdb.web.coodecision.dto;

import java.math.BigDecimal;

/**
 * 레거시 FCR_INFO_TEMP(원산지판정용 임시 워킹테이블) 한 행.
 *
 * 원본은 Oracle GLOBAL TEMPORARY TABLE 로, 매출 1건(FM_LIST) 판정을 시작할 때 FCR_DTL(BOM 소요량)
 * 에서 INSERT 로 적재한 뒤 판정 로직 전체(배제기준/CTC/RVC/RCEP 등)가 이 테이블을 수십 차례 반복 조회한다.
 * Java 이관에서는 이 테이블을 그대로 옮기지 않고, 매출 1건당 한 번만 조회해 이 DTO 리스트로 메모리에
 * 적재한 뒤 이후의 모든 판정 로직이 스트림 연산으로 처리하도록 설계했다(반복 DB 호출 제거).
 */
public class FcrInfoRow {

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
	private BigDecimal inareaQty;
	private BigDecimal inareaAmount;
	private BigDecimal outareaQty;
	private BigDecimal outareaAmount;
	private String cooNation;

	/** EXCLUSION_RULE1_YN ~ EXCLUSION_RULE14_YN. index 0 = RULE1 */
	private final boolean[] exclusionRuleYn = new boolean[14];

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

	public String getCooNation() {
		return cooNation;
	}

	public void setCooNation(String cooNation) {
		this.cooNation = cooNation;
	}

	/** ruleNo: 1 ~ 14 */
	public boolean isExclusionRule(int ruleNo) {
		return exclusionRuleYn[ruleNo - 1];
	}

	/** ruleNo: 1 ~ 14 */
	public void setExclusionRule(int ruleNo, boolean yn) {
		exclusionRuleYn[ruleNo - 1] = yn;
	}

	public boolean isKoreaOrigin() {
		return "KR".equals(cooNation);
	}
}
