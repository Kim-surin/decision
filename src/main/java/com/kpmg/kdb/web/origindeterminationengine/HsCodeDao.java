package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeBatchResult;
import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeCriteria;

public interface HsCodeDao {
	/**
	 * 원본 FS03_GET_HS_CODE 는 ROWNUM = 1 로 단일 행만 반환했다.
	 * Oracle 전용 ROWNUM 대신 SQL의 FETCH FIRST 1 ROW ONLY 로 DB에서 1건만 잘라 전송하며,
	 * 매칭되는 행이 없으면 null 을 반환한다(MyBatis가 0건일 때 null 매핑).
	 */
	HsCodeCandidateRow selectHsCodeCandidates(HsCodeCriteria criteria);

	/**
	 * {@link #selectHsCodeCandidates} 의 배치 버전. (companyCode,divisionCode,customerCode,itemCode,
	 * nationCode,ftaCode,baseDate) 조합 전체를 한 번에 조회한다 — 같은 제품이 FTA_CODE 후보 수만큼
	 * 반복되는 3-2 단계(FCR_MST 생성, salesLines × ftaMasters)에서 사용한다
	 * ({@link com.kpmg.kdb.web.origindeterminationexecution.HsCodeService#prefetchHsCode} 참고). 요청 조합마다 반드시
	 * 결과 행이 1건씩 존재한다(LEFT JOIN LATERAL — ITEM_MST 조차 없는 조합도 후보 필드가 전부 null인
	 * 행으로 돌아온다).
	 */
	List<HsCodeBatchResult> selectHsCodeCandidatesBatch(@Param("requests") List<HsCodeCriteria> requests);
}
