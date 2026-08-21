package com.kpmg.kdb.web.origindeterminationexecution.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationexecution.OriginDeterminationCursorDao#selectApplicableOriginCriteriaBatch} 배치
 * 조회 1건의 입력 키(대상 HS코드/FTA_CODE/HS코드 세부유형/APTA 신규 PSR 적용여부).
 */
public class OriginCriteriaBatchRequest {

	private final String hsCode;
	private final String ftaCode;
	private final String hsCodeSubCategory;
	private final String newAptaPsrFlag;

	public OriginCriteriaBatchRequest(String hsCode, String ftaCode, String hsCodeSubCategory, String newAptaPsrFlag) {
		this.hsCode = hsCode;
		this.ftaCode = ftaCode;
		this.hsCodeSubCategory = hsCodeSubCategory;
		this.newAptaPsrFlag = newAptaPsrFlag;
	}

	public String getHsCode() {
		return hsCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public String getHsCodeSubCategory() {
		return hsCodeSubCategory;
	}

	public String getNewAptaPsrFlag() {
		return newAptaPsrFlag;
	}
}
