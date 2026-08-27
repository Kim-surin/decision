package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * "해당 사업장 BOM 존재 확인"(own)과 "타 플랜트 BOM 체크"(any)를 (사업장,제품) 조합별로 한 번에 배치
 * 조회한 결과 1건. own/any 어느 쪽도 없으면 두 필드 모두 null(BOM 없음 확정).
 */
public class BomAvailabilityBatchResult {

	private String reqProdDivisionCode;
	private String reqProductCode;
	private String ownDivisionCode;
	private String ownYyyymm;
	private String anyDivisionCode;
	private String anyYyyymm;

	public String getReqProdDivisionCode() {
		return reqProdDivisionCode;
	}

	public void setReqProdDivisionCode(String reqProdDivisionCode) {
		this.reqProdDivisionCode = reqProdDivisionCode;
	}

	public String getReqProductCode() {
		return reqProductCode;
	}

	public void setReqProductCode(String reqProductCode) {
		this.reqProductCode = reqProductCode;
	}

	public String getOwnDivisionCode() {
		return ownDivisionCode;
	}

	public void setOwnDivisionCode(String ownDivisionCode) {
		this.ownDivisionCode = ownDivisionCode;
	}

	public String getOwnYyyymm() {
		return ownYyyymm;
	}

	public void setOwnYyyymm(String ownYyyymm) {
		this.ownYyyymm = ownYyyymm;
	}

	public String getAnyDivisionCode() {
		return anyDivisionCode;
	}

	public void setAnyDivisionCode(String anyDivisionCode) {
		this.anyDivisionCode = anyDivisionCode;
	}

	public String getAnyYyyymm() {
		return anyYyyymm;
	}

	public void setAnyYyyymm(String anyYyyymm) {
		this.anyYyyymm = anyYyyymm;
	}
}
