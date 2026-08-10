package com.kpmg.kdb.web.createfcr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.createfcr.dto.BomAvailability;
import com.kpmg.kdb.web.createfcr.dto.BomLeafRow;
import com.kpmg.kdb.web.createfcr.dto.DomesticSalesLine;
import com.kpmg.kdb.web.createfcr.dto.ExportSalesLine;
import com.kpmg.kdb.web.createfcr.dto.FcrDtlInsertRow;
import com.kpmg.kdb.web.createfcr.dto.FcrMstInsertRow;
import com.kpmg.kdb.web.createfcr.dto.FtaMasterActive;
import com.kpmg.kdb.web.createfcr.dto.ProductFcrDtlSourceRow;
import com.kpmg.kdb.web.createfcr.dto.SalesDtlBomTarget;
import com.kpmg.kdb.web.createfcr.dto.SalesInvoiceHeader;

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

	/** "해당 사업장 BOM 존재 확인". 원본 ROWNUM=1(정렬기준 없음)을 FETCH FIRST 1 ROW ONLY 로 이관 */
	BomAvailability selectOwnDivisionBom(@Param("companyCode") String companyCode,
			@Param("prodDivisionCode") String prodDivisionCode, @Param("productCode") String productCode,
			@Param("bomType") String bomType, @Param("bomPreviousYyyymm") String bomPreviousYyyymm,
			@Param("yyyymm") String yyyymm);

	/** "타 플랜트 BOM 체크". 원본 ROWNUM=1(정렬기준 없음)을 FETCH FIRST 1 ROW ONLY 로 이관 */
	BomAvailability selectAnyDivisionBom(@Param("companyCode") String companyCode,
			@Param("productCode") String productCode, @Param("bomType") String bomType,
			@Param("bomPreviousYyyymm") String bomPreviousYyyymm, @Param("yyyymm") String yyyymm);

	void updateSalesDtlBomStatus(@Param("salesNo") String salesNo, @Param("salesSeq") int salesSeq,
			@Param("divisionCode") String divisionCode, @Param("companyCode") String companyCode,
			@Param("productCode") String productCode, @Param("status") String status,
			@Param("bomStatus") String bomStatus, @Param("bomYyyymm") String bomYyyymm,
			@Param("bomDivisionCode") String bomDivisionCode);

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

	/** "3-5. FCR MST UPDATE -- 상품 원산지 판정" */
	void mergeFcrMstOriginDetermination(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("invoiceDate") String invoiceDate);

	/** "3-6. FCR RESULT UPDATE -- 상품 원산지 판정" */
	void insertFcrResultForProducts(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);

	/** "3-7. FCR_MST 의 역내산/역외산 재료비금액 UPDATE" */
	void mergeFcrMstMaterialAmountTotals(@Param("salesNo") String salesNo, @Param("divisionCode") String divisionCode,
			@Param("companyCode") String companyCode, @Param("productCodes") List<String> productCodes);
}
