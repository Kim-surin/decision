package com.kpmg.kdb.web.origindeterminationexecution.dto;

/**
 * {@link OriginRatePrecheck} 1건(BOM 자재 1건)의 사전조회 결과. FTA_CODE 와 무관하게 결정되는
 * 조회구간(fromDate~lookupEnd)과 구매원장 집계(poSummary)를 담아, FTA_CODE 별로 반복되는
 * "비인증 원산지 구매 집계"(ItemOriginRateService 4단계) 조회만 다시 하면 되게 한다.
 */
public class OriginRateStage {

	private final String itemCode;
	private final String fromDate;
	private final String lookupEnd;
	private final PurchaseLedgerSummary poSummary;

	public OriginRateStage(String itemCode, String fromDate, String lookupEnd, PurchaseLedgerSummary poSummary) {
		this.itemCode = itemCode;
		this.fromDate = fromDate;
		this.lookupEnd = lookupEnd;
		this.poSummary = poSummary;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getLookupEnd() {
		return lookupEnd;
	}

	public PurchaseLedgerSummary getPoSummary() {
		return poSummary;
	}
}
