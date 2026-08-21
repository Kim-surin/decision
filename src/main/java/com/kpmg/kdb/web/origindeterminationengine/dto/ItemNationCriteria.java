package com.kpmg.kdb.web.origindeterminationexecution.dto;

/** 레거시 FC01_GET_ITEM_NATION 파라미터 대체 객체 */
public class ItemNationCriteria {

	private String companyCode;
	private String divisionCode;
	private String itemCode;
	/**
	 * 원본 P_FTA_CODE: 함수 본문에서는 사용되지 않고 EXT_COO_CERTIFY_DTL.FTA_CODE 조건이 'PKRRC' 로
	 * 하드코딩되어 있다(호출부가 항상 FTA_CODE='PKRRC' 인 경우에만 이 함수를 호출하므로 실제로는
	 * 문제되지 않는다). 호출부 호환성 유지를 위해 필드는 유지하되 SQL 바인딩에는 사용하지 않는다.
	 */
	private String ftaCode;
	private String hsCode;
	/** 기준일자(YYYYMMDD). null 이면 서비스에서 오늘 날짜로 대체한다. */
	private String baseDate;

	public ItemNationCriteria() {
	}

	public ItemNationCriteria(String companyCode, String divisionCode, String itemCode, String ftaCode,
			String hsCode, String baseDate) {
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.itemCode = itemCode;
		this.ftaCode = ftaCode;
		this.hsCode = hsCode;
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

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
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
