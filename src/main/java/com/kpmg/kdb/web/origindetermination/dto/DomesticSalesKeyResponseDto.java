package com.kpmg.kdb.web.origindetermination.dto;

/**
 * (매출년월/플랜트/고객사/품번) 그룹 기준으로 "지금 시점"에 판정 대상으로 삼아야 할 SALES_NO/SALES_SEQ와
 * 그 그룹의 판정상태를 다시 조회한 결과 1건. 가상매출이 있으면 가상매출을, 없으면 원본 매출을 가리킨다.
 */
public class DomesticSalesKeyResponseDto {
	private String product_code;
	private String customer_code;
	private String division_code;
	private String invoice_month;
	private String sales_no;
	private Integer sales_seq;
	private String status;
	private String status_name;

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getCustomer_code() {
		return customer_code;
	}

	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}

	public String getInvoice_month() {
		return invoice_month;
	}

	public void setInvoice_month(String invoice_month) {
		this.invoice_month = invoice_month;
	}

	public String getSales_no() {
		return sales_no;
	}

	public void setSales_no(String sales_no) {
		this.sales_no = sales_no;
	}

	public Integer getSales_seq() {
		return sales_seq;
	}

	public void setSales_seq(Integer sales_seq) {
		this.sales_seq = sales_seq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatus_name() {
		return status_name;
	}

	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
}
