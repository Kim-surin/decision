package com.kpmg.kdb.core.common.helper.excel;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;

public class ExcelCommmonVo implements List<ExcelRow>, Serializable {

	private static final long serialVersionUID = -5611684802481686195L;

	private static final Log log = LogFactory.getLog(ExcelCommmonVo.class);

	private static final int MAX_LOG_DUMP_SIZE = 10;

	private static final int CHECK_AMOUNT_UNIT_SIZE = ApplicationConstants.EXCEL_SHEET_ROWS;

	private static final int MAX_ROWS = ApplicationConstants.EXCEL_MAX_ROWS;

	private List<ExcelRow> excelTable = new ArrayList<ExcelRow>();

	private String voName = "";

	private int maxRows = MAX_ROWS;

	public ExcelCommmonVo() {
	}

	public ExcelCommmonVo(int max) {
		maxRows = max;
	}

	public ExcelCommmonVo(String name) {
		voName = name;
	}

	public ExcelCommmonVo(String name, int max) {
		voName = name;
		maxRows = max;
	}

	public String getName() {
		return voName;
	}

	public void set(String key, Object value) {
		set(0, key, value);
	}

	public void set(String key, char value) {
		set(0, key, value);
	}

	public void set(String key, boolean value) {
		set(0, key, value);
	}

	public void set(String key, int value) {
		set(0, key, value);
	}

	public void set(String key, float value) {
		set(0, key, value);
	}

	public void set(String key, long value) {
		set(0, key, value);
	}

	public void set(String key, double value) {
		set(0, key, value);
	}

	public void set(int idx, String key, Object value) {
		ExcelRow row = null;

		if (idx < excelTable.size() && excelTable.get(idx) != null) {
			row = excelTable.get(idx);
		} else {
			row = this.createRowInstance();
			add(idx, row);
		}
		row.put(key, value);
	}

	public void set(int idx, String key, char value) {
		set(idx, key, new Character(value));
	}

	public void set(int idx, String key, boolean value) {
		set(idx, key, new Boolean(value));
	}

	public void set(int idx, String key, int value) {
		set(idx, key, new Integer(value));
	}

	public void set(int idx, String key, float value) {
		set(idx, key, new Float(value));
	}

	public void set(int idx, String key, long value) {
		set(idx, key, new Long(value));
	}

	public void set(int idx, String key, double value) {
		set(idx, key, new Double(value));
	}

	public Object get(String key) {
		return get(0, key);
	}

	public char getChar(String key) {
		return getChar(0, key);
	}

	public boolean getBoolean(String key) {
		return getBoolean(0, key);
	}

	public String getString(String key) {
		return getString(0, key);
	}

	public int getInt(String key) {
		return getInt(0, key);
	}

	public float getFloat(String key) {
		return getFloat(0, key);
	}

	public long getLong(String key) {
		return getLong(0, key);
	}

	public double getDouble(String key) {
		return getDouble(0, key);
	}

	public Object get(String key, Object defaultNullValue) {
		return get(0, key, defaultNullValue);
	}

	public char getChar(String key, char defaultNullValue) {
		return getChar(0, key, defaultNullValue);
	}

	public boolean getBoolean(String key, boolean defaultNullValue) {
		return getBoolean(0, key, defaultNullValue);
	}

	public String getString(String key, String defaultNullValue) {
		return getString(0, key, defaultNullValue);
	}

	public int getInt(String key, int defaultNullValue) {
		return getInt(0, key, defaultNullValue);
	}

	public float getFloat(String key, float defaultNullValue) {
		return getFloat(0, key, defaultNullValue);
	}

	public long getLong(String key, long defaultNullValue) {
		return getLong(0, key, defaultNullValue);
	}

	public double getDouble(String key, double defaultNullValue) {
		return getDouble(0, key, defaultNullValue);
	}

	public Object get(int idx, String key, Object defaultNullValue) {
		return getRow(idx).get(key, defaultNullValue);
	}

	public char getChar(int idx, String key, char defaultNullValue) {
		return getRow(idx).getChar(key, defaultNullValue);
	}

	public boolean getBoolean(int idx, String key, boolean defaultNullValue) {
		return getRow(idx).getBoolean(key, defaultNullValue);
	}

	public String getString(int idx, String key, String defaultNullValue) {
		return getRow(idx).getString(key, defaultNullValue);
	}

	public int getInt(int idx, String key, int defaultNullValue) {
		return getRow(idx).getInt(key, defaultNullValue);
	}

	public float getFloat(int idx, String key, float defaultNullValue) {
		return getRow(idx).getFloat(key, defaultNullValue);
	}

	public long getLong(int idx, String key, long defaultNullValue) {
		return getRow(idx).getLong(key, defaultNullValue);
	}

	public double getDouble(int idx, String key, double defaultNullValue) {
		return getRow(idx).getDouble(key, defaultNullValue);
	}

	public Object get(int idx, String key) {
		return getRow(idx).get(key);
	}

	public char getChar(int idx, String key) {
		return getRow(idx).getChar(key, ' ');
	}

	public boolean getBoolean(int idx, String key) {
		return getRow(idx).getBoolean(key, false);
	}

	public String getString(int idx, String key) {
		return getRow(idx).getString(key, null);
	}

	public int getInt(int idx, String key) {
		return getRow(idx).getInt(key, 0);
	}

	public float getFloat(int idx, String key) {
		return getRow(idx).getFloat(key, 0F);
	}

	public long getLong(int idx, String key) {
		return getRow(idx).getLong(key, 0L);
	}

	public double getDouble(int idx, String key) {
		return getRow(idx).getDouble(key, 0D);
	}

	public void addRow(ExcelRow row) {
		add(row);
	}

	public void addRow(int idx, ExcelRow row) {
		add(idx, row);
	}

	public void addRow(Map<String, Object> map) {
		add(new ExcelRow(map));
	}

	public void addRow(int idx, Map<String, Object> map) {
		addRow(idx, new ExcelRow(map));
	}

	public ExcelRow getRow() {
		return getRow(0);
	}

	public ExcelRow getRow(int idx) {
		if (excelTable.size() <= idx) {
			throw new IndexOutOfBoundsException("ValueObject index is out of range. [Index:" + idx + ", Size:" + excelTable.size() + "]");
		}
		return excelTable.get(idx);
	}

	public ExcelRow cloneRow(int idx) {
		return getRow(idx).clone();
	}

	public ExcelRow cloneRow() {
		return getRow(0).clone();
	}

	public void setRow(int idx, ExcelRow row) {
		if (excelTable.size() <= idx) {
			throw new IndexOutOfBoundsException("ValueObject index is out of range. [Index:" + idx + ", Size:" + excelTable.size() + "]");
		}

		if (row == null) {
			row = createRowInstance();
		}

		excelTable.set(idx, row);
	}

	public void setRow(ExcelRow row) {
		setRow(0, row);
	}

	public List<ExcelRow> getTable() {
		return excelTable;
	}

	public void setTable(List<ExcelRow> excelTable) {
		clear();
		if (excelTable != null) {
			for (int i = 0; i < excelTable.size(); i++) {
				add(excelTable.get(i));
			}
		}
	}

	public void setTable(Map<String, Object>[] mapArray) {
		clear();
		if (mapArray != null) {
			for (int i = 0; i < mapArray.length; i++) {
				add(new ExcelRow(mapArray[i]));
			}
		}
	}

	public void addTable(List<ExcelRow> excelTable) {
		if (excelTable != null) {
			for (int i = 0; i < excelTable.size(); i++) {
				add(excelTable.get(i));
			}
		}
	}

	private ExcelRow createRowInstance() {
		return new ExcelRow();
	}

	public ExcelRow remove(int idx) {
		return excelTable.remove(idx);
	}

	public Object remove(int idx, String key) throws IndexOutOfBoundsException {
		return getRow(idx).remove(key);
	}

	public boolean isExist(int idx, String key) {
		ExcelRow row = null;
		try {
			row = getRow(idx);
		} catch (IndexOutOfBoundsException ex) {
			return false;
		}

		return row.containsKey(key);
	}

	public boolean isExist(String key) {
		return isExist(0, key);
	}

	public int size() {
		return excelTable.size();
	}

	public void clear() {
		excelTable.clear();
	}

	public Map<String, Object> getRowAsMap(int idx) {
		return getRow(idx).getMap();
	}

	public Map<String, Object> getRowAsMap() {
		return getRowAsMap(0);
	}

	public ExcelCommmonVo getRowAsVo(int idx) {
		ExcelCommmonVo vo = new ExcelCommmonVo();
		// vo.add(getRow(idx).clone());
		vo.add(getRow(idx));
		return vo;
	}

	public ExcelCommmonVo getRowAsVo() {
		return getRowAsVo(0);
	}

	public void dumpRow(Log applog) {
		dumpRow(0, applog);
	}

	public void dumpRow(int idx, Log applog) {
		if (applog.isTraceEnabled()) {
			ExcelRow row = getRow(idx);
			if (row == null) {
				return;
			}
			row.dump(idx, applog);
		}
	}

	public void dumpTable(Log applog) {
		dumpTable(applog, MAX_LOG_DUMP_SIZE);
	}

	public void dumpTable(Log applog, int maxSize) {
		if (applog.isTraceEnabled()) {

			if (excelTable == null) {
				return;
			}

			int len;

			if (maxSize < excelTable.size()) {
				len = maxSize;
			} else {
				len = excelTable.size();
			}

			for (int i = 0; i < len; i++) {
				excelTable.get(i).dump(i, applog);
			}

			if (maxSize < excelTable.size()) {
				if (applog.isTraceEnabled()) {
					log.trace("\n .............. The rest is ommitted. (이하 생략), \t [Row Size:" + excelTable.size() + ", MAX Size:" + maxSize + "]");
				}
			}
		}
	}

	public void dumpTable(OutputStream out, int maxSize) {

		if (excelTable == null) {
			return;
		}

		int len = 0;
		if (maxSize < excelTable.size()) {
			len = maxSize;
		} else {
			len = excelTable.size();
		}

		for (int i = 0; i < len; i++) {
			excelTable.get(i).dump(i, out);
		}

		if (maxSize < excelTable.size()) {
			String msg = "\n .............. The rest is ommitted. (이하 생략), \t [Row Size:" + excelTable.size() + ", MAX Size:" + maxSize + "]";
			try {
				out.write(msg.getBytes());
			} catch (IOException ignored) {
			}
		}
	}

	public void dumpObjectSize(Log applog) {

		if (applog.isTraceEnabled()) {
			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ObjectOutputStream oos = new ObjectOutputStream(baos);
				oos.writeObject(this);
				applog.trace("ValueObject(" + getName() + ")'s size : " + baos.size() / 1024 + "KB");
			} catch (IOException e) {
				if (log.isErrorEnabled()) {
					log.error("ValueObject.getSize() Error", e);
				}
			}
		}

	}

	public boolean add(ExcelRow row) {
		if (excelTable.size() >= maxRows) {
			try {
				throw new Exception("max rows=" + maxRows);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				
			}
		}

		if (row == null) {
			row = createRowInstance();
		}

		if (log.isDebugEnabled()) {
			if ((excelTable.size() + 1) % CHECK_AMOUNT_UNIT_SIZE == 0) {
				Throwable th = new Throwable();
				StackTraceElement ste[] = th.getStackTrace();
				StringBuffer sb = new StringBuffer();

				for (int i = 0; i < ste.length; i++) {
					sb.append(ste[i].toString());
					sb.append("\n");
					if (i > 20) {
						sb.append("... omitted");
						break;
					}
				}
				log.debug("ValueObject size checker : " + excelTable.size() + "'th row added at \n" + sb.toString());
			}
		}
		return excelTable.add(row);
	}

	public void add(int idx, ExcelRow row) {
		if (size() < idx) {
			throw new IndexOutOfBoundsException("ValueObject index is out of range. [Index:" + idx + ", Size:" + excelTable.size() + "]");
		} else if (idx >= maxRows) {
			try {
				throw new Exception("max rows=" + maxRows);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				
			}
		}

		if (row == null) {
			row = createRowInstance();
		}

		if (log.isDebugEnabled()) {
			if ((excelTable.size() + 1) % CHECK_AMOUNT_UNIT_SIZE == 0) {
				Throwable th = new Throwable();
				StackTraceElement ste[] = th.getStackTrace();
				StringBuffer sb = new StringBuffer();

				for (int i = 0; i < ste.length; i++) {
					sb.append(ste[i].toString());
					sb.append("\n");
					if (i > 20) {
						sb.append("... omitted");
						break;
					}
				}
				log.debug("ValueObject size checker : " + excelTable.size() + "'th row added at \n" + sb.toString());
			}
		}
		excelTable.add(idx, row);
	}

	public boolean addAll(Collection<? extends ExcelRow> c) {
		return excelTable.addAll(c);
	}

	public boolean addAll(int index, Collection<? extends ExcelRow> c) {
		return excelTable.addAll(c);
	}

	public boolean contains(Object o) {
		return excelTable.contains(o);
	}

	public boolean containsAll(Collection<?> c) {
		return excelTable.containsAll(c);
	}

	public ExcelRow get(int idx) {
		if (excelTable.size() <= idx) {
			throw new IndexOutOfBoundsException("ValueObject index is out of range. [Index:" + idx + ", Size:" + excelTable.size() + "]");
		}
		return excelTable.get(idx);
	}

	public int indexOf(Object o) {
		return excelTable.indexOf(o);
	}

	public boolean isEmpty() {
		return excelTable.isEmpty();
	}

	public Iterator<ExcelRow> iterator() {
		return excelTable.iterator();
	}

	public int lastIndexOf(Object o) {
		return excelTable.lastIndexOf(o);
	}

	public ListIterator<ExcelRow> listIterator() {
		return excelTable.listIterator();
	}

	public ListIterator<ExcelRow> listIterator(int index) {
		return excelTable.listIterator(index);
	}

	public boolean remove(Object o) {
		return excelTable.remove(o);
	}

	public boolean removeAll(Collection<?> c) {
		return excelTable.removeAll(c);
	}

	public boolean retainAll(Collection<?> c) {
		return excelTable.retainAll(c);
	}

	public ExcelRow set(int index, ExcelRow element) {
		return excelTable.set(index, element);
	}

	public List<ExcelRow> subList(int fromIndex, int toIndex) {
		return excelTable.subList(fromIndex, toIndex);
	}

	public Object[] toArray() {
		return excelTable.toArray();
	}

	public <T> T[] toArray(T[] a) {
		return excelTable.toArray(a);
	}
}
