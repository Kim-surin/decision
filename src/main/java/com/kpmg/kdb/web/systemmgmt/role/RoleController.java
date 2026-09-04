package com.kpmg.kdb.web.systemmgmt.role;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/** 시스템관리 > 권한관리 */
@Controller
@SuppressWarnings("rawtypes")
public class RoleController extends GenericController {

    protected Logger logger = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    protected RoleService roleService;

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt")
    public String roleMgmtView(Model model, HttpSession session) {
        return "systemmgmt/roleMgmt";
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/retrieveRoleList")
    @ResponseBody
    public Result retrieveRoleList(@RequestBody Map param) {
        try {
            return roleService.retrieveRoleList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("권한 목록 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/retrieveRoleDetail")
    @ResponseBody
    public Result retrieveRoleDetail(@RequestBody Map param) {
        try {
            return roleService.retrieveRoleDetail(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("권한 상세 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/retrieveRoleMenuList")
    @ResponseBody
    public Result retrieveRoleMenuList(@RequestBody Map param) {
        try {
            return roleService.retrieveRoleMenuList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("권한 메뉴 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/saveRole")
    @ResponseBody
    public Result saveRole(@RequestBody Map param) {
        try {
            return roleService.saveRole(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("권한 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/deleteRole")
    @ResponseBody
    public Result deleteRole(@RequestBody Map param) {
        try {
            return roleService.deleteRole(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("권한 삭제 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/saveRoleMenu")
    @ResponseBody
    public Result saveRoleMenu(@RequestBody Map param) {
        try {
            return roleService.saveRoleMenu(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("메뉴 권한 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/retrieveUserRoleList")
    @ResponseBody
    public Result retrieveUserRoleList(@RequestBody Map param) {
        try {
            return roleService.retrieveUserRoleList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("사용자별 권한 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/roleMgmt/saveUserRole")
    @ResponseBody
    public Result saveUserRole(@RequestBody Map param) {
        try {
            return roleService.saveUserRole(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("사용자별 권한 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }
}
