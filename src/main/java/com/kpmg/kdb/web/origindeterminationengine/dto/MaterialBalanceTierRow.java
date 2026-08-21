package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * MATERIAL_INV_BAL(원재료 수불부) 조회 결과 한 행.
 * FC10_GET_ITEM_PRICE 의 단가 산출 공식을 Java에서 계산하기 위한 원본 컬럼.
 */
public class MaterialBalanceTierRow {

	private String yyyymm;
	private String divisionCode;
	private BigDecimal issueAmount;
	private BigDecimal issueQty;
	private BigDecimal inventoryAmount;
	private BigDecimal inventoryQty;
	private BigDecimal extraIssueAmount;
	private BigDecimal extraIssueQty;

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

	private static BigDecimal nvl(BigDecimal value) {
		return value == null ? BigDecimal.ZERO : value;
	}

	/**
	 * FC10_GET_ITEM_PRICE 공식: (ISSUE_AMOUNT + EXTRA_ISSUE_AMOUNT) / (ISSUE_QTY + EXTRA_ISSUE_QTY)
	 * 분모가 0이면 0 (기말재고 기반 단가는 더 이상 사용하지 않음 - 2018-04-04 변경분 반영)
	 */
	public BigDecimal calculatePriceForPrice() {
		BigDecimal amount = nvl(issueAmount).add(nvl(extraIssueAmount));
		BigDecimal qty = nvl(issueQty).add(nvl(extraIssueQty));
		if (qty.signum() == 0) {
			return BigDecimal.ZERO;
		}
		return amount.divide(qty, 10, RoundingMode.HALF_UP);
	}

	public String buildPriceNoteText() {
		return "수불부 단가 (" + yyyymm + "," + divisionCode + ")";
	}
}
