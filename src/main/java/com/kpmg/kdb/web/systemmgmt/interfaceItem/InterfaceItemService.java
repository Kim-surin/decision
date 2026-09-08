package com.kpmg.kdb.web.systemmgmt.interfaceItem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceItemService extends GeneralService {

    public Result retrieveInterfaceItemList(Map<String, Object> param) {
        Result result = new Result();
        result.setValue(sqlSession.getMapper(InterfaceItemDao.class).retrieveInterfaceItemList(param));
        result.setSuccess(true); result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    public Result retrieveInterfaceItemDetail(Map<String, Object> param) {
        InterfaceItemDao dao = sqlSession.getMapper(InterfaceItemDao.class);
        Map<String, Object> value = new HashMap<String, Object>();
        value.put("item", dao.retrieveInterfaceItemDetail(param));
        value.put("columns", dao.retrieveInterfaceColumnList(param));
        Result result = new Result();
        result.setValue(value); result.setSuccess(true); result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    public Result saveInterfaceItem(Map<String, Object> param) {
        normalizeYn(param, "using_yn", "Y");
        normalizeYn(param, "trans_company_code_yn", "N");
        normalizeYn(param, "trans_division_code_yn", "N");
        normalizeYn(param, "excel_upload_yn", "N");

        String saveType = text(param.get("save_type"));
        String ifCode = text(param.get("if_code"));
        if (ifCode.isEmpty() || text(param.get("if_name")).isEmpty())
            return failure("인터페이스 코드와 인터페이스 명을 입력해 주세요.");
        if (!"I".equals(text(param.get("interface_type"))) && !"O".equals(text(param.get("interface_type"))))
            return failure("인터페이스 유형을 선택해 주세요.");

        // DB 작업 전에 상세 숫자 필드를 검증하고 Integer 타입으로 정규화한다.
        List<Map<String, Object>> columns = list(param.get("columns"));
        for (int i = 0; i < columns.size(); i++) {
            Map<String, Object> column = columns.get(i);
            if (text(column.get("target_column")).isEmpty()) continue;

            Integer columnType = integerValue(column.get("column_type"));
            Integer columnLength = integerValue(column.get("column_length"));
            Integer decimalLength = integerValue(column.get("column_dcmlpoint_length"));
            if (columnType == null || columnType < 0 || columnType > Short.MAX_VALUE)
                return failure((i + 1) + "번째 상세행의 컬럼 타입을 올바르게 입력해 주세요.");
            if (columnLength == null || columnLength < 0)
                return failure((i + 1) + "번째 상세행의 컬럼 길이를 올바르게 입력해 주세요.");
            if (decimalLength == null) decimalLength = 0;
            if (decimalLength < 0)
                return failure((i + 1) + "번째 상세행의 소수점 길이를 올바르게 입력해 주세요.");

            column.put("column_type", columnType);
            column.put("column_length", columnLength);
            column.put("column_dcmlpoint_length", decimalLength);
        }

        InterfaceItemDao dao = sqlSession.getMapper(InterfaceItemDao.class);
        if ("I".equals(saveType)) {
            if (dao.retrieveInterfaceItemCount(param) > 0) return failure("이미 등록된 인터페이스 코드입니다.");
            dao.insertInterfaceItem(param);
        } else if ("U".equals(saveType)) {
            if (dao.updateInterfaceItem(param) == 0) return failure("수정할 인터페이스 항목을 찾을 수 없습니다.");
        } else return failure("저장 구분값이 올바르지 않습니다.");

        // 동시에 두 요청이 같은 MAX 값을 채번하지 않도록 트랜잭션 동안 테이블을 잠근다.
        // 기존 상세를 삭제하기 전에 전체 테이블의 MAX + 1을 확보해야 ID가 역행하거나 재사용되지 않는다.
        dao.lockInterfaceColumnTable();
        long detailId = dao.retrieveNextDetailId(param);
        dao.deleteInterfaceColumn(param);
        for (Map<String, Object> column : columns) {
            if (text(column.get("target_column")).isEmpty()) continue;
            column.put("interface_item_dtl_id", detailId++);
            column.put("if_code", ifCode);
            column.put("company_code", param.get("company_code"));
            column.put("update_by", param.get("update_by"));
            normalizeYn(column, "column_required_yn", "N");
            normalizeYn(column, "pk_yn", "N");
            normalizeYn(column, "using_yn", "Y");
            dao.insertInterfaceColumn(column);
        }

        Map<String, Object> value = new HashMap<String, Object>(); value.put("if_code", ifCode);
        Result result = new Result(); result.setValue(value); result.setSuccess(true); result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    private void normalizeYn(Map<String, Object> map, String key, String defaultValue) {
        String value = text(map.get(key));
        map.put(key, ("Y".equals(value) || "N".equals(value)) ? value : defaultValue);
    }
    private List<Map<String, Object>> list(Object value) {
        return value instanceof List ? (List<Map<String, Object>>) value : new ArrayList<Map<String, Object>>();
    }
    private String text(Object value) { return value == null ? "" : String.valueOf(value).trim(); }
    private Integer integerValue(Object value) {
        String text = text(value);
        if (text.isEmpty()) return null;
        try { return Integer.valueOf(text); }
        catch (NumberFormatException e) { return null; }
    }
    private Result failure(String message) { Result r = new Result(); r.setSuccess(false); r.setMessage(message); return r; }
}
