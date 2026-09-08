package com.kpmg.kdb.web.origindeterminationengine.dto;

// UpdateFrmLookupRequest 1건에 대응하는 배치 조회 결과 행. "역내산 우선, 없으면 역외산만 존재" 2단계 조회를
// LATERAL 서브쿼리로 합쳐 1건만 반환하며, 매칭 없어도 요청 키(reqSalesSeq 등)로 결과에 포함된다(matchTier=null).
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
