package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.MaterialHsCodeDao#selectHsCodeCandidatesBatch} 배치 조회 1건의 결과.
 * 요청 키 7개(reqCompanyCode~reqBaseDate)를 그대로 돌려받아야 결과를 요청별로 다시 묶을 수 있다
 * (원본 조회 조건 전체가 키이기 때문에 {@link HsCodeCandidateRow} 자체에는 구분 정보가 없다).
 */
public class HsCodeBatchResult {

	private String reqCompanyCode;
	private String reqDivisionCode;
	private String reqCustomerCode;
	private String reqItemCode;
	private String reqNationCode;
	private String reqFtaCode;
	private String reqBaseDate;

	private String customerHsCode;
	private String ftaAgmHsCode;
	private String ftaHsCode;
	private String historyHsCode;
	private String itemHsCode;

	public String getReqCompanyCode() {
		return reqCompanyCode;
	}

	public void setReqCompanyCode(String reqCompanyCode) {
		this.reqCompanyCode = reqCompanyCode;
	}

	public String getReqDivisionCode() {
		return reqDivisionCode;
	}

	public void setReqDivisionCode(String reqDivisionCode) {
		this.reqDivisionCode = reqDivisionCode;
	}

	public String getReqCustomerCode() {
		return reqCustomerCode;
	}

	public void setReqCustomerCode(String reqCustomerCode) {
		this.reqCustomerCode = reqCustomerCode;
	}

	public String getReqItemCode() {
		return reqItemCode;
	}

	public void setReqItemCode(String reqItemCode) {
		this.reqItemCode = reqItemCode;
	}

	public String getReqNationCode() {
		return reqNationCode;
	}

	public void setReqNationCode(String reqNationCode) {
		this.reqNationCode = reqNationCode;
	}

	public String getReqFtaCode() {
		return reqFtaCode;
	}

	public void setReqFtaCode(String reqFtaCode) {
		this.reqFtaCode = reqFtaCode;
	}

	public String getReqBaseDate() {
		return reqBaseDate;
	}

	public void setReqBaseDate(String reqBaseDate) {
		this.reqBaseDate = reqBaseDate;
	}

	public String getCustomerHsCode() {
		return customerHsCode;
	}

	public void setCustomerHsCode(String customerHsCode) {
		this.customerHsCode = customerHsCode;
	}

	public String getFtaAgmHsCode() {
		return ftaAgmHsCode;
	}

	public void setFtaAgmHsCode(String ftaAgmHsCode) {
		this.ftaAgmHsCode = ftaAgmHsCode;
	}

	public String getFtaHsCode() {
		return ftaHsCode;
	}

	public void setFtaHsCode(String ftaHsCode) {
		this.ftaHsCode = ftaHsCode;
	}

	public String getHistoryHsCode() {
		return historyHsCode;
	}

	public void setHistoryHsCode(String historyHsCode) {
		this.historyHsCode = historyHsCode;
	}

	public String getItemHsCode() {
		return itemHsCode;
	}

	public void setItemHsCode(String itemHsCode) {
		this.itemHsCode = itemHsCode;
	}

	public HsCodeCandidateRow toCandidateRow() {
		HsCodeCandidateRow row = new HsCodeCandidateRow();
		row.setCustomerHsCode(customerHsCode);
		row.setFtaAgmHsCode(ftaAgmHsCode);
		row.setFtaHsCode(ftaHsCode);
		row.setHistoryHsCode(historyHsCode);
		row.setItemHsCode(itemHsCode);
		return row;
	}
}
