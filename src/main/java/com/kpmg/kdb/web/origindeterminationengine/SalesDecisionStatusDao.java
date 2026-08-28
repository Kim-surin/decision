package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * 판정완료 SALES_MST/SALES_DTL/FCR_MST 상태값 갱신. 내수(가상 SALES_NO)/수출(실제 SALES_NO) 구분 없이
 * 공용으로 쓰인다. {@link SalesDecisionStatusUpdater} 가 사용한다.
 */
public interface SalesDecisionStatusDao {

	/**
	 * 판정완료 SALES_MST 상태값 갱신. 가상매출(VIRTUAL_YN='Y')이면 무조건 '4', 실제매출(수출 판정대상)이면
	 * FCR_MST/FCR_RESULT 오류 존재 여부에 따라 '4' 또는 '5'. productCodes 가 null/빈 리스트면 salesNo
	 * 전체 제품(월 판정) 대상.
	 */
	void updateSalesMstDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode, @Param("productCodes") List<String> productCodes);

	/**
	 * 판정완료 SALES_DTL 상태값 갱신(FCR_MST/FCR_RESULT 오류 존재 여부에 따라 '4' 또는 '5').
	 * productCodes 가 null/빈 리스트면 salesNo 전체 제품(월 판정) 대상. DIVISION_CODE 조건이 필요한
	 * 이유는 {@link #updateSalesMstDecisionComplete} 참고.
	 */
	void updateSalesDtlDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode, @Param("productCodes") List<String> productCodes);

	/** 판정완료 FCR_MST 상태값 갱신(COO_DATE=NOW). DIVISION_CODE 조건이 필요한 이유는 {@link #updateSalesMstDecisionComplete} 참고. */
	void updateFcrMstDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode, @Param("productCodes") List<String> productCodes);

	/**
	 * 판정 처리 중 예외가 발생한 대상을 판정실패('5')로 표시한다. updateSalesMstDecisionComplete/
	 * updateSalesDtlDecisionComplete 처럼 FCR_MST/FCR_RESULT 내용을 보고 '4'/'5'를 가리지 않고
	 * 무조건 '5' — 예외가 난 시점엔 FCR_RESULT/FCR_MST 데이터가 없거나 불완전할 수 있어 그 내용을
	 * 신뢰할 수 없기 때문이다. DIVISION_CODE 조건이 필요한 이유는 {@link #updateSalesMstDecisionComplete} 참고.
	 */
	void markSalesMstDecisionFailed(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode);

	/** {@link #markSalesMstDecisionFailed} 의 SALES_DTL 버전. */
	void markSalesDtlDecisionFailed(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode, @Param("productCodes") List<String> productCodes);
}
