package com.kpmg.kdb.web.origindetermination.dto;

// PostgreSQL은 따옴표 없는 식별자를 소문자로 접어서 반환하므로,
// 실제 응답(HashMap) 키와 맞추기 위해 필드명을 소문자로 선언
public class OriginDeterminationDetailResultResponseDto {
	private String fta_code;
	private String hs_code;
	private String fta_name;
	private String amount;
	private String rule_contents;
	private String company_coo_yn;
	private String rvc_rate;
	private String de_minimis_rate;

	public String getFta_code() {
		return fta_code;
	}

	public void setFta_code(String fta_code) {
		this.fta_code = fta_code;
	}

	public String getHs_code() {
		return hs_code;
	}

	public void setHs_code(String hs_code) {
		this.hs_code = hs_code;
	}

	public String getFta_name() {
		return fta_name;
	}

	public void setFta_name(String fta_name) {
		this.fta_name = fta_name;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getRule_contents() {
		return rule_contents;
	}

	public void setRule_contents(String rule_contents) {
		this.rule_contents = rule_contents;
	}

	public String getCompany_coo_yn() {
		return company_coo_yn;
	}

	public void setCompany_coo_yn(String company_coo_yn) {
		this.company_coo_yn = company_coo_yn;
	}

	public String getRvc_rate() {
		return rvc_rate;
	}

	public void setRvc_rate(String rvc_rate) {
		this.rvc_rate = rvc_rate;
	}

	public String getDe_minimis_rate() {
		return de_minimis_rate;
	}

	public void setDe_minimis_rate(String de_minimis_rate) {
		this.de_minimis_rate = de_minimis_rate;
	}
}
