package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.originbasis.dto.CooNationBatchResult;
import com.kpmg.kdb.web.originbasis.dto.CooNationLookupRequest;

/**
 * 레거시 FC01_GET_ITEM_NATION 이 사용하는 조회 중, {@link ItemOriginRateDao}(FC10_GET_ITEM_ORIGIN_RATE)와
 * 공유하지 않는 부분(구매원장/원산지확인서로부터 COO_NATION 산정)만 담당한다. C_MAT 커서 및 최근 입고월
 * 조회는 두 함수가 완전히 동일한 SQL 을 사용하므로 {@link ItemOriginRateDao#selectMaterialCandidates}
 * / {@link ItemOriginRateDao#selectLastInputYyyyMm} 를 그대로 재사용한다({@link ItemNationService} 참고).
 */
public interface ItemNationDao {

	/**
	 * 원본 SELECT CASE WHEN COUNT(*)&gt;1 THEN 'TT' ELSE MAX(COO_NATION) END 이관.
	 * 동일 품목에 다중 벤더/원산지 조합이 존재하면 'TT'(다중소싱), 아니면 유일한 COO_NATION 값을 반환한다.
	 */
	String selectCooNation(@Param("companyCode") String companyCode, @Param("itemCode") String itemCode,
			@Param("hsCode") String hsCode, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	/**
	 * {@link #selectCooNation} 의 배치 버전. 요청마다 조회구간(fromDate/toDate)이 다를 수 있어(자재별
	 * 수불부 데이터 기준으로 호출측이 순수 Java 로 미리 계산) (companyCode,itemCode,hsCode,fromDate,toDate)
	 * 전체 조합을 요청 1건씩 받는다. COUNT/MAX 집계라 요청마다 항상 정확히 1행이 나온다(원본과 동일하게
	 * cooNation 이 null 이어도 그 자체가 유효한 "결과 없음" 값 — {@link CooNationBatchResult} 참고).
	 */
	List<CooNationBatchResult> selectCooNationBatch(@Param("requests") List<CooNationLookupRequest> requests);
}
