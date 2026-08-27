package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class FtaBomDetailRequestDto extends BaseRequestDto {
	// 기준년월
	@JsonProperty("yyyymm")
	private String yyyymm;

	// 제품코드
	@JsonProperty("product_code")
	private String product_code;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}
}
