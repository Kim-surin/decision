package com.kpmg.kdb.web.ts.inspection;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;


@Service
@SuppressWarnings({ "rawtypes" })
public class InspectionResService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(InspectionResService.class);
    
    
    /**
     * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooCertSearchPopupList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(InspectionResDao.class).retrieveCooCertSearchPopupList(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 실사 대응 서류 > 마스터 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooAuditDocumentInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		Map<String, Object> cooAuditDocumentInfoMap = sqlSession.getMapper(InspectionResDao.class).retrieveCooAuditDocumentInfo(param);
    		
    		result.setValue(cooAuditDocumentInfoMap);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 실사 대응 서류 > 확인서 정보 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooAuditDocumentDetailList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(InspectionResDao.class).retrieveCooAuditDocumentDetailList(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 실사 대응 서류 > 소요량 명세서 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieveBillOfMaterials(Map<String, Object> param){
    	
    	List<Map<String, Object>> list = null;
    	try {
    		list = sqlSession.getMapper(InspectionResDao.class).retrieveBillOfMaterials(param);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return list;
    }
    
    public byte[] createBomExcel(List<Map<String, Object>> list) throws Exception {
        if (list == null || list.isEmpty()) {
            throw new IllegalArgumentException("엑셀로 다운로드할 데이터가 없습니다.");
        }

        Workbook workbook = new XSSFWorkbook();
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            Map<String, Object> first = list.get(0);

            String productCode = getString(first.get("customer_product_code"));
            String productName = getString(first.get("product_name"));
            String ftaName = getString(first.get("fta_name"));
            String hsCode = getString(first.get("product_hs_code"));

            String sheetName = (productCode == null || productCode.trim().isEmpty())
                    ? "BOM" : productCode + "_BOM";

            Sheet sheet = workbook.createSheet(sheetName);

            CellStyle titleStyle = createTitleStyle(workbook);
            CellStyle headerStyle = createHeaderStyle(workbook);
            CellStyle leftStyle = createLeftStyle(workbook);
            CellStyle centerStyle = createCenterStyle(workbook);
            CellStyle rightStyle = createRightStyle(workbook);
            CellStyle money2Style = createMoneyStyle(workbook, "#,##0.00");
            CellStyle money6Style = createMoneyStyle(workbook, "#,##0.000000");
            CellStyle percentStyle = createMoneyStyle(workbook, "0.00%");

            int rowIdx = 0;

            Row row = sheet.createRow(rowIdx++);
            row.setHeightInPoints(25);
            createCell(row, 0, "소요부품 명세서(Bill of Materials)", titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 17));

            row = sheet.createRow(rowIdx++);
            createCell(row, 1, "□ 제품품명 :", leftStyle);
            createCell(row, 2, productName + " (HS CODE : " + hsCode + ")", leftStyle);

            row = sheet.createRow(rowIdx++);
            createCell(row, 1, "□ 제품번호 :", leftStyle);
            createCell(row, 2, productCode, leftStyle);

            row = sheet.createRow(rowIdx++);
            createCell(row, 1, "□ 적용협정 :", leftStyle);
            createCell(row, 2, ftaName + " FTA", leftStyle);

            row = sheet.createRow(rowIdx++);
            createCell(row, 1, "□ 원재료 사용내역", leftStyle);

            rowIdx++;

            row = sheet.createRow(rowIdx++);
            int col = 0;
            createCell(row, col++, "순", headerStyle);
            createCell(row, col++, "재료명", headerStyle);
            createCell(row, col++, "", headerStyle);
            createCell(row, col++, "품번", headerStyle);
            createCell(row, col++, "세번부호\n(HS No)", headerStyle);
            createCell(row, col++, "원산지", headerStyle);
            createCell(row, col++, "최소\n기준", headerStyle);
            createCell(row, col++, "단위", headerStyle);
            createCell(row, col++, "소요량", headerStyle);
            createCell(row, col++, "(단가)", headerStyle);
            createCell(row, col++, "가격(원)", headerStyle);
            createCell(row, col++, "구성비", headerStyle);
            createCell(row, col++, "", headerStyle);
            createCell(row, col++, "제조자", headerStyle);
            createCell(row, col++, "구매처", headerStyle);
            createCell(row, col++, "입증서류\n(확인서 번호)", headerStyle);
            createCell(row, col++, "연락처", headerStyle);
            createCell(row, col++, "대체가능\n재료", headerStyle);

            sheet.addMergedRegion(new CellRangeAddress(rowIdx - 1, rowIdx - 1, 1, 2));

            int seq = 1;

            for (Map<String, Object> data : list) {
                row = sheet.createRow(rowIdx);
                col = 0;

                createCell(row, col++, seq++, rightStyle);

                createCell(row, col++, getString(data.get("item_name")), leftStyle);
                createCell(row, col++, "", leftStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowIdx, rowIdx, 1, 2));

                createCell(row, col++, getString(data.get("item_code")), leftStyle);
                createCell(row, col++, getString(data.get("item_hs_code")), centerStyle);
                createCell(row, col++, getString(data.get("origin")), centerStyle);
                createCell(row, col++, "", centerStyle);
                createCell(row, col++, getString(data.get("unit")), centerStyle);

                createCell(row, col++, getBigDecimal(data.get("item_requirement_qty")), money6Style);
                createCell(row, col++, getBigDecimal(data.get("item_input_price")), money2Style);
                createCell(row, col++, getBigDecimal(data.get("item_input_amount")), money2Style);
                createCell(row, col++, getBigDecimal(data.get("item_rate")), percentStyle);

                createCell(row, col++, "", centerStyle);
                createCell(row, col++, getString(data.get("vendor_name")), leftStyle);
                createCell(row, col++, getString(data.get("division_name")), leftStyle);
                createCell(row, col++, getString(data.get("ext_coo_certify_no")), leftStyle);
                createCell(row, col++, getString(data.get("tel_no")), leftStyle);
                createCell(row, col++, "", centerStyle);

                rowIdx++;
            }

            rowIdx += 2;

            BigDecimal originAmt = getBigDecimal(first.get("prod_origin_amount"));
            BigDecimal nonoriginAmt = getBigDecimal(first.get("prod_nonorigin_amount"));
            BigDecimal inputAmt = getBigDecimal(first.get("prod_input_amount"));

            row = sheet.createRow(rowIdx++);
            createCell(row, 9, "역내산 합계", leftStyle);
            createCell(row, 10, originAmt, money2Style);
            if (inputAmt.compareTo(BigDecimal.ZERO) > 0) {
                createCell(row, 11, originAmt.divide(inputAmt, 8, RoundingMode.UP), percentStyle);
            }

            row = sheet.createRow(rowIdx++);
            createCell(row, 9, "역외산 합계", leftStyle);
            createCell(row, 10, nonoriginAmt, money2Style);
            if (inputAmt.compareTo(BigDecimal.ZERO) > 0) {
                createCell(row, 11, nonoriginAmt.divide(inputAmt, 8, RoundingMode.UP), percentStyle);
            }

            row = sheet.createRow(rowIdx);
            createCell(row, 9, "총 계", leftStyle);
            createCell(row, 10, inputAmt, money2Style);

            int[] widths = {5, 12, 12, 12, 12, 8, 6, 6, 10, 12, 12, 10, 6, 16, 16, 12, 12, 10};
            for (int i = 0; i < widths.length; i++) {
                sheet.setColumnWidth(i, widths[i] * 256);
            }

            workbook.write(out);
            return out.toByteArray();
        } finally {
            out.close();
        }
    }

    private void createCell(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value == null ? "" : value);
        cell.setCellStyle(style);
    }

    private void createCell(Row row, int col, int value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    private void createCell(Row row, int col, BigDecimal value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value == null ? 0d : value.doubleValue());
        cell.setCellStyle(style);
    }

    private String getString(Object obj) {
        return obj == null ? "" : String.valueOf(obj);
    }

    private BigDecimal getBigDecimal(Object obj) {
        if (obj == null) return BigDecimal.ZERO;
        if (obj instanceof BigDecimal) return (BigDecimal) obj;
        if (obj instanceof Number) return BigDecimal.valueOf(((Number) obj).doubleValue());
        return new BigDecimal(String.valueOf(obj));
    }

    private CellStyle createTitleStyle(Workbook workbook) {
        Font font = workbook.createFont();
        font.setFontName("맑은 고딕");
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        font.setFontHeightInPoints((short) 14);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        return style;
    }

    private CellStyle createHeaderStyle(Workbook workbook) {
        Font font = workbook.createFont();
        font.setFontName("맑은 고딕");
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        font.setFontHeightInPoints((short) 10);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return style;
    }

    private CellStyle createLeftStyle(Workbook workbook) {
        Font font = workbook.createFont();
        font.setFontName("맑은 고딕");
        font.setFontHeightInPoints((short) 10);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        return style;
    }

    private CellStyle createCenterStyle(Workbook workbook) {
        Font font = workbook.createFont();
        font.setFontName("맑은 고딕");
        font.setFontHeightInPoints((short) 10);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        return style;
    }

    private CellStyle createRightStyle(Workbook workbook) {
        Font font = workbook.createFont();
        font.setFontName("맑은 고딕");
        font.setFontHeightInPoints((short) 10);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        return style;
    }

    private CellStyle createMoneyStyle(Workbook workbook, String format) {
        CellStyle style = createRightStyle(workbook);
        DataFormat df = workbook.createDataFormat();
        style.setDataFormat(df.getFormat(format));
        return style;
    }

    
    
    /**
     * 실사 대응 서류 > 협력사확인서 목록 > 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveVendorCertFileList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(InspectionResDao.class).retrieveVendorCertFileList(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<String, Object> retrieveVendorCertFile(Map<String, Object> param){
    	
    	Map<String, Object> resultMap = null;
    	try {
    		resultMap = sqlSession.getMapper(InspectionResDao.class).retrieveVendorCertFile(param);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return resultMap;
    }
}
