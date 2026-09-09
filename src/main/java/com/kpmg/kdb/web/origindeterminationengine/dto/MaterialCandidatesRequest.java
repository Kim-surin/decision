package com.kpmg.kdb.web.origindeterminationengine.dto;

// selectMaterialCandidatesBatch 배치 조회 1건의 입력 키. companyCode는 호출 시점에 스코프가
// 이미 고정돼 있어 이 키엔 포함 안 하고, baseDate는 SQL 바인딩엔 안 쓰고 캐시 키 복원용이다.
public class MaterialCandidatesRequest {

	private final String divisionCode;
	private final String itemCode;
	private final String baseDate;
	private final String fromYyyyMm;
	private final String toYyyyMm;

	public MaterialCandidatesRequest(String divisionCode, String itemCode, String baseDate, String fromYyyyMm,
			String toYyyyMm) {
		this.divisionCode = divisionCode;
		this.itemCode = itemCode;
		this.baseDate = baseDate;
		this.fromYyyyMm = fromYyyyMm;
		this.toYyyyMm = toYyyyMm;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getBaseDate() {
		return baseDate;
	}

	public String getFromYyyyMm() {
		return fromYyyyMm;
	}

	public String getToYyyyMm() {
		return toYyyyMm;
	}
}
