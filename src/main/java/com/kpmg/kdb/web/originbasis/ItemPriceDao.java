package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.originbasis.dto.StandardCostRow;

public interface ItemPriceDao {

	/** 1단계(자기 PLANT) - FC10_GET_ITEM_PRICE 용. MAX(YYYYMM) 조건 = 출고수량 기준 */
	List<MaterialBalanceTierRow> selectOwnDivisionBalanceForPrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** 2단계(타 PLANT) - FC10_GET_ITEM_PRICE 용 */
	List<MaterialBalanceTierRow> selectOtherDivisionBalanceForPrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** 1단계(자기 PLANT) - FC10_GET_ITEM_PRICE_NOTE 용. MAX(YYYYMM) 조건 = 출고+재고수량 기준(원본 그대로) */
	List<MaterialBalanceTierRow> selectOwnDivisionBalanceForNote(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** 2단계(타 PLANT) - FC10_GET_ITEM_PRICE_NOTE 용 */
	List<MaterialBalanceTierRow> selectOtherDivisionBalanceForNote(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/** 3단계(구매단가) - 두 함수 공용 */
	List<PoLedgerPriceRow> selectRecentPurchasePrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMmdd") String fromYyyyMmdd, @Param("toYyyyMmdd") String toYyyyMmdd);

	/** 4단계(표준원가, division 필터 있음) - 두 함수 공용 */
	List<StandardCostRow> selectStandardCostByDivision(@Param("c") ItemPriceCriteria criteria);

	/** 4단계 최종 fallback(표준원가, division 필터 없음) - FC10_GET_ITEM_PRICE 전용(원본에만 존재) */
	List<StandardCostRow> selectStandardCostAnyDivision(@Param("c") ItemPriceCriteria criteria);
}
