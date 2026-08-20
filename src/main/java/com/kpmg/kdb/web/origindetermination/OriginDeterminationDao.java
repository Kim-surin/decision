package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;


public interface OriginDeterminationDao {
	public List<OriginDeterminationResponseDto> retrieveDomesticOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveExportOriginDetermination(OriginDeterminationRequestDto param);
	public List<OriginDeterminationResponseDto> retrieveOriginDeterminationResult(OriginDeterminationRequestDto param);
}