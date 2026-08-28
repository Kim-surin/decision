package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/** {@link PurchaseLedgerSummaryRequest} 1건에 대응하는 배치 조회 결과 행(입력 키 + 집계값). */
public class PurchaseLedgerSummaryBatchResult {

	private String itemCode;
	private String fromDate;
	private String toDate;
	private long poCount;
	private BigDecimal warehousingAmountSum = BigDecimal.ZERO;

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public long getPoCount() {
		return poCount;
	}

	public void setPoCount(long poCount) {
		this.poCount = poCount;
	}

	public BigDecimal getWarehousingAmountSum() {
		return warehousingAmountSum;
	}

	public void setWarehousingAmountSum(BigDecimal warehousingAmountSum) {
		this.warehousingAmountSum = warehousingAmountSum == null ? BigDecimal.ZERO : warehousingAmountSum;
	}

	public PurchaseLedgerSummary toSummary() {
		PurchaseLedgerSummary summary = new PurchaseLedgerSummary();
		summary.setPoCount(poCount);
		summary.setWarehousingAmountSum(warehousingAmountSum);
		return summary;
	}
}
