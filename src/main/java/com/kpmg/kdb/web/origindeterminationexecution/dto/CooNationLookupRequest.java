package com.kpmg.kdb.web.origindeterminationexecution.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationexecution.ItemNationDao#selectCooNationBatch} 배치 조회 1건의 입력 키.
 * fromDate/toDate 는 {@link com.kpmg.kdb.web.origindeterminationexecution.ItemNationService} 가 자재별 수불부 데이터를
 * 기준으로 순수 Java 로 미리 계산해둔 조회구간이다(요청마다 다를 수 있어 SQL 이 아닌 호출측에서 계산).
 * reqKey 는 호출측 캐시 키를 그대로 왕복시키기 위한 불투명(opaque) 값이다.
 */
public class CooNationLookupRequest {

	private final String reqKey;
	private final String companyCode;
	private final String itemCode;
	private final String hsCode;
	private final String fromDate;
	private final String toDate;

	public CooNationLookupRequest(String reqKey, String companyCode, String itemCode, String hsCode, String fromDate,
			String toDate) {
		this.reqKey = reqKey;
		this.companyCode = companyCode;
		this.itemCode = itemCode;
		this.hsCode = hsCode;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

	public String getReqKey() {
		return reqKey;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getHsCode() {
		return hsCode;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getToDate() {
		return toDate;
	}
}
