package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.originbasis.dto.DivisionItemKey;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierBatchResult;
import com.kpmg.kdb.web.originbasis.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceBatchResult;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.originbasis.dto.StandardCostBatchResult;
import com.kpmg.kdb.web.originbasis.dto.StandardCostRow;

/**
 * 각 조회는 FETCH FIRST 1 ROW ONLY 로 DB에서 최대 1건만 잘라 전송하도록 매핑되어 있다.
 * 매칭되는 행이 없으면 null 을 반환한다(MyBatis가 0건일 때 null 매핑).
 */
public interface ItemPriceDao {

	/**
	 * 1~2단계(자기 PLANT 우선, 없으면 전체 PLANT) - FC10_GET_ITEM_PRICE 용. 자기 사업부에 조회기간 내
	 * 출고실적(MAX YYYYMM 조건 = 출고수량 기준)이 있으면 그 사업부 데이터를, 없으면 전체 사업부를
	 * 통틀은 최신월 데이터를 1건 반환한다(원래 별도 쿼리였던 1단계/2단계를 단일 쿼리로 통합 —
	 * ItemPriceDaoMapper.xml 의 selectDivisionBalanceForPrice 주석 참고).
	 */
	MaterialBalanceTierRow selectDivisionBalanceForPrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm);

	/**
	 * {@link #selectDivisionBalanceForPrice} 의 배치 버전. companyCode/조회기간은 이 호출 범위(createFcr()
	 * 1회 호출, 단일 salesNo)에서 항상 같은 값이라 (divisionCode,itemCode) 조합만 배치로 받는다. 매칭되는
	 * MATERIAL_INV_BAL 행이 없는 조합도 결과에 포함되며(LEFT JOIN LATERAL), 그 경우 yyyymm 등이 null 이다
	 * — {@link MaterialBalanceTierBatchResult#toRowOrNull()} 참고.
	 */
	List<MaterialBalanceTierBatchResult> selectDivisionBalanceForPriceBatch(@Param("companyCode") String companyCode,
			@Param("fromYyyyMm") String fromYyyyMm, @Param("toYyyyMm") String toYyyyMm,
			@Param("items") List<DivisionItemKey> items);

	/** 3단계(구매단가) - 두 함수 공용 */
	PoLedgerPriceRow selectRecentPurchasePrice(@Param("c") ItemPriceCriteria criteria,
			@Param("fromYyyyMmdd") String fromYyyyMmdd, @Param("toYyyyMmdd") String toYyyyMmdd);

	/**
	 * {@link #selectRecentPurchasePrice} 의 배치 버전. companyCode/조회기간은 이 호출 범위(createFcr()
	 * 1회 호출, 단일 salesNo)에서 항상 같은 값이라 (divisionCode,itemCode) 조합만 배치로 받는다.
	 * 매칭되는 PO_LEDGER 행이 없는 조합도 결과에 포함되며(LEFT JOIN LATERAL), 그 경우 unitPrice 등이
	 * null 이다 — {@link PoLedgerPriceBatchResult#toRowOrNull()} 참고.
	 */
	List<PoLedgerPriceBatchResult> selectRecentPurchasePriceBatch(@Param("companyCode") String companyCode,
			@Param("fromYyyyMmdd") String fromYyyyMmdd, @Param("toYyyyMmdd") String toYyyyMmdd,
			@Param("items") List<DivisionItemKey> items);

	/** 4단계(표준원가, division 필터 있음) - 두 함수 공용 */
	StandardCostRow selectStandardCostByDivision(@Param("c") ItemPriceCriteria criteria);

	/**
	 * {@link #selectStandardCostByDivision} 의 배치 버전. companyCode/기준일자는 이 호출 범위(createFcr()
	 * 1회 호출, 단일 salesNo)에서 항상 같은 값이라 (divisionCode,itemCode) 조합만 배치로 받는다. 매칭되는
	 * STANDARD_COST 행이 없는 조합도 결과에 포함되며(LEFT JOIN LATERAL), 그 경우 standardCostAmount 등이
	 * null 이다 — {@link StandardCostBatchResult#toRowOrNull()} 참고.
	 */
	List<StandardCostBatchResult> selectStandardCostByDivisionBatch(@Param("companyCode") String companyCode,
			@Param("baseDate") String baseDate, @Param("items") List<DivisionItemKey> items);

	/** 4단계 최종 fallback(표준원가, division 필터 없음) - FC10_GET_ITEM_PRICE 전용(원본에만 존재) */
	StandardCostRow selectStandardCostAnyDivision(@Param("c") ItemPriceCriteria criteria);
}
