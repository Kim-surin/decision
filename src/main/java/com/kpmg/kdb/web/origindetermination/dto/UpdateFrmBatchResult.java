package com.kpmg.kdb.web.origindetermination.dto;

/**
 * {@link UpdateFrmLookupRequest} 1건에 대응하는 배치 조회 결과 행. UPDATE_FRM_PROCEDURE 의 "역내산
 * (COMPANY_COO_YN='Y') 우선, 없으면 역외산만 존재(COMPANY_COO_YN='N',STATUS='N')" 2단계 조회를 LATERAL
 * 서브쿼리 안에서 우선순위(ORDER BY)로 합쳐 1건만 반환한다 —
 * {@link com.kpmg.kdb.web.origindetermination.OriginDeterminationSupportDao#selectOwnOrNonCooFcrResultBatch} 참고.
 *
 * <p>매칭되는 FCR_RESULT 행이 전혀 없는 요청도 결과에 포함되며(LEFT JOIN LATERAL), 그 경우
 * {@link OriginDeterminationResult} 쪽 필드는 전부 null 이고 matchTier 도 null 이다 — 원본의 "E"(둘 다
 * 없음) 분기에 대응한다. reqSalesSeq/reqFtaCode/reqDivisionCode 는 그 경우에도 항상 채워지므로 호출자가
 * 요청 키로 결과를 되찾을 수 있다.
 */
public class UpdateFrmBatchResult extends OriginDeterminationResult {

	private int reqSalesSeq;
	private String reqFtaCode;
	private String reqDivisionCode;
	/** 'Y' = 역내산(COMPANY_COO_YN='Y') 매칭, 'N' = 역외산만 존재 매칭, null = 매칭 없음 */
	private String matchTier;

	public int getReqSalesSeq() {
		return reqSalesSeq;
	}

	public void setReqSalesSeq(int reqSalesSeq) {
		this.reqSalesSeq = reqSalesSeq;
	}

	public String getReqFtaCode() {
		return reqFtaCode;
	}

	public void setReqFtaCode(String reqFtaCode) {
		this.reqFtaCode = reqFtaCode;
	}

	public String getReqDivisionCode() {
		return reqDivisionCode;
	}

	public void setReqDivisionCode(String reqDivisionCode) {
		this.reqDivisionCode = reqDivisionCode;
	}

	public String getMatchTier() {
		return matchTier;
	}

	public void setMatchTier(String matchTier) {
		this.matchTier = matchTier;
	}
}
