package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationCursorDao#selectMaterialOriginRowsBatch} 배치
 * 조회 1건의 입력 키. companyCode/salesNo 는 배치 호출 시점(determineOrigin() 1회 호출)에 이미 스코프가
 * 고정돼 있어 별도 파라미터로 넘기고 이 키에는 포함하지 않는다.
 *
 * <p>parentHsCode 는 조회조건(FCR_DTL WHERE 절)에는 쓰이지 않는다 — 원본처럼 단순히 결과 행마다
 * 그대로 echo 되는 상수값(그 FM_LIST 행의 제품 HS코드, CTC 판정에서 자재 HS코드와의 접두어 비교 기준)
 * 이라 요청 키가 아니라 결과 조립 시 그대로 붙여 넣는다.
 */
public class MaterialOriginRowsRequest {

	private final String ftaCode;
	private final String divisionCode;
	private final int salesSeq;
	private final String parentHsCode;

	public MaterialOriginRowsRequest(String ftaCode, String divisionCode, int salesSeq, String parentHsCode) {
		this.ftaCode = ftaCode;
		this.divisionCode = divisionCode;
		this.salesSeq = salesSeq;
		this.parentHsCode = parentHsCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public int getSalesSeq() {
		return salesSeq;
	}

	public String getParentHsCode() {
		return parentHsCode;
	}
}
