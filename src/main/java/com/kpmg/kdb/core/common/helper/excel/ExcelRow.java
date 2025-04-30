package com.kpmg.kdb.core.common.helper.excel;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;

public class ExcelRow {
	private Map<String, Object> row = null;

	public ExcelRow() {
		row = new HashMap<String, Object>();
	}

	public ExcelRow(Map<String, Object> map) {
		row = map;
	}

	public ExcelRow(ExcelRow r) {
		row = r.getMap();
	}

	public ExcelRow clone() {
		return new ExcelRow(new HashMap<String, Object>(row));
	}

	public Map<String, Object> getMap() {
		return row;
	}

	public Object get(Object key) {
		return row.get(key);
	}

	public Object get(String key, Object defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else {
			return obj;
		}
	}

	public char getChar(String key, char defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else {
			return ((Character) obj).charValue();
		}
	}

	public boolean getBoolean(String key, boolean defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Boolean) {
			return ((Boolean) obj).booleanValue();
		} else {
			String str = String.valueOf(obj);
			return Boolean.parseBoolean(str);
		}
	}

	public String getString(String key, String defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Double || obj instanceof Float) {
			return BigDecimal.valueOf(((Number) obj).doubleValue()).toString();
		} else {
			return obj.toString();
		}
	}

	public int getInt(String key, int defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Number) {
			return ((Number) obj).intValue();
		} else {
			String str = String.valueOf(obj);
			if (str.length() == 0) {
				return defaultValue;
			} else {
				return Integer.parseInt(str);
			}
		}
	}

	public float getFloat(String key, float defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Number) {
			return ((Number) obj).floatValue();
		} else {
			String str = String.valueOf(obj);
			if (str.length() == 0) {
				return defaultValue;
			} else {
				return Float.parseFloat(str);
			}
		}
	}

	public long getLong(String key, long defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Number) {
			return ((Number) obj).longValue();
		} else {
			String str = String.valueOf(obj);
			if (str.length() == 0) {
				return defaultValue;
			} else {
				return Long.parseLong(str);
			}
		}
	}

	public double getDouble(String key, double defaultValue) {
		Object obj = get(key);
		if (obj == null) {
			return defaultValue;
		} else if (obj instanceof Number) {
			return ((Number) obj).doubleValue();
		} else {
			String str = String.valueOf(obj);
			if (str.length() == 0) {
				return defaultValue;
			} else {
				return Double.parseDouble(str);
			}
		}
	}

	public void clear() {
		row.clear();
	}

	public boolean containsKey(Object key) {
		return row.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return row.containsValue(value);
	}

	public Set<java.util.Map.Entry<String, Object>> entrySet() {
		return row.entrySet();
	}

	public boolean isEmpty() {
		return row.isEmpty();
	}

	public Set<String> keySet() {
		return row.keySet();
	}

	public Object put(String key, Object value) {
		return row.put(key, value);
	}

	public void putAll(Map<? extends String, ? extends Object> map) {
		row.putAll(map);
	}

	public Object remove(Object key) {
		return row.remove(key);
	}

	public int size() {
		return row.size();
	}

	public Collection<Object> values() {
		return row.values();
	}

	public void dump(int idx, Log applog) {
		if (applog.isTraceEnabled()) {
			StringBuilder sb = new StringBuilder();
			sb.append("(").append(idx).append(")");
			sb.append(toString());
			applog.trace(sb.toString());
		}
	}

	public void dump(int idx, OutputStream out) {
		StringBuilder sb = new StringBuilder();
		sb.append("(").append(idx).append(")");
		sb.append(toString()).append("\n");
		try {
			out.write(sb.toString().getBytes());
		} catch (IOException ignore) {
		}
	}

	public String toString() {
		Iterator<String> ir = keySet().iterator();

		StringBuilder sb = new StringBuilder();
		sb.append("[");
		String keyTmp = null;
		Object value = null;

		while (ir.hasNext()) {
			keyTmp = ir.next();
			sb.append("{");
			sb.append(keyTmp);
			sb.append(":");
			value = get(keyTmp);
			if (value == null) {
				sb.append("null");
			} else if (value instanceof String) {
				sb.append("\"");
				sb.append(value);
				sb.append("\"");
			} else if (value instanceof char[]) {
				sb.append("'");
				sb.append((char[]) value);
				sb.append("'");
			} else if (value instanceof Object[]) {
				Object[] arr = (Object[]) value;
				sb.append("(");
				for (int i = 0; i < arr.length - 1; i++) {
					sb.append(arr[i]);
					sb.append(",");
				}
				if (sb.lastIndexOf(",") == sb.length() - 1) {
					sb.deleteCharAt(sb.length() - 1);
				}
				sb.append(")");
			} else {
				sb.append(value);
			}
			sb.append("},");
		}

		if (sb.lastIndexOf(",") == sb.length() - 1) {
			sb.deleteCharAt(sb.length() - 1);
		}

		sb.append("]");

		return sb.toString();
	}
}
