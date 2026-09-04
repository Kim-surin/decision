package com.kpmg.kdb.web.systemmgmt.interfaceDetermination;

import java.util.List;
import java.util.Map;

public interface InterfaceDeterminationDao {

    List<Map<String, Object>> retrieveScheduleCombo(Map<String, Object> param);
    
    List<Map<String, Object>> retrieveDivisionCombo(Map<String, Object> param);

    List<Map<String, Object>> retrieveInterfaceCombo(Map<String, Object> param);

    List<Map<String, Object>> retrieveExcelInterfaceList(Map<String, Object> param);

    List<Map<String, Object>> retrieveInterfaceColumns(Map<String, Object> param);

    Map<String, Object> retrieveExecutionTarget(Map<String, Object> param);

    void lockInterfaceTransTable();

    Long retrieveNextTransId();

    int insertInterfaceTrans(Map<String, Object> param);

    int insertInterfaceTransDetail(Map<String, Object> param);

    List<Map<String, Object>> retrieveUploadList(Map<String, Object> param);

    List<Map<String, Object>> retrieveDeterminationList(Map<String, Object> param);

    int restoreScheduleStatus(Map<String, Object> param);
}
