package com.kpmg.kdb.web.ftabom;

import java.util.List;

import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailResponseDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailVendorRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomMasterRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomMasterResponseDto;

public interface FtaBomDao {
	public List<FtaBomMasterResponseDto> retrieveftaBomMaster(FtaBomMasterRequestDto param);

	public List<FtaBomDetailResponseDto> retrieveftaBomDetail(FtaBomDetailRequestDto param);
	
	public List<FtaBomDetailResponseDto> retrieveftaBomDetailVendor(FtaBomDetailVendorRequestDto param);
}