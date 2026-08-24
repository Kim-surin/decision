package com.kpmg.kdb.web.ts.cootarget;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.RestfulClientUtil;

/*******************************************************************************************
 *
 * targetreceiptController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 *         기초정보 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class CootargetController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CootargetController.class);
	

	@Autowired
	protected CootargetService service;
	
	
	
	/*
	 * @RequestMapping(value = "/targetReceiptList") public String
	 * targetReceiptList_view(Model model, HttpSession session) { return
	 * "targetreceipt/targetReceiptList"; }
	 */

	/**
	 * 협력업체 원산지확인서 > 확인서 수취대상 관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/cootarget/CootargetList")
	public String cootarget000_view(Model model, HttpSession session) {
		return "cootarget/cootargetList";
	}
	
	
	
	/**
	 * 확인서 수취율 정보 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/cootarget/retrieveCootargetList")
	@ResponseBody
	public Result retrieveCootargetList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCootargetList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCootargetList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCootargetList END");
		
		return result;
	}
	
	/**
	 * 확인서 수취율 팝업 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/cootarget/retrieveCootargetPopup")
	@ResponseBody
	public Result retrieveCootargetPopup(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCootargetPopup ");
		Result result = new Result();
		try {
			
			result = service.retrieveCootargetPopup(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCootargetPopup END");
		
		return result;
	}
	
	
	/**
	 * 확인서 수취율 대시보드 조회 
	 * @param param
	 * @return
	 */
	@PostMapping("/cootarget/retrieveCootargetDashboard")
	@ResponseBody
	public Result retrieveCootargetDashboard(@RequestBody Map param) {
	    Result result = new Result();

	    try {
	        result = service.retrieveCootargetDashboard(super.extendsMap(param));
	    } catch (Exception e) {
	        e.printStackTrace();
	        result = super.getResult(
	            false,
	            "MSG_UNSPECIFIED_ERROR",
	            new Object[] {}
	        );
	    }

	    return result;
	}
	
	
	

	@RequestMapping(value = "/cootarget_pop")
	public String cootarget_pop(Model model, HttpSession session) {
		return "cootarget/cootarget_pop";
	}
	
}