package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultResponseDto;
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
}