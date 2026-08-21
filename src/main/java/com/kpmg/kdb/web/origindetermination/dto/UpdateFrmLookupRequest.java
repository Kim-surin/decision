package com.kpmg.kdb.web.origindetermination.dto;

/**
 * {@link com.kpmg.kdb.web.origindetermination.OriginDeterminationSupportDao#selectOwnOrNonCooFcrResultBatch} 배치
 * 조회 1건의 입력 키. salesNo/companyCode 는 배치 호출 시점(determineOrigin() 1회 호출)에 이미 스코프가
 * 고정돼 있어 별도 파라미터로 넘기고 이 키에는 포함하지 않는다.
 */
public class UpdateFrmLookupRequest {

	private final int salesSeq;
	private final String ftaCode;
	private final String divisionCode;

	public UpdateFrmLookupRequest(int salesSeq, String ftaCode, String divisionCode) {
		this.salesSeq = salesSeq;
		this.ftaCode = ftaCode;
		this.divisionCode = divisionCode;
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
}
