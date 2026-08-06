package com.kpmg.kdb.web.createfcr.dto;

/** 레거시 CREATE_FCR 3-2(내수) 단계에서 SALES 와 교차조인되는 활성 FTA_MASTER(DELETE_YN='N') 한 행 */
public class FtaMasterActive {

	private String ftaCode;
	private String intermediateYn;

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getIntermediateYn() {
		return intermediateYn;
	}

	public void setIntermediateYn(String intermediateYn) {
		this.intermediateYn = intermediateYn;
	}
}
