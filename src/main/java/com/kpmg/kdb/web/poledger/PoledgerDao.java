package com.kpmg.kdb.web.poledger;

import java.util.List;
import java.util.Map;

public interface PoledgerDao {
	public List<Map<String, Object>> retrievePoledger(Map param);
}
