package com.kpmg.kdb.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.kpmg.kdb.schedule.quartz.job.collection.TransferMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@SuppressWarnings("rawtypes")
public class JsonUtil {


	public static void viewJson(List list, TransferMap trsMap) throws Exception {
		viewJson(list, trsMap, null);
	}

	public static boolean isJsonType(String jsonResponse) throws Exception {
		return (jsonResponse.startsWith("[") && jsonResponse.endsWith("]")) ? true : false;
	}

	@SuppressWarnings("unchecked")
	public static void viewJson(List list, TransferMap trsMap, String keyName) throws Exception {
		String jsonString = null;

		if (list != null && list.size() < 1) {
			Map emptyMap = new HashMap();

			emptyMap.put("empty", "");

			list.add(emptyMap);
		}

		JSONArray jsonObject = JSONArray.fromObject(list);
		jsonString = jsonObject.toString();

		if (StringUtil.isNull(keyName)) {
			trsMap.put("jrows", jsonString);
		} else {
			trsMap.put(keyName, jsonString);
		}
	}

	@SuppressWarnings("unchecked")
	public static String getViewJson(List list) throws Exception {
		String jsonString = null;

		if (list != null && list.size() < 1) {
			Map emptyMap = new HashMap();

			emptyMap.put("empty", "");

			list.add(emptyMap);
		}

		JSONArray jsonObject = JSONArray.fromObject(list);
		jsonString = jsonObject.toString();

		return jsonString;
	}

	public static List<Object> getList(String jsonResponse) throws Exception {
		return getList(jsonResponse, -1);
	}

	public static List<Object> getList(String jsonResponse, int i) throws Exception {
		List<Object> listResponse = new ArrayList<Object>();

		if (jsonResponse == null || jsonResponse.equals("")) {
			jsonResponse = "[]";
		} else {
			// 뉴라인 문자를 제거해야 오류가 발생하지 않음
			jsonResponse = jsonResponse.replace('\n', ' ');
			jsonResponse = jsonResponse.replace('\r', ' ');
		}

		if (JsonUtil.isJsonType(jsonResponse)) {
			JSONArray jsonArray = JSONArray.fromObject(jsonResponse);

			if (i == -1) {
				for (int a = 0; a < jsonArray.size(); a++) {
					toMultiList(jsonArray, listResponse, a);
				}
			} else {
				toMultiList(jsonArray, listResponse, i);
			}
		} else {
			throw new Exception("MalFormed JSON Array Response.");
		}

		return listResponse;
	}

	public static Map<String, Object> getMap(String jsonResponse) throws Exception {
		Map<String, Object> mapResponse = new LinkedHashMap<String, Object>();

		if (jsonResponse.startsWith("{")) {
			JSONObject jsonObj = JSONObject.fromObject(jsonResponse);
			toJavaMap(jsonObj, mapResponse);
		} else {
			throw new Exception("MalFormed JSON Array Response.");
		}

		return mapResponse;
	}

	private static void toJavaMap(JSONObject o, Map<String, Object> b) {
		Iterator ji = o.keys();

		while (ji.hasNext()) {
			String key = (String) ji.next();
			Object val = o.get(key);

			if (val.getClass() == JSONObject.class) {
				Map<String, Object> sub = new LinkedHashMap<String, Object>();

				toJavaMap((JSONObject) val, sub);
				b.put(key, sub);
			} else if (val.getClass() == JSONArray.class) {
				List<Object> l = new ArrayList<Object>();
				JSONArray arr = (JSONArray) val;

				for (int a = 0; a < arr.size(); a++) {
					Map<String, Object> sub = new LinkedHashMap<String, Object>();
					Object element = arr.get(a);

					if (element instanceof JSONObject) {
						toJavaMap((JSONObject) element, sub);

						l.add(sub);
					} else {
						l.add(element);
					}
				}

				b.put(key, l);
			} else {
				b.put(key, val);
			}
		}
	}

	@SuppressWarnings("unused")
	private static void toJavaList(JSONArray ar, List<Object> ll) {
		int i = 0;

		while (i < ar.size()) {
			Object val = ar.get(i);

			if (val.getClass() == JSONObject.class) {
				Map<String, Object> sub = new LinkedHashMap<String, Object>();
				toJavaMap((JSONObject) val, sub);
				ll.add(sub);
			} else if (val.getClass() == JSONArray.class) {
				List<Object> l = new ArrayList<Object>();
				JSONArray arr = (JSONArray) val;

				for (int a = 0; a < arr.size(); a++) {
					Map<String, Object> sub = new LinkedHashMap<String, Object>();
					Object element = arr.get(a);

					if (element instanceof JSONObject) {
						toJavaMap((JSONObject) element, sub);
						ll.add(sub);
					} else {
						ll.add(element);
					}
				}

				l.add(l);
			} else {
				ll.add(val);
			}

			i++;
		}
	}

	private static void toMultiList(JSONArray ar, List<Object> ll, int i) {
		if (ar.size() > 0) {
			Object val = ar.get(i);

			if (val != null) {
				if (val instanceof JSONArray) {
					toMultiList((JSONArray) val, ll, i);
				} else if (val instanceof JSONObject) {
					Map<String, Object> sub = new HashMap<String, Object>();
					toJavaMap((JSONObject) val, sub);
					ll.add(sub);
				} else {
					ll.add(val);
				}
			}
		}
	}

	public static JSONArray fromObject(Object dataSet) {
		return net.sf.json.JSONArray.fromObject(dataSet);
	}

	public static int getJSONArrayLevel(String jsonResponse) {
		int level = 1;
		StringBuffer arrayFlag = new StringBuffer("");

		JSONArray jsonArray = JSONArray.fromObject(jsonResponse);

		for (int i = 0; i < jsonArray.size(); i++) {
			arrayFlag.append("[");
		}

		if (jsonResponse.startsWith(arrayFlag.toString())) {
			level = jsonArray.size();
		}

		return level;
	}

	public static List<Object> getHMList(String jsonResponse) throws Exception {
		List<Object> listResponse = new ArrayList<Object>();

		if (jsonResponse == null || jsonResponse.equals("")) {
			jsonResponse = "[]";
		}

		if (jsonResponse.startsWith("[")) {
			JSONArray jsonArray = JSONArray.fromObject(jsonResponse);
			toJavaHMList(jsonArray, listResponse);
		} else {
			throw new Exception("MalFormed JSON Array Response.");
		}

		return listResponse;
	}

	private static void toJavaHMList(JSONArray ar, List<Object> ll) {
		int i = 0;

		while (i < ar.size()) {
			Object val = ar.get(i);

			if (val.getClass() == JSONObject.class) {
				Map<String, Object> sub = new LinkedHashMap<String, Object>();
				toJavaHMMap((JSONObject) val, sub);
				ll.add(sub);
			} else if (val.getClass() == JSONArray.class) {
				List<Object> l = new ArrayList<Object>();
				JSONArray arr = (JSONArray) val;

				for (int a = 0; a < arr.size(); a++) {
					Map<String, Object> sub = new LinkedHashMap<String, Object>();
					Object element = arr.get(a);

					if (element instanceof JSONObject) {
						toJavaHMMap((JSONObject) element, sub);
						ll.add(sub);
					} else {
						ll.add(element);
					}
				}

				l.add(l);
			} else {
				ll.add(val);
			}

			i++;
		}
	}

	private static void toJavaHMMap(JSONObject o, Map<String, Object> b) {
		Iterator ji = o.keys();

		while (ji.hasNext()) {
			String key = (String) ji.next();
			Object val = o.get(key);
			if (val.getClass() == JSONObject.class) {
				Map<String, Object> sub = new LinkedHashMap<String, Object>();
				toJavaMap((JSONObject) val, sub);
				b.put(key, sub);
			} else if (val.getClass() == JSONArray.class) {
				List<Object> l = new ArrayList<Object>();
				JSONArray arr = (JSONArray) val;

				for (int a = 0; a < arr.size(); a++) {
					Map<String, Object> sub = new LinkedHashMap<String, Object>();
					Object element = arr.get(a);
					if (element instanceof JSONObject) {
						toJavaMap((JSONObject) element, sub);
						l.add(sub);
					} else {
						l.add(element);
					}
				}
				b.put(key, l);
			} else {
				b.put(key, val);
			}
		}
	}

}
