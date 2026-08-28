package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.BufferRates;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrMstDecisionUpdateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.UpdateFrmBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.UpdateFrmLookupRequest;

/** 원산지 판정 공용 헬퍼(버퍼율/최소공정/RCEP/판정결과 저장/FCR_MST 갱신)가 사용하는 조회/저장. */
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

	/** 판정결과(FCR_RESULT) 배치 INSERT */
	void insertFcrResults(@Param("records") List<OriginDeterminationResult> records);

	/** UPDATE_FRM_PROCEDURE 1단계: 역내산(COMPANY_COO_YN='Y') 판정결과 조회 */
	List<OriginDeterminationResult> selectOwnCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/** UPDATE_FRM_PROCEDURE 2단계: 역외산만 존재(COMPANY_COO_YN='N', STATUS='N') 판정결과 조회 */
	List<OriginDeterminationResult> selectNonCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/** {@link #selectOwnCooFcrResult}/{@link #selectNonCooFcrResult}의 배치 버전(역내산 우선, 없으면 역외산) */
	List<UpdateFrmBatchResult> selectOwnOrNonCooFcrResultBatch(@Param("companyCode") String companyCode,
			@Param("salesNo") String salesNo, @Param("requests") List<UpdateFrmLookupRequest> requests);

	/** FCR_MST 최종 판정결과(FTA_COO_YN/COMPANY_COO_YN 등) 배치 UPDATE */
	void updateFcrMstDecisionResults(@Param("rows") List<FcrMstDecisionUpdateRow> rows);
}
