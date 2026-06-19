package com.kpmg.kdb.web.standardcost;

import java.util.List;

import com.kpmg.kdb.web.standardcost.dto.StandardCostRequestDto;
import com.kpmg.kdb.web.standardcost.dto.StandardCostResponseDto;

public interface StandardCostDao {
	public List<StandardCostResponseDto> retrieveStandardCost(StandardCostRequestDto param);
}