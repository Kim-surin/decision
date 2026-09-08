package com.kpmg.kdb.web.ftabom;

import java.util.List;
import java.util.Map;

public interface FtaBomDao {
	public List<Map<String, Object>> retrieveftaBomMaster(Map param);

	public List<Map<String, Object>> retrieveftaBomDetail(Map param);

	public List<Map<String, Object>> retrieveftaBomDetailVendor(Map param);
}
