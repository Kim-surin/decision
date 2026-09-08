package com.kpmg.kdb.web.systemmgmt.menu;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface MenuDao {

    public List retrieveMenuList(Map param);

    public Map retrieveMenuDetail(Map param);

    public int retrieveMenuIdCount(Map param);

    public int insertMenu(Map param);

    public int updateMenu(Map param);
}