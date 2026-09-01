package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailMaterialResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailReasonResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;


public interface OriginDeterminationDao {
	public List<OriginDeterminationResponseDto> retrieveDomesticOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveExportOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveOriginDeterminationResult(OriginDeterminationRequestDto param);
	public List<OriginDeterminationDetailResponseDto> retrieveOriginDeterminationDetailList(OriginDeterminationDetailRequestDto param);
	// 판정완료 건의 판정결과(협정별) 목록
	public List<OriginDeterminationDetailResultResponseDto> retrieveOriginDeterminationDetailResultList(OriginDeterminationDetailResultRequestDto param);
	// 판정결과(FTA_CODE)별 판정 상세내용(기준별) 전체 목록 - 프론트에서 fta_code로 매핑해 사용
	public List<OriginDeterminationDetailResultDetailResponseDto> retrieveOriginDeterminationDetailResultDetailList(OriginDeterminationDetailResultRequestDto param);
	// 판정실패 건의 실패 사유(FCR_RESULT.STATUS='E'인 협정/룰) 목록
	public List<OriginDeterminationFailReasonResponseDto> retrieveOriginDeterminationFailReasonList(OriginDeterminationDetailResultRequestDto param);
	// 실패 사유(FTA_CODE)별로 그 협정에 걸린 룰 전체의 처리결과 - 프론트에서 fta_code로 매핑해 사용
	public List<OriginDeterminationFailDetailResponseDto> retrieveOriginDeterminationFailDetailList(OriginDeterminationDetailResultRequestDto param);
	// TXT_HSCODE_INCLUDE_MISSING/MSG_FAILED_DECISION_QTY_AMOUNT 사유일 때 보여줄 원재료(FCR_DTL) 목록 -
	// 프론트에서 fta_code로 매핑해 사용
	public List<OriginDeterminationFailMaterialResponseDto> retrieveOriginDeterminationFailMaterialList(OriginDeterminationDetailResultRequestDto param);
}