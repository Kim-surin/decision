package com.kpmg.kdb.global.config.aop.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Getter;
import lombok.Setter;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class BaseRequestDto {
	private String company_code;
	private String create_by;
	private String update_by;
	private String default_language;


	public String getCompany_code() {
		return company_code;
	}

	public void setCompany_code(String companyCode) {
		this.company_code = companyCode;
	}

	public void setCreate_by(String createBy) {
		this.create_by = createBy;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setUpdate_by(String updateBy) {
		this.update_by = updateBy;
	}

	public String getUpdate_by() {
		return update_by;
	}
	
	public void setDefault_language(String defaultLanguage) {
		this.default_language = defaultLanguage;
	}

	public String getDefault_language() {
		return default_language;
	}
}
