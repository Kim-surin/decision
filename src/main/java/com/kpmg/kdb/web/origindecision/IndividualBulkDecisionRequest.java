package com.kpmg.kdb.web.origindecision;

import java.util.List;

/**
 * {@link IndividualBulkDecisionService} 입력 1건. companyCode 와 원본 (SALES_NO, PRODUCT_CODE) 행
 * 목록을 하나로 묶어, {@link BulkDecisionService} 인터페이스가 요구하는 단일 파라미터 형태를 맞춘다.
 */
public class IndividualBulkDecisionRequest {

	private final String companyCode;
	private final List<IndividualDecisionRawLine> rawLines;

	public IndividualBulkDecisionRequest(String companyCode, List<IndividualDecisionRawLine> rawLines) {
		this.companyCode = companyCode;
		this.rawLines = rawLines;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public List<IndividualDecisionRawLine> getRawLines() {
		return rawLines;
	}
}
