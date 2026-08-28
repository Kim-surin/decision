package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class OriginDeterminationDetailRequestDto extends BaseRequestDto {
	// 좌측에서 체크되어 넘어온 판정 대상 라인(SALES_NO, SALES_SEQ) 목록
	@JsonProperty("datas")
	private List<SalesKey> datas;

	public List<SalesKey> getDatas() {
		return datas;
	}

	public void setDatas(List<SalesKey> datas) {
		this.datas = datas;
	}

	public static class SalesKey {
		@JsonProperty("sales_no")
		private String sales_no;

		@JsonProperty("sales_seq")
		private Integer sales_seq;

		@JsonProperty("division_code")
		private String division_code;

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

		public String getDivision_code() {
			return division_code;
		}

		public void setDivision_code(String division_code) {
			this.division_code = division_code;
		}
	}
}
