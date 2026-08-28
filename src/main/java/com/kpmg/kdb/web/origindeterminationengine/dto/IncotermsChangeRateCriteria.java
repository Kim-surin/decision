package com.kpmg.kdb.web.origindeterminationengine.dto;

/** 레거시 GET_INCOTERMS_CHANGE_RATE 파라미터 대체 객체. */
public class IncotermsChangeRateCriteria {

	private String stdYyyy;
	private String companyCode;
	private String divisionCode;
	private String exportFlag;
	private String nationCode;
	private String fromIncotermsCode;
	private String toIncotermsCode;

	public IncotermsChangeRateCriteria() {
	}

	public IncotermsChangeRateCriteria(String stdYyyy, String companyCode, String divisionCode, String exportFlag,
			String nationCode, String fromIncotermsCode, String toIncotermsCode) {
		this.stdYyyy = stdYyyy;
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.exportFlag = exportFlag;
		this.nationCode = nationCode;
		this.fromIncotermsCode = fromIncotermsCode;
		this.toIncotermsCode = toIncotermsCode;
	}

	public String getStdYyyy() {
		return stdYyyy;
	}

	public void setStdYyyy(String stdYyyy) {
		this.stdYyyy = stdYyyy;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getNationCode() {
		return nationCode;
	}

	public void setNationCode(String nationCode) {
		this.nationCode = nationCode;
	}

	public String getFromIncotermsCode() {
		return fromIncotermsCode;
	}

	public void setFromIncotermsCode(String fromIncotermsCode) {
		this.fromIncotermsCode = fromIncotermsCode;
	}

	public String getToIncotermsCode() {
		return toIncotermsCode;
	}

	public void setToIncotermsCode(String toIncotermsCode) {
		this.toIncotermsCode = toIncotermsCode;
	}
}
