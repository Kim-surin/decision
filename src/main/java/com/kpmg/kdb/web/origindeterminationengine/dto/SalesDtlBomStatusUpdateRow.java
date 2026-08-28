package com.kpmg.kdb.web.origindeterminationengine.dto;

/** {@code updateSalesDtlBomStatusBatch} 배치 UPDATE 대상 1행(SALES_SEQ 단위). */
public class SalesDtlBomStatusUpdateRow {

	private int salesSeq;
	private String productCode;
	private String status;
	private String bomStatus;
	private String bomYyyymm;
	private String bomDivisionCode;

	public SalesDtlBomStatusUpdateRow(int salesSeq, String productCode, String status, String bomStatus,
			String bomYyyymm, String bomDivisionCode) {
		this.salesSeq = salesSeq;
		this.productCode = productCode;
		this.status = status;
		this.bomStatus = bomStatus;
		this.bomYyyymm = bomYyyymm;
		this.bomDivisionCode = bomDivisionCode;
	}

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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBomStatus() {
		return bomStatus;
	}

	public void setBomStatus(String bomStatus) {
		this.bomStatus = bomStatus;
	}

	public String getBomYyyymm() {
		return bomYyyymm;
	}

	public void setBomYyyymm(String bomYyyymm) {
		this.bomYyyymm = bomYyyymm;
	}

	public String getBomDivisionCode() {
		return bomDivisionCode;
	}

	public void setBomDivisionCode(String bomDivisionCode) {
		this.bomDivisionCode = bomDivisionCode;
	}
}
