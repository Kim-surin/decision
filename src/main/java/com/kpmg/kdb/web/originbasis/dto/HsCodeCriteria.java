package com.kpmg.kdb.web.originbasis.dto;

/**
 * 레거시 FS03_GET_HS_CODE(companyCode, divisionCode, customerCode, itemCode,
 * nationCode, ftaCode, yyyymmdd) 파라미터 대체 객체.
 */
public class HsCodeCriteria {

	private String companyCode;
	private String divisionCode;
	private String customerCode;
	private String itemCode;
	private String nationCode;
	private String ftaCode;
	/** 기준일자(YYYYMMDD). null 이면 서비스에서 오늘 날짜로 대체한다. */
	private String baseDate;

	public HsCodeCriteria() {
	}

	public HsCodeCriteria(String companyCode, String divisionCode, String customerCode, String itemCode,
			String nationCode, String ftaCode, String baseDate) {
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.customerCode = customerCode;
		this.itemCode = itemCode;
		this.nationCode = nationCode;
		this.ftaCode = ftaCode;
		this.baseDate = baseDate;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getNationCode() {
		return nationCode;
	}

	public void setNationCode(String nationCode) {
		this.nationCode = nationCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	/** 캐시 키 및 SQL 바인딩에 사용할 정규화된 기준일자(YYYYMMDD). MyBatis #{resolvedBaseDate} 바인딩용 getter */
	public String getResolvedBaseDate() {
		if (baseDate == null || baseDate.isBlank()) {
			return java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.BASIC_ISO_DATE);
		}
		return baseDate;
	}
}
