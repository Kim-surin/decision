package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.util.Collections;
import java.util.List;

// precheckOriginRate 결과. FTA_CODE와 무관한 부분(대상 자재/조회구간/구매원장 집계)만 미리 계산해
// 같은 조합을 FTA_CODE만 바꿔 반복 조회할 때 재사용한다. zero가 true면 0(역외산) 확정이라 후속 조회를 생략한다.
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
