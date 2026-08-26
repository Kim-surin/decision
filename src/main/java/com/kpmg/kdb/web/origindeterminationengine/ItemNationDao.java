package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.CooNationBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.CooNationLookupRequest;

/** 구매원장/원산지확인서로 자재의 원산지국(COO_NATION)을 산정한다. */
public interface ItemNationDao {

	/** 동일 품목에 다중 벤더/원산지 조합이 존재하면 'TT'(다중소싱), 아니면 유일한 COO_NATION 값을 반환한다. */
	String selectCooNation(@Param("companyCode") String companyCode, @Param("itemCode") String itemCode,
			@Param("hsCode") String hsCode, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	/** {@link #selectCooNation}의 배치 버전 */
	List<CooNationBatchResult> selectCooNationBatch(@Param("requests") List<CooNationLookupRequest> requests);
}
