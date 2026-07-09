package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FtaBomDetailVendorRequestDto extends BaseRequestDto {
	// 기준년월
	@JsonProperty("yyyymm")
	String yyyymm;
	
	// 자재코드
	@JsonProperty("item_code")
	String item_code;
}
