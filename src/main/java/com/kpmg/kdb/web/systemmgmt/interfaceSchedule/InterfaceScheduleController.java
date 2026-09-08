package com.kpmg.kdb.web.systemmgmt.interfaceSchedule;

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

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/** 시스템관리 > 인터페이스관리 > 스케줄관리 */
@Controller
@SuppressWarnings("rawtypes")
public class InterfaceScheduleController extends GenericController {

    private final Logger logger = LoggerFactory.getLogger(InterfaceScheduleController.class);

    @Autowired
    private InterfaceScheduleService interfaceScheduleService;

    @RequestMapping(value = "/system/interface/scheduleMgmt")
    public String scheduleMgmtView(Model model, HttpSession session) {
        return "systemmgmt/scheduleMgmt";
    }

    /** 스케줄 등록/수정 팝업 */
    @RequestMapping(value = "/system/interface/scheduleDetail")
    public String scheduleDetailView(@RequestParam Map param, Model model, HttpSession session) {
    	model.addAllAttributes(param);
        return "systemmgmt/scheduleDetail";
    }

    @RequestMapping(value = "/system/interface/scheduleMgmt/retrieveScheduleList")
    @ResponseBody
    public Result retrieveScheduleList(@RequestBody Map param) {
        try {
            return interfaceScheduleService.retrieveScheduleList(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("스케줄 목록 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/scheduleMgmt/retrieveScheduleDetail")
    @ResponseBody
    public Result retrieveScheduleDetail(@RequestBody Map param) {
        try {
            return interfaceScheduleService.retrieveScheduleDetail(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("스케줄 상세 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    /** 인터페이스 항목 Combo 목록 조회 */
    @RequestMapping(value = "/system/interface/scheduleMgmt/retrieveInterfaceItemCombo")
    @ResponseBody
    public Result retrieveInterfaceItemCombo(@RequestBody Map param) {
        try {
            return interfaceScheduleService.retrieveInterfaceItemCombo(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("인터페이스 항목 Combo 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/scheduleMgmt/saveSchedule")
    @ResponseBody
    public Result saveSchedule(@RequestBody Map param) {
        try {
            return interfaceScheduleService.saveSchedule(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("스케줄 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/scheduleMgmt/restoreScheduleStatus")
    @ResponseBody
    public Result restoreScheduleStatus(@RequestBody Map param) {
        try {
            return interfaceScheduleService.restoreScheduleStatus(super.extendsMap(param));
        } catch (Exception e) {
            logger.error("스케줄 상태 복원 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }
}
