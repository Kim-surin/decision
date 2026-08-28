package com.kpmg.kdb.web.poledger.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

public class PoLedgerRequestDto extends BaseRequestDto {
	// 입고일자 (from)
	@JsonProperty("from_date")
	private String from_date;

	// 입고일자 (to)
	@JsonProperty("to_date")
	private String to_date;

	// 자재
	@JsonProperty("item")
	private String item;

	// 확인서 수취여부
	@JsonProperty("coo_certify_yn")
	private String coo_certify_yn;

	// 플랜트
	@JsonProperty("division_code")
	private String division_code;

	// 입고구분
	@JsonProperty("warehousing_type")
	private String warehousing_type;

	// 집중관리 협력사
	@JsonProperty("mail_send_yn")
	private String mail_send_yn;

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getCoo_certify_yn() {
		return coo_certify_yn;
	}

	public void setCoo_certify_yn(String coo_certify_yn) {
		this.coo_certify_yn = coo_certify_yn;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}

	public String getWarehousing_type() {
		return warehousing_type;
	}

	public void setWarehousing_type(String warehousing_type) {
		this.warehousing_type = warehousing_type;
	}

	public String getMail_send_yn() {
		return mail_send_yn;
	}

	public void setMail_send_yn(String mail_send_yn) {
		this.mail_send_yn = mail_send_yn;
	}
}
