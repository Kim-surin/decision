package com.kpmg.kdb.web.origindetermination.dto;

import java.util.List;

import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OriginDeterminationDetailRequestDto extends BaseRequestDto {
	// 좌측에서 체크되어 넘어온 판정 대상 라인(SALES_NO, SALES_SEQ) 목록
	List<SalesKey> datas;

	@Getter
	@Setter
	public static class SalesKey {
		String sales_no;
		String sales_seq;
	}
}
