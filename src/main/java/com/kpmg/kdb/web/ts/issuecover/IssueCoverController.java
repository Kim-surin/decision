package com.kpmg.kdb.web.ts.issuecover;

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
 * IssueCoverController.class
 *
 * @since 2026.08
 * @author D.Cat
 *
 *         확인서/증명서 발급 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class IssueCoverController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(IssueCoverController.class);
	

	@Autowired
	protected IssueCoverService service;

	/**
	 * FTA C/O 발급 > 확인서 발급
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecover/CooIssueCover")
	public String issuecover000_view(Model model, HttpSession session) {
		return "issuecover/cooIssueCover";
	}
	
	/**
	 * FTA C/O 발급 > 확인서 발급 현황
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/issuecover/CooIssueStatus")
	public String issuecover001_view(Model model, HttpSession session) {
		return "issuecover/cooIssueStatus";
	}
	
	
	/**
	 * 회사관리 - 왼쪽 트리 목록 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/retrieveCooIssueCoverList")
	@ResponseBody
	public Result retrieveCooIssueCoverList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooIssueCoverList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooIssueCoverList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooIssueCoverList END");
		
		return result;
	}
}