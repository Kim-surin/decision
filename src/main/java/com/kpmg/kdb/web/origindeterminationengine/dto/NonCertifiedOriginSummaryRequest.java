package com.kpmg.kdb.web.origindeterminationengine.dto;

// selectNonCertifiedOriginSummaryBatch 배치 조회 1건의 입력 키(itemCode/ftaCode/조회구간).
// companyCode는 배치 호출 시점에 이미 스코프가 고정돼 있어 이 키엔 포함하지 않는다.
public class NonCertifiedOriginSummaryRequest {

	private final String itemCode;
	private final String ftaCode;
	private final String fromDate;
	private final String toDate;

	public NonCertifiedOriginSummaryRequest(String itemCode, String ftaCode, String fromDate, String toDate) {
		this.itemCode = itemCode;
		this.ftaCode = ftaCode;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getToDate() {
		return toDate;
	}
}
