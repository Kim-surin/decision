package com.kpmg.kdb.web.origindetermination.dto;

/**
 * 원산지 판정 상세 팝업(내수 전용) 응답 1건. (매출년월/플랜트/고객사/품번) 그룹 기준으로 "지금 시점"에
 * 판정 대상으로 삼아야 할 SALES_NO/SALES_SEQ(가상매출이 있으면 가상매출, 없으면 원본 매출)를 다시 찾아
 * 그 라인의 판정상태와 상품상세를 함께 담는다.
 */
public class DomesticOriginDeterminationDetailResponseDto {
	private String sales_no;
	private Integer sales_seq;
	private String division_code;
	private String customer_code;
	private String invoice_month;
	private String product_code;
	private String product_name;
	private String hs_code;
	private String quantity;
	private String unit;
	private String unit_price;
	private String amount;
	private String status;
	private String status_name;

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

	public String getDivision_code() {
		return division_code;
	}

	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}

	public String getCustomer_code() {
		return customer_code;
	}

	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}

	public String getInvoice_month() {
		return invoice_month;
	}

	public void setInvoice_month(String invoice_month) {
		this.invoice_month = invoice_month;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getHs_code() {
		return hs_code;
	}

	public void setHs_code(String hs_code) {
		this.hs_code = hs_code;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getUnit_price() {
		return unit_price;
	}

	public void setUnit_price(String unit_price) {
		this.unit_price = unit_price;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
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
