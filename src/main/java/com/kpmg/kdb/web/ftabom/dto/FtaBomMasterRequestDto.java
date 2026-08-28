package com.kpmg.kdb.web.ftabom.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class FtaBomMasterRequestDto extends BaseRequestDto {
	// 기준년월 (from)
	@JsonProperty("from_date")
	private String from_date;

	// 기준년월 (to)
	@JsonProperty("to_date")
	private String to_date;

	// 제품
	@JsonProperty("product")
	private String product;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
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
