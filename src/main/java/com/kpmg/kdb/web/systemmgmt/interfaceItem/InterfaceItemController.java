package com.kpmg.kdb.web.systemmgmt.interfaceItem;

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

/** 시스템관리 > 인터페이스관리 > 인터페이스 항목관리 */
@Controller
@SuppressWarnings("rawtypes")
public class InterfaceItemController extends GenericController {
    private final Logger logger = LoggerFactory.getLogger(InterfaceItemController.class);

    @Autowired
    private InterfaceItemService interfaceItemService;

    @RequestMapping(value = "/system/interface/itemMgmt")
    public String itemMgmtView(Model model, HttpSession session) {
        return "systemmgmt/itemMgmt";
    }

    @RequestMapping(value = "/system/interface/itemDetail")
    public String itemDetailView(@RequestParam Map param, Model model, HttpSession session) {
    	model.addAllAttributes(param);
        return "systemmgmt/itemDetail";
    }

    @RequestMapping(value = "/system/interface/itemMgmt/retrieveInterfaceItemList")
    @ResponseBody
    public Result retrieveInterfaceItemList(@RequestBody Map param) {
        try { return interfaceItemService.retrieveInterfaceItemList(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("인터페이스 항목 목록 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/itemMgmt/retrieveInterfaceItemDetail")
    @ResponseBody
    public Result retrieveInterfaceItemDetail(@RequestBody Map param) {
        try { return interfaceItemService.retrieveInterfaceItemDetail(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("인터페이스 항목 상세 조회 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }

    @RequestMapping(value = "/system/interface/itemMgmt/saveInterfaceItem")
    @ResponseBody
    public Result saveInterfaceItem(@RequestBody Map param) {
        try { return interfaceItemService.saveInterfaceItem(super.extendsMap(param)); }
        catch (Exception e) {
            logger.error("인터페이스 항목 저장 중 오류가 발생했습니다.", e);
            return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
    }
}
