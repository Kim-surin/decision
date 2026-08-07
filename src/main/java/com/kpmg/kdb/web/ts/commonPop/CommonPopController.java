package com.kpmg.kdb.web.ts.commonPop;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/*******************************************************************************************
 *
 * FtaInfoController.class
 *
 * @since 2026.07
 *
 *         FTA 정보 관리 > FTA 협정 정보 관리
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class CommonPopController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CommonPopController.class);
	

	@Autowired
	protected CommonPopService commonPopService;

	/**
	 * 공통 팝업 - 공통코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String comCodePop_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "commonPop/comCode_pop";
	}
	
	
	/**
	 *  공통 팝업 - 공통코드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComCodeList")
	@ResponseBody
	public Result retrieveComCodeList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComCodeList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * 공통 팝업 - 국가코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comNation", method = { RequestMethod.GET, RequestMethod.POST })
	public String comNationPop_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
			model.addAttribute("params", params);
			return "commonPop/comNation_pop";
		}
	
	/**
	 *  공통 팝업 - 국가코드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComNationList")
	@ResponseBody
	public Result retrieveComNationList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComNationList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	/**
	 * 공통 팝업 - 사업장코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comDivision", method = { RequestMethod.GET, RequestMethod.POST })
	public String comDivisionPop_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "commonPop/comDivision_pop";
	}
	
	/**
	 *  공통 팝업 - 사업장코드코드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComDivisionList")
	@ResponseBody
	public Result retrieveComDivisionList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComDivisionList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	

	/**
	 * 공통 팝업 - 자재코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comItem", method = { RequestMethod.GET, RequestMethod.POST })
	public String comItem_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "commonPop/comItem_pop";
	}
	
	/**
	 *  공통 팝업 - 자재코드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComItemList")
	@ResponseBody
	public Result retrieveComItemList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComItemList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * 공통 팝업 - HS코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comHsCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String comHsCode_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "commonPop/comHsCode_pop";
	}
	
	/**
	 *  공통 팝업 - HS 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComHsCodePopList")
	@ResponseBody
	public Result retrieveComHsCodePopList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComHsCodePopList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * 공통 팝업 - FTA 코드 조회
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/commonPop/comFtaCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String comFtaCode_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "commonPop/comFtaCode_pop";
	}
	
	/**
	 *  공통 팝업 - FTA 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/commonPop/retrieveComFtaCodePopList")
	@ResponseBody
	public Result retrieveComFtaCodePopList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = commonPopService.retrieveComFtaCodePopList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
}