package com.kpmg.kdb.web.systemmgmt.interfaceManualExecution;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/** 시스템관리 > 인터페이스관리 > 인터페이스 수동 실행 */
@Controller
@SuppressWarnings("rawtypes")
public class InterfaceManualExecutionController extends GenericController {

    private final Logger logger = LoggerFactory.getLogger(InterfaceManualExecutionController.class);
    private final InterfaceManualExecutionService interfaceManualExecutionService;

    public InterfaceManualExecutionController(InterfaceManualExecutionService interfaceManualExecutionService) {
        this.interfaceManualExecutionService = interfaceManualExecutionService;
    }

    @RequestMapping(value = "/system/interface/manualExecution")
    public String manualExecutionView(Model model, HttpSession session) {
        return "systemmgmt/manualExecution";
    }

    @RequestMapping(value = "/system/interface/manualExecution/retrieveScheduleCombo")
    @ResponseBody
    public Result retrieveScheduleCombo(@RequestBody Map param) {
        try { return interfaceManualExecutionService.retrieveScheduleCombo(super.extendsMap(param)); }
        catch (Exception e) { return error("배치 목록 조회", e); }
    }

    @RequestMapping(value = "/system/interface/manualExecution/retrieveInterfaceCombo")
    @ResponseBody
    public Result retrieveInterfaceCombo(@RequestBody Map param) {
        try { return interfaceManualExecutionService.retrieveInterfaceCombo(super.extendsMap(param)); }
        catch (Exception e) { return error("인터페이스 목록 조회", e); }
    }

    @RequestMapping(value = "/system/interface/manualExecution/executeInterface")
    @ResponseBody
    public Result executeInterface(@RequestBody Map param) {
        try { return interfaceManualExecutionService.executeInterface(super.extendsMap(param)); }
        catch (Exception e) { return error("인터페이스 수동 실행", e); }
    }

    @RequestMapping(value = "/system/interface/manualExecution/retrieveExecutionResultList")
    @ResponseBody
    public Result retrieveExecutionResultList(@RequestBody Map param) {
        try { return interfaceManualExecutionService.retrieveExecutionResultList(super.extendsMap(param)); }
        catch (Exception e) { return error("수행결과 조회", e); }
    }

    @RequestMapping(value = "/system/interface/manualExecution/retrieveExecutionDetail")
    @ResponseBody
    public Result retrieveExecutionDetail(@RequestBody Map param) {
        try { return interfaceManualExecutionService.retrieveExecutionDetail(super.extendsMap(param)); }
        catch (Exception e) { return error("수행 상세 조회", e); }
    }

    private Result error(String action, Exception e) {
        logger.error(action + " 중 오류가 발생했습니다.", e);
        return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    }
}
