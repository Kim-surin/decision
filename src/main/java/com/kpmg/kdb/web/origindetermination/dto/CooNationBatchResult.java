package com.kpmg.kdb.web.origindetermination.dto;

/**
 * {@link com.kpmg.kdb.web.origindetermination.ItemNationDao#selectCooNationBatch} 배치 조회 1건의 결과.
 * 단건 {@link com.kpmg.kdb.web.origindetermination.ItemNationDao#selectCooNation} 과 동일하게 COUNT/MAX 집계라
 * GROUP BY 없이 항상 정확히 1행이 나온다 — cooNation 이 null 이어도 "조회 완료, 결과 없음"이지
 * "아직 조회 안 함"이 아니다(요청 자체가 결과에서 통째로 빠지는 경우가 없다).
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
