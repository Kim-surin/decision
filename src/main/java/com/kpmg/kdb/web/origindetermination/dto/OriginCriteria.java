package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * 레거시 PKG99_COO_DECISION.COO_DECISION 의 커서 변수 FR_LIST(CURSOR C_FTA_RULE) 한 행.
 * 판정 대상 HS코드에 적용 가능한 FTA_RULE(협정별 원산지 판정기준) 한 건을 표현한다.
 */
public class OriginCriteria {

	private Integer ruleId;
	private String ftaCode;
	private String hsCode;
	private String hsCodeSubCategory;
	private String ruleSeq;
	private String hsCodeDescription;
	private String ruleDescription;
	private String ruleContents;
	/** 'SP' 또는 '*' */
	private String spRule;
	/** 'WO' 또는 '*' */
	private String woRule;
	/** 세번변경기준 유형: 'CC'(류변경) / 'CTH'(호변경) / 'CTSH'(소호변경) 또는 '*' */
	private String cthRule;
	private BigDecimal bdRule;
	private BigDecimal buRule;
	private BigDecimal ncRule;
	private BigDecimal mcRule;
	private String deMinimisUnit;
	private BigDecimal deMinimisRate;
	private String exclusionRuleYn;

	public Integer getRuleId() {
		return ruleId;
	}

	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	public String getHsCodeSubCategory() {
		return hsCodeSubCategory;
	}

	public void setHsCodeSubCategory(String hsCodeSubCategory) {
		this.hsCodeSubCategory = hsCodeSubCategory;
	}

	public String getRuleSeq() {
		return ruleSeq;
	}

	public void setRuleSeq(String ruleSeq) {
		this.ruleSeq = ruleSeq;
	}

	public String getHsCodeDescription() {
		return hsCodeDescription;
	}

	public void setHsCodeDescription(String hsCodeDescription) {
		this.hsCodeDescription = hsCodeDescription;
	}

	public String getRuleDescription() {
		return ruleDescription;
	}

	public void setRuleDescription(String ruleDescription) {
		this.ruleDescription = ruleDescription;
	}

	public String getRuleContents() {
		return ruleContents;
	}

	public void setRuleContents(String ruleContents) {
		this.ruleContents = ruleContents;
	}

	public String getSpRule() {
		return spRule;
	}

	public void setSpRule(String spRule) {
		this.spRule = spRule;
	}

	public String getWoRule() {
		return woRule;
	}

	public void setWoRule(String woRule) {
		this.woRule = woRule;
	}

	public String getCthRule() {
		return cthRule;
	}

	public void setCthRule(String cthRule) {
		this.cthRule = cthRule;
	}

	public BigDecimal getBdRule() {
		return bdRule;
	}

	public void setBdRule(BigDecimal bdRule) {
		this.bdRule = bdRule;
	}

	public BigDecimal getBuRule() {
		return buRule;
	}

	public void setBuRule(BigDecimal buRule) {
		this.buRule = buRule;
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

	public String getDeMinimisUnit() {
		return deMinimisUnit;
	}

	public void setDeMinimisUnit(String deMinimisUnit) {
		this.deMinimisUnit = deMinimisUnit;
	}

	public BigDecimal getDeMinimisRate() {
		return deMinimisRate;
	}

	public void setDeMinimisRate(BigDecimal deMinimisRate) {
		this.deMinimisRate = deMinimisRate;
	}

	public String getExclusionRuleYn() {
		return exclusionRuleYn;
	}

	public void setExclusionRuleYn(String exclusionRuleYn) {
		this.exclusionRuleYn = exclusionRuleYn;
	}
}
