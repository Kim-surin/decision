package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class OriginDeterminationRequestDto extends BaseRequestDto {
	// 입고일자 (from)
	@JsonProperty("from_date")
	private String from_date;

	// 입고일자 (to)
	@JsonProperty("to_date")
	private String to_date;

	// 품번
	@JsonProperty("product")
	private String product;

	// 고객사
	@JsonProperty("customer")
	private String customer;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	// 판매구분
	@JsonProperty("export_flag")
	private String export_flag;

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

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}

	public String getExport_flag() {
		return export_flag;
	}

	public void setExport_flag(String export_flag) {
		this.export_flag = export_flag;
	}
}
