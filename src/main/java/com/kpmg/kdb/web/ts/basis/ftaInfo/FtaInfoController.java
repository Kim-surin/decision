package com.kpmg.kdb.web.ts.basis.ftaInfo;

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
import com.kpmg.kdb.web.poledger.dto.PoLedgerRequestDto;

/*******************************************************************************************
 *
 * FtaInfoController.class
 *
 * @since 2026.07
 *
 *         기초정보 관리 > FTA 협정정보관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class FtaInfoController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(FtaInfoController.class);
	

	@Autowired
	protected FtaInfoService ftaInfoservice;

	/**
	 * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/basis/ftaInfo")
	public String ftaInfo_view(Model model, HttpSession session) {
		return "basis/ftaInfo/ftaInfoMgnt";
	}
	

	/**
	 *  기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/ftaInfo/retrieveFtaInfoList")
	@ResponseBody
	public Result retrieveCompanyDivisionFormData(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaInfoservice.retrieveFtaInfoList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/ftaInfo/saveFtaInfoList")
	@ResponseBody
	public Result saveFtaInfoList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaInfoservice.saveFtaInfoList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	/**
	 * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/basis/ftaInfo/ftaNation")
	public String sample001pop02_view(Model model, HttpSession session) {
		return "basis/ftaInfo/ftaInfoMgnt_nation_pop";
	}
	

	/**
	 *  기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 좌측 그리드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/ftaInfo/ftaNation/retrieveFtaNationAllList")
	@ResponseBody
	public Result retrieveFtaNationAllList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaInfoservice.retrieveFtaNationAllList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	

	/**
	 *  기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/ftaInfo/ftaNation/retrieveFtaNationApplyList")
	@ResponseBody
	public Result retrieveFtaNationApplyList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaInfoservice.retrieveFtaNationApplyList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	

	/**
	 *  기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/ftaInfo/saveFtaNationList")
	@ResponseBody
	public Result saveFtaNationList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaInfoservice.saveFtaNationList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	

	
}