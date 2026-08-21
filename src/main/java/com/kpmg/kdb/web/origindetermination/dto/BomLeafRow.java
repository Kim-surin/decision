package com.kpmg.kdb.web.origindetermination.dto;

import java.math.BigDecimal;

/**
 * 레거시 CREATE_FCR 3-3(제품 BOM 소요량) 단계의 BOM 최말단(ISLEAF_YN='Y') 자재 원시 행.
 * FC10_GET_ITEM_PRICE / FC10_GET_ITEM_ORIGIN_RATE / FC10_GET_ITEM_PRICE_NOTE 호출 전 데이터로,
 * 이 호출들은 Java 쪽(originbasis 서비스)에서 수행한다.
 */
public class BomLeafRow {

	private String itemCode;
	private String ftaCode;
	private String salesNo;
	private int salesSeq;
	private String productCode;
	private String divisionCode;
	private String companyCode;
	/** NVL(IM.HS_CODE, NVL(FM.HS_CODE,' ')) 로 계산된 최종 HS_CODE */
	private String hsCode;
	/** IM.HS_CODE 원본값(NULL 가능). HS_CODE_YN 판정에 hsCode 가 아닌 이 값을 사용한다(원본과 동일) */
	private String itemHsCode;
	private BigDecimal requirementQty;
	/** FC10_GET_ITEM_PRICE 등의 P_DIVISION_CODE 인자(FBD.FROM_DIVISION_CODE, 제품이 아닌 BOM 자재의 출처 사업부) */
	private String fromDivisionCode;
	private String invoiceDate;

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public int getSalesSeq() {
		return salesSeq;
	}

	public void setSalesSeq(int salesSeq) {
		this.salesSeq = salesSeq;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	public String getItemHsCode() {
		return itemHsCode;
	}

	public void setItemHsCode(String itemHsCode) {
		this.itemHsCode = itemHsCode;
	}

	public BigDecimal getRequirementQty() {
		return requirementQty;
	}

	public void setRequirementQty(BigDecimal requirementQty) {
		this.requirementQty = requirementQty;
	}

	public String getFromDivisionCode() {
		return fromDivisionCode;
	}

	public void setFromDivisionCode(String fromDivisionCode) {
		this.fromDivisionCode = fromDivisionCode;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
}
