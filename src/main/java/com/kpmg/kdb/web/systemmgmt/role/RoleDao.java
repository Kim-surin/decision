package com.kpmg.kdb.web.systemmgmt.role;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface RoleDao {

    public List retrieveRoleList(Map param);
    public Map retrieveRoleDetail(Map param);
    public List retrieveRoleMenuList(Map param);
    public int retrieveRoleCount(Map param);
    public int insertRole(Map param);
    public int updateRole(Map param);
    public int deleteRoleMenu(Map param);
    public int deleteRoleUser(Map param);
    public int deleteRole(Map param);
    public int insertRoleMenuList(Map param);
    public List retrieveUserRoleList(Map param);
    public int deleteUserRoleList(Map param);
    public int insertUserRoleList(Map param);
}
