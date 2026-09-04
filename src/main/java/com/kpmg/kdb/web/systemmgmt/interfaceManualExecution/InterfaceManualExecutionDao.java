package com.kpmg.kdb.web.systemmgmt.interfaceManualExecution;

import java.util.List;
import java.util.Map;

public interface InterfaceManualExecutionDao {

    List<Map<String, Object>> retrieveScheduleCombo(Map<String, Object> param);

    List<Map<String, Object>> retrieveInterfaceCombo(Map<String, Object> param);

    Map<String, Object> retrieveExecutionTarget(Map<String, Object> param);

    List<Map<String, Object>> retrieveExecutionResultList(Map<String, Object> param);

    List<Map<String, Object>> retrieveExecutionDetailColumns(Map<String, Object> param);

    List<Map<String, Object>> retrieveExecutionDetailList(Map<String, Object> param);
}
