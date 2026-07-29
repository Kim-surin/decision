package com.kpmg.kdb.web.originbasis.dto;

/**
 * 레거시 FC10_GET_ITEM_PRICE / FC10_GET_ITEM_PRICE_NOTE 공통 파라미터 대체 객체.
 *
 * 참고: 원본 함수들은 P_FTA_CODE 파라미터를 선언만 하고 실제 조회 조건에는 사용하지 않는다.
 * 이관 시 동작을 바꾸지 않기 위해 필드는 유지하되 SQL 바인딩에는 사용하지 않는다.
 */
public class ItemPriceCriteria {

	private String companyCode;
	private String divisionCode;
	private String itemCode;
	private String ftaCode;
	/** 기준일자(YYYYMMDD). null 이면 서비스에서 오늘 날짜로 대체한다. */
	private String baseDate;

	public ItemPriceCriteria() {
	}

	public ItemPriceCriteria(String companyCode, String divisionCode, String itemCode, String ftaCode,
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
