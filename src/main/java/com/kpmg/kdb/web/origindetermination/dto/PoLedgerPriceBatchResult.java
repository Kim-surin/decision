package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * {@link com.kpmg.kdb.web.origindetermination.ItemPriceDao#selectRecentPurchasePriceBatch} 배치 조회 1건의 결과.
 * 요청받은 (divisionCode,itemCode) 조합 전체를 LEFT JOIN LATERAL 로 조회하므로, 매칭되는 PO_LEDGER
 * 행이 없는 조합도 요청 키(reqDivisionCode/reqItemCode)만 채워진 채 결과에 포함된다(그 경우 나머지
 * 필드는 전부 null — {@link com.kpmg.kdb.web.origindetermination.ItemPriceDao#selectRecentPurchasePrice} 가
 * 0건일 때 null 을 반환하던 것과 동등하게 취급한다).
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
