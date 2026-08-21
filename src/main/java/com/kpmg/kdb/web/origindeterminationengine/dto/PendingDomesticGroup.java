package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.DomesticDecisionGroupingDao#selectPendingDomesticGroups} 조회 결과 1건.
 * mergeAggregatedSalesMst 가 MERGE 안의 GROUP BY(COMPANY_CODE, DIVISION_CODE, CUSTOMER_CODE)로 감춰서
 * 한 번에 처리하던 것을, 그 GROUP BY 대상과 동일한 (companyCode,divisionCode,customerCode) 조합을 먼저
 * 목록으로 뽑아둔 것 — 그룹마다 개별 판정과 동일하게 파이프라인 1개씩 실행할 수 있도록 한다.
 */
public class PendingDomesticGroup {

	private String companyCode;
	private String divisionCode;
	private String customerCode;

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
}
