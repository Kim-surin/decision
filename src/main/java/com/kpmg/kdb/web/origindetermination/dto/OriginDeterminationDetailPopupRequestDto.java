package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class OriginDeterminationDetailPopupRequestDto extends BaseRequestDto {
	// 원산지 판정 상세 팝업에 표시할 대상 라인 목록. 내수/수출/결과조회 화면마다 필드 구성이 달라 Map으로 받는다
	@JsonProperty("datas")
	private List<Map<String, Object>> datas;

	@JsonProperty("mode")
	private String mode;

	public List<Map<String, Object>> getDatas() {
		return datas;
	}

	public void setDatas(List<Map<String, Object>> datas) {
		this.datas = datas;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
}
