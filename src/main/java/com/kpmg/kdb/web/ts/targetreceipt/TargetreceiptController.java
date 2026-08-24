package com.kpmg.kdb.web.ts.targetreceipt;

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
public class TargetreceiptController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(TargetreceiptController.class);
	

	@Autowired
	protected TargetreceiptService service;
	
	
	
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
	@RequestMapping(value = "/targetreceipt/TargetReceiptList")
	public String targetreceipt000_view(Model model, HttpSession session) {
		return "targetreceipt/targetReceiptList";
	}
	
	
	
	/**
	 * 확인서 수취대상 관리 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/targetreceipt/retrieveTargetReceiptList")
	@ResponseBody
	public Result retrieveTargetReceiptList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveTargetReceiptList ");
		Result result = new Result();
		try {
			
			result = service.retrieveTargetReceiptList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveTargetReceiptList END");
		
		return result;
	}
	
	

}