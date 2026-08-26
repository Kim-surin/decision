package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * "상품"(PRODUCT_ASSETS_TYPE IN ('M','R','B')) 원산지판정 전용 조회/저장. "제품"(P,H)은
 * {@link OriginDeterminationCursorDao} 의 FM_LIST/FR_LIST 커서를 순회하며 예외판정/세번변경기준/
 * 부가가치기준 규칙을 하나씩 적용하는 반면, 상품은 그보다 단순한 집합 연산(구매처 원산지확인서와
 * FTA_RULE 조회 결과를 FCR_MST 에 반영 -&gt; FCR_RESULT 기록)으로 판정한다.
 *
 * <p>레거시에서는 이 로직이 CREATE_FCR 프로시저 안(3-5/3-6단계)에 있었으나, "판정" 관련 로직을 전부
 * {@link OriginDeterminationExecutionService#determineOrigin} 에 모으기 위해 옮겨왔다. CREATE_FCR
 * ({@link com.kpmg.kdb.web.origindeterminationengine.CreateFcrService})은 이제 FCR_MST/FCR_DTL 데이터 생성까지만
 * 담당한다.
 */
public interface CommodityOriginDeterminationDao {

	/** 구매처 원산지확인서(EXT_COO_CERTIFY_*)/FTA_RULE 조회 결과로 FCR_MST.FTA_COO_YN/COMPANY_COO_YN/RULE_CONTENTS 갱신 */
	void mergeFcrMstOriginDetermination(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("invoiceDate") String invoiceDate,
			@Param("productCodes") List<String> productCodes);

	/** 위에서 갱신된 FCR_MST 를 바탕으로 FCR_RESULT(판정결과) 기록 */
	void insertFcrResultForProducts(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes,
			@Param("createBy") String createBy);
}
