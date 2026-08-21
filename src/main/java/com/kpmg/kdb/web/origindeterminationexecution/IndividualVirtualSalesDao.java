package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationexecution.dto.VirtualSalesGenerationParams;

/**
 * 개별 판정(API 호출) 전용 가상매출 생성 쿼리. 월 판정(MONTHLY_DECISION_PROC, {@link
 * com.kpmg.kdb.web.origindeterminationexecution.MonthlyDecisionDao})은 회사/사업부/기간 범위의 실매출을 고객사
 * 단위로 GROUP BY 집계해 가상매출을 만드는 반면, 개별 판정은 이미 알고 있는 실제 매출건
 * 1건({@code sourceSalesNo})의 헤더를 그대로 복사하고, 요청받은 제품(productCode) 단위로 가상
 * SALES_DTL 을 만든다는 점에서 로직이 다르다 — 그래서 별도 DAO/매퍼로 분리했다.
 */
public interface IndividualVirtualSalesDao {

	/**
	 * "2. SALES_MST 가상 매출 생성": {@code p.sourceSalesNo} 1건의 헤더(거래처/생산자/INKOTERMS 등)를
	 * 그대로 복사해 가상 SALES_MST({@code virtualSalesNo})를 MERGE 로 생성한다.
	 */
	int mergeIndividualSalesMst(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/**
	 * "3. SALES_DTL 가상 매출 생성": {@code productCodes} 전체에 대해 요청 기간(p.yyyymm) 동안의 실매출을
	 * 집계해 가상 SALES_DTL 을 한 번의 MERGE 로 생성한다(배치화 — 원본은 제품마다 별개의 MERGE 문을
	 * 반복 실행했으나, GROUP BY 에 PRODUCT_CODE 가 포함돼 있어 여러 제품을 한 번에 넘겨도 상품별 집계
	 * 결과와 SALES_SEQ 채번 방식은 동일하다).
	 */
	int mergeIndividualSalesDtl(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params, @Param("productCodes") List<String> productCodes);
}
