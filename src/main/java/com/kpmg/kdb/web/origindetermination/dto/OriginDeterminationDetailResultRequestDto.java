package com.kpmg.kdb.web.origindetermination.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class OriginDeterminationDetailResultRequestDto extends BaseRequestDto {
	@JsonProperty("sales_no")
	private String sales_no;

	@JsonProperty("sales_seq")
	private Integer sales_seq;

	public String getSales_no() {
		return sales_no;
	}

	public void setSales_no(String sales_no) {
		this.sales_no = sales_no;
	}

	public Integer getSales_seq() {
		return sales_seq;
	}

	public void setSales_seq(Integer sales_seq) {
		this.sales_seq = sales_seq;
	}
}
