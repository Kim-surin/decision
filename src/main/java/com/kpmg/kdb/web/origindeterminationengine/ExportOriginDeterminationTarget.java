package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

// ExportOriginDeterminationService 입력 1건. 수출은 이미 존재하는 실제 SALES_NO를 그대로 대상 삼아 가상매출 생성 단계가
// 없으므로(내수와 달리 그룹핑·합산해 가상 SALES_NO를 만드는 로직 불필요), 확정된 조합을 그대로 넘긴다.
public class ExportOriginDeterminationTarget {

	private final String companyCode;
	private final String divisionCode;
	private final String salesNo;
	/** null 이면 salesNo 전체 제품 대상(OriginDeterminationPipelineFactory#forExport 와 동일). */
	private final List<String> productCodes;
	/** GenericController#extendsMap이 세션에서 채워준 사용자 ID. FCR_MST/FCR_DTL/FCR_RESULT/SALES_MST 등의 CREATE_BY/UPDATE_BY에 그대로 쓰인다. */
	private final String createBy;

	public ExportOriginDeterminationTarget(String companyCode, String divisionCode, String salesNo, List<String> productCodes,
			String createBy) {
		this.companyCode = companyCode;
		this.divisionCode = divisionCode;
		this.salesNo = salesNo;
		this.productCodes = productCodes;
		this.createBy = createBy;
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

	public String getCreateBy() {
		return createBy;
	}
}
