package com.kpmg.kdb.web.originbasis;

import java.util.List;

import com.kpmg.kdb.web.originbasis.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.IncotermsRateRow;

public interface IncotermsRateDao {
	/**
	 * STD_YYYY 가 기준연도 이하인 행을 최신순으로 조회한다.
	 * 원본의 상관 서브쿼리(MAX(STD_YYYY) ...)와 ROWNUM = 1 은 ORDER BY + 애플리케이션에서의 첫 행 선택으로 대체한다.
	 */
	List<IncotermsRateRow> selectIncotermsInfo(IncotermsChangeRateCriteria criteria);
}
