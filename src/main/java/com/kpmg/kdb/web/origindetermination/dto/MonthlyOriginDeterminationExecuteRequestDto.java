package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MonthlyOriginDeterminationExecuteRequestDto extends BaseRequestDto {
	// 매출일자 (from, YYYYMMDD)
	@JsonProperty("from_date")
	String from_date;

	// 매출일자 (to, YYYYMMDD)
	@JsonProperty("to_date")
	String to_date;
}
