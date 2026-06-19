package com.kpmg.kdb.web.materialinv.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MaterialInvRequestDto extends BaseRequestDto {
	// 기준년월 (from)
	@JsonProperty("from_date")
	String from_date;

	// 기준년월 (to)
	@JsonProperty("to_date")
	String to_date;

	// 자재
	@JsonProperty("item")
	String item;

	// 플랜트
	@JsonProperty("division_code")
	String division_code;
}
