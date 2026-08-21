package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/** 레거시 CURSOR C_FTA_EXCLUSION_RULE(FER_LIST) 한 행: 예외타입 1건의 결합조건/기준율 */
public class ExclusionRuleHeader {

	private String exclusionType;
	/** 'AND' / 'OR' / 'IF' */
	private String joinCondition;
	private BigDecimal exclusionRate;

	public String getExclusionType() {
		return exclusionType;
	}

	public void setExclusionType(String exclusionType) {
		this.exclusionType = exclusionType;
	}

	public String getJoinCondition() {
		return joinCondition;
	}

	public void setJoinCondition(String joinCondition) {
		this.joinCondition = joinCondition;
	}

	public BigDecimal getExclusionRate() {
		return exclusionRate;
	}

	public void setExclusionRate(BigDecimal exclusionRate) {
		this.exclusionRate = exclusionRate;
	}
}
