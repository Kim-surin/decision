package com.kpmg.kdb.web.origindeterminationengine.dto;

// selectPendingDomesticGroups 조회 결과 1건. mergeAggregatedSalesMst의 MERGE GROUP BY 대상과
// 동일한 (companyCode,divisionCode,customerCode) 조합을 먼저 뽑아 그룹마다 파이프라인을 하나씩 실행한다.
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
