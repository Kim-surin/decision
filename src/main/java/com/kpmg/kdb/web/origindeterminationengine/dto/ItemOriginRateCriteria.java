package com.kpmg.kdb.web.origindeterminationexecution.dto;

/** 레거시 FC10_GET_ITEM_ORIGIN_RATE 파라미터 대체 객체 */
public class ItemOriginRateCriteria {

	private String companyCode;
	private String divisionCode;
	private String itemCode;
	private String ftaCode;
	/** 기준일자(YYYYMMDD). null 이면 서비스에서 오늘 날짜로 대체한다. */
	private String baseDate;

	public ItemOriginRateCriteria() {
	}

	public ItemOriginRateCriteria(String companyCode, String divisionCode, String itemCode, String ftaCode,
			String baseDate) {
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.itemCode = itemCode;
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

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
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

	public String getResolvedBaseDate() {
		if (baseDate == null || baseDate.isBlank()) {
			return java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.BASIC_ISO_DATE);
		}
		return baseDate;
	}
}
