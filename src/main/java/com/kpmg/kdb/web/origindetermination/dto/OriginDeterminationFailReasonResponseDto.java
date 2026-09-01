package com.kpmg.kdb.web.origindetermination.dto;

public class OriginDeterminationFailReasonResponseDto {
	private String fta_code;
	private String fta_name;
	private String error_code;
	private String error_msg;

	public String getFta_code() {
		return fta_code;
	}

	public void setFta_code(String fta_code) {
		this.fta_code = fta_code;
	}

	public String getFta_name() {
		return fta_name;
	}

	public void setFta_name(String fta_name) {
		this.fta_name = fta_name;
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
}
