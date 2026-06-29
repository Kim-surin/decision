package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FtaBomDetailRequestDto extends BaseRequestDto {
	// 기준년월
	@JsonProperty("yyyymm")
	String yyyymm;
	
	// 제품코드
	@JsonProperty("product_code")
	String product_code;

	// 플랜트
	@JsonProperty("division_code")
	String division_code;
}
