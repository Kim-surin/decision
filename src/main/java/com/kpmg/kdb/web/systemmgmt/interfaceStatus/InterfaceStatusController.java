package com.kpmg.kdb.web.systemmgmt.interfaceStatus;

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

/** 시스템관리 > 인터페이스관리 > 인터페이스 현황 */
@Controller
@SuppressWarnings("rawtypes")
public class InterfaceStatusController extends GenericController {

    private final Logger logger = LoggerFactory.getLogger(InterfaceStatusController.class);

    @Autowired
    private InterfaceStatusService interfaceStatusService;

    @RequestMapping(value = "/system/interface/statusMgmt")
    public String statusMgmtView(Model model, HttpSession session) {
        return "systemmgmt/statusMgmt";
    }

    @RequestMapping(value = "/system/interface/statusMgmt/retrieveScheduleStatusList")
    @ResponseBody
    public Result retrieveScheduleStatusList(@RequestBody Map param) {
        try { return interfaceStatusService.retrieveScheduleStatusList(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("이관 스케줄 현황 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/statusMgmt/retrieveTransferList")
    @ResponseBody
    public Result retrieveTransferList(@RequestBody Map param) {
        try { return interfaceStatusService.retrieveTransferList(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("이관 완료 및 에러 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/statusMgmt/retrieveTransferDetail")
    @ResponseBody
    public Result retrieveTransferDetail(@RequestBody Map param) {
        try { return interfaceStatusService.retrieveTransferDetail(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("이관 상세항목 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }
}
