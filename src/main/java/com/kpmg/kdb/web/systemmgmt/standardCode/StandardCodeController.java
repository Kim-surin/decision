package com.kpmg.kdb.web.systemmgmt.standardCode;

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

/** 시스템관리 > 표준코드관리 */
@Controller
@SuppressWarnings("rawtypes")
public class StandardCodeController extends GenericController {

    private final Logger logger = LoggerFactory.getLogger(StandardCodeController.class);

    @Autowired
    private StandardCodeService standardCodeService;

    @RequestMapping(value = "/system/code/standardCodeMgmt")
    public String standardCodeMgmtView(Model model, HttpSession session) {
        return "systemmgmt/standardCodeMgmt";
    }

    @RequestMapping(value = "/system/code/standardCodeMgmt/retrieveCategoryList")
    @ResponseBody
    public Result retrieveCategoryList(@RequestBody Map param) {
        try { return standardCodeService.retrieveCategoryList(super.extendsMap(param)); }
        catch (Exception e) { return error("카테고리 목록 조회", e); }
    }

    @RequestMapping(value = "/system/code/standardCodeMgmt/retrieveCategoryDetail")
    @ResponseBody
    public Result retrieveCategoryDetail(@RequestBody Map param) {
        try { return standardCodeService.retrieveCategoryDetail(super.extendsMap(param)); }
        catch (Exception e) { return error("표준코드 상세 조회", e); }
    }

    @RequestMapping(value = "/system/code/standardCodeMgmt/saveStandardCode")
    @ResponseBody
    public Result saveStandardCode(@RequestBody Map param) {
        try { return standardCodeService.saveStandardCode(super.extendsMap(param)); }
        catch (Exception e) { return error("표준코드 저장", e); }
    }

    @RequestMapping(value = "/system/code/standardCodeMgmt/deleteStandardCode")
    @ResponseBody
    public Result deleteStandardCode(@RequestBody Map param) {
        try { return standardCodeService.deleteStandardCode(super.extendsMap(param)); }
        catch (Exception e) { return error("표준코드 삭제", e); }
    }

    private Result error(String action, Exception e) {
        logger.error(action + " 중 오류가 발생했습니다.", e);
        return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    }
}
