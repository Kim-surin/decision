package com.kpmg.kdb.web.origindetermination.dto;

/** 레거시 CREATE_FCR "1. 파라미터 셋업 작업" 에서 조회하는 SALES_MST 헤더 정보 */
public class SalesInvoiceHeader {

	private String exportFlag;
	private String invoiceDate;
	private String virtualYn;

	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getVirtualYn() {
		return virtualYn;
	}

	public void setVirtualYn(String virtualYn) {
		this.virtualYn = virtualYn;
	}
}
