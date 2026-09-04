package com.kpmg.kdb.web.systemmgmt.company;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface CompanyDao {

    public List retrieveCompanyList(Map param);
    public Map retrieveCompanyDetail(Map param);
    public int retrieveCompanyCount(Map param);
    public int insertCompany(Map param);
    public int updateCompany(Map param);
    
    public int updateOptionDetail(Map param);
    public int userInfoInsert(Map param);
    public int roleMstInsert(Map param);
    public int roleUserInsert(Map param);
    public int roleMenuInsert(Map param);
    public int codeMstInsert(Map param);
    public int codeDtlInsert(Map param);
    public int interfaceItemMstInsert(Map param);
    public int interfaceItemDtlInsert(Map param);
    public int interfaceScheduleInsert(Map param);
    public int interfaceScheduleMappingInsert(Map param);
}
