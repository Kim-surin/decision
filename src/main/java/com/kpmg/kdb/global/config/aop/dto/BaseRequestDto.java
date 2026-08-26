package com.kpmg.kdb.global.config.aop.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class BaseRequestDto {
	private String company_code;
	private String create_by;
	private String update_by;
	//private String division_code;
	private String default_language;

	// snake_case 접근자: MyBatis(#{company_code} 등)와 JSON 요청 바디(company_code 등) 바인딩에 사용
	public String getCompany_code() {
		return company_code;
	}

	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	public String getUpdate_by() {
		return update_by;
	}

	public void setUpdate_by(String update_by) {
		this.update_by = update_by;
	}

	public String getDefault_language() {
		return default_language;
	}

	public void setDefault_language(String default_language) {
		this.default_language = default_language;
	}

	// camelCase 접근자는 자바 코드(SessionInjectionAspect 등)에서만 사용.
	// snake_case 접근자와 JSON 프로퍼티명이 겹쳐 Jackson이 "Conflicting getter definitions"
	// 오류를 내므로 역/직렬화 대상에서는 제외.
	@JsonIgnore
	public String getCompanyCode() {
		return company_code;
	}

	@JsonIgnore
	public void setCompanyCode(String companyCode) {
		this.company_code = companyCode;
	}

	@JsonIgnore
	public void setCreateBy(String createBy) {
		this.create_by = createBy;
	}

	@JsonIgnore
	public String getCreateBy() {
		return create_by;
	}

	@JsonIgnore
	public void setUpdateBy(String updateBy) {
		this.update_by = updateBy;
	}

	@JsonIgnore
	public String getUpdateBy() {
		return update_by;
	}

	/*
	 * public void setDivisionCode(String divisionCode) { this.division_code =
	 * divisionCode; }
	 *
	 * public String getDivisionCode() { return division_code; }
	 */

	@JsonIgnore
	public void setDefaultLanguage(String defaultLanguage) {
		this.default_language = defaultLanguage;
	}

	@JsonIgnore
	public String getDefaultLanguage() {
		return default_language;
	}
}
