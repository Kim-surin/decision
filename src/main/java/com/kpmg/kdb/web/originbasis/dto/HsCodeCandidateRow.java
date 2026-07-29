package com.kpmg.kdb.web.originbasis.dto;

/**
 * ITEM_MST 및 관련 우선순위 테이블을 조인해서 얻은 HS코드 후보 원본 값.
 * 우선순위 판단(CASE WHEN)은 SQL이 아닌 {@link com.kpmg.kdb.web.originbasis.HsCodeService}에서 수행한다.
 */
public class HsCodeCandidateRow {

	/** 거래처별 모델 HS코드 (최우선) */
	private String customerHsCode;
	/** FTA 협정별 HS코드 */
	private String ftaAgmHsCode;
	/** 수입국별 HS코드 */
	private String ftaHsCode;
	/** 품목 HS코드 변경이력 */
	private String historyHsCode;
	/** 품목마스터 기본 HS코드 (최후 순위) */
	private String itemHsCode;

	public String getCustomerHsCode() {
		return customerHsCode;
	}

	public void setCustomerHsCode(String customerHsCode) {
		this.customerHsCode = customerHsCode;
	}

	public String getFtaAgmHsCode() {
		return ftaAgmHsCode;
	}

	public void setFtaAgmHsCode(String ftaAgmHsCode) {
		this.ftaAgmHsCode = ftaAgmHsCode;
	}

	public String getFtaHsCode() {
		return ftaHsCode;
	}

	public void setFtaHsCode(String ftaHsCode) {
		this.ftaHsCode = ftaHsCode;
	}

	public String getHistoryHsCode() {
		return historyHsCode;
	}

	public void setHistoryHsCode(String historyHsCode) {
		this.historyHsCode = historyHsCode;
	}

	public String getItemHsCode() {
		return itemHsCode;
	}

	public void setItemHsCode(String itemHsCode) {
		this.itemHsCode = itemHsCode;
	}

	/** CASE WHEN CM.CUSTOMER_HS_CODE IS NOT NULL THEN ... 우선순위를 그대로 이관 */
	public String resolvePriorityHsCode() {
		if (customerHsCode != null && !customerHsCode.isBlank()) {
			return customerHsCode;
		}
		if (ftaAgmHsCode != null && !ftaAgmHsCode.isBlank()) {
			return ftaAgmHsCode;
		}
		if (ftaHsCode != null && !ftaHsCode.isBlank()) {
			return ftaHsCode;
		}
		if (historyHsCode != null && !historyHsCode.isBlank()) {
			return historyHsCode;
		}
		return itemHsCode;
	}
}
