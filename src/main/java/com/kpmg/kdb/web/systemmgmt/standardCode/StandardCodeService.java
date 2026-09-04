package com.kpmg.kdb.web.systemmgmt.standardCode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class StandardCodeService extends GeneralService {

    private static final Logger logger = LoggerFactory.getLogger(StandardCodeService.class);

    public Result retrieveCategoryList(Map<String, Object> param) {
        return success(dao().retrieveCategoryList(param));
    }

    public Result retrieveCategoryDetail(Map<String, Object> param) {
        StandardCodeDao dao = dao();
        Map<String, Object> value = new HashMap<String, Object>();
        value.put("category", dao.retrieveCategory(param));
        value.put("codes", dao.retrieveCodeList(param));
        return success(value);
    }

    @Transactional(rollbackFor = Exception.class)
    public Result saveStandardCode(Map<String, Object> param) {
        String saveType = text(param.get("save_type"));
        String category = text(param.get("category"));
        String categoryName = text(param.get("category_name"));
        Integer codeLength = integer(param.get("code_length"));

        if (category.isEmpty() || category.length() > 5) {
            return failure("카테고리는 5자리 이내로 입력해 주세요.");
        }
        if (categoryName.isEmpty()) {
            return failure("카테고리 명을 입력해 주세요.");
        }
        if (codeLength == null || codeLength < 1 || codeLength > 50) {
            return failure("코드 길이는 1에서 50 사이로 입력해 주세요.");
        }
        if (!isYn(param.get("update_yn"))) {
            return failure("코드 수정 가능 여부를 올바르게 선택해 주세요.");
        }

        param.put("category", category);
        param.put("code_length", codeLength);

        // 저장 작업 전에 상세 전체를 검증하여 중간 데이터가 반영되지 않도록 한다.
        List<Map<String, Object>> codes = list(param.get("codes"));
        Set<String> duplicateCheck = new HashSet<String>();
        int defaultSortNo = 1;
        for (Map<String, Object> code : codes) {
            String codeValue = text(code.get("code"));
            if (codeValue.isEmpty()) return failure(defaultSortNo + "번째 코드값을 입력해 주세요.");
            if (codeValue.length() > codeLength) return failure(defaultSortNo + "번째 코드가 설정된 코드 길이를 초과합니다.");
            if (text(code.get("code_name")).isEmpty()) return failure(defaultSortNo + "번째 코드명을 입력해 주세요.");
            if (!duplicateCheck.add(codeValue)) return failure("중복된 코드가 있습니다. (" + codeValue + ")");
            Integer sortNo = integer(code.get("sort_no"));
            code.put("sort_no", sortNo == null ? defaultSortNo : sortNo);
            if (!isYn(code.get("using_yn"))) code.put("using_yn", "Y");
            defaultSortNo++;
        }

        StandardCodeDao dao = dao();

        if ("I".equals(saveType)) {
            if (dao.retrieveCategoryCount(param) > 0) {
                return failure("이미 등록된 카테고리입니다.");
            }
            dao.insertCategory(param);
        } else if ("U".equals(saveType)) {
            if (dao.updateCategory(param) == 0) {
                return failure("수정할 카테고리를 찾을 수 없습니다.");
            }
        } else {
            return failure("저장 구분값이 올바르지 않습니다.");
        }

        dao.markCodeDetailDeleted(param);
        for (Map<String, Object> code : codes) {
            code.put("category", category);
            code.put("company_code", param.get("company_code"));
            code.put("update_by", param.get("update_by"));
            dao.upsertCodeDetail(code);
        }

        Map<String, Object> value = new HashMap<String, Object>();
        value.put("category", category);
        return success(value);
    }

    @Transactional(rollbackFor = Exception.class)
    public Result deleteStandardCode(Map<String, Object> param) {
        if (text(param.get("category")).isEmpty()) return failure("삭제할 카테고리를 선택해 주세요.");
        StandardCodeDao dao = dao();
        dao.deleteCodeDetail(param);
        if (dao.deleteCategory(param) == 0) return failure("삭제할 카테고리를 찾을 수 없습니다.");
        return success(null);
    }

    private StandardCodeDao dao() {
        return sqlSession.getMapper(StandardCodeDao.class);
    }

    private List<Map<String, Object>> list(Object value) {
        return value instanceof List ? (List<Map<String, Object>>) value : new ArrayList<Map<String, Object>>();
    }

    private Integer integer(Object value) {
        String text = text(value);
        if (text.isEmpty()) return null;
        try { return Integer.valueOf(text); }
        catch (NumberFormatException e) { return null; }
    }

    private boolean isYn(Object value) {
        return "Y".equals(text(value)) || "N".equals(text(value));
    }

    private String text(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }

    private Result success(Object value) {
        Result result = new Result();
        result.setValue(value);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    private Result failure(String message) {
        logger.warn(message);
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
