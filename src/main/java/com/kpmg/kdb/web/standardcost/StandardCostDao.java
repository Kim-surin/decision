package com.kpmg.kdb.web.standardcost;

import java.util.List;
import java.util.Map;

public interface StandardCostDao {
	public List<Map<String, Object>> retrieveStandardCost(Map param);
}
