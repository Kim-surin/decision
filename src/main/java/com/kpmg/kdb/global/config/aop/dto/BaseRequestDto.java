package com.kpmg.kdb.global.config.aop.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class BaseRequestDto {
	public String company_code;
	private String create_by;
	private String update_by;
	private String division_code;

	private String default_language;
	private String userId;

	private String page;
	private String rows;

	public String getCompanyCode() {
		return company_code;
	}

	public void setCompanyCode(String companyCode) {
		this.company_code = companyCode;
	}

	public void setCreateBy(String createBy) {
		this.create_by = createBy;
	}

	public String getCreateBy() {
		return create_by;
	}

	public void setUpdateBy(String updateBy) {
		this.update_by = updateBy;
	}

	public String getUpdateBy() {
		return update_by;
	}

	public void setDivisionCode(String divisionCode) {
		this.division_code = divisionCode;
	}

	public String getDivisionCode() {
		return division_code;
	}
}
