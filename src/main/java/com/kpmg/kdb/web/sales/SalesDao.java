package com.kpmg.kdb.web.sales;

import java.util.List;

import com.kpmg.kdb.web.sales.dto.SalesRequestDto;
import com.kpmg.kdb.web.sales.dto.SalesResponseDto;

public interface SalesDao {
	public List<SalesResponseDto> retrieveSales(SalesRequestDto param);
}