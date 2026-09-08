package com.kpmg.kdb.web.systemmgmt.interfaceSchedule;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface InterfaceScheduleDao {
    List retrieveScheduleList(Map param);
    Map retrieveScheduleDetail(Map param);
    List retrieveScheduleMappingList(Map param);
    List retrieveInterfaceItemCombo(Map param);
    int retrieveScheduleCount(Map param);
    int insertSchedule(Map param);
    int updateSchedule(Map param);
    int deleteScheduleMapping(Map param);
    int insertScheduleMapping(Map param);
    int restoreScheduleStatus(Map param);
}
