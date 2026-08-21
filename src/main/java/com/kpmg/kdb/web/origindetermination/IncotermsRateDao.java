package com.kpmg.kdb.web.origindetermination;

import com.kpmg.kdb.web.origindetermination.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.origindetermination.dto.IncotermsRateRow;

public interface IncotermsRateDao {
	/**
	 * STD_YYYY 가 기준연도 이하인 행 중 최신 1건을 조회한다.
	 * 원본의 상관 서브쿼리(MAX(STD_YYYY) ...)와 ROWNUM = 1 은 ORDER BY DESC + FETCH FIRST 1 ROW ONLY 로
	 * 대체한다(DB에서 1건만 잘라 전송). 매칭되는 행이 없으면 null 을 반환한다.
	 */
	IncotermsRateRow selectIncotermsInfo(IncotermsChangeRateCriteria criteria);
}
