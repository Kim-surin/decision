package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

public class OriginDeterminationFailMaterialResponseDto {
	private String fta_code;
	private String item_code;
	private String item_name;
	private String hs_code;
	private BigDecimal requirement_qty;
	private BigDecimal input_amount;
	private BigDecimal inarea_qty;
	private BigDecimal inarea_amount;
	private BigDecimal outarea_qty;
	private BigDecimal outarea_amount;

	public String getFta_code() {
		return fta_code;
	}

	public void setFta_code(String fta_code) {
		this.fta_code = fta_code;
	}

	public String getItem_code() {
		return item_code;
	}

	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getHs_code() {
		return hs_code;
	}

	public void setHs_code(String hs_code) {
		this.hs_code = hs_code;
	}

	public BigDecimal getRequirement_qty() {
		return requirement_qty;
	}

	public void setRequirement_qty(BigDecimal requirement_qty) {
		this.requirement_qty = requirement_qty;
	}

	public BigDecimal getInput_amount() {
		return input_amount;
	}

	public void setInput_amount(BigDecimal input_amount) {
		this.input_amount = input_amount;
	}

	public BigDecimal getInarea_qty() {
		return inarea_qty;
	}

	public void setInarea_qty(BigDecimal inarea_qty) {
		this.inarea_qty = inarea_qty;
	}

	public BigDecimal getInarea_amount() {
		return inarea_amount;
	}

	public void setInarea_amount(BigDecimal inarea_amount) {
		this.inarea_amount = inarea_amount;
	}

	public BigDecimal getOutarea_qty() {
		return outarea_qty;
	}

	public void setOutarea_qty(BigDecimal outarea_qty) {
		this.outarea_qty = outarea_qty;
	}

	public BigDecimal getOutarea_amount() {
		return outarea_amount;
	}

	public void setOutarea_amount(BigDecimal outarea_amount) {
		this.outarea_amount = outarea_amount;
	}
}
