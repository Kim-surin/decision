package com.kpmg.kdb.core.common.helper.excel;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.NPOIFSFileSystem;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.kpmg.kdb.util.StringUtil;

import ch.qos.logback.classic.Logger;

/**
 * @Description XSSF Type Excel Loader Class
 * @author D.Cat
 * 
 */
@SuppressWarnings("unchecked")
public class ExcelTypeXLoader extends ExcelFileHelper {

	private static Log log = LogFactory.getLog(ExcelTypeXLoader.class);

	private XSSFWorkbook workbook = null;
	private int maxRowWidth = 0;
	private int formattingConvention = 0;
	private int startRownum = 0;
	private int lastCellNumber = 0;
	private DataFormatter formatter = null;
	private FormulaEvaluator evaluator = null;
	private String separator = null;
	
	private boolean endRowFlag4PowerTech = true;

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
	public List<Map<String, Object>> read4PowerTech(File file, String sheetName) throws Exception {
		return this.read4PowerTech(file, this.DEFAULT_SEPARATOR, this.EXCEL_STYLE_ESCAPING, false);
	}

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex, String sheetName, boolean formula) throws Exception {
		return this.read(file, headIndex, sheetName, null, this.DEFAULT_SEPARATOR, this.EXCEL_STYLE_ESCAPING, formula);
	}

	
	/**
	 * for PowerTech
	 * @param file
	 * @param separator
	 * @param formattingConvention
	 * @param formula
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read4PowerTech(File file, String separator, int formattingConvention, boolean formula) throws Exception {
		File source = file;
		File[] filesList = null;
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> returnList = new ArrayList();
		try {
			if (!source.exists()) {
				throw new Exception("작업 대상 파일을 찾을 수 없습니다.- The source for the Excel file(s) cannot be found.");
			}

			if (formattingConvention != this.EXCEL_STYLE_ESCAPING && formattingConvention != this.UNIX_STYLE_ESCAPING) {
				throw new Exception("매개변수 오류(formattingConvention) - he value passed to the formattingConvention parameter is out of range.");
			}

			this.separator = separator;
			this.formattingConvention = formattingConvention;

			if (source.isDirectory()) {
				filesList = source.listFiles(new ExcelFilenameFilter());
			} else {
				filesList = new File[] { source };
			}

			
			
			for (File excelFile : filesList) {

				log.debug("Opening XSSFWorkbook- " + excelFile.getName() + " [" + excelFile + "]");

				this.openWorkbook(excelFile, formula);
				/** Truck 운송장은 4번째 로우부터 시작 해서 최대 22번 Cell까지 있다. */
				startRownum = 4;
				lastCellNumber = 22;
				
				
				int sheetNum  = this.workbook.getNumberOfSheets();
				String sheetName = "";
				for(int inx = 0; inx < this.workbook.getNumberOfSheets(); inx++) {
					sheetName =  this.workbook.getSheetName(inx);
					
					// 해상운송, 해상내역, 기록의 Text가 존재하는 Sheet는 작업대상에서 제외함.
					if( sheetName.indexOf("해상운송") > -1 || sheetName.indexOf("해상내역") > -1 || sheetName.indexOf("기록") > -1 ){
						continue;
					}
					log.debug("############   Opening XSSFWorkbook- " + excelFile.getName() + " [" + sheetName + "] Sheet Works Start!!");
					this.endRowFlag4PowerTech = true;	// 새로운 Sheet를 시작할때 true로 초기화
					list = this.convertToCSV4PowerTech(sheetName);
					
					Map<String, Object> tmpMap = new LinkedHashMap();	// Cell Merge Temp Map
					
					
					for(int ix = 0; ix < list.size(); ix++) {
						Map<String, Object> row = list.get(ix);
						if(ix == 0) {
							tmpMap.put("B", row.get("B"));
							tmpMap.put("C", row.get("C"));
							tmpMap.put("D", row.get("D"));
							tmpMap.put("E", row.get("E"));
							tmpMap.put("F", row.get("F"));
							tmpMap.put("G", row.get("G"));
							tmpMap.put("H", row.get("H"));
							
							Map<String, Object> tempMap = new LinkedHashMap();
							Map<String, Object> rowSpanData = new LinkedHashMap();
							rowSpanData.put("SHIPPING_METHOD", list.size());
							rowSpanData.put("INTER_COUNT",list.size());
							rowSpanData.put("WEEK_RECEIVE",list.size());
							rowSpanData.put("TRUCKER_KIND_TEXT",list.size());
							rowSpanData.put("VEHICLE_NO",list.size());
							rowSpanData.put("DRIVER_NAME",list.size());
							rowSpanData.put("PHONE_NO",list.size());
							
							tempMap.put("rowSpan", rowSpanData);
							row.put("_extraData", tempMap);
							
						}else {
							
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("B")))) {
								row.put("B",tmpMap.get("B"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("C")))) {
								row.put("C",tmpMap.get("C"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("D")))) {
								row.put("D",tmpMap.get("D"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("E")))) {
								row.put("E",tmpMap.get("E"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("F")))) {
								row.put("F",tmpMap.get("F"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("G")))) {
								row.put("G",tmpMap.get("G"));
							}
							if("".equalsIgnoreCase(StringUtil.null2String(row.get("H")))) {
								row.put("H",tmpMap.get("H"));
							}
						}
						returnList.add(row);
					}
				}

				

				log.debug("row size = " + returnList.size());
			}
		} catch (Exception ep) {
			// ep.printStackTrace();
			throw ep;
		}

		return returnList;
	}
	
	@SuppressWarnings("static-access")
	private List<Map<String, Object>> read(File file, int headIndex, String sheetName, String distPath, String separator, int formattingConvention, boolean formula) throws Exception {
		File source = file;
		File[] filesList = null;
		List<Map<String, Object>> list = null;
		try {
			if (!source.exists()) {
				throw new Exception("작업 대상 파일을 찾을 수 없습니다.- The source for the Excel file(s) cannot be found.");
			}

			if (formattingConvention != this.EXCEL_STYLE_ESCAPING && formattingConvention != this.UNIX_STYLE_ESCAPING) {
				throw new Exception("매개변수 오류(formattingConvention) - he value passed to the formattingConvention parameter is out of range.");
			}

			this.separator = separator;
			this.formattingConvention = formattingConvention;

			if (source.isDirectory()) {
				filesList = source.listFiles(new ExcelFilenameFilter());
			} else {
				filesList = new File[] { source };
			}

			for (File excelFile : filesList) {

				log.debug("Opening XSSFWorkbook- " + excelFile.getName() + " [" + excelFile + "]");

				this.openWorkbook(excelFile, formula);

				if (headIndex < 0){
					startRownum = 0;
				}else{
					startRownum = headIndex;
				}
					

				list = this.convertToCSV(sheetName);

				log.debug("row size = " + list.size());
			}
		} catch (Exception ep) {
			// ep.printStackTrace();
			throw ep;
		}

		return list;
	}

	@SuppressWarnings("static-access")
	private void openWorkbook(File file, boolean formula) throws Exception {
		InputStream fis = null;
		NPOIFSFileSystem pfs = null;

		try {
			if (file == null) {
				throw new FileNotFoundException("Unable to locate give file..");
			} else {
				fis = new FileInputStream(file);
				/*if (!fis.markSupported()) {
					fis = new PushbackInputStream(fis, 8);
				}

				if (POIFSFileSystem.hasPOIFSHeader(fis)) {
					pfs = new NPOIFSFileSystem(fis);
					EncryptionInfo info = new EncryptionInfo(pfs);
					Decryptor d = Decryptor.getInstance(info);

					if (!d.verifyPassword(d.DEFAULT_PASSWORD)) {
						throw new EncryptedDocumentException("Unable to process: document is encrypted");
					}

					fis = d.getDataStream(pfs);
				}*/

				if (log.isInfoEnabled())
					log.info("available file : " + fis.available());

				this.workbook = new XSSFWorkbook(fis);
				if (formula) {
					this.evaluator = workbook.getCreationHelper().createFormulaEvaluator();
				}
					
				this.formatter = new DataFormatter(true);

				log.debug("created workbook.... OK");
			}
		} catch (Exception ep) {
			log.error("File open Error : " + ep);
			// ep.printStackTrace();
			throw ep;
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
	}

	
	@SuppressWarnings("rawtypes")
	private List convertToCSV4PowerTech(String sheetName) throws Exception {
		XSSFSheet sheet = null;
		XSSFRow row = null;
		int lastRowNum = 0;
		List list = new ArrayList<Map<String, Object>>();

		log.debug("Converting files contents to CSV format(sheet name = " + sheetName + ").");

		sheet = this.workbook.getSheet(sheetName);

		if (sheet != null && sheet.getPhysicalNumberOfRows() > 0) {
			lastRowNum = sheet.getLastRowNum();

			for (int j = startRownum; j <= lastRowNum; j++) {
				if(this.endRowFlag4PowerTech) {	// 유효한 데이터까지 읽고나면 false로 변경됨
					row = sheet.getRow(j);
					Map rowMap = this.rowToCSV4PowerTech(row, (j + 1));

					if (rowMap != null && rowMap.size() > 0) {
						list.add(rowMap);
					}	
				}
				
			}
		} else {
			throw new Exception("There is not found sheet.");
		}

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	private List convertToCSV(String sheetName) throws Exception {
		XSSFSheet sheet = null;
		XSSFRow row = null;
		int lastRowNum = 0;
		List list = new ArrayList<Map<String, Object>>();

		log.debug("Converting files contents to CSV format(sheet name = " + sheetName + ").");

		if (sheetName == null) {
			int numSheets = this.workbook.getNumberOfSheets();

			for (int i = 0; i < numSheets; i++) {
				sheet = this.workbook.getSheetAt(i);

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

			if (sheet != null && sheet.getPhysicalNumberOfRows() > 0) {
				lastRowNum = sheet.getLastRowNum();

				for (int j = startRownum; j <= lastRowNum; j++) {
					row = sheet.getRow(j);
					Map rowMap = this.rowToCSV(row, (j + 1));

					if (rowMap != null && rowMap.size() > 0) {
						list.add(rowMap);
					}
				}
			} else {
				throw new Exception("There is not found sheet.");
			}
		}

		return list;
	}

	
	
	@SuppressWarnings("rawtypes")
	private Map rowToCSV(XSSFRow row, int rownum) throws Exception {
		XSSFCell cell = null;
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
					if (cell.getCellType() == XSSFCell.CELL_TYPE_FORMULA) {
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
					} else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
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
	
	/**
	 * 지정된 Row에 지정된 Cell 만큼 Read
	 * @param row
	 * @param rownum
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	private Map rowToCSV4PowerTech(XSSFRow row, int rownum) throws Exception {
		XSSFCell cell = null;
		int lastCellNum = 0;
		Map<String, Object> csvLine = new LinkedHashMap<String, Object>();
		String emptyTest = null;
		if (row != null) {
			char ch = 'A';
			for (int i = 0; i <= lastCellNumber; i++) {
				cell = row.getCell(i);
				String cellName = Character.toString(ch);
				
				if (cell == null) {
					csvLine.put(cellName, "");
				} else {
					if (cell.getCellType() == XSSFCell.CELL_TYPE_FORMULA) {
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
					} else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
						if (DateUtil.isCellDateFormatted(cell)) {
							SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
							String cellValue = StringUtil.null2String(formatter.format(cell.getDateCellValue()));
							csvLine.put(cellName, cellValue);

							emptyTest += cellValue;
						} else {
							DecimalFormat formatter = new DecimalFormat("0.########");
							String cellValue = StringUtil.null2String(formatter.format(cell.getNumericCellValue()));
							csvLine.put(cellName, cellValue);
							
							if (cellValue != null && (cellValue.indexOf("E") > 0 || cellValue.indexOf("e") > 0)) {
								csvLine.put(cellName, cell.getRawValue().trim());
							}

							emptyTest += cellValue;
						}
					} else if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
						String cellValue  =  StringUtil.null2String(cell.getStringCellValue()).trim();
						if(cellValue.equals("하차지")) {
							break;/* "하차지" 까지만 처리 */
						}
						csvLine.put(cellName, cellValue);
						emptyTest += cellValue;
						
					} else if (cell.getCellType() == XSSFCell.CELL_TYPE_BLANK) {
						csvLine.put(cellName, "");
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
			

			if (emptyTest == null || emptyTest.trim().isEmpty()) {
				this.endRowFlag4PowerTech = this.endRowCheck( csvLine, rownum);
				//log.debug("############# "+ rownum + "번 emptyTest 도중 오류가 발견되었습니다. (Map)csvLine 을 초기화 합니다.- " + csvLine.toString());
				csvLine = null;
			}else {
				//log.debug("############ "+ rownum + "번 row를 완성했습니다. : " + csvLine.toString());
			}
		}

		

		return csvLine;
	}
	
	/**
	 * read row Vaildation Check ( End Row Y/N)
	 * @param csvLine
	 * @param rownum
	 * @return
	 */
	private boolean endRowCheck(Map<String, Object> csvLine, int rownum) {
		
		if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("A"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("A"+rownum)))) {
			if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("B"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("B"+rownum)))) {
				if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("C"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("C"+rownum)))) {
					if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("D"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("D"+rownum)))) {
						if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("E"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("E"+rownum)))) {
							if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("F"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("F"+rownum)))) {
								if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("G"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("G"+rownum)))) {
									if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("H"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("H"+rownum)))) {
										if("BNK".equalsIgnoreCase(StringUtil.null2String(csvLine.get("I"+rownum))) || "".equalsIgnoreCase(StringUtil.null2String(csvLine.get("I"+rownum)))) {
											log.debug("############ "+ rownum + "번 마지막 Row를 만났습니다. 해당 시트에 대한 읽기를 종료합니다. ");
											return false;
										}
									}
								}
							}
						}
					}
				}	
			}
		}
		
		
		return true;
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
			return (name.endsWith(".xlsx"));
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


	@Override
	public List read4PowerTech(File file, int headIndex, String sheetName, String distPath, String separator,
			int formattingConvention, boolean formula) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("static-access")
	public List<Map<String, Object>> read(File file, int headIndex, int sheetNum) throws Exception {
		log.debug("############ read 진입");
		File source = file;
		File[] filesList = null;
		List<Map<String, Object>> list = null;
		try {
			if (!source.exists()) {
				log.debug("작업 대상 파일을 찾을 수 없습니다.- The source for the Excel file(s) cannot be found.");
				throw new Exception("작업 대상 파일을 찾을 수 없습니다.- The source for the Excel file(s) cannot be found.");
			}
			this.separator = this.DEFAULT_SEPARATOR;
			this.formattingConvention = formattingConvention;
			if (source.isDirectory()) {
				filesList = source.listFiles(new ExcelFilenameFilter());
			} else {
				filesList = new File[] { source };
			}
			for (File excelFile : filesList) {
				log.debug("Opening XSSFWorkbook- " + excelFile.getName() + " [" + excelFile + "]");
				this.openWorkbook(excelFile, false);
				if (headIndex < 0){
					startRownum = 0;
				}else{
					startRownum = headIndex;
				}
				list = this.convertToCSV(sheetNum);
				log.debug("row size = " + list.size());
			}
		} catch (Exception ep) {
			ep.printStackTrace();
			throw ep;
		} finally {
			if(source.exists()) {
				// 사용한 파일 삭제 
				source.delete();
			}
			if (!source.isDirectory()) {
				if(file.exists()) {
					// 사용한 파일 삭제 
					file.delete();
				}
			}
			
		}

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	private List convertToCSV(int sheetNum) throws Exception {
		XSSFSheet sheet = null;
		XSSFRow row = null;
		int lastRowNum = 0;
		List list = new ArrayList<Map<String, Object>>();

		log.debug("Converting files contents to CSV format(sheet number = " + sheetNum + ").");

		sheet = this.workbook.getSheetAt(sheetNum);

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
