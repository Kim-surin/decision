package com.kpmg.kdb.web.originbasis;

import java.util.List;

import com.kpmg.kdb.web.originbasis.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;

public interface HsCodeDao {
	/**
	 * 원본 FS03_GET_HS_CODE 는 ROWNUM = 1 로 단일 행만 반환했다.
	 * Oracle 전용 ROWNUM 대신 정렬된 목록을 받아 첫 행을 애플리케이션에서 선택하도록 하여 DB 이식성을 확보한다.
	 */
	List<HsCodeCandidateRow> selectHsCodeCandidates(HsCodeCriteria criteria);
}
