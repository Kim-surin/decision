package com.kpmg.kdb.web.systemmgmt.company;

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

/** 시스템관리 > 회사관리 */
@Controller
@SuppressWarnings("rawtypes")
public class CompanyController extends GenericController {

    protected Logger logger = LoggerFactory.getLogger(CompanyController.class);

    @Autowired
    protected CompanyService companyService;

    @RequestMapping(value = "/origin/systemmgmt/companyAdd")
    public String companyMgmtView(Model model, HttpSession session) {
        return "systemmgmt/companyAdd";
    }

    @RequestMapping(value = "/origin/systemmgmt/companyMgmt/retrieveCompanyList")
    @ResponseBody
    public Result retrieveCompanyList(@RequestBody Map param) {
        try {
            return companyService.retrieveCompanyList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("회사 목록 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/companyMgmt/retrieveCompanyDetail")
    @ResponseBody
    public Result retrieveCompanyDetail(@RequestBody Map param) {
        try {
            return companyService.retrieveCompanyDetail(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("회사 상세 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/origin/systemmgmt/companyMgmt/saveCompany")
    @ResponseBody
    public Result saveCompany(@RequestBody Map param) {
        try {
            return companyService.saveCompany(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("회사 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }
}
