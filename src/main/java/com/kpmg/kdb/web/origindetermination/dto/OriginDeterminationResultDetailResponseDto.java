package com.kpmg.kdb.web.origindetermination.dto;

// PostgreSQL은 따옴표 없는 식별자를 소문자로 접어서 반환하므로,
// 실제 응답(HashMap) 키와 맞추기 위해 필드명을 소문자로 선언
public class OriginDeterminationResultDetailResponseDto {
	private String rule_code;
	private String company_coo_yn;

	public String getRule_code() {
		return rule_code;
	}

	public void setRule_code(String rule_code) {
		this.rule_code = rule_code;
	}

	public String getCompany_coo_yn() {
		return company_coo_yn;
	}

	public void setCompany_coo_yn(String company_coo_yn) {
		this.company_coo_yn = company_coo_yn;
	}
}
