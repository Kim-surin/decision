package com.kpmg.kdb.web.monthlydecision.dto;

/** 레거시 MONTHLY_DECISION_PROC 의 COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회 결과 */
public class CompanyDecisionFlags {

	private String materialUseYn;
	private String ctcDecisionOnlyYn;

	public String getMaterialUseYn() {
		return materialUseYn;
	}

	public void setMaterialUseYn(String materialUseYn) {
		this.materialUseYn = materialUseYn;
	}

	public String getCtcDecisionOnlyYn() {
		return ctcDecisionOnlyYn;
	}

	public void setCtcDecisionOnlyYn(String ctcDecisionOnlyYn) {
		this.ctcDecisionOnlyYn = ctcDecisionOnlyYn;
	}
}
