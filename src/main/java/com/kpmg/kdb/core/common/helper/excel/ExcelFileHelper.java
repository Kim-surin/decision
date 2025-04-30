package com.kpmg.kdb.core.common.helper.excel;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

@SuppressWarnings("rawtypes")
public abstract class ExcelFileHelper {

	public abstract List read(File file, int index) throws Exception;

	public abstract List read(File file, int index, String id) throws Exception;

	public abstract List read(File file, int index, String id, boolean formula) throws Exception;

	public abstract void write(List list, File file) throws Exception;

	public abstract void write(List list, File file, String[] columns) throws Exception;

	public abstract void view(List<List<Map<String, Object>>> list, HSSFWorkbook workbook) throws Exception;

	public abstract void view(List<List<Map<String, Object>>> list_list, HSSFWorkbook wb, Map<String, Object> param) throws Exception;
	
	/*PowerTech 전용 모듈*/
	public abstract List read4PowerTech(File file, String id) throws Exception;
	public abstract List read4PowerTech(File file, int headIndex, String sheetName, String distPath, String separator, int formattingConvention, boolean formula) throws Exception;
	
	public abstract List read(File file, int index, int sheetNum) throws Exception;
}
