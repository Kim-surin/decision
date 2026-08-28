package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class DomesticOriginDeterminationExecuteRequestDto extends BaseRequestDto {
	// 판정을 실행할 대상 라인(매출년월/고객사/플랜트/품번) 목록
	@JsonProperty("datas")
	private List<Line> datas;

	public List<Line> getDatas() {
		return datas;
	}

	public void setDatas(List<Line> datas) {
		this.datas = datas;
	}

	public static class Line {
		@JsonProperty("invoice_month")
		private String invoice_month;

		@JsonProperty("customer_code")
		private String customer_code;

		@JsonProperty("division_code")
		private String division_code;

		@JsonProperty("product_code")
		private String product_code;

		public String getInvoice_month() {
			return invoice_month;
		}

		public void setInvoice_month(String invoice_month) {
			this.invoice_month = invoice_month;
		}

		public String getCustomer_code() {
			return customer_code;
		}

		public void setCustomer_code(String customer_code) {
			this.customer_code = customer_code;
		}

		public String getDivision_code() {
			return division_code;
		}

		public void setDivision_code(String division_code) {
			this.division_code = division_code;
		}

		public String getProduct_code() {
			return product_code;
		}

		public void setProduct_code(String product_code) {
			this.product_code = product_code;
		}
	}
}
