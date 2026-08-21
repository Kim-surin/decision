package com.kpmg.kdb.web.origindeterminationexecution.dto;

/** {@link com.kpmg.kdb.web.origindeterminationexecution.ItemOriginRateDao#selectLastInputYyyyMmBatch} 배치 조회 입력 키. */
public class DivisionItemKey {

	private final String divisionCode;
	private final String itemCode;

	public DivisionItemKey(String divisionCode, String itemCode) {
		this.divisionCode = divisionCode;
		this.itemCode = itemCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public String getItemCode() {
		return itemCode;
	}
}
