package com.kpmg.kdb.web.systemmgmt.interfaceDetermination;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceDeterminationService extends GeneralService {

    private static final int MAX_ATTRIBUTE_COUNT = 50;
    private static final long MAX_UPLOAD_SIZE = 30L * 1024L * 1024L;
    private static final Set<String> TARGET_SHEETS = new HashSet<String>(Arrays.asList(
            "입고", "수불부", "매출", "자재", "BOM", "표준원가", "구매처", "판매처"));

    //private final JobLauncher jobLauncher;
    private final ApplicationContext applicationContext;

	public InterfaceDeterminationService(/* JobLauncher jobLauncher, */ApplicationContext applicationContext) {
        //this.jobLauncher = jobLauncher;
        this.applicationContext = applicationContext;
    }

    public Result retrieveScheduleCombo(Map<String, Object> param) {
        return success(dao().retrieveScheduleCombo(param));
    }

    public Result retrieveDivisionCombo(Map<String, Object> param) {
        return success(dao().retrieveDivisionCombo(param));
    }
    
    public Result retrieveInterfaceCombo(Map<String, Object> param) {
        return success(dao().retrieveInterfaceCombo(param));
    }

    @Transactional(rollbackFor = Exception.class)
    public Result uploadExcel(MultipartFile file, Map<String, Object> param) throws Exception {
        String scheduleCode = text(param.get("schedule_code"));
        String baseYyyymm = digits(param.get("base_yyyymm"));
        if (file == null || file.isEmpty()) return failure("업로드할 엑셀 파일을 선택해 주세요.");
        if (file.getSize() > MAX_UPLOAD_SIZE) return failure("엑셀 파일은 30MB 이하만 업로드할 수 있습니다.");
        if (!StringUtils.hasText(scheduleCode)) return failure("스케줄을 선택해 주세요.");
        if (!baseYyyymm.matches("\\d{6}")) return failure("기준일자는 YYYYMM 형식으로 입력해 주세요.");

        String fileName = text(file.getOriginalFilename()).toLowerCase(Locale.ROOT);
        if (!fileName.endsWith(".xlsx") && !fileName.endsWith(".xls") && !fileName.endsWith(".xlsm")) {
            return failure("엑셀 파일(.xlsx, .xls, .xlsm)만 업로드할 수 있습니다.");
        }

        InterfaceDeterminationDao dao = dao();
        List<Map<String, Object>> interfaces = dao.retrieveExcelInterfaceList(param);
        if (interfaces.isEmpty()) return failure("엑셀 업로드 대상으로 등록된 인터페이스가 없습니다.");

        List<SheetUpload> uploads = new ArrayList<SheetUpload>();
		/*
		 * try (Workbook workbook = WorkbookFactory.create(file.getInputStream())) {
		 * DataFormatter formatter = new DataFormatter(); FormulaEvaluator evaluator =
		 * workbook.getCreationHelper().createFormulaEvaluator(); for (int sheetIndex =
		 * 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) { Sheet sheet =
		 * workbook.getSheetAt(sheetIndex); if (workbook.isSheetHidden(sheetIndex) ||
		 * workbook.isSheetVeryHidden(sheetIndex)) continue; if
		 * (!TARGET_SHEETS.contains(normalize(sheet.getSheetName()))) continue;
		 * Map<String, Object> interfaceItem = resolveInterface(sheet.getSheetName(),
		 * interfaces); if (interfaceItem == null) { throw new
		 * IllegalArgumentException(sheet.getSheetName() +
		 * " 시트에 연결할 인터페이스가 없습니다. 인터페이스 항목관리의 ATTRIBUTE01에 시트명을 지정해 주세요."); }
		 * param.put("if_code", interfaceItem.get("if_code")); List<Map<String, Object>>
		 * columns = dao.retrieveInterfaceColumns(param); if (columns.isEmpty()) throw
		 * new IllegalArgumentException(sheet.getSheetName() +
		 * " 시트의 인터페이스 상세항목이 없습니다."); if (columns.size() > MAX_ATTRIBUTE_COUNT) throw
		 * new IllegalArgumentException(sheet.getSheetName() + " 시트의 항목이 50개를 초과합니다.");
		 * uploads.add(readSheet(sheet, interfaceItem, columns, formatter, evaluator));
		 * } }
		 */
        if (uploads.isEmpty()) return failure("처리 가능한 업로드 시트를 찾을 수 없습니다. 시트명과 인터페이스 설정을 확인해 주세요.");

        dao.lockInterfaceTransTable();
        long nextTransId = dao.retrieveNextTransId();
        int totalRows = 0;
        int totalErrors = 0;
        for (SheetUpload upload : uploads) {
            long transId = nextTransId++;
            int errorCount = countErrors(upload.rows);
            Map<String, Object> master = new HashMap<String, Object>(param);
            master.put("intg_interface_trans_id", transId);
            master.put("if_code", upload.ifCode);
            master.put("total_rows", upload.rows.size());
            master.put("error_yn", errorCount > 0 ? "Y" : "N");
            master.put("error_message", errorCount > 0 ? errorCount + "건의 필수값 오류가 있습니다." : null);
            master.put("interface_id", abbreviate(file.getOriginalFilename(), 100));
            master.put("interface_type", "EXCEL");
            master.put("if_param", abbreviate("BaseYYYYMM=" + baseYyyymm + " Sheet=" + upload.sheetName, 1000));
            dao.insertInterfaceTrans(master);

            long rowId = 1L;
            for (Map<String, Object> row : upload.rows) {
                row.put("intg_interface_trans_id", transId);
                row.put("intg_interface_id", rowId++);
                row.put("company_code", param.get("company_code"));
                row.put("update_by", param.get("update_by"));
                dao.insertInterfaceTransDetail(row);
            }
            totalRows += upload.rows.size();
            totalErrors += errorCount;
        }

        Map<String, Object> value = new HashMap<String, Object>();
        value.put("sheet_count", uploads.size());
        value.put("total_rows", totalRows);
        value.put("error_count", totalErrors);
        return success(value);
    }

    public Result executeDetermination(Map<String, Object> param) throws Exception {
        String scheduleCode = text(param.get("schedule_code"));
        String baseYyyymm = digits(param.get("base_yyyymm"));
        if (!StringUtils.hasText(scheduleCode)) return failure("스케줄을 선택해 주세요.");
        if (!baseYyyymm.matches("\\d{6}")) return failure("기준일자는 YYYYMM 형식으로 입력해 주세요.");

        Map<String, Object> target = dao().retrieveExecutionTarget(param);
        if (target == null || !StringUtils.hasText(text(target.get("execution_program")))) {
            return failure("실행 프로그램이 등록되지 않은 스케줄입니다.");
        }
        String programName = text(target.get("execution_program"));
        if (!applicationContext.containsBean(programName)) return failure("실행 프로그램 Bean을 찾을 수 없습니다. (" + programName + ")");

		/*
		 * Job job = applicationContext.getBean(programName, Job.class); JobParameters
		 * parameters = new JobParametersBuilder() .addString("company_code",
		 * text(param.get("company_code"))) .addString("division_code",
		 * text(param.get("division_code"))) .addString("schedule_code", scheduleCode)
		 * .addString("batch_yyyymm", baseYyyymm) .addLong("manual_request_time",
		 * System.currentTimeMillis()) .toJobParameters(); jobLauncher.run(job,
		 * parameters);
		 */
        return success(null);
    }

    public Result retrieveUploadList(Map<String, Object> param) {
        param.put("base_yyyymm", digits(param.get("base_yyyymm")));
        return success(dao().retrieveUploadList(param));
    }

    public Result retrieveDeterminationList(Map<String, Object> param) {
        param.put("base_yyyymm", digits(param.get("base_yyyymm")));
        return success(dao().retrieveDeterminationList(param));
    }

    @Transactional(rollbackFor = Exception.class)
    public Result restoreScheduleStatus(Map<String, Object> param) {
        if (dao().restoreScheduleStatus(param) == 0) return failure("복원할 스케줄을 찾을 수 없습니다.");
        return success(null);
    }

    private SheetUpload readSheet(Sheet sheet, Map<String, Object> item, List<Map<String, Object>> columns,
            DataFormatter formatter, FormulaEvaluator evaluator) {
        Row header = findHeaderRow(sheet, columns, formatter, evaluator);
        if (header == null) throw new IllegalArgumentException(sheet.getSheetName() + " 시트에 헤더가 없습니다.");
        Map<String, Integer> headerIndexes = new LinkedHashMap<String, Integer>();
        for (Cell cell : header) headerIndexes.put(normalize(formatter.formatCellValue(cell, evaluator)), cell.getColumnIndex());

        List<Integer> columnIndexes = new ArrayList<Integer>();
        for (int i = 0; i < columns.size(); i++) {
            Map<String, Object> column = columns.get(i);
            Integer index = findColumnIndex(headerIndexes, column);
            int firstColumn = Math.max(0, header.getFirstCellNum());
            columnIndexes.add(index == null ? firstColumn + i : index);
        }

        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (int rowIndex = header.getRowNum() + 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
            Row excelRow = sheet.getRow(rowIndex);
            if (excelRow == null) continue;
            Map<String, Object> data = new HashMap<String, Object>();
            List<String> errors = new ArrayList<String>();
            boolean hasValue = false;
            for (int i = 0; i < columns.size(); i++) {
                String value = formatter.formatCellValue(excelRow.getCell(columnIndexes.get(i)), evaluator).trim();
                if (!value.isEmpty()) hasValue = true;
                data.put(String.format("attribute%02d", i + 1), value);
                if ("Y".equals(text(columns.get(i).get("column_required_yn"))) && value.isEmpty()) {
                    errors.add(text(columns.get(i).get("column_name")) + " 필수값 누락");
                }
            }
            if (!hasValue) continue;
            data.put("current_row", rowIndex + 1);
            data.put("error_yn", errors.isEmpty() ? "N" : "Y");
            data.put("error_message", abbreviate(String.join(", ", errors), 2000));
            rows.add(data);
        }
        return new SheetUpload(sheet.getSheetName(), text(item.get("if_code")), rows);
    }

    private Row findHeaderRow(Sheet sheet, List<Map<String, Object>> columns,
            DataFormatter formatter, FormulaEvaluator evaluator) {
        Set<String> columnNames = new HashSet<String>();
        for (Map<String, Object> column : columns) {
            columnNames.add(normalize(text(column.get("column_name"))));
            columnNames.add(normalize(text(column.get("source_column"))));
            columnNames.add(normalize(text(column.get("target_column"))));
            columnNames.add(normalize(text(column.get("history_column"))));
        }
        columnNames.remove("");

        Row bestRow = null;
        int bestScore = 0;
        int last = Math.min(sheet.getLastRowNum(), sheet.getFirstRowNum() + 99);
        for (int i = sheet.getFirstRowNum(); i <= last; i++) {
            Row row = sheet.getRow(i);
            if (row == null || row.getPhysicalNumberOfCells() == 0) continue;
            int score = 0;
            for (Cell cell : row) {
                if (columnNames.contains(normalize(formatter.formatCellValue(cell, evaluator)))) score++;
            }
            if (score > bestScore) {
                bestScore = score;
                bestRow = row;
            }
        }
        return bestScore > 0 ? bestRow : null;
    }

    private Integer findColumnIndex(Map<String, Integer> headerIndexes, Map<String, Object> column) {
        String[] names = { text(column.get("column_name")), text(column.get("source_column")),
                text(column.get("target_column")), text(column.get("history_column")) };
        for (String name : names) {
            Integer index = headerIndexes.get(normalize(name));
            if (index != null) return index;
        }
        return null;
    }

    private Map<String, Object> resolveInterface(String sheetName, List<Map<String, Object>> interfaces) {
        String sheet = normalize(sheetName);
        for (Map<String, Object> item : interfaces) {
            if (!text(item.get("sheet_name")).isEmpty() && sheet.equals(normalize(text(item.get("sheet_name"))))) return item;
        }
        for (Map<String, Object> item : interfaces) {
            if (sheet.equals(normalize(text(item.get("if_name"))))) return item;
        }
        List<Map<String, Object>> matches = new ArrayList<Map<String, Object>>();
        String[] aliases = sheetAliases(sheet);
        for (Map<String, Object> item : interfaces) {
            String name = normalize(text(item.get("if_name")));
            for (String alias : aliases) {
                if (name.contains(normalize(alias))) { matches.add(item); break; }
            }
        }
        if (matches.size() > 1) throw new IllegalArgumentException(sheetName + " 시트에 해당하는 인터페이스가 여러 개입니다. INTERFACE_ITEM_MST.ATTRIBUTE01에 시트명을 지정해 주세요.");
        return matches.isEmpty() ? null : matches.get(0);
    }

    private String[] sheetAliases(String sheet) {
        if (sheet.contains("입고")) return new String[] { "입고", "구매입고" };
        if (sheet.contains("수불부")) return new String[] { "수불부" };
        if (sheet.contains("매출")) return new String[] { "매출" };
        if (sheet.contains("자재")) return new String[] { "자재" };
        if (sheet.contains("BOM")) return new String[] { "BOM" };
        if (sheet.contains("표준원가")) return new String[] { "표준원가" };
        if (sheet.contains("구매처")) return new String[] { "구매처", "공급업체" };
        if (sheet.contains("판매처")) return new String[] { "판매처", "고객" };
        return new String[0];
    }

    private int countErrors(List<Map<String, Object>> rows) {
        int count = 0;
        for (Map<String, Object> row : rows) if ("Y".equals(row.get("error_yn"))) count++;
        return count;
    }

    private InterfaceDeterminationDao dao() { return sqlSession.getMapper(InterfaceDeterminationDao.class); }
    private String digits(Object value) { return text(value).replaceAll("[^0-9]", ""); }
    private String normalize(String value) { return text(value).replaceAll("[^0-9A-Za-z가-힣]", "").toUpperCase(Locale.ROOT); }
    private String text(Object value) { return value == null ? "" : String.valueOf(value).trim(); }
    private String abbreviate(String value, int max) { return value == null || value.length() <= max ? value : value.substring(0, max); }

    private Result success(Object value) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        result.setValue(value);
        return result;
    }

    private Result failure(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }

    private static class SheetUpload {
        private final String sheetName;
        private final String ifCode;
        private final List<Map<String, Object>> rows;
        private SheetUpload(String sheetName, String ifCode, List<Map<String, Object>> rows) {
            this.sheetName = sheetName;
            this.ifCode = ifCode;
            this.rows = rows;
        }
    }
}
