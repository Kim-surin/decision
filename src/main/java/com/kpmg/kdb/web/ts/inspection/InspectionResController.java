package com.kpmg.kdb.web.ts.inspection;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.RestfulClientUtil;

/*******************************************************************************************
 *
 * IssueCertController.class
 *
 * @since 2026.08
 * @author D.Cat
 *
 *         증명서 발급 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class InspectionResController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(InspectionResController.class);
	

	@Autowired
	protected InspectionResService service;

	/**
	 * 실사 대응 서류
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping("/inspection/CooAuditDocument")
	public String cooAuditDocument_view(Model model, HttpSession session) {
		return "inspection/cooAuditDocument";
	}
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping("/inspection/cooCertifyPopup")
	public String cooCertifyPopup_view(Model model, HttpSession session) {
		return "inspection/cooCertifyPopup";
	}
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooCertSearchPopupList")
	@ResponseBody
	public Result retrieveCooCertSearchPopupList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooCertSearchPopupList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList END");
		
		return result;
	}
	
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooAuditDocumentInfo")
	@ResponseBody
	public Result retrieveCooAuditDocumentInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooAuditDocumentInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentInfo END");
		
		return result;
	}
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooAuditDocumentDetailList")
	@ResponseBody
	public Result retrieveCooAuditDocumentDetailList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentDetailList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooAuditDocumentDetailList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentDetailList END");
		
		return result;
	}
}