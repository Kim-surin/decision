package com.kpmg.kdb.web.master;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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


/*******************************************************************************************
 * 
 * RefundBasisController.class
 * 
 * @since 2018.02.01
 * @author D.Cat
 *
 * 환급 마스터 정보 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class MasterController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(MasterController.class);

	@Autowired
	protected MasterService service;


	
	
	/**
	 * 회사관리
	 * 
	 * @author  D.Cat
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-001")
	public String mm_001_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "mm-001 ");
		
		return "mastermgmt/mm-001";

	}
	
	/**
	 * 회사정보 조회
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/retrieveCompanyInfo")
	@ResponseBody
	public Result retrieveCompanyInfo(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveCompanyInfo(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 회사정보 저장
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/updateCompanyInfo")
	@ResponseBody
	public Result updateCompanyInfo(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.updateCompanyInfo(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 고객사관리
	 * 
	 * @author  피로물질
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-002")
	public String mm_002_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "mm-002 ");
		
		return "mastermgmt/mm-002";

	}
	
	/**
	 * 고객사리스트
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/master/retrieveCustomerList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveCustomerList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveCustomerList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 고객사상세 팝업
	 * 
	 * @author  D.Cat
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-00201")
	public String mm_00201_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		
		return "mastermgmt/mm-00201";

	}
	
	/**
	 * 고객사상세
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/retrieveCustomerDetail")
	@ResponseBody
	public Result retrieveCustomerDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCustomerDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveCustomerDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 고객사 상세 저장
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/updateCustomerDetail")
	@ResponseBody
	public Result updateCustomerDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.updateCustomerDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 협력사관리
	 * 
	 * @author  피로물질
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-003")
	public String mm_003_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "mm-003 ");
		
		return "mastermgmt/mm-003";

	}
	
	/**
	 * 고객사리스트
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/master/retrieveVendorList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveVendorList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveVendorList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 협력사상세 팝업
	 * 
	 * @author  피로물질
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-00301")
	public String mm_00301_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		
		return "mastermgmt/mm-00301";

	}
	
	/**
	 * 협력사상세
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/retrieveVendorDetail")
	@ResponseBody
	public Result retrieveVendorDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveVendorDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveVendorDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 협력사상세 저장
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/updateVendorDetail")
	@ResponseBody
	public Result updateVendorDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.updateVendorDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 환급제한규정
	 * 
	 * @author  피로물질
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-004")
	public String mm_004_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "mm-004 ");
		
		return "mastermgmt/mm-004";

	}
	
	/**
	 * 환급제한규정 리스트
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/master/retrieveDrwbakLmttList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveDrwbakLmttList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveDrwbakLmttList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 환급제한규정상세 팝업
	 * 
	 * @author  피로물질
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-00401")
	public String mm_00401_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		
		return "mastermgmt/mm-00401";

	}
	
	/**
	 * 환급제한규정상세
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/retrieveDrwbakLmttDetail")
	@ResponseBody
	public Result retrieveDrwbakLmttDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveDrwbakLmttDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveDrwbakLmttDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 환급제한규정 저장
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/updateDrwbakLmttDetail")
	@ResponseBody
	public Result updateDrwbakLmttDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.updateDrwbakLmttDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 환급제한규정 삭제
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/master/deleteDrwbakLmttDetail")
	@ResponseBody
	public Result deleteDrwbakLmttDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyInfo ");
		Result rs = new Result();
		try {
			rs.setValue(service.deleteDrwbakLmttDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 자재마스터 관리 
	 * 
	 * @author  
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/mm-006")
	public String mm_006_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "mm-006 ");
		
		return "mastermgmt/mm-006";

	}

	/**
	 * 자재마스터 리스트 조회
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/master/retrieveItemList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveItemList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveItemList(super.extendsMap(param));		
		
		return gridData;
	}

}