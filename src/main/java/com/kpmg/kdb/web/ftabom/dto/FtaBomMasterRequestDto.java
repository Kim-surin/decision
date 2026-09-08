package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class FtaBomMasterRequestDto extends BaseRequestDto {
	// 기준년월 (from)
	@JsonProperty("from_yyyymm")
	private String from_yyyymm;

	// 기준년월 (to)
	@JsonProperty("to_yyyymm")
	private String to_yyyymm;

	// 제품
	@JsonProperty("product")
	private String product;

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

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}
}
