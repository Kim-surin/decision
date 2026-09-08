package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

// FTA_EXCLUSION_RULE 상세 행. 하나의 예외타입에 여러 EXCLUSION_HS_CODE가 등록될 수 있어,
// 자재 HS코드가 이 중 하나를 접두로 매칭하는지 검사하는 데 쓴다.
public class ExclusionRuleDetail {

	private String exclusionHsCode;
	private BigDecimal exclusionRate;

	public String getExclusionHsCode() {
		return exclusionHsCode;
	}

	public void setExclusionHsCode(String exclusionHsCode) {
		this.exclusionHsCode = exclusionHsCode;
	}

	public BigDecimal getExclusionRate() {
		return exclusionRate;
	}

	public void setExclusionRate(BigDecimal exclusionRate) {
		this.exclusionRate = exclusionRate;
	}
}
