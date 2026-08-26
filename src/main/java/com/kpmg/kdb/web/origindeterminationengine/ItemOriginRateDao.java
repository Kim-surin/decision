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

	/** 원본 C_MAT 커서(BOM 원재료 + 대체자재 수불부 기초정보)를 한 번의 쿼리로 조회 */
	List<MaterialBalanceRow> selectMaterialCandidates(@Param("c") ItemOriginRateCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/**
	 * {@link #selectMaterialCandidates} 를 (divisionCode,itemCode,조회구간) 조합별로 반복 호출하는 대신 한 번에
	 * 조회하는 배치 버전. {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#prefetchMaterialCandidates}
	 * 참고. 요청 1건당 결과가 0~N 행(BOM 자재 0/1건 + 대체자재 0..N건)이라 요청 목록에 있어도 매칭되는 자재가
	 * 없으면 결과에 아예 나타나지 않는다(단건 조회가 빈 리스트를 반환하던 것과 동일).
	 */
	List<MaterialCandidatesBatchResult> selectMaterialCandidatesBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<MaterialCandidatesRequest> requests);

	/** 대상 품목의 최근 입고월(INPUT_QTY > 0) 조회 */
	String selectLastInputYyyyMm(@Param("companyCode") String companyCode, @Param("divisionCode") String divisionCode,
			@Param("itemCode") String itemCode, @Param("uptoYyyyMm") String uptoYyyyMm);

	/**
	 * {@link #selectLastInputYyyyMm} 의 배치 버전. companyCode/uptoYyyyMm 는 호출 범위(같은 salesNo 의
	 * createFcr()/determineOrigin() 1회 호출) 안에서 항상 고정값이라 단일 파라미터로 받고,
	 * (divisionCode,itemCode) 조합만 배치로 받는다. 매칭되는 자재 원장이 없는 조합은 결과에 아예
	 * 나타나지 않는다(단건 조회의 MAX(...)=NULL 1행과 동등 — 호출자가 Map 조회 결과 null 로 처리).
	 */
	List<LastInputYyyyMmResult> selectLastInputYyyyMmBatch(@Param("companyCode") String companyCode,
			@Param("uptoYyyyMm") String uptoYyyyMm, @Param("items") List<DivisionItemKey> items);

	/** 구매원장 건수/입고금액 합계(원산지확인서 여부 무관) */
	PurchaseLedgerSummary selectPurchaseLedgerSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	/**
	 * {@link #selectPurchaseLedgerSummary} 를 (itemCode,fromDate,toDate) 조합별로 반복 호출하는 대신 한 번에
	 * 조회하는 배치 버전. {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#prefetchPurchaseLedgerSummaries}
	 * 참고. 요청 목록에 없는 조합은 결과에 없다(호출자가 필요분만 넘긴다는 전제).
	 */
	List<PurchaseLedgerSummaryBatchResult> selectPurchaseLedgerSummaryBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<PurchaseLedgerSummaryRequest> requests);

	/** 역내산 확인서 미수취(또는 역외산) 구매 건수/입고금액 합계 */
	PurchaseLedgerSummary selectNonCertifiedOriginSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("ftaCode") String ftaCode, @Param("fromDate") String fromDate,
			@Param("toDate") String toDate);

	/**
	 * {@link #selectNonCertifiedOriginSummary} 를 (itemCode,ftaCode,fromDate,toDate) 조합별로 반복 호출하는
	 * 대신 한 번에 조회하는 배치 버전. CreateFcrService 의 BOM 리프 자재 루프(자재 수 × FTA_CODE 후보 수만큼
	 * 반복 호출되던 지점)에서 사용한다 — {@link com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService#prefetchNonCertifiedOriginSummaries}
	 * 참고. 요청 목록에 없는 조합은 결과에 없다(호출자가 필요분만 넘긴다는 전제).
	 */
	List<NonCertifiedOriginSummaryResult> selectNonCertifiedOriginSummaryBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<NonCertifiedOriginSummaryRequest> requests);
}
