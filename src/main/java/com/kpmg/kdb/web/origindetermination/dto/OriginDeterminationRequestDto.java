package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OriginDeterminationRequestDto extends BaseRequestDto {
	// 입고일자 (from)
	@JsonProperty("from_date")
	String from_date;

	// 입고일자 (to)
	@JsonProperty("to_date")
	String to_date;

	// 품번
	@JsonProperty("product")
	String product;

	// 고객사
	@JsonProperty("customer")
	String customer;
	
	// 플랜트
	@JsonProperty("division_code")
	String division_code;
}
