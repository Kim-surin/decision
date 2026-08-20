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

		// SALES_DTL.SALES_SEQ가 NUMERIC 컬럼이라 String으로 바인딩하면
		// "operator does not exist: numeric = character varying" 오류가 남
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
}
