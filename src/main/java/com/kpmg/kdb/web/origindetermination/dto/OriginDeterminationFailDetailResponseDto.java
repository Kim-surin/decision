package com.kpmg.kdb.web.origindetermination.dto;

public class OriginDeterminationFailDetailResponseDto {
	// 실패 사유(FTA_CODE) 목록과 프론트에서 매핑할 때 쓰는 키
	private String fta_code;
	private Integer rule_seq;
	private String rule_code;
	private String status;
	private String error_code;
	private String error_msg;
	private String rule_description;

	public String getFta_code() {
		return fta_code;
	}

	public void setFta_code(String fta_code) {
		this.fta_code = fta_code;
	}

	public Integer getRule_seq() {
		return rule_seq;
	}

	public void setRule_seq(Integer rule_seq) {
		this.rule_seq = rule_seq;
	}

	public String getRule_code() {
		return rule_code;
	}

	public void setRule_code(String rule_code) {
		this.rule_code = rule_code;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getError_code() {
		return error_code;
	}

	public void setError_code(String error_code) {
		this.error_code = error_code;
	}

	public String getError_msg() {
		return error_msg;
	}

	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}

	public String getRule_description() {
		return rule_description;
	}

	public void setRule_description(String rule_description) {
		this.rule_description = rule_description;
	}
}
