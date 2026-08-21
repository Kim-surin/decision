package com.kpmg.kdb.web.origindeterminationengine.dto;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateDao#selectMaterialCandidatesBatch} 배치 조회 1건의
 * 입력 키. companyCode 는 배치 호출 시점에 이미 스코프가 고정돼 있어(한 번의 createFcr() 호출은 항상
 * 같은 회사) 별도 파라미터로 넘기고 이 키에는 포함하지 않는다.
 *
 * <p>{@code baseDate} 는 SQL 바인딩(조회기간 fromYyyyMm/toYyyyMm)에는 쓰이지 않고, 결과를
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#precheckKey} 와 동일한 캐시 키로 되돌려주기
 * 위한 원본(raw) 값이다 — fromYyyyMm/toYyyyMm 은 baseDate 로부터 계산된 파생값이라 caller 가 이미
 * 계산해 넘긴다.
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
