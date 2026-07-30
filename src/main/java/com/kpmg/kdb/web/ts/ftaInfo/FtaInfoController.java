package com.kpmg.kdb.web.ts.ftaInfo;

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
 * FtaInfoController.class
 *
 * @since 2026.07
 *
 *         FTA 정보 관리 > FTA 협정 정보 관리
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class FtaInfoController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(FtaInfoController.class);
	

	@Autowired
	protected FtaInfoService ftaInfoservice;

	/**
	 * FTA 정보 관리 > FTA 협정 정보 관리
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/ftaInfo")
	public String ftaInfo_view(Model model, HttpSession session) {
		return "ftaInfo/ftaInfoMgnt";
	}
	

	/**
	 *  FTA 정보 관리 > FTA 협정 정보 관리 > 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/retrieveFtaInfoList")
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
	 *  FTA 정보 관리 > FTA 협정 정보 관리 > 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/saveFtaInfoList")
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
	 *FTA 정보 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/ftaInfo/ftaNation")
	public String sample001pop02_view(Model model, HttpSession session) {
		return "ftaInfo/ftaInfoMgnt_nation_pop";
	}
	

	/**
	 *  FTA 정보 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 좌측 그리드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/ftaNation/retrieveFtaNationAllList")
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
	 *  FTA 정보 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/ftaNation/retrieveFtaNationApplyList")
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
	 *  FTA 정보 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/saveFtaNationList")
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