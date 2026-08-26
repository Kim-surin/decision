package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateDao#selectMaterialCandidatesBatch} 배치 조회 1건의
 * 입력 키. companyCode 는 호출 시점에 이미 스코프가 고정돼 있어 별도 파라미터로 넘기고 이 키에는 포함하지
 * 않는다. {@code baseDate} 는 SQL 바인딩에는 쓰이지 않고 캐시 키 복원용 원본값이다.
 */
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
