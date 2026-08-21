package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

/**
 * {@link ExportBulkDecisionService} 입력 1건. 수출은 이미 존재하는 실제 SALES_NO 를 그대로 대상으로
 * 삼아 가상매출 생성 단계가 없으므로(내수 개별판정과 달리 SALES_NO/PRODUCT_CODE 를 그룹핑·합산해
 * 가상 SALES_NO 를 새로 만드는 데이터 가공 로직이 필요 없다), 호출측이 이미 확정된
 * (companyCode,divisionCode,salesNo,productCodes) 조합을 그대로 넘긴다.
 */
public class ExportDecisionTarget {

	private final String companyCode;
	private final String divisionCode;
	private final String salesNo;
	/** null 이면 salesNo 전체 제품 대상(OriginDecisionPipelineFactory#forExport 와 동일). */
	private final List<String> productCodes;

	public ExportDecisionTarget(String companyCode, String divisionCode, String salesNo, List<String> productCodes) {
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.salesNo = salesNo;
		this.productCodes = productCodes;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public String getSalesNo() {
		return salesNo;
	}

	public List<String> getProductCodes() {
		return productCodes;
	}
}
