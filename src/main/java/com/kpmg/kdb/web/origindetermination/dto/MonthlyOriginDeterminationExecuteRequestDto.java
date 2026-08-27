package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class MonthlyOriginDeterminationExecuteRequestDto extends BaseRequestDto {
	// 매출일자 (from, YYYYMMDD)
	@JsonProperty("from_date")
	private String from_date;

	// 매출일자 (to, YYYYMMDD)
	@JsonProperty("to_date")
	private String to_date;

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
