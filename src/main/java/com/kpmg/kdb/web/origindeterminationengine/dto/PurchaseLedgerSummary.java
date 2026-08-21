package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/** PO_LEDGER 집계 결과(건수, 입고금액 합계). FC10_GET_ITEM_ORIGIN_RATE 에서 공용으로 사용 */
public class PurchaseLedgerSummary {

	private long poCount;
	private BigDecimal warehousingAmountSum = BigDecimal.ZERO;

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
}
