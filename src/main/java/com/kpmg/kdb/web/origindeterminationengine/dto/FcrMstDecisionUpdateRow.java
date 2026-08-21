package com.kpmg.kdb.web.origindeterminationexecution.dto;

/**
 * UPDATE_FRM_PROCEDURE 말미의 FCR_MST 갱신 1건. FM_LIST 행(=FTA 후보)마다 즉시 UPDATE 하는 대신
 * determineOrigin() 1회 호출 범위에서 모았다가 한 번의 배치 UPDATE 로 반영한다
 * (OriginDeterminationSupportService#updateFrm/#flushFcrMstUpdates 참고).
 */
public class FcrMstDecisionUpdateRow {

	private final String salesNo;
	private final int salesSeq;
	private final String ftaCode;
	private final String divisionCode;
	private final String companyCode;
	private final String ruleContents;
	private final String ftaCooYn;
	private final String companyCooYn;
	private final String rcepCooNation;

	public FcrMstDecisionUpdateRow(String salesNo, int salesSeq, String ftaCode, String divisionCode,
			String companyCode, String ruleContents, String ftaCooYn, String companyCooYn, String rcepCooNation) {
		this.salesNo = salesNo;
		this.salesSeq = salesSeq;
		this.ftaCode = ftaCode;
		this.divisionCode = divisionCode;
		this.companyCode = companyCode;
		this.ruleContents = ruleContents;
		this.ftaCooYn = ftaCooYn;
		this.companyCooYn = companyCooYn;
		this.rcepCooNation = rcepCooNation;
	}

	public String getSalesNo() {
		return salesNo;
	}

	public int getSalesSeq() {
		return salesSeq;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public String getRuleContents() {
		return ruleContents;
	}

	public String getFtaCooYn() {
		return ftaCooYn;
	}

	public String getCompanyCooYn() {
		return companyCooYn;
	}

	public String getRcepCooNation() {
		return rcepCooNation;
	}
}
