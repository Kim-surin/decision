package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultResponseDto;


public interface OriginDeterminationDao {
	public List<OriginDeterminationResponseDto> retrieveDomesticOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveExportOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveOriginDeterminationResult(OriginDeterminationRequestDto param);
	public List<OriginDeterminationDetailResponseDto> retrieveDomesticOriginDeterminationDetailList(OriginDeterminationDetailRequestDto param);
	// 판정완료 건의 판정결과(협정별) 목록
	public List<OriginDeterminationResultResponseDto> retrieveDomesticOriginDeterminationResultList(OriginDeterminationResultRequestDto param);
	// 판정결과에서 협정(FTA_CODE) 선택 시 그 협정의 판정 상세내용(기준별) 목록
	public List<OriginDeterminationResultDetailResponseDto> retrieveDomesticOriginDeterminationResultDetailList(OriginDeterminationResultDetailRequestDto param);
}