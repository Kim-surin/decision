package com.kpmg.kdb.web.origindetermination;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindetermination.dto.CompanyDecisionFlags;
import com.kpmg.kdb.web.origindetermination.dto.PendingDomesticGroup;
import com.kpmg.kdb.web.origindetermination.dto.SalesTarget;
import com.kpmg.kdb.web.origindetermination.dto.VirtualSalesGenerationParams;

/** 레거시 MONTHLY_DECISION_PROC 이 사용하는 조회/저장. 오케스트레이션은 {@link MonthlyDecisionService} 참고. */
public interface MonthlyDecisionDao {

	CompanyDecisionFlags selectCompanyDecisionFlags(@Param("companyCode") String companyCode);

	/**
	 * mergeAggregatedSalesMst 가 처리할 (companyCode,divisionCode,customerCode) 그룹 목록을 미리 조회한다
	 * — mergeAggregatedSalesMst 의 WHERE 조건(EXPORT_FLAG='D', VIRTUAL_YN='N', 기간/사업부/고객사/
	 * 배송처 필터)과 GROUP BY 대상을 그대로 SELECT DISTINCT 로 옮긴 것이다
	 * ({@link com.kpmg.kdb.web.origindetermination.DomesticDecisionGroupingService} 참고).
	 */
	List<PendingDomesticGroup> selectPendingDomesticGroups(@Param("p") VirtualSalesGenerationParams params);

	/**
	 * 판정대상 커서(C_SALES_MST, {@link #selectDecisionTargets})의 EXPORT_FLAG='E' 분기만 떼어 미리
	 * 조회한다 — 수출은 가상매출 생성이 필요 없어(이미 실제 SALES_NO 에 TARGET_FTA_CODE 가 세팅돼 있음)
	 * {@link #selectPendingDomesticGroups} 처럼 고객사/사업부 그룹 발견을 거칠 필요가 없다
	 * ({@link com.kpmg.kdb.web.origindetermination.ExportDecisionGroupingService} 참고).
	 */
	List<SalesTarget> selectPendingExportTargets(@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_DTL 삭제 */
	int deleteAggregatedSalesDtl(@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성" 전처리: 기존 가상 SALES_MST 삭제 */
	int deleteAggregatedSalesMst(@Param("p") VirtualSalesGenerationParams params);

	/** "1. 내수 포괄 매출 생성": 고객사/사업부/월 단위로 집계한 가상 SALES_MST 를 MERGE 로 생성 */
	int mergeAggregatedSalesMst(@Param("p") VirtualSalesGenerationParams params);

	/**
	 * "2. 포괄 SALES_DTL 생성": 가상 SALES_MST 에 대응하는 집계 SALES_DTL 을 MERGE 로 생성.
	 * 원본의 ROWNUM 기반 SALES_SEQ 채번(스캔 순서에 의존, DB 이식성 없음)을 ROW_NUMBER() OVER(...)
	 * 기반의 그룹별(CUSTOMER_CODE, DIVISION_CODE) 결정적 채번으로 교체했다(동작 개선 + 이식성 확보,
	 * 사용자 요청에 따라 이 부분은 원본을 그대로 재현하지 않고 의도적으로 고쳤다 — 업무팀 확인 권장).
	 */
	int mergeAggregatedSalesDtl(@Param("p") VirtualSalesGenerationParams params);

	/** "4. 판정대상 커서" (C_SALES_MST) */
	List<SalesTarget> selectDecisionTargets(@Param("p") VirtualSalesGenerationParams params);

	/**
	 * 판정완료 SALES_MST 상태값 갱신. 가상매출(VIRTUAL_YN='Y')이면 무조건 '4', 실제매출(수출 판정대상)이면
	 * FCR_MST/FCR_RESULT 오류 존재 여부에 따라 '4' 또는 '5'. productCodes 가 null/빈 리스트면 salesNo
	 * 전체 제품(월 판정) 대상.
	 */
	void updateSalesMstDecisionComplete(@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

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
