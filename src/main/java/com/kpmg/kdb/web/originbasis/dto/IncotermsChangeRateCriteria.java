package com.kpmg.kdb.web.originbasis.dto;

/**
 * 레거시 GET_INCOTERMS_CHANGE_RATE 파라미터 대체 객체.
 *
 * 참고: 원본 함수는 P_COMPNAY_CODE(회사코드) 파라미터를 선언만 하고 실제 조회 조건(WHERE 절)에는
 * 전혀 사용하지 않는다. 이관 시 동작을 바꾸지 않기 위해 회사코드 필드는 유지하되 SQL 바인딩에는
 * 사용하지 않는다(호출부 호환성 유지 목적). 실제로 회사별 구분이 필요한지는 업무팀 확인이 필요하다.
 */
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
