package com.kpmg.kdb.web.ts.ftaInfo.ftaIncoterms;

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
 *         FTA 정보 관리 > FTA별 INCOTERMS
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class FtaIncotermsController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(FtaIncotermsController.class);
	

	@Autowired
	protected FtaIncotermsService ftaIncotermsService;

	/**
	 * FTA 정보 관리 > FTA별 INCOTERMS
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/ftaInfo/ftaIncoterms")
	public String ftaIncoterms_view(Model model, HttpSession session) {
		return "ftaInfo/ftaIncoterms";
	}
	
	
	/**
	 *  FTA 정보 관리 > FTA별 INCOTERMS > 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/ftaIncoterms/retrieveFtaIncotermsList")
	@ResponseBody
	public Result retrieveFtaIncotermsList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaIncotermsService.retrieveFtaIncotermsList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  FTA 정보 관리 > FTA별 INCOTERMS > 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/ftaIncoterms/saveFtaIncotermsList")
	@ResponseBody
	public Result saveFtaIncotermsList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = ftaIncotermsService.saveFtaIncotermsList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	

	
}