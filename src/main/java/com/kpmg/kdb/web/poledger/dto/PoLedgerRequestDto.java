package com.kpmg.kdb.web.poledger.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PoLedgerRequestDto extends BaseRequestDto {
	// 입고일자 (from)
	@JsonProperty("from_date")
	String from_date;

	// 입고일자 (to)
	@JsonProperty("to_date")
	String to_date;

	// 자재
	@JsonProperty("item")
	String item;

	// 확인서 수취여부
	@JsonProperty("coo_certify_yn")
	String coo_certify_yn;

	// 플랜트
	@JsonProperty("division_code")
	String division_code;

	// 입고구분
	@JsonProperty("warehousing_type")
	String warehousing_type;
}
