package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ProductOriginDeterminationDao#selectMaterialOriginRowsBatch} 배치
 * 조회 1건의 입력 키. companyCode/salesNo 는 이미 스코프가 고정돼 있어 별도 파라미터로 넘긴다.
 * parentHsCode 는 조회조건이 아니라 결과 행마다 그대로 echo 되는 상수값(CTC 판정용 제품 HS코드)이다.
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
