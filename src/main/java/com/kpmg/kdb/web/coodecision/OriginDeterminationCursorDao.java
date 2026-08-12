package com.kpmg.kdb.web.coodecision;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.coodecision.dto.MaterialOriginRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.coodecision.dto.OriginCriteria;
import com.kpmg.kdb.web.coodecision.dto.OriginCriteriaBatchRequest;
import com.kpmg.kdb.web.coodecision.dto.OriginCriteriaBatchResult;

/**
 * 레거시 PKG99_COO_DECISION / PKG99_COO_CTC_DECISION 의 메인 프로시저 COO_DECISION 이 사용하는
 * 커서(C_FCR_MST, C_FTA_RULE)와 FCR_INFO_TEMP 조회를 담당한다.
 * 실제 오케스트레이션은 {@link OriginDeterminationService} 참고.
 *
 * <p>원본에 있던 "기판정 FCR_RESULT 삭제"(FM_LIST 1건당 1회)는 제거했다 — determineOrigin() 은
 * 항상 CreateFcrService.createFcr() 직후에 호출되고, 그 안에서 이미 이 salesNo/스코프의 FCR_RESULT 를
 * FTA_CODE 무관하게 통째로 지운다(CreateFcrDao.deleteFcrResult). FCR_RESULT 를 기록하는 곳은
 * {@link OriginDeterminationService} 뿐이라 같은 determineOrigin() 호출 안에서는 FM_LIST 행별
 * 삭제가 지울 대상이 이미 없었다.
 */
public interface OriginDeterminationCursorDao {

	/** SALES_MST.INVOICE_DATE 조회 (V_YYYYMMDD, APTA 신규 PSR 적용여부 판단 기준일) */
	String selectInvoiceDate(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo);

	/**
	 * 판정대상 스코프(FCR_MST)에 실제로 존재하는 PRODUCT_ASSETS_TYPE 목록. 제품(P,H)/상품(M,R,B) 판정을
	 * 분기 호출하기 위한 사전 확인용 — {@link OriginDeterminationService#determineOrigin} 참고.
	 */
	List<String> selectDistinctProductAssetsTypes(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

	/**
	 * 레거시 CURSOR C_FCR_MST 이관. 판정대상 매출(SALES_NO) 1건에 대해 존재하는 FTA_CODE 후보 전체를
	 * 한 번에 조회한다(매출 1건당 1회 호출 — FM_LIST 커서를 여는 시점과 동일한 호출 빈도).
	 * productCodes 가 null/빈 리스트면 salesNo 전체 제품(월 판정), 값이 있으면 그 제품들만(개별 판정)
	 * 대상으로 한다 — CreateFcrDao 가 같은 스코프로 (재)생성한 FCR_MST 행만 골라 판정하기 위함이다.
	 */
	List<OriginDeterminationTarget> selectOriginDeterminationTargets(@Param("companyCode") String companyCode,
			@Param("salesNo") String salesNo, @Param("productCodes") List<String> productCodes);

	/**
	 * 레거시 "INSERT INTO FCR_INFO_TEMP SELECT ... FROM FCR_DTL" 이관.
	 * FCR_INFO_TEMP(임시테이블) 를 물리 테이블로 두지 않고, FM_LIST 1건당 1회만 조회해
	 * {@link OriginDeterminationContext#getMaterialOriginRows()} 로 메모리에 적재한 뒤 이후 판정 로직은 전부
	 * 스트림으로 처리한다(반복 SQL 제거).
	 */
	List<MaterialOriginRow> selectMaterialOriginRows(@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("salesSeq") int salesSeq, @Param("parentHsCode") String parentHsCode);

	/**
	 * 레거시 CURSOR C_FTA_RULE 이관. CTSH&gt;CTH&gt;CC 순으로 가장 긴 HS_CODE 접두어가 일치하는 룰을 찾기
	 * 위해 서브쿼리로 최대 HS_CODE 길이를 구한 뒤 그 길이로 다시 필터링한다(원본과 동일 로직, ANSI SQL).
	 */
	List<OriginCriteria> selectApplicableOriginCriteria(@Param("hsCode") String hsCode, @Param("ftaCode") String ftaCode,
			@Param("hsCodeSubCategory") String hsCodeSubCategory, @Param("newAptaPsrFlag") String newAptaPsrFlag);

	/**
	 * {@link #selectApplicableOriginCriteria} 의 배치 버전. 같은 salesNo 안에서 (hsCode,hsCodeSubCategory)가
	 * 같은 제품이 FTA_CODE 후보(~25개)마다 FM_LIST 행을 만들어 반복 조회를 유발하므로, determineOrigin()
	 * 1회 호출에 필요한 조합 전체를 한 번에 가져온다 — 전역 캐시가 아니라 이 호출 범위에서만 쓰고 버리는
	 * 사전조회다(OriginDeterminationService#determineOrigin 참고).
	 */
	List<OriginCriteriaBatchResult> selectApplicableOriginCriteriaBatch(@Param("requests") List<OriginCriteriaBatchRequest> requests);
}
