package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRowBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRowsRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginCriteriaBatchRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginCriteriaBatchResult;

/**
 * 제품(P,H) 원산지판정 전용 조회: FTA 후보(FCR_MST)/룰(FTA_RULE)/자재원산지(FCR_DTL). "상품"(M,R,B)은
 * {@link CommodityOriginDeterminationDao} 참고. 오케스트레이션은 {@link OriginDeterminationExecutionService} 참고.
 */
public interface ProductOriginDeterminationDao {

	/**
	 * 판정대상 매출(SALES_NO) 1건에 존재하는 FTA_CODE 후보 전체를 조회한다. productCodes가 null/빈 리스트면
	 * salesNo 전체 제품(월 판정), 값이 있으면 그 제품들만(개별 판정) 대상으로 한다.
	 */
	List<OriginDeterminationTarget> selectOriginDeterminationTargets(@Param("companyCode") String companyCode,
			@Param("salesNo") String salesNo, @Param("productCodes") List<String> productCodes);

	/** FCR_DTL의 자재원산지 정보 조회. FTA 후보 1건당 1회 조회해 메모리에 적재한 뒤 판정 로직은 스트림으로 처리한다. */
	List<MaterialOriginRow> selectMaterialOriginRows(@Param("ftaCode") String ftaCode, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("salesNo") String salesNo,
			@Param("salesSeq") int salesSeq, @Param("parentHsCode") String parentHsCode);

	/** {@link #selectMaterialOriginRows}의 배치 버전. 매칭되는 자재가 없으면 결과에 나타나지 않는다(빈 리스트와 동일). */
	List<MaterialOriginRowBatchResult> selectMaterialOriginRowsBatch(@Param("companyCode") String companyCode,
			@Param("salesNo") String salesNo, @Param("requests") List<MaterialOriginRowsRequest> requests);

	/** CTSH&gt;CTH&gt;CC 순으로 가장 긴 HS_CODE 접두어가 일치하는 적용 룰을 조회한다. */
	List<OriginCriteria> selectApplicableOriginCriteria(@Param("hsCode") String hsCode, @Param("ftaCode") String ftaCode,
			@Param("hsCodeSubCategory") String hsCodeSubCategory, @Param("newAptaPsrFlag") String newAptaPsrFlag);

	/** {@link #selectApplicableOriginCriteria}의 배치 버전. */
	List<OriginCriteriaBatchResult> selectApplicableOriginCriteriaBatch(@Param("requests") List<OriginCriteriaBatchRequest> requests);
}
