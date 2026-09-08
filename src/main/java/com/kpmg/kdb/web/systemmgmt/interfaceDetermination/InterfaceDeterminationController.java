package com.kpmg.kdb.web.systemmgmt.interfaceDetermination;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/** FTA 기준정보 > 인터페이스 및 판정 */
@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceDeterminationController extends GenericController {

    private final Logger logger = LoggerFactory.getLogger(InterfaceDeterminationController.class);

    @Autowired
    private InterfaceDeterminationService interfaceDeterminationService;

    @RequestMapping(value = "/ftaInfo/interfaceDetermination")
    public String interfaceDeterminationView(Model model, HttpSession session) {
        return "systemmgmt/interfaceDetermination";
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/retrieveScheduleCombo")
    @ResponseBody
    public Result retrieveScheduleCombo(@RequestBody Map param) {
        try { return interfaceDeterminationService.retrieveScheduleCombo(super.extendsMap(param)); }
        catch (Exception e) { return error("스케줄 목록 조회", e); }
    }
    
    @RequestMapping(value = "/ftaInfo/interfaceDetermination/retrieveDivisionCombo")
    @ResponseBody
    public Result retrieveDivisionCombo(@RequestBody Map param) {
        try { return interfaceDeterminationService.retrieveDivisionCombo(super.extendsMap(param)); }
        catch (Exception e) { return error("플랜트 목록 조회", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/retrieveInterfaceCombo")
    @ResponseBody
    public Result retrieveInterfaceCombo(@RequestBody Map param) {
        try { return interfaceDeterminationService.retrieveInterfaceCombo(super.extendsMap(param)); }
        catch (Exception e) { return error("인터페이스 목록 조회", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/uploadExcel")
    @ResponseBody
    public Result uploadExcel(@RequestParam("excel_file") MultipartFile excelFile,
            @RequestParam("schedule_code") String scheduleCode,
            @RequestParam("base_yyyymm") String baseYyyymm,
            @RequestParam(value = "if_code", required = false) String ifCode,
            @RequestParam(value = "division_code", required = false) String divisionCode) {
        try {
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("schedule_code", scheduleCode);
            param.put("base_yyyymm", baseYyyymm);
            param.put("if_code", ifCode);
            param.put("division_code", divisionCode);
            return interfaceDeterminationService.uploadExcel(excelFile, super.extendsMap(param));
        } catch (Exception e) { return error("인터페이스 엑셀 업로드", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/executeDetermination")
    @ResponseBody
    public Result executeDetermination(@RequestBody Map param) {
        try { return interfaceDeterminationService.executeDetermination(super.extendsMap(param)); }
        catch (Exception e) { return error("원산지 판정 실행", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/retrieveUploadList")
    @ResponseBody
    public Result retrieveUploadList(@RequestBody Map param) {
        try { return interfaceDeterminationService.retrieveUploadList(super.extendsMap(param)); }
        catch (Exception e) { return error("업로드 현황 조회", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/retrieveDeterminationList")
    @ResponseBody
    public Result retrieveDeterminationList(@RequestBody Map param) {
        try { return interfaceDeterminationService.retrieveDeterminationList(super.extendsMap(param)); }
        catch (Exception e) { return error("판정결과 조회", e); }
    }

    @RequestMapping(value = "/ftaInfo/interfaceDetermination/restoreScheduleStatus")
    @ResponseBody
    public Result restoreScheduleStatus(@RequestBody Map param) {
        try { return interfaceDeterminationService.restoreScheduleStatus(super.extendsMap(param)); }
        catch (Exception e) { return error("스케줄 상태 복원", e); }
    }

    private Result error(String action, Exception e) {
        logger.error(action + " 중 오류가 발생했습니다.", e);
        return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    }
}
