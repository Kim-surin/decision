package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class DomesticOriginDeterminationExecuteRequestDto {
	@JsonProperty("company_code")
	private String company_code;

	// GenericController#extendsMap이 세션에서 채워준 사용자 ID. FCR_MST/FCR_DTL/FCR_RESULT/SALES_MST 등의
	// CREATE_BY/UPDATE_BY에 그대로 쓰인다.
	@JsonProperty("create_by")
	private String create_by;

	// 판정을 실행할 대상 라인(매출년월/고객사/플랜트/품번) 목록
	@JsonProperty("datas")
	private List<Line> datas;

	public String getCompany_code() {
		return company_code;
	}

	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

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
