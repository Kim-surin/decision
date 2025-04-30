package com.kpmg.kdb.core.common.helper.excel;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.record.crypto.Biff8EncryptionKey;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpmg.kdb.util.StringUtil;

/**
 * @Description SS Type Excel Loader Class
 * @author D.Cat
 * 
 */
@SuppressWarnings("unchecked")
public class ExcelTypeSLoader extends ExcelFileHelper {

	private static Logger log = LoggerFactory.getLogger(ExcelTypeSLoader.class);

	private Workbook workbook = null;
	private int maxRowWidth = 0;
	private int formattingConvention = 0;
	private int startRownum = 0;
	private DataFormatter formatter = null;
	private FormulaEvaluator evaluator = null;
	private String separator = null;

	private static final String CSV_FILE_EXTENSION = ".csv";
	private static final String DEFAULT_SEPARATOR = ",";

	public static final int EXCEL_STYLE_ESCAPING = 0;

	public static final int UNIX_STYLE_ESCAPING = 1;

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex) throws Exception {
		return this.read(file, headIndex, null, null, this.DEFAULT_SEPARATOR, this.EXCEL_STYLE_ESCAPING, false);
	}

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex, String sheetName) throws Exception {
		return this.read(file, headIndex, sheetName, null, this.DEFAULT_SEPARATOR, this.EXCEL_STYLE_ESCAPING, false);
	}

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex, String sheetName, boolean formula) throws Exception {
		return this.read(file, headIndex, sheetName, null, this.DEFAULT_SEPARATOR, this.EXCEL_STYLE_ESCAPING, formula);
	}

	@SuppressWarnings("static-access")
	private List<Map<String, Object>> read(File file, int headIndex, String sheetName, String distPath, String separator, int formattingConvention, boolean formula) throws Exception {
		File source = file;
		File[] filesList = null;
		List<Map<String, Object>> list = null;

		if (!source.exists()) {
			throw new Exception("The source for the Excel file(s) cannot be found.");
		}

		if (formattingConvention != this.EXCEL_STYLE_ESCAPING && formattingConvention != this.UNIX_STYLE_ESCAPING) {
			throw new Exception("The value passed to the formattingConvention parameter is out of range.");
		}

		this.separator = separator;
		this.formattingConvention = formattingConvention;

		if (source.isDirectory()) {
			filesList = source.listFiles(new ExcelFilenameFilter());
		} else {
			filesList = new File[] { source };
		}

		for (File excelFile : filesList) {
			this.openWorkbook(excelFile, formula);

			if (headIndex < 0)
				startRownum = 0;

			list = this.convertToCSV(sheetName);
		}

		return list;
	}

	private void openWorkbook(File file, boolean formula) throws Exception {
		InputStream fis = null;
		POIFSFileSystem pfs = null;

		try {

			log.debug("Opening workbook [" + file.getName() + "]");

			fis = new FileInputStream(file);
			if (file.getName().toLowerCase().endsWith(".xls")) {
				if (!fis.markSupported()) {
					fis = new PushbackInputStream(fis, 8);
				}

				if (POIFSFileSystem.hasPOIFSHeader(fis)) {
					pfs = new POIFSFileSystem(fis);
					String password = StringUtil.null2String(Biff8EncryptionKey.getCurrentUserPassword());

					if (log.isInfoEnabled())
						log.info("password : " + password);

					if (!password.isEmpty()) {
						throw new RuntimeException("Unable to process: document is encrypted");
					}
				} else {
					pfs = new POIFSFileSystem(fis);
				}

				this.workbook = WorkbookFactory.create(pfs);
			} else {
				this.workbook = WorkbookFactory.create(fis);
			}
			if (formula)
				this.evaluator = this.workbook.getCreationHelper().createFormulaEvaluator();
			this.formatter = new DataFormatter(true);
		} catch (Exception ep) {
			log.error("File open Error : " + ep);
			throw ep;
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
	}

	@SuppressWarnings("rawtypes")
	private List convertToCSV(String sheetName) throws Exception {
		Sheet sheet = null;
		Row row = null;
		int lastRowNum = 0;
		List list = new ArrayList<Map<String, Object>>();

		log.debug("Converting files contents to CSV format(sheet name = " + sheetName + ").");

		if (sheetName == null) {
			int numSheets = this.workbook.getNumberOfSheets();

			for (int i = 0; i < numSheets; i++) {
				sheet = ((Workbook) this.workbook).getSheetAt(i);

				if (sheet.getPhysicalNumberOfRows() > 0) {
					lastRowNum = sheet.getLastRowNum();

					for (int j = startRownum; j <= lastRowNum; j++) {
						row = sheet.getRow(j);

						Map rowMap = this.rowToCSV(row, (j + 1));

						if (rowMap != null && rowMap.size() > 0) {
							list.add(rowMap);
						}
					}
				}
			}
		} else {
			sheet = this.workbook.getSheet(sheetName);

			if (sheet != null) {
				if (sheet.getPhysicalNumberOfRows() > 0) {
					lastRowNum = sheet.getLastRowNum();

					for (int j = startRownum; j <= lastRowNum; j++) {
						row = sheet.getRow(j);
						Map rowMap = this.rowToCSV(row, (j + 1));

						if (rowMap != null && rowMap.size() > 0) {
							list.add(rowMap);
						}
					}
				}
			} else {
				throw new Exception("There is not found sheet.");
			}
		}

		return list;
	}

	@SuppressWarnings("rawtypes")
	private Map rowToCSV(Row row, int rownum) throws Exception {
		Cell cell = null;
		int lastCellNum = 0;
		Map<String, Object> csvLine = new LinkedHashMap<String, Object>();
		String emptyTest = null;

		if (row != null) {
			lastCellNum = row.getLastCellNum();
			char ch = 'A';

			for (int i = 0; i <= lastCellNum; i++) {
				cell = row.getCell(i);
				String cellName = Character.toString(ch) + rownum;

				if (cell == null) {
					csvLine.put(cellName, "");
				} else {
					if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
						try {
							String cellValue = null;
							if (this.evaluator == null) {
								cellValue = "";
							} else {
								cellValue = this.formatter.formatCellValue(cell, this.evaluator);
							}

							csvLine.put(cellName, cellValue);
						} catch (Exception e) {
							if (this.evaluator != null)
								csvLine.put(cellName, this.formatter.formatCellValue(cell).replace(",", "€"));
						}
					} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						if (DateUtil.isCellDateFormatted(cell)) {
							SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
							String cellValue = StringUtil.null2String(formatter.format(cell.getDateCellValue()));
							csvLine.put(cellName, cellValue);

							emptyTest += cellValue;
						} else {
							DecimalFormat formatter = new DecimalFormat("0.########");
							String cellValue = StringUtil.null2String(formatter.format(cell.getNumericCellValue()));
							csvLine.put(cellName, cellValue);

							emptyTest += cellValue;
						}
					} else {
						String cellValue = this.formatter.formatCellValue(cell);
						csvLine.put(cellName, cellValue);

						emptyTest += cellValue;
					}
				}

				ch++;
			}

			if (lastCellNum > this.maxRowWidth) {
				this.maxRowWidth = lastCellNum;
			}
		}

		if (emptyTest == null || emptyTest.trim().isEmpty()) {
			csvLine = null;
		}

		return csvLine;
	}

	@SuppressWarnings("static-access")
	private String escapeEmbeddedCharacters(String field) throws Exception {
		StringBuffer buffer = null;

		if (this.formattingConvention == this.EXCEL_STYLE_ESCAPING) {
			if (field.contains("\"")) {
				buffer = new StringBuffer(field.replaceAll("\"", "\\\"\\\""));
				buffer.insert(0, "\"");
				buffer.append("\"");
			} else {
				buffer = new StringBuffer(field);
				if ((buffer.indexOf(this.separator)) > -1 || (buffer.indexOf("\n")) > -1) {
					buffer.insert(0, "\"");
					buffer.append("\"");
				}
			}
			return (buffer.toString().trim());
		} else {
			if (field.contains(this.separator)) {
				field = field.replaceAll(this.separator, ("\\\\" + this.separator));
			}
			if (field.contains("\n")) {
				field = field.replaceAll("\n", "\\\\\n");
			}
			return (field);
		}
	}

	class ExcelFilenameFilter implements FilenameFilter {
		public boolean accept(File file, String name) {
			return (name.endsWith(".xls"));
		}
	}

	@SuppressWarnings("rawtypes")
	public void write(List list, File file) throws Exception {
		this.write(list, file, null);
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	public void write(List list, File file, String[] columns) throws Exception {
		FileWriter fw = null;
		BufferedWriter bw = null;
		Map<String, Object> line = null;
		StringBuffer buffer = null;
		String csvLineElement = null;

		String destinationFilename = file.getName();
		destinationFilename = destinationFilename.substring(0, destinationFilename.lastIndexOf(".")) + this.CSV_FILE_EXTENSION;

		File destination = new File(file.getParent(), destinationFilename);

		try {

			log.debug("Saving the CSV file [" + destination.getName() + "]");

			log.debug("this.maxRowWidth = " + this.maxRowWidth + ", start rownum = " + startRownum);

			fw = new FileWriter(destination);
			bw = new BufferedWriter(fw);
			int number = startRownum + 1;

			for (int i = 0; i < list.size(); i++) {
				buffer = new StringBuffer();
				line = (Map) list.get(i);
				char ch = 'A';

				for (int j = 0; j < this.maxRowWidth; j++) {
					if (line.size() > j) {
						String cellName = Character.toString(ch) + (number);
						csvLineElement = StringUtil.null2String(line.get(cellName)).replace("€", ",");

						if (csvLineElement != null) {
							buffer.append(this.escapeEmbeddedCharacters(csvLineElement));
						}
					}
					if (j < (this.maxRowWidth - 1)) {
						buffer.append(this.separator);
					}

					ch++;
				}

				bw.write(buffer.toString().trim());

				if (i < (list.size() - 1)) {
					bw.newLine();
				}

				number++;
			}
		}

		finally {
			if (bw != null) {
				bw.flush();
				bw.close();
			}
		}
	}

	@Override
	public void view(List<List<Map<String, Object>>> list, HSSFWorkbook workbook) throws Exception {
		// TODO Auto-generated method stub

	}
	
	@Override
	public void view(List<List<Map<String, Object>>> list, HSSFWorkbook workbook, Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub

	}
	

	/**
	 * 파워텍에서 사용하지 않아 구현하지 않음
	 */
	@Override
	public List read4PowerTech(File file, int headIndex, String sheetName, String distPath, String separator,
			int formattingConvention, boolean formula) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List read4PowerTech(File file,  String id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex, int sheetNum) throws Exception {
		File source = file;
		File[] filesList = null;
		List<Map<String, Object>> list = null;

		if (!source.exists()) {
			throw new Exception("The source for the Excel file(s) cannot be found.");
		}

		if (formattingConvention != this.EXCEL_STYLE_ESCAPING && formattingConvention != this.UNIX_STYLE_ESCAPING) {
			throw new Exception("The value passed to the formattingConvention parameter is out of range.");
		}

		this.separator = this.DEFAULT_SEPARATOR;
		this.formattingConvention = this.EXCEL_STYLE_ESCAPING;

		if (source.isDirectory()) {
			filesList = source.listFiles(new ExcelFilenameFilter());
		} else {
			filesList = new File[] { source };
		}

		for (File excelFile : filesList) {
			this.openWorkbook(excelFile, false);

			if (headIndex < 0)
				startRownum = 0;

			list = this.convertToCSV(sheetNum);
		}

		return list;
	}

	@SuppressWarnings("rawtypes")
	private List convertToCSV(int sheetNum) throws Exception {
		Sheet sheet = null;
		Row row = null;
		int lastRowNum = 0;
		List list = new ArrayList<Map<String, Object>>();

		log.debug("Converting files contents to CSV format(sheet number = " + sheetNum + ").");

		sheet = ((Workbook) this.workbook).getSheetAt(sheetNum);

		if (sheet.getPhysicalNumberOfRows() > 0) {
			lastRowNum = sheet.getLastRowNum();

			for (int j = startRownum; j <= lastRowNum; j++) {
				row = sheet.getRow(j);

				Map rowMap = this.rowToCSV(row, (j + 1));

				if (rowMap != null && rowMap.size() > 0) {
					list.add(rowMap);
				}
			}
		}

		return list;
	}

}
