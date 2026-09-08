package com.kpmg.kdb.web.materialinv;

import java.util.List;
import java.util.Map;

public interface MaterialInvDao {
	public List<Map<String, Object>> retrieveMaterialInv(Map param);
}
