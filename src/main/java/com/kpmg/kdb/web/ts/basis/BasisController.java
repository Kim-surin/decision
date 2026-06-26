package com.kpmg.kdb.web.ts.basis;

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

/*******************************************************************************************
 *
 * BasisController.class
 *
 * @since 2025.04
 * @author D.Catddddddddddddddddddddddddd
 *
 *         기초정보 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class BasisController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(BasisController.class);
	

	@Autowired
	protected BasisService service;

	/**
	 * 기초정보관리 > 회사관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/basis000")
	public String sample001_view(Model model, HttpSession session) {
		return "basis/basis-000";
	}
	
	
	/**
	 * 회사관리 - 왼쪽 트리 목록 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveCompanyDivisionList")
	@ResponseBody
	public Result retrieveCompanyDivisionList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCompanyDivisionList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionList END");
		
		return result;
	}
	
	/**
	 * 회사관리 - 회사 또는 플렌트 1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveCompanyDivisionFormData")
	@ResponseBody
	public Result retrieveCompanyDivisionFormData(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData ");
		Result result = new Result();
		try {
			
			result = service.retrieveCompanyDivisionFormData(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData END");
		
		return result;
	}
	
	
	/**
	 * 회사 버퍼 설정 
	 * 회사 버퍼  설정값에  따른 해당 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveBufferDatalist")
	@ResponseBody
	public Result retrieveBufferDatalist(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveBufferDatalist ");
		Result result = new Result();
		try {
			
			result = service.retrieveBufferDatalist(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveBufferDatalist END");
		
		return result;
	}
	

}