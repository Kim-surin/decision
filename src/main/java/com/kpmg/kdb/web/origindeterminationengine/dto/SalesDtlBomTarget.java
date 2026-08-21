package com.kpmg.kdb.web.origindeterminationengine.dto;

/** 레거시 CURSOR C_SALES_DTL(CREATE_FCR "2. 실적 BOM 및 표준 BOM 확인") 한 행 */
public class SalesDtlBomTarget {

	private int salesSeq;
	private String productCode;
	private String prodDivisionCode;
	private String status;

	public int getSalesSeq() {
		return salesSeq;
	}

	public void setSalesSeq(int salesSeq) {
		this.salesSeq = salesSeq;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getProdDivisionCode() {
		return prodDivisionCode;
	}

	public void setProdDivisionCode(String prodDivisionCode) {
		this.prodDivisionCode = prodDivisionCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
