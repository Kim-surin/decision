package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class ExportOriginDeterminationExecuteRequestDto extends BaseRequestDto {
	// 판정을 실행할 대상(매출번호/플랜트) 목록 - 수출은 이미 존재하는 실제 SALES_NO를 그대로
	// 판정 대상으로 삼아 내수(DomesticOriginDeterminationExecuteRequestDto)처럼
	// 매출년월/고객사/품번으로 그룹핑할 필요가 없다
	@JsonProperty("datas")
	private List<Line> datas;

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
