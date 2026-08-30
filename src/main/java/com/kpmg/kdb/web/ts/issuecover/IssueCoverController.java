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
	public String issueCover_view(Model model, HttpSession session) {
		return "issuecover/cooIssueCover";
	}
	
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서 발급버튼 클릭 팝업
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecover/cooIssueCoverForm")
	public String cooIssueCoverForm_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		return "issuecover/cooIssueCoverForm";
	}
	
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서 상세
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecover/cooIssueCoverDetail")
	public String cooIssueCoverDetail_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		return "issuecover/cooIssueCoverDetail";
	}
	
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서 상세 > 확인서 수정 발급 (대상 데이터 조회 포함)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/issuecover/cooIssueCoverModifyForm")
	public String cooIssueCoverModifyForm_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		Map targetMap = service.selectCooFcrMstOne(super.extendsMap(param));
		
		model.addAttribute("sales_no", targetMap.get("sales_no"));
		model.addAttribute("sales_seq", targetMap.get("sales_seq"));
		model.addAttribute("customer_code", targetMap.get("customer_code"));
		model.addAttribute("invoice_date", targetMap.get("invoice_date"));
		
		return "issuecover/cooIssueCoverModifyForm";
	}
	
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 검색버튼
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
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서발급 팝업 > 고객사 정보 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/retrieveCooIssueTargetCustomerInfo")
	@ResponseBody
	public Result retrieveCooIssueTargetCustomerInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooIssueTargetCustomerInfo ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooIssueTargetCustomerInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooIssueTargetCustomerInfo END");
		
		return result;
	}
	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서발급 팝업 > 발급대상 그리드 데이터 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/retrieveCooIssueTargetList")
	@ResponseBody
	public Result retrieveCooIssueTargetList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooIssueTargetList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooIssueTargetList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooIssueTargetList END");
		
		return result;
	}
	
	
	/**
	 * 포괄 확인서 발급 > 중복체크
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/checkDuplicateCertifyNo")
	@ResponseBody
	public Result checkDuplicateCertifyNo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "checkDuplicateCertifyNo ");
		Result result = new Result();
		try {
			
			result = service.checkDuplicateCertifyNo(super.extendsMap(param));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "checkDuplicateCertifyNo END");
		
		return result;
	}
	
	/**
	 * 포괄 확인서 발급 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/confirmIssue")
	@ResponseBody
	public Result retrieveCooIssㅇueTargetList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "confirmIssue ");
		Result result = new Result();
		try {
			
			String cooCertifyNo = service.confirmIssue(super.extendsMap(param));
			result.setValue(cooCertifyNo);
			result.setSuccess(true);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		
		logger.debug("##### Request Type result Class : " + "confirmIssue END");
		
		return result;
	}

	
	/**
	 * FTA C/O 발급 > 확인서 발급 > 확인서상세 팝업 > 그리드 데이터 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/retrieveIssuedCoverList")
	@ResponseBody
	public Result retrieveIssuedCoverList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveIssuedCoverList ");
		Result result = new Result();
		try {
			
			result = service.retrieveIssuedCoverList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveIssuedCoverList END");
		
		return result;
	}
	
	/**
	 * 수정발급 대상 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecover/retrieveCooModifyCoverList")
	@ResponseBody
	public Result retrieveCooModifyCoverList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooModifyCoverList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooModifyCoverList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooModifyCoverList END");
		
		return result;
	}
}