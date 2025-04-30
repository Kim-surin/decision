package com.kpmg.kdb.web.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.StringUtil;


/*******************************************************************************************
 * 
 * SystemController.class
 * 
 * @since 2018.06.25
 * @author 우희재
 *
 * 시스템 관리 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class SystemController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(SystemController.class);

	@Autowired
	protected SystemService service;


	

	
	/**
	 * 인터페이스 스케줄 관리
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-001")
	public String interfaceSch_View(Model model, HttpSession session) {
		
		return "systemmgmt/sm-001";
	}

	
	/**
	 * 인터페이스 스케줄 관리 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceSch")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceSch(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceSch ");
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveInterfaceSch(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceSch END");
		
		
		return gridData;
	}
	
	/**
	 * 인터페이스 스케줄 관리 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceDetailSch")
	@ResponseBody
	public Result retrieveInterfaceDetailSch(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveInterfaceDetailSch ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveInterfaceDetailSch(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveInterfaceDetailSch END");
		
		return rs;
	}
	
	
	
	/**
	 * 인터페이스 스케줄 관리
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-00101")
	public String interfaceSch_Dialog_View(@RequestParam Map param, Model model, HttpSession session) {
		logger.debug("\n\n\n\n");
		logger.debug("<##### 인터페이스 스케줄 관리 상세화면 팝업> @ModelAttribute : " + param);
		logger.debug("##### ------------------------------------------");
		model.addAttribute("reqParam", super.extendsMap(param));
		return "systemmgmt/sm-00101";
	}
	
	
	/**
	 * 인터페이스 스케줄 Mapping List
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceSchMapping")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceSchMapping(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = null;
		try {
			logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceSchMapping ");
			gridData = this.service.retrieveInterfaceSchMapping(super.extendsMap(param));		
			logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceSchMapping END");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return gridData;
	}

	
	
	/**
	 * 인터페이스 아이템
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-002")
	public String interfaceItem_View(Model model, HttpSession session) {
		
		return "systemmgmt/sm-002";
	}
	
	
	/**
	 * 인터페이스 아이템 마스터 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceItemMaster")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceItemMaster(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceItemMaster ");
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveInterfaceItemMaster(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceItemMaster END");
		
		
		return gridData;
	}
	
	
	/**
	 * 인터페이스 스케줄 관리 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceItemDetail")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceItemDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceItemDetail ");
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveInterfaceItemDetail(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceItemDetail END");
		
		
		return gridData;
	}
	

	
	/**
	 * 인터페이스 이력
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-003")
	public String interfaceHistory_View(Model model, HttpSession session) {
		
		return "systemmgmt/sm-003";
	}
	
	
	
	/**
	 * 인터페이스 이력 마스터 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceHistoryMaster")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceHistoryMaster(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceHistoryMaster ");
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveInterfaceHistoryMaster(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceHistoryMaster END");
		
		
		return gridData;
	}
	
	
	/**
	 * 인터페이스 이력 상세 그리드 해더 정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceHistoryLayout")
	@ResponseBody
	public Result retrieveInterfaceHistoryLayout(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveInterfaceHistoryLayout ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveInterfaceHistoryLayout(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveInterfaceHistoryLayout END");
		
		return rs;
	}
	
	/**
	 * 인터페이스 이력 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveInterfaceHistoryDetail")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveInterfaceHistoryDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceHistoryDetail ");
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveInterfaceHistoryDetail(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + "retrieveInterfaceHistoryDetail END");
		
		
		return gridData;
	}
	
	
	/**
	 * 인터페이스 수동실행
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-004")
	public String interfaceMenual_View(Model model, HttpSession session) {
		
		return "systemmgmt/sm-004";
	}
	
	
	
	/**
	 * 스케줄 및 현황 > 스케줄 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/retrieveDataTransSchdule")
	@ResponseBody
	public Result retrieveDataTransSchdule(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		rs = service.retrieveDataTransSchdule(super.extendsMap(param));
		rs.setSuccess(true);
		return rs;
	}
	
	
	
	
	/** D.Cat 추가 : 2019.02.18  */
	
	
	
	/**
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */
	@RequestMapping(value = "/sm-005")
	public String sm005_View(Model model, HttpSession session) {
		
		return "systemmgmt/sm-005";
	}
	
	
	/**
	 * 시스템 관리 > 권한관리 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieveComAuthorGroupList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveComAuthorGroupList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName());
		logger.debug(super.logText);
		logger.debug("##### Request Parameters  : " + param);
		logger.debug(super.logText);
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveComAuthorGroupList(super.extendsMap(param));		
		
		logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName()+ " END");
		
		
		return gridData;
	}

	/**
	 * updateComAuthorGroup
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/updateComAuthorGroup", method = RequestMethod.POST)
	@ResponseBody
	public Result updateComAuthorGroup(@RequestBody Map param) throws Exception {
		
		return service.updateComAuthorGroup(super.extendsMap(param));
	}
	
	/**
	 * 부여되지 않은 권한 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/retrieveExistsMenuList", method = RequestMethod.POST)
	@ResponseBody
	public Result retrieveExistsMenuList(@RequestBody Map param) throws Exception {
		
		return service.retrieveExistsMenuList(super.extendsMap(param));
	}
	
	
	@RequestMapping(value = "/sys/changeAuthorMenuList", method = RequestMethod.POST)
	@ResponseBody
	public Result changeAuthorMenuList(@RequestBody Map param) throws Exception {
		
		return service.changeAuthorMenuList(super.extendsMap(param));
	} 
	
	@RequestMapping(value = "/sm-006")
	public String sm006_View(@RequestParam Map param, HttpSession session, Model model) throws Exception {
		if(String.valueOf(param.get("SEARCH_USE_YN")) == "null" || String.valueOf(param.get("SEARCH_USE_YN")) == null) {
			param.put("SEARCH_USE_YN", "Y");
		}
		model.addAttribute("SYSTEM_MENU_TREE" ,(service.retrieveSystemMenuList(super.extendsMap(param)).getValue()));
		model.addAttribute("reqParam", param);
		return "systemmgmt/sm-006";
	}
	
	/**
	 * 메뉴리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/retrieveSystemMenuTreeList", method = RequestMethod.POST)
	@ResponseBody
	public Result retrieveSystemMenuTreeList(@RequestBody Map param) throws Exception {
		
		return service.retrieveSystemMenuList(super.extendsMap(param));
	}
	
	
	/**
	 * 메뉴 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/updateSystemMenu", method = RequestMethod.POST)
	@ResponseBody
	public Result updateSystemMenu(@RequestBody Map param) throws Exception {
		return service.updateSystemMenu(super.extendsMap(param));
	}
	
	
	
	/**
	 * 잔량사용이력 조회
	 * @param param
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/sm-007")
    public String incmeLocalBntHstry_View(@RequestParam Map param, Model model, HttpSession session) {
        logger.debug("\n\n\n\n");
        logger.debug("<##### 잔량사용이력 View> @ModelAttribute : " + param);
        logger.debug("##### ------------------------------------------");
        model.addAttribute("reqParam", super.extendsMap(param));
        return "systemmgmt/sm-007";
    }
	
	
	
	@RequestMapping(value="/sys/retrieve_IncmeLocalBntHstry")
    @ResponseBody
    public GridOutputData<Map<String, Object>> retrieve_IncmeLocalBntHstry(@RequestBody Map param) throws Exception {
        logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName());
        logger.debug(super.logText);
        logger.debug("##### Request Parameters  : " + param);
        logger.debug(super.logText);
        
        GridOutputData<Map<String, Object>> gridData = this.service.retrieve_IncmeLocalBntHstry(super.extendsMap(param));        
        
        logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName()+ " END");
        
        
        return gridData;
    }
	
	
	/**
	 * 인터페이스 마스터
	 * @param param
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/sm-008")
    public String interfaceMaster_View(@RequestParam Map param, Model model, HttpSession session) {
        logger.debug("\n\n\n\n");
        logger.debug("##### <인터페이스 마스터 View> @ModelAttribute : " + param);
        logger.debug("##### ------------------------------------------");
        model.addAttribute("reqParam", super.extendsMap(param));
        return "systemmgmt/sm-008";
    }
	
	
	/**
	 * 인터페이스 마스터 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/retrieve_interfaceMaster")
    @ResponseBody
    public GridOutputData<Map<String, Object>> retrieve_interfaceMaster(@RequestBody Map param) throws Exception {
        logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName());
        logger.debug(super.logText);
        logger.debug("##### Request Parameters  : " + param);
        logger.debug(super.logText);
        
        GridOutputData<Map<String, Object>> gridData = this.service.retrieve_interfaceMaster(super.extendsMap(param));        
        
        logger.debug("##### Request Type ToastOutputData : " + new Object(){}.getClass().getEnclosingMethod().getName()+ " END");
        
        
        return gridData;
    }
	
	/**
	 * 인터페이스 마스터 데이터 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/update_interfaceMaster", method = RequestMethod.POST)
	@ResponseBody
	public Result update_interfaceMaster(@RequestBody Map param) throws Exception {
		
		return service.update_interfaceMaster(super.extendsMap(param));
	}
	
	/**
	 * 인터페이스 마스터 데이터 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/update_interfaceMasterStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result update_interfaceMasterStatus(@RequestBody Map param) throws Exception {
		
		return service.update_interfaceMasterStatus(super.extendsMap(param));
	}
	
	
	
	/**
	 * 인터페이스 수동 실행
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/runInterfaceItem", method = RequestMethod.POST)
	@ResponseBody
	public Result runInterfaceItem(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		
		List<Map<String, Object>> runCheck = service.retrieveInterfaceRunCheck(super.extendsMap(param));
		
		if(runCheck.size() > 0) {
			Map oneRow = runCheck.get(0);
			rs.setSuccess(false);
			String returnMessage = StringUtil.null2String(oneRow.get("COMPANY_CODE"))+"법인에서 "
					+ StringUtil.null2String(oneRow.get("IF_NAME"))+"인터페이스가 수행중입니다. \n 다른 법인의 인터페이스 수행 완료 후 수행해주세요. ";
			rs.setMessage(returnMessage);
		}else {
			param.put("STATUS_FLAG", "Y");
			service.updateInterfaceStatus(super.extendsMap(param));
			
			rs = service.runInterfaceItem(super.extendsMap(param));	
		}
		
		
		
		return rs;
	}

}