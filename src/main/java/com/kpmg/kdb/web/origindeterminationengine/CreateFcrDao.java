package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.BomAvailabilityBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.BomAvailabilityRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.BomLeafRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.DomesticSalesLine;
import com.kpmg.kdb.web.origindeterminationengine.dto.ExportSalesLine;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrDtlInsertRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrMstInsertRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.FtaMasterActive;
import com.kpmg.kdb.web.origindeterminationengine.dto.ProductFcrDtlSourceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesDtlBomStatusUpdateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesDtlBomTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesInvoiceHeader;

/** 레거시 CREATE_FCR 프로시저가 사용하는 조회/저장. 실제 오케스트레이션은 {@link CreateFcrService} 참고. */
public interface CreateFcrDao {

	/** "1. 파라미터 셋업 작업" */
	SalesInvoiceHeader selectSalesInvoiceHeader(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo);

	/** P_BOM_TYPE='X' 정산작업 시 중간재 적용판정 여부(IM_APPLY_YN='MF') 확인 */
	long countIntermediateApplyFcrMst(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo);

	/**
	 * 레거시 CURSOR C_SALES_DTL. productCodes 가 null/빈 리스트면 salesNo 전체 제품(월 판정),
	 * 값이 있으면 그 제품들만(개별 판정) 대상으로 한다.
	 */
	List<SalesDtlBomTarget> selectSalesDtlBomTargets(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

	/**
	 * "해당 사업장 BOM 존재 확인"(own) / "타 플랜트 BOM 체크"(any) 를 (사업장,제품) 조합별로 한 번에
	 * 배치 조회한다 — 원본은 이 두 조회(+updateSalesDtlBomStatus)를 C_SALES_DTL 커서 행마다(제품 수만큼)
	 * 반복했으나, LATERAL 조인으로 대상 조합 전체를 한 번의 왕복으로 처리한다. own/any 각각 원본과 동일
	 * 하게 ROWNUM=1(정렬기준 없음)을 FETCH FIRST 1 ROW ONLY 로 이관.
	 */
	List<BomAvailabilityBatchResult> selectBomAvailabilityBatch(@Param("companyCode") String companyCode,
			@Param("bomType") String bomType, @Param("bomPreviousYyyymm") String bomPreviousYyyymm,
			@Param("yyyymm") String yyyymm, @Param("requests") List<BomAvailabilityRequest> requests);

	/** updateSalesDtlBomStatus 배치 버전: C_SALES_DTL 커서 대상 전체(SALES_SEQ 단위)를 한 번에 UPDATE */
	void updateSalesDtlBomStatusBatch(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("rows") List<SalesDtlBomStatusUpdateRow> rows);

	/** "3-1. 전 처리 작업": FCR_DTL/FCR_RESULT/FCR_MST 중 이번 호출 대상 제품(SALES_DTL) 초기화 */
	int deleteFcrDtl(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);

	int deleteFcrResult(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);

	int deleteFcrMst(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);

	/** "3-2. FCR_MST 데이터 생성" 내수(EXPORT_FLAG='D') 원시 데이터 */
	List<DomesticSalesLine> selectDomesticSalesLines(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

	/** 내수 분기에서 SALES 와 교차조인되는 활성 FTA_MASTER(DELETE_YN='N') 목록 */
	List<FtaMasterActive> selectActiveFtaMasters(@Param("companyCode") String companyCode);

	/** "3-2. FCR_MST 데이터 생성" 수출 원시 데이터(FTA_APPLY_NATION/FTA_MASTER 매칭 결과 포함) */
	List<ExportSalesLine> selectExportSalesLines(@Param("companyCode") String companyCode,
			@Param("divisionCode") String divisionCode, @Param("salesNo") String salesNo,
			@Param("productCodes") List<String> productCodes);

	/** HS코드/인코텀즈 환산이 끝난 FCR_MST 행을 청크 단위로 일괄 INSERT */
	void insertFcrMstRows(@Param("rows") List<FcrMstInsertRow> rows);

	/** "3-3. 제품 BOM 소요량" 원시 leaf 자재 목록(단가/원산지비율 계산 전) */
	List<BomLeafRow> selectBomLeafRows(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("bomType") String bomType,
			@Param("productCodes") List<String> productCodes);

	/** "3-4. 상품/부산물 FCR_DTL" 원시 목록(원산지비율 계산 전) */
	List<ProductFcrDtlSourceRow> selectProductFcrDtlSourceRows(@Param("salesNo") String salesNo,
			@Param("divisionCode") String divisionCode, @Param("companyCode") String companyCode,
			@Param("productCodes") List<String> productCodes);

	/** 계산이 끝난 FCR_DTL 행을 청크 단위로 일괄 INSERT (3-3, 3-4 공용) */
	void insertFcrDtlRows(@Param("rows") List<FcrDtlInsertRow> rows);

	/**
	 * "3-7. FCR_MST 의 역내산/역외산 재료비금액 UPDATE". 상품(M,R,B) 원산지 판정(과거 3-5/3-6 단계)은
	 * {@link com.kpmg.kdb.web.origindeterminationengine.CommodityOriginDeterminationDao} 로 옮겨
	 * {@link com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationExecutionService#determineOrigin} 에서 수행한다
	 * — CREATE_FCR 은 FCR_MST/FCR_DTL 데이터 생성까지만 담당한다.
	 */
	void mergeFcrMstMaterialAmountTotals(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);
}
