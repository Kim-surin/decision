package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceRow;
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
}
