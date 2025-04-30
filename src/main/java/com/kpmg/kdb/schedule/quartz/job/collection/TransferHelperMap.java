package com.kpmg.kdb.schedule.quartz.job.collection;

import java.util.HashMap;
import java.util.Map;

import com.kpmg.kdb.util.StringUtil;



@SuppressWarnings("rawtypes")
public class TransferHelperMap extends HashMap {

	
	private static final long serialVersionUID = 9168899778865879029L;

	
	public TransferHelperMap() {
		super(500);
	}

	
	public TransferHelperMap(int initialCapacity) {
		super(initialCapacity);
	}

	@SuppressWarnings("unchecked")
	public TransferHelperMap(Map map) {
		super(map);
	}

	public Object get(Object key) {
		Object obj = super.get(key);
		// super.containsKey(key);
		if (obj == null && key instanceof String) {
			String keyName = (String) key;
			obj = super.get(StringUtil.toDbStyle(keyName));
		}
		return obj;
	}
}