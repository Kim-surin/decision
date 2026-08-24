package com.kpmg.kdb.web.ts.itemgroupmgmt;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface ItemGroupMgmtDao {

    List<Map<String, Object>> retrieveItemGroupMgmt(Map param);

    List<Map<String, Object>> retrieveItemGroupItemList(Map param);

    Map<String, Object> retrieveItemGroupDetail(Map param);

    String selectItemGroupDuplicate(Map param);

    int insertItemGroup(Map param);

    int updateItemGroup(Map param);

    int deleteItemGroup(Map param);

    int insertItemGroupFile(Map param);

    int deleteItemGroupFile(Map param);

    int deleteItemGroupFileAll(Map param);

    List<Map<String, Object>> retrieveItemGroupFileList(Map param);

    Map<String, Object> itemGroupFileDownload(Map param);

    Map<String, Object> retrieveItemDetail(Map param);

    List<Map<String, Object>> retrieveItemGroupCombo(Map param);

    int updateItemProductCode(Map param);

    int insertItemFile(Map param);

    List<Map<String, Object>> retrieveItemFileList(Map param);

    int deleteItemFile(Map param);

    public int deleteItemGroupFileList(Map param);

    public int deleteItemGroupList(Map param);
    
}
