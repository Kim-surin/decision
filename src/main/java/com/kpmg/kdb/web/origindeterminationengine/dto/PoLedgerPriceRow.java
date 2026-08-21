package com.kpmg.kdb.web.origindeterminationexecution.dto;

import java.math.BigDecimal;

/** PO_LEDGER(구매원장)에서 가장 최근 입고 단가를 조회한 결과. FC10_GET_ITEM_PRICE/ _NOTE 공용(3번째 fallback) */
public class PoLedgerPriceRow {

	private BigDecimal unitPrice;
	private String warehousingDate;
	private String divisionCode;
	private String vendorCode;

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getWarehousingDate() {
		return warehousingDate;
	}

	public void setWarehousingDate(String warehousingDate) {
		this.warehousingDate = warehousingDate;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public String buildPriceNoteText() {
		return "구매 단가 (" + warehousingDate + "," + divisionCode + "," + vendorCode + ")";
	}
}
