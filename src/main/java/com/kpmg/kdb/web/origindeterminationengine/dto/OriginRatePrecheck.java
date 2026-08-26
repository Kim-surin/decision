package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.util.Collections;
import java.util.List;

/**
 * {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#precheckOriginRate} 결과.
 * FTA_CODE 와 무관하게 결정되는 부분(대상 자재/조회구간/구매원장 집계)만 미리 계산해, 같은 (회사/
 * 사업부/품목/기준일) 조합을 FTA_CODE 만 바꿔 반복 조회할 때 재사용하는 캐시 단위다.
 *
 * <p>{@code zero} 가 true 면 최종 결과가 0(역외산)으로 확정된 것이라 FTA_CODE 별 후속 조회를 생략해도
 * 된다. false 면 {@link #getStages()} 순서대로 FTA_CODE 별 후속 조회를 진행한다.
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
