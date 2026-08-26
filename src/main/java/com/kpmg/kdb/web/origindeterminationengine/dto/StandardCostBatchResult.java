package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemPriceDao#selectStandardCostByDivisionBatch} 배치 조회 1건의 결과.
 * 요청받은 (divisionCode,itemCode) 조합 전체를 LEFT JOIN LATERAL 로 조회하므로, 매칭되는 STANDARD_COST
 * 행이 없는 조합도 요청 키(reqDivisionCode/reqItemCode)만 채워진 채 결과에 포함된다(그 경우 나머지 필드는
 * 전부 null — {@link com.kpmg.kdb.web.origindeterminationengine.ItemPriceDao#selectStandardCostByDivision} 이 0건일 때
 * null 을 반환하던 것과 동등하게 취급한다).
 */
public class StandardCostBatchResult {

	private String reqDivisionCode;
	private String reqItemCode;
	private BigDecimal standardCostAmount;
	private String applyDate;
	private String divisionCode;

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

	/** 매칭되는 STANDARD_COST 행이 없었으면(standardCostAmount 등 전부 null) null 을 돌려준다. */
	public StandardCostRow toRowOrNull() {
		if (standardCostAmount == null) {
			return null;
		}
		StandardCostRow row = new StandardCostRow();
		row.setStandardCostAmount(standardCostAmount);
		row.setApplyDate(applyDate);
		row.setDivisionCode(divisionCode);
		return row;
	}
}
