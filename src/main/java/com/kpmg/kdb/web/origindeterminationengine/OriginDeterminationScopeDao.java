package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * 상품(M,R,B)/제품(P,H) 판정 분기를 정하기 전에 공용으로 조회하는 정보(매출일자, 판정대상 asset type
 * 목록). {@link OriginDeterminationExecutionService#determineOrigin} 이 사용한다.
 */
public interface OriginDeterminationScopeDao {

	/** SALES_MST.INVOICE_DATE 조회 (APTA 신규 PSR 적용여부 판단 기준일) */
	String selectInvoiceDate(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo);

	/** 판정대상 스코프(FCR_MST)에 실제로 존재하는 PRODUCT_ASSETS_TYPE 목록. 제품(P,H)/상품(M,R,B) 판정 분기용. */
	List<String> selectDistinctProductAssetsTypes(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);
}
