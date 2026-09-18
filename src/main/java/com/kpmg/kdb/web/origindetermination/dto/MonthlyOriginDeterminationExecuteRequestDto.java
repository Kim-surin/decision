package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MonthlyOriginDeterminationExecuteRequestDto {
	@JsonProperty("company_code")
	private String company_code;

	// GenericController#extendsMap이 세션에서 채워준 사용자 ID. FCR_MST/FCR_DTL/FCR_RESULT/SALES_MST 등의
	// CREATE_BY/UPDATE_BY에 그대로 쓰인다.
	@JsonProperty("create_by")
	private String create_by;

	// 매출일자 (from, YYYYMMDD)
	@JsonProperty("from_date")
	private String from_date;

	// 매출일자 (to, YYYYMMDD)
	@JsonProperty("to_date")
	private String to_date;

	public String getCompany_code() {
		return company_code;
	}

	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
}
