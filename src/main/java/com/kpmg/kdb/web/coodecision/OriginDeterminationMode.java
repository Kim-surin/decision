package com.kpmg.kdb.web.coodecision;

/**
 * 레거시 PKG99_COO_DECISION(RVC+CTC 통합) / PKG99_COO_CTC_DECISION(CTC 전용) 두 패키지를
 * 대체하는 전략 구분자. MONTHLY_DECISION_PROC 의 V_CTC_DECISION_ONLY_YN 플래그에 대응한다.
 */
public enum OriginDeterminationMode {
	/** PKG99_COO_DECISION: RVC(부가가치기준) + CTC(세번변경기준) 통합 판정 */
	RVC_CTC("PKG99_COO_DECISION"),
	/** PKG99_COO_CTC_DECISION: 세번변경기준(CTC) 전용 판정 */
	CTC_ONLY("PKG99_COO_CTC_DECISION");

	private final String procedureName;

	OriginDeterminationMode(String procedureName) {
		this.procedureName = procedureName;
	}

	/** FCR_RESULT.CREATE_BY / UPDATE_BY 등에 기록되는 원본 패키지명 */
	public String getProcedureName() {
		return procedureName;
	}
}
