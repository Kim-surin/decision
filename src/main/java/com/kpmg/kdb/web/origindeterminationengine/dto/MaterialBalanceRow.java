package com.kpmg.kdb.web.origindeterminationexecution.dto;

import java.math.BigDecimal;

/**
 * FC10_GET_ITEM_ORIGIN_RATE 의 C_MAT 커서 한 행(BOM 원재료 또는 대체자재의 수불부 기초정보).
 */
public class MaterialBalanceRow {

	private String itemCode;
	private String matYyyyMm;
	private BigDecimal matInitialQty;
	private BigDecimal matInputQty;
	private Integer matAgingPeriod;
	private String matItemType;

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

	public boolean hasPositiveInitialQty() {
		return matInitialQty != null && matInitialQty.signum() > 0;
	}

	public boolean hasPositiveInputQty() {
		return matInputQty != null && matInputQty.signum() > 0;
	}

	public boolean hasPositiveAgingPeriod() {
		return matAgingPeriod != null && matAgingPeriod > 0;
	}

	public boolean hasNegativeAgingPeriod() {
		return matAgingPeriod != null && matAgingPeriod < 0;
	}
}
