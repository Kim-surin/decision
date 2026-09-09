package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ExportOriginDeterminationExecuteRequestDto {
	@JsonProperty("company_code")
	private String company_code;

	// 판정을 실행할 대상(매출번호/플랜트) 목록
	@JsonProperty("datas")
	private List<Line> datas;

	public String getCompany_code() {
		return company_code;
	}

	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}

	public List<Line> getDatas() {
		return datas;
	}

	public void setDatas(List<Line> datas) {
		this.datas = datas;
	}

	public static class Line {
		@JsonProperty("sales_no")
		private String sales_no;

		@JsonProperty("division_code")
		private String division_code;

		public String getSales_no() {
			return sales_no;
		}

		public void setSales_no(String sales_no) {
			this.sales_no = sales_no;
		}

		public String getDivision_code() {
			return division_code;
		}

		public void setDivision_code(String division_code) {
			this.division_code = division_code;
		}
	}
}
