package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemNationDao#selectCooNationBatch} 배치 조회 1건의 결과.
 * COUNT/MAX 집계라 GROUP BY 없이 항상 정확히 1행이 나온다 — cooNation 이 null 이어도 요청 자체가 결과에서
 * 빠지는 경우는 없다.
 */
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
