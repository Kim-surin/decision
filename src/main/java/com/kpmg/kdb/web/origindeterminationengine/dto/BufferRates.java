package com.kpmg.kdb.web.origindeterminationengine.dto;

import java.math.BigDecimal;

/** GET_BUFFER 조회 결과(RVC 버퍼율, 미소기준 버퍼율) */
public class BufferRates {

	private BigDecimal rvcRate;
	private BigDecimal deMinimisRate;

	public BigDecimal getRvcRate() {
		return rvcRate;
	}

	public void setRvcRate(BigDecimal rvcRate) {
		this.rvcRate = rvcRate;
	}

	public BigDecimal getDeMinimisRate() {
		return deMinimisRate;
	}

	public void setDeMinimisRate(BigDecimal deMinimisRate) {
		this.deMinimisRate = deMinimisRate;
	}
}
