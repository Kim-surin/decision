package com.kpmg.kdb.web.originbasis;

import com.kpmg.kdb.web.originbasis.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;

public interface HsCodeDao {
	/**
	 * 원본 FS03_GET_HS_CODE 는 ROWNUM = 1 로 단일 행만 반환했다.
	 * Oracle 전용 ROWNUM 대신 SQL의 FETCH FIRST 1 ROW ONLY 로 DB에서 1건만 잘라 전송하며,
	 * 매칭되는 행이 없으면 null 을 반환한다(MyBatis가 0건일 때 null 매핑).
	 */
	HsCodeCandidateRow selectHsCodeCandidates(HsCodeCriteria criteria);
}
