package com.kpmg.kdb.web.origindetermination.dto;

/** {@link DivisionItemKey} 1건에 대응하는 {@link com.kpmg.kdb.web.origindetermination.ItemOriginRateDao#selectLastInputYyyyMmBatch} 결과 행. */
public class LastInputYyyyMmResult {

	private String divisionCode;
	private String itemCode;
	private String lastInputYyyyMm;

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getLastInputYyyyMm() {
		return lastInputYyyyMm;
	}

	public void setLastInputYyyyMm(String lastInputYyyyMm) {
		this.lastInputYyyyMm = lastInputYyyyMm;
	}
}
