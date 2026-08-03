package com.kpmg.kdb.web.ts.ftaInfo.hsCode;

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
 *         FTA 정보 관리 > FTA HSCODE 결정기준
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class HsCodeController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(HsCodeController.class);
	

	@Autowired
	protected HsCodeService hsCodeService;

	/**
	 *    FTA 정보 관리 > FTA HSCODE 결정기준
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/ftaInfo/hsCodeMgnt")
	public String hsCodeMgnt_view(Model model, HttpSession session) {
		return "ftaInfo/hsCodeMgnt";
	}
	
	
	/**
	 * FTA 정보 관리 > FTA HSCODE 결정기준 > 좌측 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/retrieveHsCodeList")
	@ResponseBody
	public Result retrieveHsCodeList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeService.retrieveHsCodeList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * FTA 정보 관리 > FTA HSCODE 결정기준 > 우측 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/retrieveHsCodePsrList")
	@ResponseBody
	public Result retrieveHsCodePsrList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeService.retrieveHsCodePsrList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}

	
}