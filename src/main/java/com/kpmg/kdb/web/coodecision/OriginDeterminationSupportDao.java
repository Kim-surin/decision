package com.kpmg.kdb.web.coodecision;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.coodecision.dto.BufferRates;
import com.kpmg.kdb.web.coodecision.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.coodecision.dto.UpdateFrmBatchResult;
import com.kpmg.kdb.web.coodecision.dto.UpdateFrmLookupRequest;

/**
 * PKG99_COO_DECISION / PKG99_COO_CTC_DECISION 두 패키지에 완전 동일하게 존재하는
 * 공용 헬퍼 프로시저(GET_BUFFER, GET_MP_ITEM, GET_RCEP_NATION, GET_RCEP_RVC_NATION,
 * INSERT_FRD_PROCESS, UPDATE_FRM_PROCEDURE) 가 사용하는 조회/저장을 담당한다.
 */
public interface OriginDeterminationSupportDao {

	/** COMPANY_OPTION.OPTION_CODE = 'BF' 값 조회 (GET_BUFFER 1단계) */
	String selectBufferOptionValue(@Param("companyCode") String companyCode);

	BufferRates selectCompanyBuffer(@Param("companyCode") String companyCode);

	BufferRates selectDivisionBuffer(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode);

	BufferRates selectProductLineBuffer(@Param("companyCode") String companyCode,
			@Param("productCode") String productCode);

	BufferRates selectFtaBuffer(@Param("companyCode") String companyCode, @Param("ftaCode") String ftaCode);

	/** 최소공정 제외 품목 해당 건수 (GET_MP_ITEM) */
	long selectMinimalProcessItemCount(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("salesSeq") int salesSeq);

	/** 해당 FTA 협정 적용대상 회원국 코드 목록 (GET_RCEP_NATION / GET_RCEP_RVC_NATION 공용) */
	List<String> selectFtaApplyNations(@Param("ftaCode") String ftaCode);

	/**
	 * INSERT_FRD_PROCESS 의 FCR_RESULT 배치 INSERT. SEQ 컬럼은 넘기지 않고 DB 컬럼 DEFAULT(시퀀스)로
	 * 채번한다. FM_LIST 1건(FTA 후보) 처리 중 룰별로 쌓인 결과를 한 번에 저장한다
	 * (OriginDeterminationSupportService#flushPendingResults 참고).
	 */
	void insertFcrResults(@Param("records") List<OriginDeterminationResult> records);

	/** UPDATE_FRM_PROCEDURE 1단계: 역내산(COMPANY_COO_YN='Y') 판정결과 조회 */
	List<OriginDeterminationResult> selectOwnCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/** UPDATE_FRM_PROCEDURE 2단계: 역외산만 존재(COMPANY_COO_YN='N', STATUS='N') 판정결과 조회 */
	List<OriginDeterminationResult> selectNonCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/**
	 * {@link #selectOwnCooFcrResult}/{@link #selectNonCooFcrResult} 를 (salesSeq,ftaCode,divisionCode)
	 * 조합별로 반복 호출(역내산 우선 조회 → 없으면 역외산만 존재 조회)하는 대신 한 번에 처리하는 배치
	 * 버전. companyCode/salesNo 는 determineOrigin() 1회 호출 범위에서 항상 같은 값이라 별도 파라미터로
	 * 받는다. 매칭되는 FCR_RESULT 행이 전혀 없는 요청도 결과에 포함되며(LEFT JOIN LATERAL), 그 경우
	 * matchTier 가 null 이다 — {@link UpdateFrmBatchResult} 참고.
	 */
	List<UpdateFrmBatchResult> selectOwnOrNonCooFcrResultBatch(@Param("companyCode") String companyCode,
			@Param("salesNo") String salesNo, @Param("requests") List<UpdateFrmLookupRequest> requests);

	/**
	 * UPDATE_FRM_PROCEDURE 말미: FCR_MST 최종 판정결과 반영. FM_LIST 행(FTA 후보)마다 즉시 실행하는 대신
	 * determineOrigin() 1회 호출 범위에서 모았다가 한 번의 배치 UPDATE 로 반영한다
	 * (OriginDeterminationSupportService#updateFrm/#flushFcrMstUpdates 참고).
	 */
	void updateFcrMstDecisionResults(@Param("rows") List<FcrMstDecisionUpdateRow> rows);
}
