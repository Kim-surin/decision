package com.kpmg.kdb.web.standardcost.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class StandardCostRequestDto extends BaseRequestDto {
	// 적용일자
	@JsonProperty("search_date")
	private String search_date;

	// 자재
	@JsonProperty("item")
	private String item;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	public String getSearch_date() {
		return search_date;
	}

	public void setSearch_date(String search_date) {
		this.search_date = search_date;
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
