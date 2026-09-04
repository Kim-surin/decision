package com.kpmg.kdb.web.systemmgmt.interfaceItem;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface InterfaceItemDao {
    List retrieveInterfaceItemList(Map param);
    Map retrieveInterfaceItemDetail(Map param);
    List retrieveInterfaceColumnList(Map param);
    int retrieveInterfaceItemCount(Map param);
    void lockInterfaceColumnTable();
    long retrieveNextDetailId(Map param);
    int insertInterfaceItem(Map param);
    int updateInterfaceItem(Map param);
    int deleteInterfaceColumn(Map param);
    int insertInterfaceColumn(Map param);
}
