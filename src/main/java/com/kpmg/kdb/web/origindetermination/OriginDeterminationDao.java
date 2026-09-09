package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

public interface OriginDeterminationDao {
	public List<Map<String, Object>> retrieveDomesticOriginDetermination(Map param);
	public List<Map<String, Object>> retrieveExportOriginDetermination(Map param);
	public List<Map<String, Object>> retrieveOriginDeterminationResult(Map param);
	public List<Map<String, Object>> retrieveOriginDeterminationDetailList(Map param);
	// 판정완료 건의 판정결과(협정별) 목록
	public List<Map<String, Object>> retrieveOriginDeterminationDetailResultList(Map param);
	// 판정결과(FTA_CODE)별 판정 상세내용(기준별) 전체 목록 - 프론트에서 fta_code로 매핑해 사용
	public List<Map<String, Object>> retrieveOriginDeterminationDetailResultDetailList(Map param);
	// 판정실패 건의 실패 사유(FCR_RESULT.STATUS='E'인 협정/룰) 목록
	public List<Map<String, Object>> retrieveOriginDeterminationFailReasonList(Map param);
	// 실패 사유(FTA_CODE)별로 그 협정에 걸린 룰 전체의 처리결과 - 프론트에서 fta_code로 매핑해 사용
	public List<Map<String, Object>> retrieveOriginDeterminationFailDetailList(Map param);
	// FCR_DTL(협정 판정 계산에 실제로 쓰인 최종 원재료) 목록. TXT_HSCODE_INCLUDE_MISSING/
	// MSG_FAILED_DECISION_QTY_AMOUNT 사유일 때(param.fta_code 미지정 - 프론트에서 fta_code로 매핑해 사용)와
	// BOM 추적 팝업(param.fta_code 지정 - 그 협정 1건만 조회)에서 함께 쓴다
	public List<Map<String, Object>> retrieveOriginDeterminationFailMaterialList(Map param);
	// 원산지 판정 상세 팝업(내수 전용). (매출년월/플랜트/고객사/품번) 그룹별로 "지금 시점" 판정 대상
	// SALES_NO/SALES_SEQ(가상매출 우선)와 판정상태/상품상세를 함께 조회한다.
	public List<Map<String, Object>> retrieveDomesticOriginDeterminationDetailList(Map param);
}
