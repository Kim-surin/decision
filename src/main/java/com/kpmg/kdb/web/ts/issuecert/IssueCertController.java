package com.kpmg.kdb.web.ts.issuecert;

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
public class IssueCertController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(IssueCertController.class);
	

	@Autowired
	protected IssueCertService service;

	/**
	 * FTA C/O 발급 > 증명서 발급
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecert/CooIssueCert")
	public String issueCert_view(Model model, HttpSession session) {
		return "issuecert/cooIssueCert";
	}
	
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서 발급버튼 클릭 팝업
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecert/cooIssueCertForm")
	public String cooIssueCertForm_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		return "issuecert/cooIssueCertForm";
	}
	
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서 상세
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/issuecert/cooIssueCertDetail")
	public String cooIssueCertDetail_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		return "issuecert/cooIssueCertDetail";
	}
	
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서 상세 > 증명서 수정 발급 (대상 데이터 조회 포함)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/issuecert/cooIssueCertModifyForm")
	public String cooIssueCertModifyForm_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		Map targetMap = service.selectCooFcrMstOne(super.extendsMap(param));
		
		model.addAttribute("sales_no", targetMap.get("sales_no"));
		model.addAttribute("sales_seq", targetMap.get("sales_seq"));
		model.addAttribute("customer_code", targetMap.get("customer_code"));
		model.addAttribute("invoice_date", targetMap.get("invoice_date"));
		
		return "issuecert/cooIssueCertModifyForm";
	}
	
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/retrieveCooIssueCertList")
	@ResponseBody
	public Result retrieveCooIssueCertList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooIssueCertList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooIssueCertList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooIssueCertList END");
		
		return result;
	}
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서발급 팝업 > 고객사 정보 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/retrieveCooIssueTargetCustomerInfo")
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
	 * FTA C/O 발급 > 증명서 발급 > 증명서발급 팝업 > 발급대상 그리드 데이터 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/retrieveCooIssueTargetList")
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
	 * 포괄 증명서 발급 > 중복체크
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/checkDuplicateCertifyNo")
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
	 * 포괄 증명서 발급 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/confirmIssue")
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
	 * FTA C/O 발급 > 증명서 발급 > 증명서상세 팝업 > 그리드 데이터 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/retrieveIssuedCertList")
	@ResponseBody
	public Result retrieveIssuedCertList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveIssuedCertList ");
		Result result = new Result();
		try {
			
			result = service.retrieveIssuedCertList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveIssuedCertList END");
		
		return result;
	}
	
	/**
	 * 수정발급 대상 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/issuecert/retrieveCooModifyCertList")
	@ResponseBody
	public Result retrieveCooModifyCertList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooModifyCertList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooModifyCertList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooModifyCertList END");
		
		return result;
	}
}