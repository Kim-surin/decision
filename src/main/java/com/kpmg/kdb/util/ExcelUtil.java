package com.kpmg.kdb.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.common.helper.excel.ExcelCommmonVo;
import com.kpmg.kdb.core.common.helper.excel.ExcelConverter;
import com.kpmg.kdb.core.common.helper.excel.ExcelFileHelper;
import com.kpmg.kdb.core.common.helper.excel.ExcelTypeSLoader;
import com.kpmg.kdb.core.extendz.MessageResourceExtends;

public class ExcelUtil {
    
    private static Log log = LogFactory.getLog(ExcelUtil.class);
    

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static ExcelCommmonVo convExcelVo(List list, String name) {
        ExcelCommmonVo vo = new ExcelCommmonVo(name);
        
        for(int i = 0; i < list.size(); i++) {
            Map<String, Object> map = (Map<String, Object>) list.get(i);
            
            vo.addRow(i, map);
        }
        
        if(log.isDebugEnabled()) log.debug("vo size = " + vo.size());
        
        return vo;
    }
    

    @SuppressWarnings("rawtypes")
    public static String[] transformColumns(Map<String, Object> map) {
        String[] columns = new String[map.size()];
        
        int i = 0;
        Iterator iter = map.entrySet().iterator();
        
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            String key = entry.getKey().toString();
            
            if(!key.equals("TOTALCOUNT") && !key.equals("PG_CNT")) {
                columns[i] = key;
                i++;
            }
        }
        
        if(log.isDebugEnabled()) log.debug("column 0 check = " + columns[0]);
        
        return columns;
    }
    

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List setHeaderColumns(List resutList, Object parameterObject) {
		if(resutList == null) {
			resutList = new LinkedList();
		}
		
		if(parameterObject instanceof Map) {
			Map map = (Map) parameterObject;
			
			try {
				String columns = StringUtil.null2String(map.get("headers"));
				
				if(!StringUtil.isNull(columns)) {
					JSONArray jsonArray = JSONArray.fromObject(columns);
					int level = jsonArray.size();
					
					if(log.isDebugEnabled()) log.debug("json array size = " + level + " / columns : " + columns);
					
					List list = new LinkedList();
					
					for(int idx = 0 ; idx < level ; idx++) {
						String jsonString = StringUtil.null2String(JsonUtil.fromObject(columns).get(idx));
						
						jsonArray = JsonUtil.fromObject(jsonString);
						
						List colList = new LinkedList();
						
						for(int i = 0 ; i < jsonArray.size(); i++) {
							colList.add(JsonUtil.getList(jsonString, i).get(0));
						}
						
						list.add(colList);
					}
					
					if(list != null && list.size() > 0) {
						Map columMap = new HashMap();
						String file = StringUtil.null2String(map.get("filename"));
						String sheet = StringUtil.null2String(map.get("sheetname"));
						
						columMap.put("headers", list);
						columMap.put("file", file);
						columMap.put("sheet", sheet);
						
						List cols = (List) list.get(0);
						
						if(log.isDebugEnabled()) log.debug("excel file header(total size = "+list.size()+
								", column number=" + cols.size() + "):" + cols.get(0)+
								", file name = " + file + ", sheet name = " + sheet);
						
						resutList.add(columMap);
					}
				}
			} catch(Exception e) {
				if(log.isErrorEnabled()) log.error("json convertion error : " + e);
			}
		}
		
		return resutList;
	}
	
	@SuppressWarnings("rawtypes")
	public static List setHeaderInfo(List<Map<String, Object>> list) {
		if(list == null  || list.size() <= 0) return new LinkedList();
		else return setHeaderInfo(list.get(0), list, null, null);
	}
	
	@SuppressWarnings("rawtypes")
	public static List setHeaderInfo(List<Map<String, Object>> list, String fname) {
		if(list == null  || list.size() <= 0) return new LinkedList();
		else return setHeaderInfo(list.get(0), list, fname, null);
	}
	
	@SuppressWarnings("rawtypes")
	public static List setHeaderInfo(List<Map<String, Object>> list, String fname, String sheet) {
		if(list == null  || list.size() <= 0) return new LinkedList();
		else return setHeaderInfo(list.get(0), list, fname, sheet);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List setHeaderInfo(Object headerObject, List<Map<String, Object>> list, String fname, String sheet) {
		List<Map<String, Object>> header = new LinkedList();
		Map<String, Object> headers = new HashMap(); 
		
		if(headerObject == null) return header;
		else {
			String[] names = null;
			
			if(headerObject instanceof Map) {
				names = transformColumns((Map) headerObject);
			} else if(headerObject instanceof String[]) {
				names = (String[]) headerObject;
			}
			
			for(int i = 0; i < names.length; i++) {
				String name = StringUtil.null2String(names[i]);
				String field = name;
				
				if(name.isEmpty()) continue;
				
				Map<String, Object> column = new HashMap<String, Object>();
				
				// 컬럼의 최대크기 구하기
				int s = 3200;
				for(int l = 0; l < list.size(); l++) {
					Map tMap = list.get(l);
					
					String cdata = StringUtil.null2String(tMap.get(name));
					if(s == 0 || s < (cdata.length() * 188)) {
						s = cdata.length() * 188;
					}
					
					// map정보를 통해 field ID를 구한다.
					if(l == 0) {
						field = transformColumns(tMap)[i];
					}
				}
				
				column.put("field", field);
				column.put("title", MessageResourceExtends.getMessageInstance().getMessage(name));
				column.put("width", Integer.toString(s));
				column.put("hidden", "false");
				column.put("halign", "center");
				column.put("align", "left");
				column.put("sortable", "true");
				
				header.add(column);
			}
			
			headers.put("headers", new ArrayList(Arrays.asList(header)));
			if(fname != null) {
				headers.put("file", fname);
			}
			if(sheet != null) {
				headers.put("sheet", sheet);
			}
			list.add(headers);
		}
		
		return list;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList(MultipartFile oneFile, int startRow) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter loader = new ExcelConverter(eh);
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = loader.getContents(oneFile, startRow);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList4PowerTech(MultipartFile oneFile) {
		
		//ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter loader = new ExcelConverter();
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = loader.getContents4PowerTech(oneFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
	
	public static ExcelFileHelper getExcelLoader(MultipartFile oneFile) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter conv = new ExcelConverter(eh);
    	
    	ExcelFileHelper loader = null;
		try {
			loader = conv.getLoader(oneFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return loader;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList(MultipartFile oneFile, int startRow, String targetSheet) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter conv = new ExcelConverter(eh);
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = conv.getContents(oneFile, 0, targetSheet);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
	
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList(MultipartFile oneFile, int startRow, int sheetNum) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter conv = new ExcelConverter(eh);
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = conv.getContents(oneFile, startRow, sheetNum);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList(File oneFile, int startRow, String targetSheet, String originalFilename) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter conv = new ExcelConverter(eh);
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = conv.getContents(oneFile, startRow, targetSheet, originalFilename);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public static List convertToList(File oneFile, int startRow, int targetSheet, String originalFilename) {
		
		ExcelFileHelper eh = new ExcelTypeSLoader();
    	ExcelConverter conv = new ExcelConverter(eh);
    	List retunConvertExcelList = null;
		try {
			retunConvertExcelList = conv.getContents(oneFile, startRow, targetSheet, originalFilename);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return retunConvertExcelList;
	}
}
