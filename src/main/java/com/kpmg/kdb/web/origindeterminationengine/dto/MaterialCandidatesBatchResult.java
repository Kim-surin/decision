package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/**
 * {@link MaterialCandidatesRequest} 1건(품목 1건)에 대응하는 배치 조회 결과 행. 원본 C_MAT 커서처럼
 * 요청 1건당 0~N 행(BOM 자재 0/1건 + 대체(FUNGIBLE) 자재 0..N건)이 나올 수 있어, 요청에 매칭되는 자재가
 * 하나도 없으면 그 요청은 결과에 아예 나타나지 않는다(단건 조회가 빈 리스트를 반환하던 것과 동일 —
 * 호출자가 Map 조회 결과 없으면 빈 리스트로 처리).
 */
public class MaterialCandidatesBatchResult {

	private String reqDivisionCode;
	private String reqItemCode;
	private String reqBaseDate;
	private String itemCode;
	private String matYyyyMm;
	private BigDecimal matInitialQty;
	private BigDecimal matInputQty;
	private Integer matAgingPeriod;
	private String matItemType;

	public String getReqDivisionCode() {
		return reqDivisionCode;
	}

	public void setReqDivisionCode(String reqDivisionCode) {
		this.reqDivisionCode = reqDivisionCode;
	}

	public String getReqItemCode() {
		return reqItemCode;
	}

	public void setReqItemCode(String reqItemCode) {
		this.reqItemCode = reqItemCode;
	}

	public String getReqBaseDate() {
		return reqBaseDate;
	}

	public void setReqBaseDate(String reqBaseDate) {
		this.reqBaseDate = reqBaseDate;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getMatYyyyMm() {
		return matYyyyMm;
	}

	public void setMatYyyyMm(String matYyyyMm) {
		this.matYyyyMm = matYyyyMm;
	}

	public BigDecimal getMatInitialQty() {
		return matInitialQty;
	}

	public void setMatInitialQty(BigDecimal matInitialQty) {
		this.matInitialQty = matInitialQty;
	}

	public BigDecimal getMatInputQty() {
		return matInputQty;
	}

	public void setMatInputQty(BigDecimal matInputQty) {
		this.matInputQty = matInputQty;
	}

	public Integer getMatAgingPeriod() {
		return matAgingPeriod;
	}

	public void setMatAgingPeriod(Integer matAgingPeriod) {
		this.matAgingPeriod = matAgingPeriod;
	}

	public String getMatItemType() {
		return matItemType;
	}

	public void setMatItemType(String matItemType) {
		this.matItemType = matItemType;
	}

	public MaterialBalanceRow toMaterialBalanceRow() {
		MaterialBalanceRow row = new MaterialBalanceRow();
		row.setItemCode(itemCode);
		row.setMatYyyyMm(matYyyyMm);
		row.setMatInitialQty(matInitialQty);
		row.setMatInputQty(matInputQty);
		row.setMatAgingPeriod(matAgingPeriod);
		row.setMatItemType(matItemType);
		return row;
	}
}
