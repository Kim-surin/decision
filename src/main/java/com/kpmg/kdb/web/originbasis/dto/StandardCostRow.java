package com.kpmg.kdb.web.originbasis.dto;

import java.math.BigDecimal;

/** STANDARD_COST(표준원가) 조회 결과. FC10_GET_ITEM_PRICE/ _NOTE 4번째(마지막) fallback */
public class StandardCostRow {

	private BigDecimal standardCostAmount;
	private String applyDate;
	private String divisionCode;

	public BigDecimal getStandardCostAmount() {
		return standardCostAmount;
	}

	public void setStandardCostAmount(BigDecimal standardCostAmount) {
		this.standardCostAmount = standardCostAmount;
	}

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String buildPriceNoteText() {
		return "표준 단가 (" + applyDate + "," + divisionCode + ")";
	}
}
