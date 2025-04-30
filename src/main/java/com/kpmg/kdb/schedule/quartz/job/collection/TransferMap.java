package com.kpmg.kdb.schedule.quartz.job.collection;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kpmg.kdb.util.*;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.util.StringUtil;


public class TransferMap implements Serializable, Cloneable {
	
	protected static Log log = LogFactory.getLog(TransferMap.class);
	
	
	private static final long serialVersionUID = -7517688282979333170L;

	private Map<String, Object> session;

	private TransferHelperMap map;

	public TransferHelperMap getMap() {
		return map;
	}

	
	public static final String BEGIN_LOOP = "_BeginLoop_";

	
	public static final String CONTEXT_NAME = "_CONTEXT_NAME";

	
	public TransferMap() {
		map = new TransferHelperMap(500);
	}

	
	public TransferMap(int initialCapacity) {
		map = new TransferHelperMap(initialCapacity);
	}

	
	@SuppressWarnings("rawtypes")
	public TransferMap(Map map) {
		this.map = new TransferHelperMap(map);
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	@SuppressWarnings("rawtypes")
	public Map getSession() {
		return this.session;
	}

	
	public Object get(String name) {
		Object obj = this.map.get(name);
		return obj;
	}

	@SuppressWarnings("unchecked")
	public void put(String name, int value) {
		this.map.put(name, new Integer(value));
	}

	@SuppressWarnings("unchecked")
	public void put(String name, long value) {
		this.map.put(name, new Long(value));
	}

	@SuppressWarnings("unchecked")
	public void put(String name, float value) {
		this.map.put(name, new Float(value));
	}

	@SuppressWarnings("unchecked")
	public void put(String name, double value) {
		this.map.put(name, new Double(value));
	}

	@SuppressWarnings("unchecked")
	public void put(String name, boolean value) {
		this.map.put(name, value);
	}

	@SuppressWarnings("unchecked")
	public void put(String name, Object value) {
		this.map.put(name, value);
	}

	
	public String getString(String paramName) {
		Object obj = this.map.get(paramName);
		if (obj == null) {
			return null;
		} else {
			return obj.toString();
		}
	}

	
	public int getInt(String paramName) throws NumberFormatException {
		String value = getString(paramName);
		if (value == null) {
			return 0;
		}
		return Integer.parseInt(value);
	}

	
	public long getLong(String paramName) throws NumberFormatException {
		String value = getString(paramName);
		if (value == null) {
			return 0;
		}
		return Long.parseLong(value);
	}

	
	public boolean getBoolean(String paramName) {
		String value = getString(paramName);
		if (value == null) {
			return false;
		}
		return StringUtil.getBoolean(value, false);
	}

	
	public String getParameter(String paramName) throws AllInOneException {
		String str = getString(paramName);
		if (StringUtil.isNullNotTrim(str)) {
			throw new AllInOneException(paramName);
		} else {
			return str;
		}
	}

	
	public String getParameter(String paramName, String defaultValue) {
		String str = getString(paramName);
		if (StringUtil.isNullNotTrim(str)) {
			return defaultValue;
		} else {
			return (String) str;
		}
	}

	
	public String[] getParameterValues(String paramName) {
		String[] strArr = getStringArray(paramName);
		return strArr;
	}

	
	public int getIntParameter(String paramName) throws AllInOneException {
		String str = getParameter(paramName);

		int i = 0;
		try {
			i = Integer.parseInt(str);
		} catch (NumberFormatException e) {
			throw new AllInOneException("숫자 형식이 아닙니다--" + str);
		}
		return i;
	}

	
	public int getIntParameter(String paramName, int defaultValue)
			throws AllInOneException {
		String str = getParameter(paramName, "");
		if (StringUtil.isNull(str)) {
			return defaultValue;
		}
		return getIntParameter(paramName);
	}

	
	public Object getObjectParameter(String paramName) throws AllInOneException {
		Object obj = get(paramName);
		if (obj == null) {
			throw new AllInOneException(paramName);
		} else {
			return obj;
		}
	}

	
	public Object getObjectParameter(String paramName, Object defaultObj) {
		Object obj = get(paramName);
		if (obj == null) {
			return defaultObj;
		} else {
			return obj;
		}
	}

	
	public double getDoubleParameter(String paramName) throws AllInOneException {
		String str = getParameter(paramName);

		double i = 0;
		try {
			i = Double.parseDouble(str);
		} catch (NumberFormatException e) {
			throw new AllInOneException("숫자 형식이 아닙니다--" + str);
		}
		return i;
	}

	
	public double getDoubleParameter(String paramName, double defaultValue) {
		String str = getParameter(paramName, "");
		if (StringUtil.isNull(str)) {
			return defaultValue;
		}
		double i = 0;
		try {
			i = Double.parseDouble(str);
		} catch (NumberFormatException e) {
			throw e;
		}
		return i;
	}

	
	public String[] getStringArray(String paramName) {
		Object obj = this.map.get(paramName);
		String param = null;
		String[] params = null;
		
		if (obj instanceof String[]) {
			return (String[]) obj;
		} else if (obj instanceof Collection) {
			return null;
		} else if (obj instanceof Object[]) {
			Object[] objArray = (Object[]) obj;
			String[] array = new String[objArray.length];
			
			for (int i = 0; i < objArray.length; i++) {
				try {
					array[i] = objArray[i].toString();
				} catch (NullPointerException e) {
					array[i] = "";
				}
			}
			return array;
		} else if (obj != null) {
			String[] array = new String[1];
			array[0] = obj.toString();
			
			return array;
		} else {
			param = getParameter(paramName, null);
			
			if (param == null) {
				log.debug("responseMap에" + paramName + "으로 등록된 객체가 없습니다.");
				
				return null;
			} else {
				params = new String[1];
				params[0] = param;
				
				return params;
			}
		}
	}

	
	@SuppressWarnings("unchecked")
	public Object clone() {
		TransferMap dataMap = new TransferMap();
		dataMap.putAll((Map<String, Object>) this.map.clone());
		return dataMap;
	}

	
	@SuppressWarnings("unchecked")
	public void putAll(Map<String, Object> m) {
		this.map.putAll(m);
	}

	
	@SuppressWarnings("rawtypes")
	public String toString() {
		String key = null;
		Object item = null;
		
		if (this.map.isEmpty()) {
			return "DataMap is empty.";
		}
		
		StringBuffer buf = new StringBuffer(2000);
		Set keySet = this.map.keySet();
		Iterator i = keySet.iterator();
		
		while (i.hasNext()) {
			try {
				key = i.next().toString();
				
				if ("q".equals(key) || "p".equals(key)) continue;
				
				item = get(key);
				
				if (item == null) {
					buf.append(key + "=null");
				} else if (item instanceof String) {
					if (item == null || ((String) item).length() == 0) {
						item = "";
					}
					
					buf.append(key + "=[" + item + "]");
				} else if (item instanceof Integer || item instanceof Long
						|| item instanceof Double
						|| item instanceof java.lang.Float
						|| item instanceof Boolean)
					buf.append(key + "=[" + item + "]");
				else if (item instanceof String[]) {
					String data[] = (String[]) item;
					buf.append(key + "=[");
					int j;
					for (j = 0; j < data.length; j++) {
						buf.append(data[j]);
					}
					
					if (j < (data.length - 1)) {
						buf.append(",");
					}
					
					buf.append("] Array Size:" + j + " ");
				} else {
					buf.append(key + "=[" + item + "] ClassName:" + item.getClass().getName() + "");
				}
			} catch (Exception ignore) {
				log.error(ignore.getMessage());
			}
		}
		
		if(log.isDebugEnabled()) log.debug("end of DataMap info :" + buf.toString());
		
		return "";
	}

	public String getDataMapInfo() {
		return toString();
	}

	public String getRequestURI() {
		return (String) get("URI");
	}

	@SuppressWarnings("unchecked")
	public void setRequestURI(String uri) {
		this.map.put("URI", uri);
	}

	
	public String getContextName() {
		return getString(CONTEXT_NAME);
	}

	@SuppressWarnings("unchecked")
	public void setContextName(String contextName) {
		this.map.put(CONTEXT_NAME, contextName);
	}

	public void clear() {
		this.map.clear();
	}

	public boolean containsKey(Object key) {
		return this.map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return this.map.containsValue(value);
	}

	@SuppressWarnings("rawtypes")
	public Set entrySet() {
		return this.map.entrySet();
	}

	public Object get(Object key) {
		return this.map.get(key);
	}

	public boolean isEmpty() {
		return this.map.isEmpty();
	}

	@SuppressWarnings("rawtypes")
	public Set keySet() {
		return this.map.keySet();
	}

	@SuppressWarnings("unchecked")
	public Object put(Object key, Object value) {
		return this.map.put(key, value);
	}

	public Object remove(Object key) {
		return this.map.remove(key);
	}

	public int size() {
		return this.map.size();
	}

	@SuppressWarnings("rawtypes")
	public Collection values() {
		return this.map.values();
	}

}