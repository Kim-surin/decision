package com.kpmg.kdb.web.sales;

import java.util.List;
import java.util.Map;

public interface SalesDao {
	public List<Map<String, Object>> retrieveSales(Map param);
}
