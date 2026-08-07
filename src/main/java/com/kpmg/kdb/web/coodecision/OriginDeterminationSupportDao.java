package com.kpmg.kdb.web.coodecision;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.coodecision.dto.BufferRates;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationResult;

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

	BufferRates selectFtaBuffer(@Param("ftaCode") String ftaCode);

	/** 최소공정 제외 품목 해당 건수 (GET_MP_ITEM) */
	long selectMinimalProcessItemCount(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("salesSeq") int salesSeq);

	/** 해당 FTA 협정 적용대상 회원국 코드 목록 (GET_RCEP_NATION / GET_RCEP_RVC_NATION 공용) */
	List<String> selectFtaApplyNations(@Param("ftaCode") String ftaCode);

	/** FCR_RESULT_SEQ_S.NEXTVAL 대체 */
	Long selectNextFcrResultSeq();

	/** INSERT_FRD_PROCESS 의 FCR_RESULT INSERT */
	void insertFcrResult(OriginDeterminationResult record);

	/** UPDATE_FRM_PROCEDURE 1단계: 역내산(COMPANY_COO_YN='Y') 판정결과 조회 */
	List<OriginDeterminationResult> selectOwnCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/** UPDATE_FRM_PROCEDURE 2단계: 역외산만 존재(COMPANY_COO_YN='N', STATUS='N') 판정결과 조회 */
	List<OriginDeterminationResult> selectNonCooFcrResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode);

	/** UPDATE_FRM_PROCEDURE 말미: FCR_MST 최종 판정결과 반영 */
	void updateFcrMstDecisionResult(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("ruleContents") String ruleContents,
			@Param("ftaCooYn") String ftaCooYn, @Param("companyCooYn") String companyCooYn,
			@Param("rcepCooNation") String rcepCooNation);
}
