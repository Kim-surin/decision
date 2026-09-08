package com.kpmg.kdb.web.systemmgmt.standardCode;

import java.util.List;
import java.util.Map;

public interface StandardCodeDao {

    List<Map<String, Object>> retrieveCategoryList(Map<String, Object> param);

    Map<String, Object> retrieveCategory(Map<String, Object> param);

    List<Map<String, Object>> retrieveCodeList(Map<String, Object> param);

    int retrieveCategoryCount(Map<String, Object> param);

    int insertCategory(Map<String, Object> param);

    int updateCategory(Map<String, Object> param);

    int markCodeDetailDeleted(Map<String, Object> param);

    int upsertCodeDetail(Map<String, Object> param);

    int deleteCodeDetail(Map<String, Object> param);

    int deleteCategory(Map<String, Object> param);
}
