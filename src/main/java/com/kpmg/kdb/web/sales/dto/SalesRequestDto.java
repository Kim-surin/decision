package com.kpmg.kdb.web.sales.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SalesRequestDto extends BaseRequestDto {
	// 매출일자 (from)
	@JsonProperty("from_date")
	String from_date;

	// 매출일자 (to)
	@JsonProperty("to_date")
	String to_date;

	// 자재
	@JsonProperty("product")
	String product;

	// 고객사
	@JsonProperty("customer_code")
	String customer_code;

	// 플랜트
	@JsonProperty("division_code")
	String division_code;

	// 내수/수출 구분
	@JsonProperty("export_flag")
	String export_flag;
}
