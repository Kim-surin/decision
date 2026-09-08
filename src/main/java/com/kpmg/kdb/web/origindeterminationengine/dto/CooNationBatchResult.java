package com.kpmg.kdb.web.origindeterminationengine.dto;

// selectCooNationBatch 배치 조회 1건의 결과. COUNT/MAX 집계라 항상 정확히 1행이 나오고,
// cooNation이 null이어도 요청 자체가 결과에서 빠지지 않는다.
public class CooNationBatchResult {

	private String reqKey;
	private String cooNation;

	public String getReqKey() {
		return reqKey;
	}

	public void setReqKey(String reqKey) {
		this.reqKey = reqKey;
	}

	public String getCooNation() {
		return cooNation;
	}

	public void setCooNation(String cooNation) {
		this.cooNation = cooNation;
	}
}
