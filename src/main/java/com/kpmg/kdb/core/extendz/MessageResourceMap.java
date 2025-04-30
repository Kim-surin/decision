package com.kpmg.kdb.core.extendz;

import java.util.LinkedHashMap;


@SuppressWarnings("rawtypes")
public class MessageResourceMap extends LinkedHashMap {

	private static final long serialVersionUID = 1L;

	public MessageResourceMap() {
	}

	public MessageResourceMap(String nm) {
		this.nm = nm;
	}

	private String nm;

	public String getName() {
		return nm;
	}
	public void setName(String nm) {
		this.nm = nm;
	}
}
