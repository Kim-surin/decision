package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceRow;
import com.kpmg.kdb.web.originbasis.dto.NonCertifiedOriginSummaryRequest;
import com.kpmg.kdb.web.originbasis.dto.NonCertifiedOriginSummaryResult;
import com.kpmg.kdb.web.originbasis.dto.PurchaseLedgerSummary;

public interface ItemOriginRateDao {

	/** 원본 C_MAT 커서(BOM 원재료 + 대체자재 수불부 기초정보)를 한 번의 쿼리로 조회 */
	List<MaterialBalanceRow> selectMaterialCandidates(@Param("c") ItemOriginRateCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** 대상 품목의 최근 입고월(INPUT_QTY > 0) 조회 */
	String selectLastInputYyyyMm(@Param("companyCode") String companyCode, @Param("divisionCode") String divisionCode,
			@Param("itemCode") String itemCode, @Param("uptoYyyyMm") String uptoYyyyMm);

	/** 구매원장 건수/입고금액 합계(원산지확인서 여부 무관) */
	PurchaseLedgerSummary selectPurchaseLedgerSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	/** 역내산 확인서 미수취(또는 역외산) 구매 건수/입고금액 합계 */
	PurchaseLedgerSummary selectNonCertifiedOriginSummary(@Param("companyCode") String companyCode,
			@Param("itemCode") String itemCode, @Param("ftaCode") String ftaCode, @Param("fromDate") String fromDate,
			@Param("toDate") String toDate);

	/**
	 * {@link #selectNonCertifiedOriginSummary} 를 (itemCode,ftaCode,fromDate,toDate) 조합별로 반복 호출하는
	 * 대신 한 번에 조회하는 배치 버전. CreateFcrService 의 BOM 리프 자재 루프(자재 수 × FTA_CODE 후보 수만큼
	 * 반복 호출되던 지점)에서 사용한다 — {@link com.kpmg.kdb.web.originbasis.ItemOriginRateService#prefetchNonCertifiedOriginSummaries}
	 * 참고. 요청 목록에 없는 조합은 결과에 없다(호출자가 필요분만 넘긴다는 전제).
	 */
	List<NonCertifiedOriginSummaryResult> selectNonCertifiedOriginSummaryBatch(@Param("companyCode") String companyCode,
			@Param("requests") List<NonCertifiedOriginSummaryRequest> requests);
}
