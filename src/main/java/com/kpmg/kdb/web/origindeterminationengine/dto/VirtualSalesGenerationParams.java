package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.util.List;

/**
 * 레거시 MONTHLY_DECISION_PROC 의 파라미터 목록(P_YYYYMMDD, P_COMPANY_CODE, ...) 대체 객체.
 * 가상매출 생성(OriginDecisionPipeline#generateVirtualSales) 호출 시 넘기는 조건으로, yyyymmdd(매출년월)
 * 범위 전체 실매출을 집계해 가상매출을 만든다(AggregatedVirtualSalesGenerator 참고).
 */
public class VirtualSalesGenerationParams {

	/** YYYYMM 또는 YYYYMMDD 모두 가능(INVOICE_DATE LIKE 접두어 매칭 기준) */
	private String yyyymmdd;
	private String companyCode;
	private String divisionCode;
	private String customerCode;
	private String deliveryCustomerCode;
	/** null/빈 리스트면 제품 필터 없음, 값이 있으면 그 제품들만 대상으로 한다. */
	private List<String> productCodes;
	private String exportFlag;

	public String getYyyymmdd() {
		return yyyymmdd;
	}

	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
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

	public String getDeliveryCustomerCode() {
		return deliveryCustomerCode;
	}

	public void setDeliveryCustomerCode(String deliveryCustomerCode) {
		this.deliveryCustomerCode = deliveryCustomerCode;
	}

	public List<String> getProductCodes() {
		return productCodes;
	}

	public void setProductCodes(List<String> productCodes) {
		this.productCodes = productCodes;
	}

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	/** V_YYYYMM = SUBSTR(P_YYYYMMDD, 1, 6) */
	public String getYyyymm() {
		return yyyymmdd == null || yyyymmdd.length() < 6 ? yyyymmdd : yyyymmdd.substring(0, 6);
	}
}
