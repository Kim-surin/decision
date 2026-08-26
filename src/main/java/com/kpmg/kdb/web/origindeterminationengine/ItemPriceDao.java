package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.DivisionItemKey;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceTierBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.PoLedgerPriceBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.StandardCostBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.StandardCostRow;

/** 자재 단가 4단계 fallback(수불부→구매단가→표준원가) 조회. 매칭되는 행이 없으면 null을 반환한다. */
public interface ItemPriceDao {

	/** 1~2단계: 자기 사업부 출고실적 우선, 없으면 전체 사업부 최신월 데이터 */
	MaterialBalanceTierRow selectDivisionBalanceForPrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** {@link #selectDivisionBalanceForPrice}의 배치 버전 */
	List<MaterialBalanceTierBatchResult> selectDivisionBalanceForPriceBatch(@Param("companyCode") String companyCode,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm,
			@Param("items") List<DivisionItemKey> items);

	/** 3단계(구매단가) */
	PoLedgerPriceRow selectRecentPurchasePrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMmdd") String fromYyyyMmdd, @Param("toYyyyMmdd") String toYyyyMmdd);

	/** {@link #selectRecentPurchasePrice}의 배치 버전 */
	List<PoLedgerPriceBatchResult> selectRecentPurchasePriceBatch(@Param("companyCode") String companyCode,
			@Param("fromYyyyMmdd") String fromYyyyMmdd, @Param("toYyyyMmdd") String toYyyyMmdd,
			@Param("items") List<DivisionItemKey> items);

	/** 4단계(표준원가, division 필터 있음) */
	StandardCostRow selectStandardCostByDivision(@Param("c") ItemPriceCriteria criteria);

	/** {@link #selectStandardCostByDivision}의 배치 버전 */
	List<StandardCostBatchResult> selectStandardCostByDivisionBatch(@Param("companyCode") String companyCode,
			@Param("baseDate") String baseDate, @Param("items") List<DivisionItemKey> items);

	/** 4단계 최종 fallback(표준원가, division 필터 없음) */
	StandardCostRow selectStandardCostAnyDivision(@Param("c") ItemPriceCriteria criteria);
}
