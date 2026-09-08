package com.kpmg.kdb.web.materialinv.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class MaterialInvRequestDto extends BaseRequestDto {
	// 기준년월 (from)
	@JsonProperty("from_yyyymm")
	private String from_yyyymm;

	// 기준년월 (to)
	@JsonProperty("to_yyyymm")
	private String to_yyyymm;

	// 자재
	@JsonProperty("item")
	private String item;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	public String getFrom_yyyymm() {
		return from_yyyymm;
	}

	public void setFrom_yyyymm(String from_yyyymm) {
		this.from_yyyymm = from_yyyymm;
	}

	public String getTo_yyyymm() {
		return to_yyyymm;
	}

	public void setTo_yyyymm(String to_yyyymm) {
		this.to_yyyymm = to_yyyymm;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}
}
