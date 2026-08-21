package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * {@link OriginCriteriaBatchRequest} 1건에 대응하는 배치 조회 결과 행. 여러 요청을 한 쿼리로 묶어
 * 보내므로, 어느 요청에서 나온 행인지 구분하려면 요청 키(reqHsCode/reqFtaCode/reqHsCodeSubCategory)를
 * 같이 돌려받아야 한다 — {@link OriginCriteria#getHsCode()} 는 매칭된 룰의 HS코드(요청보다 짧은
 * 접두어일 수 있음)라 그룹핑 키로 쓸 수 없다.
 */
public class OriginCriteriaBatchResult {

	private String reqHsCode;
	private String reqFtaCode;
	private String reqHsCodeSubCategory;

	private Integer ruleId;
	private String ftaCode;
	private String hsCode;
	private String hsCodeSubCategory;
	private String ruleSeq;
	private String hsCodeDescription;
	private String ruleDescription;
	private String ruleContents;
	private String spRule;
	private String woRule;
	private String cthRule;
	private BigDecimal bdRule;
	private BigDecimal buRule;
	private BigDecimal ncRule;
	private BigDecimal mcRule;
	private String deMinimisUnit;
	private BigDecimal deMinimisRate;
	private String exclusionRuleYn;

	public String getReqHsCode() {
		return reqHsCode;
	}

	public void setReqHsCode(String reqHsCode) {
		this.reqHsCode = reqHsCode;
	}

	public String getReqFtaCode() {
		return reqFtaCode;
	}

	public void setReqFtaCode(String reqFtaCode) {
		this.reqFtaCode = reqFtaCode;
	}

	public String getReqHsCodeSubCategory() {
		return reqHsCodeSubCategory;
	}

	public void setReqHsCodeSubCategory(String reqHsCodeSubCategory) {
		this.reqHsCodeSubCategory = reqHsCodeSubCategory;
	}

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

	public OriginCriteria toCriteria() {
		OriginCriteria criteria = new OriginCriteria();
		criteria.setRuleId(ruleId);
		criteria.setFtaCode(ftaCode);
		criteria.setHsCode(hsCode);
		criteria.setHsCodeSubCategory(hsCodeSubCategory);
		criteria.setRuleSeq(ruleSeq);
		criteria.setHsCodeDescription(hsCodeDescription);
		criteria.setRuleDescription(ruleDescription);
		criteria.setRuleContents(ruleContents);
		criteria.setSpRule(spRule);
		criteria.setWoRule(woRule);
		criteria.setCthRule(cthRule);
		criteria.setBdRule(bdRule);
		criteria.setBuRule(buRule);
		criteria.setNcRule(ncRule);
		criteria.setMcRule(mcRule);
		criteria.setDeMinimisUnit(deMinimisUnit);
		criteria.setDeMinimisRate(deMinimisRate);
		criteria.setExclusionRuleYn(exclusionRuleYn);
		return criteria;
	}
}
