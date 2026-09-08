package com.kpmg.kdb.web.systemmgmt.interfaceStatus;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface InterfaceStatusDao {
    List retrieveScheduleStatusList(Map param);
    List retrieveTransferList(Map param);
    List retrieveTransferDetailList(Map param);
    List retrieveTransferDetailColumns(Map param);
}
