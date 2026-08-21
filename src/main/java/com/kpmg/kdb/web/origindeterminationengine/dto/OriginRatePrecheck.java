package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.util.Collections;
import java.util.List;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#precheckOriginRate} 결과. FC10_GET_ITEM_ORIGIN_RATE
 * 원본 로직 중 FTA_CODE 와 무관하게 결정되는 부분(대상 자재 목록, 자재별 조회구간, 구매원장 집계, 그리고
 * 그 과정에서 이미 0(역외산)으로 확정되는 경우)만 미리 계산해둔 것 — 같은 (회사/사업부/품목/기준일)
 * 조합을 FTA_CODE 만 바꿔가며 반복 조회할 때(BOM 리프 자재 × 협정 수만큼) 이 부분을 한 번만 계산하고
 * 재사용하기 위한 캐시 단위다.
 *
 * <p>{@code zero} 가 true 면 FTA_CODE 와 무관하게 최종 결과가 0으로 확정된 것이므로, 호출자는 FTA_CODE
 * 별 후속 조회(4단계) 자체를 생략하고 바로 0을 반환하면 된다. false 면 {@link #getStages()} 순서대로
 * FTA_CODE 별 후속 조회를 진행해야 한다(원본의 자재 순회 순서와 단락평가 순서를 그대로 보존).
 */
public class OriginRatePrecheck {

	private static final OriginRatePrecheck ZERO = new OriginRatePrecheck(true, Collections.emptyList());

	private final boolean zero;
	private final List<OriginRateStage> stages;

	private OriginRatePrecheck(boolean zero, List<OriginRateStage> stages) {
		this.zero = zero;
		this.stages = stages;
	}

	public static OriginRatePrecheck zero() {
		return ZERO;
	}

	public static OriginRatePrecheck stages(List<OriginRateStage> stages) {
		return new OriginRatePrecheck(false, stages);
	}

	public boolean isZero() {
		return zero;
	}

	public List<OriginRateStage> getStages() {
		return stages;
	}
}
