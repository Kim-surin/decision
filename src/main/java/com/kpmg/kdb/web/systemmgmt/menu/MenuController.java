package com.kpmg.kdb.web.systemmgmt.menu;

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

/**
 * 시스템 관리 > 메뉴 관리
 *
 * @since 2026.08
 */
@Controller
@SuppressWarnings("rawtypes")
public class MenuController extends GenericController {

    protected Logger logger = LoggerFactory.getLogger(MenuController.class);

    @Autowired
    protected MenuService menuService;

    /** 메뉴 관리 화면 */
    @RequestMapping(value = "/origin/systemmgmt/menuMgmt")
    public String menuMgntView(Model model, HttpSession session) {
        return "systemmgmt/menuMgmt";
    }

    /** 메뉴 Tree 목록 조회 */
    @RequestMapping(value = "/system/menu/menuMgnt/retrieveMenuList")
    @ResponseBody
    public Result retrieveMenuList(@RequestBody Map param) {
        Result result = new Result();
        try {
            result = menuService.retrieveMenuList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("메뉴 목록 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    /** 메뉴 상세 조회 */
    @RequestMapping(value = "/system/menu/menuMgnt/retrieveMenuDetail")
    @ResponseBody
    public Result retrieveMenuDetail(@RequestBody Map param) {
        Result result = new Result();
        try {
            result = menuService.retrieveMenuDetail(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("메뉴 상세 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    /** 메뉴 등록 및 수정 */
    @RequestMapping(value = "/system/menu/menuMgnt/saveMenu")
    @ResponseBody
    public Result saveMenu(@RequestBody Map param) {
        Result result = new Result();
        try {
            result = menuService.saveMenu(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("메뉴 저장 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }
}