package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 개별 판정 전용 가상매출 생성. 월 판정({@link AggregatedVirtualSalesDao})은 회사/사업부/기간 범위의
 * 실매출을 고객사 단위로 집계하지만, 개별 판정은 실제 매출 1건({@code sourceSalesNo})의 헤더를 그대로
 * 복사하고 요청받은 제품 단위로만 가상 SALES_DTL을 만든다.
 */
public interface IndividualVirtualSalesDao {

	/** sourceSalesNo 1건의 헤더(거래처/생산자/INKOTERMS 등)를 복사해 가상 SALES_MST를 MERGE로 생성 */
	int mergeIndividualSalesMst(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params);

	/** productCodes 전체에 대해 요청 기간의 실매출을 집계해 가상 SALES_DTL을 한 번의 MERGE로 생성 */
	int mergeIndividualSalesDtl(@Param("virtualSalesNo") String virtualSalesNo,
			@Param("p") VirtualSalesGenerationParams params, @Param("productCodes") List<String> productCodes);
}
