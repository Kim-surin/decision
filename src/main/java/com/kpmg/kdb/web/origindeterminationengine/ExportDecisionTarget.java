package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

// ExportDecisionService 입력 1건. 수출은 이미 존재하는 실제 SALES_NO를 그대로 대상 삼아 가상매출 생성 단계가
// 없으므로(내수와 달리 그룹핑·합산해 가상 SALES_NO를 만드는 로직 불필요), 확정된 조합을 그대로 넘긴다.
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
