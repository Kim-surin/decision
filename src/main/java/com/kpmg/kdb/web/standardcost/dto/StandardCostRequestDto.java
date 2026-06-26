package com.kpmg.kdb.web.standardcost.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StandardCostRequestDto extends BaseRequestDto {
	// 적용일자
	@JsonProperty("search_date")
	String search_date;

	// 자재
	@JsonProperty("item")
	String item;

	// 플랜트
	@JsonProperty("division_code")
	String division_code;
}
