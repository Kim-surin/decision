package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemPriceDao#selectRecentPurchasePriceBatch} 배치 조회 1건의
 * 결과. 매칭되는 PO_LEDGER 행이 없는 조합도 요청 키만 채워진 채 결과에 포함된다(나머지 필드는 null).
 */
public class PoLedgerPriceBatchResult {

	private String reqDivisionCode;
	private String reqItemCode;
	private BigDecimal unitPrice;
	private String warehousingDate;
	private String divisionCode;
	private String vendorCode;

	public String getReqDivisionCode() {
		return reqDivisionCode;
	}

	public void setReqDivisionCode(String reqDivisionCode) {
		this.reqDivisionCode = reqDivisionCode;
	}

	public String getReqItemCode() {
		return reqItemCode;
	}

	public void setReqItemCode(String reqItemCode) {
		this.reqItemCode = reqItemCode;
	}

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

	/** 매칭되는 PO_LEDGER 행이 없었으면(unitPrice 등 전부 null) null 을 돌려준다. */
	public PoLedgerPriceRow toRowOrNull() {
		if (unitPrice == null) {
			return null;
		}
		PoLedgerPriceRow row = new PoLedgerPriceRow();
		row.setUnitPrice(unitPrice);
		row.setWarehousingDate(warehousingDate);
		row.setDivisionCode(divisionCode);
		row.setVendorCode(vendorCode);
		return row;
	}
}
