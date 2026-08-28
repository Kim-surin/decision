package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class FtaBomDetailVendorRequestDto extends BaseRequestDto {
	// 기준년월
	@JsonProperty("yyyymm")
	private String yyyymm;

	// 자재코드
	@JsonProperty("item_code")
	private String item_code;

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}

	public String getItem_code() {
		return item_code;
	}

	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
}
