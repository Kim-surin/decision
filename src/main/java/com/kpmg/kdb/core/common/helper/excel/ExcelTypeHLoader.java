package com.kpmg.kdb.core.common.helper.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.util.Region;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.extendz.MessageResourceExtends;
import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;
import com.kpmg.kdb.util.ExcelUtil;
import com.kpmg.kdb.util.StringUtil;

/**
 * @Description HSSF Type Excel Loader Class
 * @author D.Cat
 * 
 */
@SuppressWarnings("deprecation")
public class ExcelTypeHLoader extends ExcelFileHelper {

	private static Log log = LogFactory.getLog(ExcelTypeHLoader.class);

	private static final int MAX_PER_SHEET_COUNT = ApplicationConstants.EXCEL_SHEET_ROWS; // 시트당최대건수

	public List<Map<String, Object>> read(File file, int headIndex) throws Exception {
		return read(file, headIndex, null);
	}

	public List<Map<String, Object>> read(File file, int headIndex, String sheetName) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		HSSFWorkbook workbook = null;
		HSSFSheet sheet = null;
		Object cellData = null;

		if (!file.exists() || !file.isFile()) {
			throw new Exception("not found file : " + file.getAbsolutePath());
		}

		FileInputStream in = new FileInputStream(file);
		POIFSFileSystem fs = new POIFSFileSystem(in);
		workbook = new HSSFWorkbook(fs);

		// 읽어들일 sheet를 구한다.
		if (sheetName == null || sheetName.isEmpty()) {
			sheet = workbook.getSheetAt(0);
		} else {
			sheet = workbook.getSheet(sheetName);

			if (sheet == null) {
				throw new Exception("There is not found sheet.");
			}
		}

		int rows = sheet.getPhysicalNumberOfRows(); // data row 갯수

		if (log.isInfoEnabled()) {
			log.info("Excel info(File Source : " + file.getAbsolutePath() + ", Sheet Name : " + sheetName + ", ROW count:" + rows + ")");
		}

		if (headIndex < 0) {
			headIndex = 0;
		}

		try {
			if (rows > headIndex) {
				// 엑셀 데이터 추출
				for (int i = headIndex; i < rows; i++) {
					Map<String, Object> hs = new LinkedHashMap<String, Object>();
					boolean emptyCheck = false;

					// data column 갯수
					HSSFRow row = sheet.getRow(i);

					if (row == null) {
						throw new Exception("[ExcelRowLoadException] Excel load failed...");
					}

					int colls = row.getLastCellNum(); // row.getPhysicalNumberOfCells();

					for (int k = 0; k < colls; k++) {
						HSSFCell cell = row.getCell(k);

						if (cell != null) {
							// 숫자타입은 임의적으로 문자열 타입으로 변환시킨다.
							if (HSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()) {
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							}

							switch (cell.getCellType()) {
							case HSSFCell.CELL_TYPE_FORMULA:
								try {
									cellData = StringUtil.null2String(cell.getCellFormula());
								} catch (Exception e) {
									;// cellData =
										// StringUtil.null2String(cell.getStringCellValue()).trim().replace(",",
										// "€");
								}

								break;
							case HSSFCell.CELL_TYPE_NUMERIC:
								if (HSSFDateUtil.isCellDateFormatted(cell)) { // 날짜
									SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
									cellData = StringUtil.null2String(formatter.format(cell.getDateCellValue()));
								} else { // 숫자
									cellData = StringUtil.null2String(cell.getNumericCellValue());
								}
								break;
							case HSSFCell.CELL_TYPE_STRING:
								cellData = StringUtil.null2String(cell.getStringCellValue()).trim();
								cellData = StringUtil.null2String(cellData).replaceAll(",", ""); // 숫자인
																									// 경우
																									// ,를
																									// 제거함
								break;
							case HSSFCell.CELL_TYPE_BLANK:
								cellData = "";
								break;
							case HSSFCell.CELL_TYPE_BOOLEAN:
								cellData = StringUtil.null2String(cell.getBooleanCellValue());
								break;
							case HSSFCell.CELL_TYPE_ERROR:
								cellData = StringUtil.null2String(cell.getErrorCellValue());
								break;
							default:
								cellData = StringUtil.null2String(cell.getRichStringCellValue());
							}

							if (i == headIndex || i == (rows - 1)) {

								log.debug("(" + i + "row) Cell type = " + cell.getCellType() + ", data = " + cellData);
							}
						} else {
							cellData = "";
						}

						hs.put("COL_" + k, cellData);

						if (cellData != null && !"".equals(cellData)) {
							emptyCheck = true;
						}
					}

					if (emptyCheck) { // 데이터가 없는 경우엔 예외처리한다.
						list.add(hs);
					}
				}
			}
		} catch (Exception e) {
			if (log.isErrorEnabled())
				log.error(e);
			throw e;
		} finally {
			if (in != null)
				in.close();
		}

		log.debug("File contents size = " + list.size());

		return list;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void write(List list, File file) throws Exception {
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(file);

			ExcelCommmonVo vo = ExcelUtil.convExcelVo(list, null);
			String[] columns = ExcelUtil.transformColumns((Map<String, Object>) list.get(0));

			write(vo, out, columns);
		} catch (Exception ex) {
			if (out != null)
				out.close();
		}
	}

	@SuppressWarnings("rawtypes")
	public void write(List list, File file, String[] columns) throws Exception {
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(file);

			ExcelCommmonVo vo = ExcelUtil.convExcelVo(list, file.getName());

			write(vo, out, columns);
		} catch (Exception ex) {
			if (out != null)
				out.close();
		}
	}

	@SuppressWarnings("unchecked")
	public void view(List<List<Map<String, Object>>> list, HSSFWorkbook workbook) throws Exception {
		ExcelCommmonVo vo = null;
		String[] columns = null;
		int startSheet = 0;

		if (list != null && list.size() > 0) {
			// list 에는 1개이상의 엑셀시트를 포함하고 있음
			for (int si = 0; si < list.size(); si++) {
				List<Map<String, Object>> sheetList = (List<Map<String, Object>>) list.get(si);

				int lastIndex = sheetList.size() - 1;

				if (sheetList.get(lastIndex) != null) {
					Map<String, Object> map = sheetList.get(lastIndex);
					Object colObj = map.get("headers");
					String sheetName = StringUtil.null2String(map.get("sheet"), "sheet");

					if (colObj != null && colObj instanceof List) {
						List<Object> colList = (List<Object>) colObj;

						// 해더정보를 제외한 row data를 구한다.
						sheetList.remove(lastIndex);
						vo = ExcelUtil.convExcelVo(sheetList, sheetName);

						if (colList != null && colList.size() > 0) {
							startSheet = build(vo, workbook, colList, startSheet);
						}
					} else {
						vo = ExcelUtil.convExcelVo(sheetList, sheetName);
						columns = ExcelUtil.transformColumns((Map<String, Object>) sheetList.get(0));

						build(vo, workbook, columns);
					}
				}
			}
		} else {
			build(vo, workbook, columns);
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public void view(List<List<Map<String, Object>>> list, HSSFWorkbook workbook, Map<String, Object> param) throws Exception {
		ExcelCommmonVo vo = null;
		String[] columns = null;
		int startSheet = 0;

		if (list != null && list.size() > 0) {
			// list 에는 1개이상의 엑셀시트를 포함하고 있음
			for (int si = 0; si < list.size(); si++) {
				List<Map<String, Object>> sheetList = (List<Map<String, Object>>) list.get(si);

				int lastIndex = sheetList.size() - 1;

				if (sheetList.get(lastIndex) != null) {
					
					Object colObj = param.get("headers");
					
					
					ObjectMapper mapper = new ObjectMapper();
			    	List columnObject = mapper.readValue(org.apache.commons.lang.StringEscapeUtils.unescapeHtml(String.valueOf(colObj)), new TypeReference<List<Object>>(){});
			    	
					String sheetName = StringUtil.null2String(param.get("sheetname"), "sheet");

					if (columnObject != null && columnObject instanceof List) {
						List<Object> colList = (List<Object>) columnObject;


						if("TOAST_GRID".equalsIgnoreCase(StringUtil.null2String(param.get("EXCEL_EXPORT_TYPE")))) {
							vo = ExcelUtil.convExcelVo(sheetList, sheetName);

							if (colList != null && colList.size() > 0) {
								startSheet = build(vo, workbook, colList, startSheet,"TOAST_GRID");
							}
						}else {
							//Toast Grid가 아닌경우에만 해더 정보를 제외하고 Row Data를 구한다.
							// 해더정보를 제외한 row data를 구한다.
							sheetList.remove(lastIndex);		
							
							vo = ExcelUtil.convExcelVo(sheetList, sheetName);

							if (colList != null && colList.size() > 0) {
								startSheet = build(vo, workbook, colList, startSheet);
							}
						}

						
					} else {
						vo = ExcelUtil.convExcelVo(sheetList, sheetName);
						columns = ExcelUtil.transformColumns((Map<String, Object>) sheetList.get(0));

						build(vo, workbook, columns);
					}
				}
			}
		} else {
			build(vo, workbook, columns);
		}
	}

	private void write(ExcelCommmonVo pVO, OutputStream out, String[] columns) throws Exception {
		HSSFWorkbook workbook = null;

		try {
			workbook = new HSSFWorkbook();

			build(pVO, workbook, columns);

			workbook.write(out);
		} catch (IOException ex) {
			throw ex;
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException ex) {
				throw (IOException) new IOException("workbook write error.").initCause(ex);
			}
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private int build(ExcelCommmonVo pVO, HSSFWorkbook workbook, List colList, int startSheet) throws Exception {

		log.debug("excel build start....");

		HSSFSheet sheet = null;
		HSSFRow row = null;

		int total = pVO.size(); // 데이터 전체 갯수
		int sheetCnt = total / MAX_PER_SHEET_COUNT; // 시트 갯수
		int startCnt = 0; // 기록할 row index 번호
		int endCnt = 0;

		// 해더 속성
		String field = null; // 컬럼명
		String title = null; // 해더명
		int width = 0; // 넓이
		boolean hidden = true; // 숨김:true, 보임:false
		String format = null;
		int mergeRow = 0; // 머지열수
		int mergeCol = 0; // 머지행수

		// 시트갯수 및 시트명과 번호 셋팅
		if ((sheetCnt * MAX_PER_SHEET_COUNT) <= total)
			sheetCnt++;

		for (int jnx = 1; jnx <= sheetCnt; jnx++) {
			String sname = StringUtil.null2String(pVO.getName(), "Sheet" + (jnx));
			if (jnx > 0)
				sname = sname + "(" + jnx + ")";

			log.debug("sheet name = " + sname + ", sheet number = " + (startSheet + (jnx - 1)) + ", row count(per sheet) = " + MAX_PER_SHEET_COUNT);

			// 시트 생성
			if (workbook.getSheet(sname) == null) {
				sheet = workbook.createSheet(sname);
			}

			// 폰트 색상
			HSSFFont font_01 = workbook.createFont();
			font_01.setColor(HSSFColor.BLACK.index);
			font_01.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

			HSSFFont font_02 = workbook.createFont();
			font_02.setColor(HSSFColor.DARK_GREEN.index);

			int rownum = 0;
			List header_list = new LinkedList(); // 해더의 열이 두개인 경우를 처리하기 위한 임시객체

			for (int c = 0; c < colList.size(); c++) { // 해더 작성부분
				// 해더의 style 선언
				HSSFCellStyle cs = workbook.createCellStyle();
				cs.setFont(font_01);

				Object colListObj = colList.get(c);

				if (colListObj != null && colListObj instanceof List) {
					List list = (List) colListObj;
					int idex = 0;

					// excel add row
					row = sheet.createRow((short) c);

					for (int m = 0; m < list.size(); m++) { // 해더의 column 수만큼
															// Loop...
						Object colMapObj = list.get(m);

						if (colMapObj != null && colMapObj instanceof Map) {
							Map map = (Map) colMapObj;

							field = StringUtil.null2String(map.get("field"));
							title = StringUtil.null2String(map.get("title"));
							width = StringUtil.null2zero(map.get("width"));
							hidden = StringUtil.null2boolean(map.get("hidden"), false);
							format = StringUtil.null2String(map.get("formatter"));
							mergeRow = StringUtil.null2zero(map.get("merge_row"));
							mergeCol = StringUtil.null2zero(map.get("merge_col"));

							log.debug(map);

							// 해더 부분 작성
							// 1. 해더 merge 처리
							// 2. 마지막 해더에 row를 머지한 file ID 저장
							if (!hidden) {
								// excel add cell
								if (c == 0) {
									// 첫번째 열을 생성한다. 이때 Merge 설정이 있으면 실행한다.
									makeCell(idex, row, title, cs, "header");

									int start_col = 0; // 시작행
									int start_row = 0; // 시작열
									int end_col = 0; // 종료행
									int end_row = 0; // 종료열

									if (mergeRow > 0) {
										start_col = idex;
										start_row = 0;
										end_col = start_col;
										end_row = 1;

										sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col));

										sheet.setColumnWidth(idex, width); // 넓이
																			// 조정
										header_list.add(end_col, map);
									} else if (mergeCol > 0) {
										start_col = idex;
										start_row = 0;
										end_col = start_col + (mergeCol - 1);
										end_row = 0;

										sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col)); // 행,
																																	// 열,
																																	// 행,
																																	// 열

										for (int i = idex; i <= end_col; i++) {
											header_list.add(i, null);
											log.debug("index(" + i + ") is null");
										}
									} else {
										sheet.setColumnWidth(idex, width); // 넓이
																			// 조정

										header_list.add(idex, map);
									}

									log.debug("s_col:" + start_col + ", s_row:" + start_row + ", e_col:" + end_col + ", e_row:" + end_row);
								} else {
									// 두번째 행부터는 colspan한 상위열의 순서대로 등록한다.
									int header_size = header_list.size();

									for (int i = 0; i < header_size; i++) {
										if (header_list.get(i) == null) {
											makeCell(i, row, title, cs, "header");
											sheet.setColumnWidth(i, width); // 넓이
																			// 조정

											header_list.set(i, map); // 비어있는
																		// 배열index에
																		// 순서대로
																		// 등록한다.

											log.debug("header size(" + header_size + ") / list(" + i + ")=" + map);
											break;
										}
									}
								}

								if (mergeCol > 0) {
									idex = idex + 1 + (mergeCol - 1);
								} else {
									idex++;
								}
							}
						}
					}
					// cell이 비어있는 부분에 style을 적용한다.
					for (int i = 0; i < header_list.size(); i++) {
						HSSFCell cell = row.getCell(i);
						if (cell == null) {
							cell = row.createCell(i);
							cell.setCellStyle(getCellFormat(cs, "header"));
						}
					}

					rownum++;
				}else if (colList != null && colList instanceof List) {
					
					List list = (List) colList;
					int idex = 0;

					// excel add row
					row = sheet.createRow((short) c);

					for (int m = 0; m < list.size(); m++) { // 해더의 column 수만큼
															// Loop...
						Object colMapObj = list.get(m);

						if (colMapObj != null && colMapObj instanceof Map) {
							Map map = (Map) colMapObj;

							field = StringUtil.null2String(map.get("field"));
							title = StringUtil.null2String(map.get("title"));
							width = StringUtil.null2zero(map.get("width"));
							hidden = StringUtil.null2boolean(map.get("hidden"), false);
							format = StringUtil.null2String(map.get("formatter"));
							mergeRow = StringUtil.null2zero(map.get("merge_row"));
							mergeCol = StringUtil.null2zero(map.get("merge_col"));

							log.debug(map);

							// 해더 부분 작성
							// 1. 해더 merge 처리
							// 2. 마지막 해더에 row를 머지한 file ID 저장
							if (!hidden) {
								// excel add cell
								if (c == 0) {
									// 첫번째 열을 생성한다. 이때 Merge 설정이 있으면 실행한다.
									makeCell(idex, row, title, cs, "header");

									int start_col = 0; // 시작행
									int start_row = 0; // 시작열
									int end_col = 0; // 종료행
									int end_row = 0; // 종료열

									if (mergeRow > 0) {
										start_col = idex;
										start_row = 0;
										end_col = start_col;
										end_row = 1;

										sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col));

										sheet.setColumnWidth(idex, width); // 넓이
																			// 조정
										header_list.add(end_col, map);
									} else if (mergeCol > 0) {
										start_col = idex;
										start_row = 0;
										end_col = start_col + (mergeCol - 1);
										end_row = 0;

										sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col)); // 행,
																																	// 열,
																																	// 행,
																																	// 열

										for (int i = idex; i <= end_col; i++) {
											header_list.add(i, null);
											log.debug("index(" + i + ") is null");
										}
									} else {
										sheet.setColumnWidth(idex, width); // 넓이
																			// 조정

										header_list.add(idex, map);
									}

									log.debug("s_col:" + start_col + ", s_row:" + start_row + ", e_col:" + end_col + ", e_row:" + end_row);
								} else {
									// 두번째 행부터는 colspan한 상위열의 순서대로 등록한다.
									int header_size = header_list.size();

									for (int i = 0; i < header_size; i++) {
										if (header_list.get(i) == null) {
											makeCell(i, row, title, cs, "header");
											sheet.setColumnWidth(i, width); // 넓이
																			// 조정

											header_list.set(i, map); // 비어있는
																		// 배열index에
																		// 순서대로
																		// 등록한다.

											log.debug("header size(" + header_size + ") / list(" + i + ")=" + map);
											break;
										}
									}
								}

								if (mergeCol > 0) {
									idex = idex + 1 + (mergeCol - 1);
								} else {
									idex++;
								}
							}
						}
					}
					// cell이 비어있는 부분에 style을 적용한다.
					for (int i = 0; i < header_list.size(); i++) {
						HSSFCell cell = row.getCell(i);
						if (cell == null) {
							cell = row.createCell(i);
							cell.setCellStyle(getCellFormat(cs, "header"));
						}
					}

					rownum++;
				}
			}

			if (total > 0) { // 본부 작성 부분
				// 본문의 style 선언
				HSSFCellStyle cs = workbook.createCellStyle();
				cs.setFont(font_02);

				startCnt = MAX_PER_SHEET_COUNT * (jnx - 1);
				endCnt = (MAX_PER_SHEET_COUNT - 1) + MAX_PER_SHEET_COUNT * (jnx - 1);

				if (endCnt > total)
					endCnt = total - 1;

				for (int n = startCnt; n <= endCnt; n++) {
					Object colValue = null;
					Object colListObj = header_list;// colList.get(colList.size()-1);

					if (colListObj != null && colListObj instanceof List) {
						List list = (List) colListObj;
						int idex = 0;

						// excel add row
						row = sheet.createRow((short) rownum);

						for (int m = 0; m < list.size(); m++) {
							Object colMapObj = list.get(m);

							if (colMapObj != null && colMapObj instanceof Map) {
								Map map = (Map) colMapObj;

								field = StringUtil.null2String(map.get("field"), String.valueOf(map.get("name")));
								hidden = StringUtil.null2boolean(map.get("hidden"), true);
								format = StringUtil.null2String(map.get("formatter"));

								if (!hidden) {
									colValue = pVO.getString(n, field);
									makeCell(idex, row, colValue, cs, "contents", format);

									idex++;
								}
							}
						}
					}
					rownum++;
				}
			}
			startSheet++; // 시트번호
		}

		log.debug("excel build end.");

		return startSheet;
	}
	
	
	
	
	
	/***
	 * Toast Grid 용 Excel Builder
	 * @param pVO
	 * @param workbook
	 * @param colList
	 * @param startSheet
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private int build(ExcelCommmonVo pVO, HSSFWorkbook workbook, List colList, int startSheet, String builderType) throws Exception {

		log.debug("excel build start....");

		HSSFSheet sheet = null;
		HSSFRow row = null;

		int total = pVO.size(); // 데이터 전체 갯수
		int sheetCnt = total / MAX_PER_SHEET_COUNT; // 시트 갯수
		int startCnt = 0; // 기록할 row index 번호
		int endCnt = 0;

		// 해더 속성
		String field = null; // 컬럼명
		String title = null; // 해더명
		int width = 0; // 넓이
		boolean hidden = true; // 숨김:true, 보임:false
		String format = null;
		int mergeRow = 0; // 머지열수
		int mergeCol = 0; // 머지행수

		// 시트갯수 및 시트명과 번호 셋팅
		if ((sheetCnt * MAX_PER_SHEET_COUNT) <= total)
			sheetCnt++;

		for (int jnx = 1; jnx <= sheetCnt; jnx++) {
			String sname = StringUtil.null2String(pVO.getName(), "Sheet" + (jnx));
			if (jnx > 0)
				sname = sname + "(" + jnx + ")";

			log.debug("sheet name = " + sname + ", sheet number = " + (startSheet + (jnx - 1)) + ", row count(per sheet) = " + MAX_PER_SHEET_COUNT);

			// 시트 생성
			if (workbook.getSheet(sname) == null) {
				sheet = workbook.createSheet(sname);
			}

			// 폰트 색상
			HSSFFont font_01 = workbook.createFont();
			font_01.setColor(HSSFColor.BLACK.index);
			font_01.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

			HSSFFont font_02 = workbook.createFont();
			font_02.setColor(HSSFColor.DARK_GREEN.index);

			int rownum = 0;
			List header_list = new LinkedList(); // 해더의 열이 두개인 경우를 처리하기 위한 임시객체

			// 해더의 style 선언
			HSSFCellStyle cs = workbook.createCellStyle();
			cs.setFont(font_01);

			if (colList != null && colList instanceof List) { // 해더 작성부분
				
				List list = (List) colList;
				int idex = 0;

				// excel add row
				row = sheet.createRow((short) 0);

				for (int m = 0; m < list.size(); m++) { // 해더의 column 수만큼
														// Loop...
					Object colMapObj = list.get(m);

					if (colMapObj != null && colMapObj instanceof Map) {
						Map map = (Map) colMapObj;

						field = StringUtil.null2String(map.get("field"));
						title = StringUtil.null2String(map.get("title"));
						width = StringUtil.null2zero(map.get("width"));
						hidden = StringUtil.null2boolean(map.get("hidden"), false);
						format = StringUtil.null2String(map.get("formatter"));
						mergeRow = StringUtil.null2zero(map.get("merge_row"));
						mergeCol = StringUtil.null2zero(map.get("merge_col"));

						log.debug(map);

						// 해더 부분 작성
						// 1. 해더 merge 처리
						// 2. 마지막 해더에 row를 머지한 file ID 저장
						if (!hidden) {
							// excel add cell
							// 첫번째 열을 생성한다. 이때 Merge 설정이 있으면 실행한다.
							makeCell(idex, row, title, cs, "header");

							int start_col = 0; // 시작행
							int start_row = 0; // 시작열
							int end_col = 0; // 종료행
							int end_row = 0; // 종료열

							if (mergeRow > 0) {
								start_col = idex;
								start_row = 0;
								end_col = start_col;
								end_row = 1;

								sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col));

								sheet.setColumnWidth(idex, width); // 넓이
																	// 조정
								header_list.add(end_col, map);
							} else if (mergeCol > 0) {
								start_col = idex;
								start_row = 0;
								end_col = start_col + (mergeCol - 1);
								end_row = 0;

								sheet.addMergedRegion(new Region(start_row, (short) start_col, end_row, (short) end_col)); // 행,
																															// 열,
																															// 행,
																															// 열

								for (int i = idex; i <= end_col; i++) {
									header_list.add(i, null);
									log.debug("index(" + i + ") is null");
								}
							} else {
								sheet.autoSizeColumn(idex);
								sheet.setColumnWidth(idex, sheet.getColumnWidth(idex)+512); // 넓이 조정

								header_list.add(idex, map);
							}

							log.debug("s_col:" + start_col + ", s_row:" + start_row + ", e_col:" + end_col + ", e_row:" + end_row);

							if (mergeCol > 0) {
								idex = idex + 1 + (mergeCol - 1);
							} else {
								idex++;
							}
						}
					}
				}
				// cell이 비어있는 부분에 style을 적용한다.
				for (int i = 0; i < header_list.size(); i++) {
					HSSFCell cell = row.getCell(i);
					if (cell == null) {
						cell = row.createCell(i);
						cell.setCellStyle(getCellFormat(cs, "header"));
					}
				}

				rownum++;
			}
			

			if (total > 0) { // 본부 작성 부분
				// 본문의 style 선언
				HSSFCellStyle cs2 = workbook.createCellStyle();
				cs2.setFont(font_02);

				startCnt = MAX_PER_SHEET_COUNT * (jnx - 1);
				endCnt = (MAX_PER_SHEET_COUNT - 1) + MAX_PER_SHEET_COUNT * (jnx - 1);

				if (endCnt > total)
					endCnt = total - 1;

				for (int n = startCnt; n <= endCnt; n++) {
					Object colValue = null;
					Object colListObj = header_list;// colList.get(colList.size()-1);

					if (colListObj != null && colListObj instanceof List) {
						List list = (List) colListObj;
						int idex = 0;

						// excel add row
						row = sheet.createRow((short) rownum);

						for (int m = 0; m < list.size(); m++) {
							Object colMapObj = list.get(m);

							if (colMapObj != null && colMapObj instanceof Map) {
								Map map = (Map) colMapObj;

								field = StringUtil.null2String(map.get("field"), String.valueOf(map.get("name")));
								hidden = StringUtil.null2boolean(map.get("hidden"), true);
								format = StringUtil.null2String(map.get("formatter"));

								if (!hidden) {
									colValue = pVO.getString(n, field) == null ? "" :  (pVO.getString(n, field)).trim();
									makeCell(idex, row, colValue, cs2, "contents", format);

									idex++;
								}
							}
						}
					}
					rownum++;
				}
			}
			startSheet++; // 시트번호
		}

		log.debug("excel build end.");

		return startSheet;
	}

	private void build(ExcelCommmonVo pVO, HSSFWorkbook workbook, String[] columns) throws Exception {
		HSSFSheet sheet = null;
		HSSFRow row = null;

		int total = pVO.size(); // 데이터 전체 갯수
		int sheetCnt = total / MAX_PER_SHEET_COUNT; // 시트 갯수
		int startCnt = 0; // load할 index시작 번호
		int endCnt = 0;

		// 시트갯수
		if ((sheetCnt * MAX_PER_SHEET_COUNT) < total)
			sheetCnt++;

		for (int jnx = 1; jnx <= sheetCnt; jnx++) {
			String sname = StringUtil.null2String(pVO.getName(), "Sheet") + jnx;

			log.debug("sheet name = " + sname + ", sheet number = " + (startCnt + (jnx - 1)) + ", row count(per sheet) = " + MAX_PER_SHEET_COUNT);

			// 시트 생성
			if (workbook.getSheet(sname) == null) {
				sheet = workbook.createSheet(sname);
			}

			// excel add row
			row = sheet.createRow((short) 0);

			// 해더 부분 작성
			for (int c = 0; c < columns.length; c++) {
				String colName = StringUtil.null2String(columns[c]);

				if (!StringUtil.isNull(colName)) {
					colName = MessageResourceExtends.getMessageInstance().getMessage("TXT_" + colName);
					makeCell(c, row, colName, workbook.createCellStyle(), "header");
				}
			}

			startCnt = MAX_PER_SHEET_COUNT * (jnx - 1);
			endCnt = (MAX_PER_SHEET_COUNT - 1) + MAX_PER_SHEET_COUNT * (jnx - 1);

			if (endCnt > total)
				endCnt = total - 1;

			for (int n = startCnt; n <= endCnt; n++) {
				String colName = null;
				Object colValue = null;

				// excel add row
				row = sheet.createRow((short) n + 1);

				for (int i = 0; i < columns.length; i++) {
					colName = columns[i];

					if (!StringUtil.isNull(colName)) {
						colValue = pVO.get(n, colName);
						makeCell(i, row, colValue, workbook.createCellStyle(), "contents");
					}
				}
			}
		}

	}

	private void makeCell(int col, HSSFRow row, Object columnValue, HSSFCellStyle cellStyle, String type) throws Exception {
		makeCell(col, row, columnValue, cellStyle, type, null);
	}

	private void makeCell(int col, HSSFRow row, Object columnValue, HSSFCellStyle cellStyle, String type, String format) throws Exception {
		HSSFCell cell = row.createCell(col);

		if (columnValue instanceof Number) {
			cell.setCellValue(Double.parseDouble(StringUtil.null2String(columnValue)));
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		} else if (columnValue instanceof Date) {
			cell.setCellValue((Date) columnValue);
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		} else if (columnValue instanceof Boolean) {
			cell.setCellValue((Boolean) columnValue);
			cell.setCellType(HSSFCell.CELL_TYPE_BOOLEAN);
		} else {
			if (!StringUtil.isNull(format)) {
				if (format.equals("percent") && columnValue != null) {
					double value = Double.parseDouble(StringUtil.null2String(columnValue, "0")) * 100;
					cell.setCellValue(String.valueOf(value + "%"));
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				} else {
					cell.setCellValue(StringUtil.unescape(StringUtil.null2String(columnValue)));
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				}
			} else {
				if (columnValue == null) {
					cell.setCellValue("");
					cell.setCellType(HSSFCell.CELL_TYPE_BLANK);
				} else {
					cell.setCellValue(StringUtil.unescape(StringUtil.null2String(columnValue)));
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				}
			}
		}

		if (cellStyle != null) {
			cell.setCellStyle(getCellFormat(cellStyle, type)); // set cell style
		}
	}

	private HSSFCellStyle getCellFormat(HSSFCellStyle cellStyle, String type) throws Exception {
		if (type.equals("header")) {
			cellStyle.setFillBackgroundColor(new HSSFColor.LIGHT_BLUE().getIndex());
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			cellStyle.setLocked(true);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		} else if (type.equals("contents")) {
			cellStyle.setFillBackgroundColor(new HSSFColor.WHITE().getIndex());
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_DOTTED);
			cellStyle.setBorderTop(HSSFCellStyle.BORDER_DOTTED);
			cellStyle.setBorderLeft(HSSFCellStyle.BORDER_DOTTED);
			cellStyle.setBorderRight(HSSFCellStyle.BORDER_DOTTED);
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		}

		return cellStyle;
	}

	@SuppressWarnings("rawtypes")
	public List read(File file, int index, String id, boolean formula) throws Exception {
		return this.read(file, index, id);
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
	public List read4PowerTech(File file, String id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	public List<Map<String, Object>> read(File file, int headIndex, int sheetNum) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		HSSFWorkbook workbook = null;
		HSSFSheet sheet = null;
		Object cellData = null;

		if (!file.exists() || !file.isFile()) {
			throw new Exception("not found file : " + file.getAbsolutePath());
		}

		FileInputStream in = new FileInputStream(file);
		POIFSFileSystem fs = new POIFSFileSystem(in);
		workbook = new HSSFWorkbook(fs);

		// 읽어들일 sheet를 구한다.
		sheet = workbook.getSheetAt(sheetNum);

		int rows = sheet.getPhysicalNumberOfRows(); // data row 갯수

		if (log.isInfoEnabled()) {
			log.info("Excel info(File Source : " + file.getAbsolutePath() + ", Sheet Number : " + sheetNum + ", ROW count:" + rows + ")");
		}

		if (headIndex < 0) {
			headIndex = 0;
		}

		try {
			if (rows > headIndex) {
				// 엑셀 데이터 추출
				for (int i = headIndex; i < rows; i++) {
					Map<String, Object> hs = new LinkedHashMap<String, Object>();
					boolean emptyCheck = false;

					// data column 갯수
					HSSFRow row = sheet.getRow(i);

					if (row == null) {
						throw new Exception("[ExcelRowLoadException] Excel load failed...");
					}

					int colls = row.getLastCellNum(); // row.getPhysicalNumberOfCells();

					for (int k = 0; k < colls; k++) {
						HSSFCell cell = row.getCell(k);

						if (cell != null) {
							// 숫자타입은 임의적으로 문자열 타입으로 변환시킨다.
							if (HSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()) {
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							}

							switch (cell.getCellType()) {
							case HSSFCell.CELL_TYPE_FORMULA:
								try {
									cellData = StringUtil.null2String(cell.getCellFormula());
								} catch (Exception e) {
									;// cellData =
										// StringUtil.null2String(cell.getStringCellValue()).trim().replace(",",
										// "€");
								}

								break;
							case HSSFCell.CELL_TYPE_NUMERIC:
								if (HSSFDateUtil.isCellDateFormatted(cell)) { // 날짜
									SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
									cellData = StringUtil.null2String(formatter.format(cell.getDateCellValue()));
								} else { // 숫자
									cellData = StringUtil.null2String(cell.getNumericCellValue());
								}
								break;
							case HSSFCell.CELL_TYPE_STRING:
								cellData = StringUtil.null2String(cell.getStringCellValue()).trim();
								cellData = StringUtil.null2String(cellData).replaceAll(",", ""); // 숫자인
																									// 경우
																									// ,를
																									// 제거함
								break;
							case HSSFCell.CELL_TYPE_BLANK:
								cellData = "";
								break;
							case HSSFCell.CELL_TYPE_BOOLEAN:
								cellData = StringUtil.null2String(cell.getBooleanCellValue());
								break;
							case HSSFCell.CELL_TYPE_ERROR:
								cellData = StringUtil.null2String(cell.getErrorCellValue());
								break;
							default:
								cellData = StringUtil.null2String(cell.getRichStringCellValue());
							}

							if (i == headIndex || i == (rows - 1)) {

								log.debug("(" + i + "row) Cell type = " + cell.getCellType() + ", data = " + cellData);
							}
						} else {
							cellData = "";
						}

						hs.put("COL_" + k, cellData);

						if (cellData != null && !"".equals(cellData)) {
							emptyCheck = true;
						}
					}

					if (emptyCheck) { // 데이터가 없는 경우엔 예외처리한다.
						list.add(hs);
					}
				}
			}
		} catch (Exception e) {
			if (log.isErrorEnabled())
				log.error(e);
			throw e;
		} finally {
			if (in != null)
				in.close();
		}

		log.debug("File contents size = " + list.size());

		return list;
	}


}
