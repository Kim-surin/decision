package com.kpmg.kdb.web.materialinv;

import java.util.List;

import com.kpmg.kdb.web.materialinv.dto.MaterialInvRequestDto;
import com.kpmg.kdb.web.materialinv.dto.MaterialInvResponseDto;

public interface MaterialInvDao {
	public List<MaterialInvResponseDto> retrieveMaterialInv(MaterialInvRequestDto param);
}