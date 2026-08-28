package com.kpmg.kdb.web.origindeterminationengine;

import com.kpmg.kdb.web.origindeterminationengine.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.IncotermsRateRow;

public interface IncotermsRateDao {
	/**
	 * STD_YYYY 가 기준연도 이하인 행 중 최신 1건을 조회한다.
	 * 매칭되는 행이 없으면 null 을 반환한다.
	 */
	IncotermsRateRow selectIncotermsInfo(IncotermsChangeRateCriteria criteria);
}
