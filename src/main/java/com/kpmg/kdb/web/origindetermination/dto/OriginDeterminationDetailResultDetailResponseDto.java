package com.kpmg.kdb.web.origindetermination.dto;


public class OriginDeterminationDetailResultDetailResponseDto {
	// 판정결과(FTA_CODE)별 목록과 프론트에서 매핑할 때 쓰는 키
	private String fta_code;
	private String rule_code;
	private String company_coo_yn;

	public String getFta_code() {
		return fta_code;
	}

	public void setFta_code(String fta_code) {
		this.fta_code = fta_code;
	}

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
