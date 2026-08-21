package com.kpmg.kdb.web.origindeterminationexecution.dto;

import java.math.BigDecimal;

/**
 * {@link com.kpmg.kdb.web.origindeterminationexecution.ItemPriceDao#selectDivisionBalanceForPriceBatch} 배치 조회 1건의
 * 결과. 요청받은 (divisionCode,itemCode) 조합 전체를 LEFT JOIN LATERAL 로 조회하므로, 매칭되는
 * MATERIAL_INV_BAL 행이 없는 조합도 요청 키(reqDivisionCode/reqItemCode)만 채워진 채 결과에 포함된다
 * (그 경우 나머지 필드는 전부 null — {@link com.kpmg.kdb.web.origindeterminationexecution.ItemPriceDao#selectDivisionBalanceForPrice}
 * 가 0건일 때 null 을 반환하던 것과 동등하게 취급한다).
 */
public class MaterialBalanceTierBatchResult {

	private String reqDivisionCode;
	private String reqItemCode;
	private String yyyymm;
	private String divisionCode;
	private BigDecimal issueAmount;
	private BigDecimal issueQty;
	private BigDecimal inventoryAmount;
	private BigDecimal inventoryQty;
	private BigDecimal extraIssueAmount;
	private BigDecimal extraIssueQty;

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

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public BigDecimal getIssueAmount() {
		return issueAmount;
	}

	public void setIssueAmount(BigDecimal issueAmount) {
		this.issueAmount = issueAmount;
	}

	public BigDecimal getIssueQty() {
		return issueQty;
	}

	public void setIssueQty(BigDecimal issueQty) {
		this.issueQty = issueQty;
	}

	public BigDecimal getInventoryAmount() {
		return inventoryAmount;
	}

	public void setInventoryAmount(BigDecimal inventoryAmount) {
		this.inventoryAmount = inventoryAmount;
	}

	public BigDecimal getInventoryQty() {
		return inventoryQty;
	}

	public void setInventoryQty(BigDecimal inventoryQty) {
		this.inventoryQty = inventoryQty;
	}

	public BigDecimal getExtraIssueAmount() {
		return extraIssueAmount;
	}

	public void setExtraIssueAmount(BigDecimal extraIssueAmount) {
		this.extraIssueAmount = extraIssueAmount;
	}

	public BigDecimal getExtraIssueQty() {
		return extraIssueQty;
	}

	public void setExtraIssueQty(BigDecimal extraIssueQty) {
		this.extraIssueQty = extraIssueQty;
	}

	/** 매칭되는 MATERIAL_INV_BAL 행이 없었으면(yyyymm 등 전부 null) null 을 돌려준다. */
	public MaterialBalanceTierRow toRowOrNull() {
		if (yyyymm == null) {
			return null;
		}
		MaterialBalanceTierRow row = new MaterialBalanceTierRow();
		row.setYyyymm(yyyymm);
		row.setDivisionCode(divisionCode);
		row.setIssueAmount(issueAmount);
		row.setIssueQty(issueQty);
		row.setInventoryAmount(inventoryAmount);
		row.setInventoryQty(inventoryQty);
		row.setExtraIssueAmount(extraIssueAmount);
		row.setExtraIssueQty(extraIssueQty);
		return row;
	}
}
