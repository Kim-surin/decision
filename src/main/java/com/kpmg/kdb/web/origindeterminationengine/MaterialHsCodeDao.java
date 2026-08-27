package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.HsCodeBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.HsCodeCriteria;

public interface MaterialHsCodeDao {
	/** HS코드 후보 조회. 매칭되는 행이 없으면 null을 반환한다. */
	HsCodeCandidateRow selectHsCodeCandidates(HsCodeCriteria criteria);

	/** {@link #selectHsCodeCandidates}의 배치 버전 */
	List<HsCodeBatchResult> selectHsCodeCandidatesBatch(@Param("requests") List<HsCodeCriteria> requests);
}
