package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * "상품"(PRODUCT_ASSETS_TYPE IN ('M','R','B')) 원산지판정 전용 조회/저장. "제품"(P,H)은
 * {@link ProductOriginDeterminationDao} 의 FM_LIST/FR_LIST 커서로 예외판정/세번변경기준/부가가치기준을
 * 하나씩 적용하지만, 상품은 구매처 원산지확인서와 FTA_RULE 조회 결과를 FCR_MST 에 반영 후 FCR_RESULT
 * 를 기록하는 단순 집합 연산으로 판정한다.
 */
public interface CommodityOriginDeterminationDao {

	/** 구매처 원산지확인서(EXT_COO_CERTIFY_*)/FTA_RULE 조회 결과로 FCR_MST.FTA_COO_YN/COMPANY_COO_YN/RULE_CONTENTS 갱신 */
	void mergeFcrMstOriginDetermination(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("invoiceDate") String invoiceDate,
			@Param("productCodes") List<String> productCodes);

	/** 위에서 갱신된 FCR_MST 를 바탕으로 FCR_RESULT(판정결과) 기록 */
	void insertFcrResultForCommodities(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes,
			@Param("createBy") String createBy);
}
