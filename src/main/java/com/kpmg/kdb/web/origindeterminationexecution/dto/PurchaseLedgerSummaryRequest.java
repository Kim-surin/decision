package com.kpmg.kdb.web.origindeterminationexecution.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationexecution.ItemOriginRateDao#selectPurchaseLedgerSummaryBatch} 배치 조회 1건의
 * 입력 키(itemCode, 조회구간). companyCode 는 배치 호출 시점에 이미 스코프가 고정돼 있어(한 번의
 * createFcr() 호출은 항상 같은 회사) 별도 파라미터로 넘기고 이 키에는 포함하지 않는다.
 */
public class PurchaseLedgerSummaryRequest {

	private final String itemCode;
	private final String fromDate;
	private final String toDate;

	public PurchaseLedgerSummaryRequest(String itemCode, String fromDate, String toDate) {
		this.itemCode = itemCode;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getToDate() {
		return toDate;
	}
}
