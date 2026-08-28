package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.DivisionItemKey;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.LastInputYyyyMmResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialCandidatesBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialCandidatesRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.NonCertifiedOriginSummaryRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.NonCertifiedOriginSummaryResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummary;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummaryBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummaryRequest;

public interface ItemOriginRateDao {

	/** BOM 원재료 + 대체(FUNGIBLE) 자재의 수불부 기초정보 조회 */
	List<MaterialBalanceRow> selectMaterialCandidates(@Param("c") ItemOriginRateCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** {@link #selectMaterialCandidates}의 배치 버전. 매칭 자재가 없으면 결과에 나타나지 않는다. */
	List<MaterialCandidatesBatchResult> selectMaterialCandidatesBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<MaterialCandidatesRequest> requests);

	/** 대상 품목의 최근 입고월(INPUT_QTY > 0) 조회 */
	String selectLastInputYyyyMm(@Param("companyCode") String companyCode, @Param("divisionCode") String divisionCode,
			@Param("itemCode") String itemCode, @Param("uptoYyyyMm") String uptoYyyyMm);

	/** {@link #selectLastInputYyyyMm}의 배치 버전 */
	List<LastInputYyyyMmResult> selectLastInputYyyyMmBatch(@Param("companyCode") String companyCode,
			@Param("uptoYyyyMm") String uptoYyyyMm, @Param("items") List<DivisionItemKey> items);

	/** 구매원장 건수/입고금액 합계(원산지확인서 여부 무관) */
	PurchaseLedgerSummary selectPurchaseLedgerSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	/** {@link #selectPurchaseLedgerSummary}의 배치 버전 */
	List<PurchaseLedgerSummaryBatchResult> selectPurchaseLedgerSummaryBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<PurchaseLedgerSummaryRequest> requests);

	/** 역내산 확인서 미수취(또는 역외산) 구매 건수/입고금액 합계 */
	PurchaseLedgerSummary selectNonCertifiedOriginSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("ftaCode") String ftaCode, @Param("fromDate") String fromDate,
			@Param("toDate") String toDate);

	/** {@link #selectNonCertifiedOriginSummary}의 배치 버전 */
	List<NonCertifiedOriginSummaryResult> selectNonCertifiedOriginSummaryBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<NonCertifiedOriginSummaryRequest> requests);
}
