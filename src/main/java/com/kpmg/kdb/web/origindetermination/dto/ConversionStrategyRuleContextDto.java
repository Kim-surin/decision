package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * selectConversionStrategyRuleContext 전용 DTO. 이 패키지의 다른 응답 DTO(snake_case 필드, 전부 String)와
 * 달리 매퍼 XML의 resultType이 실제로 이 클래스를 가리켜서 MyBatis가 리플렉션으로 필드를 채워 넣는다.
 * mapUnderscoreToCamelCase=true 설정으로 컬럼(FTA_CODE 등)이 camelCase 프로퍼티(ftaCode)에 매핑되므로
 * 필드명을 camelCase로, 타입도 실제 연산에 쓰는 타입(BigDecimal 등) 그대로 선언해야 한다.
 */
public class ConversionStrategyRuleContextDto {
	private String ftaCode;
	private String productCode;
	private String productName;
	private String hsCode;
	private BigDecimal amount;
	private Integer ruleId;
	private String ruleCode;
	private String cthRule;
	private BigDecimal buRule;
	private BigDecimal bdRule;
	private BigDecimal ncRule;
	private BigDecimal mcRule;
	private BigDecimal inkotermsAmount;
	private BigDecimal netCostAmount;
	private BigDecimal inareaAmount;
	private BigDecimal outareaAmount;

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getRuleId() {
		return ruleId;
	}

	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}

	public String getRuleCode() {
		return ruleCode;
	}

	public void setRuleCode(String ruleCode) {
		this.ruleCode = ruleCode;
	}

	public String getCthRule() {
		return cthRule;
	}

	public void setCthRule(String cthRule) {
		this.cthRule = cthRule;
	}

	public BigDecimal getBuRule() {
		return buRule;
	}

	public void setBuRule(BigDecimal buRule) {
		this.buRule = buRule;
	}

	public BigDecimal getBdRule() {
		return bdRule;
	}

	public void setBdRule(BigDecimal bdRule) {
		this.bdRule = bdRule;
	}

	public BigDecimal getNcRule() {
		return ncRule;
	}

	public void setNcRule(BigDecimal ncRule) {
		this.ncRule = ncRule;
	}

	public BigDecimal getMcRule() {
		return mcRule;
	}

	public void setMcRule(BigDecimal mcRule) {
		this.mcRule = mcRule;
	}

	public BigDecimal getInkotermsAmount() {
		return inkotermsAmount;
	}

	public void setInkotermsAmount(BigDecimal inkotermsAmount) {
		this.inkotermsAmount = inkotermsAmount;
	}

	public BigDecimal getNetCostAmount() {
		return netCostAmount;
	}

	public void setNetCostAmount(BigDecimal netCostAmount) {
		this.netCostAmount = netCostAmount;
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
}
