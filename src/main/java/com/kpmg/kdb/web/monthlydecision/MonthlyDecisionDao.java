package com.kpmg.kdb.web.monthlydecision;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.monthlydecision.dto.CompanyDecisionFlags;
import com.kpmg.kdb.web.monthlydecision.dto.MonthlyDecisionParams;
import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;

/** 레거시 MONTHLY_DECISION_PROC 이 사용하는 조회/저장. 오케스트레이션은 {@link MonthlyDecisionService} 참고. */
public interface MonthlyDecisionDao {

	CompanyDecisionFlags selectCompanyDecisionFlags(@Param("companyCode") String companyCode);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_DTL 삭제 */
	int deleteAggregatedSalesDtl(@Param("p") MonthlyDecisionParams params);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_MST 삭제 */
	int deleteAggregatedSalesMst(@Param("p") MonthlyDecisionParams params);

	/** "1. 내수 포괄 매출 생성": 고객사/사업부/월 단위로 집계한 가상 SALES_MST 를 MERGE 로 생성 */
	int mergeAggregatedSalesMst(@Param("p") MonthlyDecisionParams params);

	/**
	 * "2. 포괄 SALES_DTL 생성": 가상 SALES_MST 에 대응하는 집계 SALES_DTL 을 MERGE 로 생성.
	 * 원본의 ROWNUM 기반 SALES_SEQ 채번(스캔 순서에 의존, DB 이식성 없음)을 ROW_NUMBER() OVER(...)
	 * 기반의 그룹별(CUSTOMER_CODE, DIVISION_CODE) 결정적 채번으로 교체했다(동작 개선 + 이식성 확보,
	 * 사용자 요청에 따라 이 부분은 원본을 그대로 재현하지 않고 의도적으로 고쳤다 — 업무팀 확인 권장).
	 */
	int mergeAggregatedSalesDtl(@Param("p") MonthlyDecisionParams params);

	/** "4. 판정대상 커서" (C_SALES_MST) */
	List<SalesTarget> selectDecisionTargets(@Param("p") MonthlyDecisionParams params);

	/** 판정완료 SALES_MST 상태값 갱신(STATUS='4', COO_DATE=NOW) */
	void updateSalesMstDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo);

	/**
	 * 판정완료 SALES_DTL 상태값 갱신(FCR_MST/FCR_RESULT 오류 존재 여부에 따라 '4' 또는 '5').
	 * productCodes 가 null/빈 리스트면 salesNo 전체 제품(월 판정) 대상.
	 */
	void updateSalesDtlDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

	/** 판정완료 FCR_MST 상태값 갱신(COO_DATE=NOW) */
	void updateFcrMstDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);
}
