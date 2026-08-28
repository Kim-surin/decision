package com.kpmg.kdb.web.origindeterminationengine.dto;

/** {@link BomAvailabilityBatchResult} 조회 요청 1건 — (사업장, 제품) 조합. */
public class BomAvailabilityRequest {

	private String prodDivisionCode;
	private String productCode;

	public BomAvailabilityRequest(String prodDivisionCode, String productCode) {
		this.prodDivisionCode = prodDivisionCode;
		this.productCode = productCode;
	}

	public String getProdDivisionCode() {
		return prodDivisionCode;
	}

	public void setProdDivisionCode(String prodDivisionCode) {
		this.prodDivisionCode = prodDivisionCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
}
