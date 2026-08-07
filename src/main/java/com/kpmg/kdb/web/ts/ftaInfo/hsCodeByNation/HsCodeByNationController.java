package com.kpmg.kdb.web.ts.ftaInfo.hsCodeByNation;

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
 *         FTA 정보 관리 > 국가별 HS코드 관리(양허표)
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class HsCodeByNationController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(HsCodeByNationController.class);
	

	@Autowired
	protected HsCodeByNationService hsCodeByNationService;

	/**
	 * FTA 정보 관리 > 국가별 HS코드 관리(양허표)
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/ftaInfo/hsCodeByNationMgnt")
	public String hsCodeByNationMgnt_view(Model model, HttpSession session) {
		return "ftaInfo/hsCodeByNationMgnt";
	}
	
	/**
	 * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 좌측 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/hsCodeByNationMgnt/retrieveNationIncludeRcepCntList")
	@ResponseBody
	public Result retrieveNationIncludeRcepCntList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeByNationService.retrieveNationIncludeRcepCntList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 상단 리스트 조회(국가별 HS코드)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/hsCodeByNationMgnt/retrieveHsCodeByNationList")
	@ResponseBody
	public Result retrieveHsCodeByNationList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeByNationService.retrieveHsCodeByNationList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 상단 리스트 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/hsCodeByNationMgnt/saveHsCodeByNationList")
	@ResponseBody
	public Result saveHsCodeByNationList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeByNationService.saveHsCodeByNationList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	/**
	 * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 하단 리스트 조회(양허표 리스트)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/hsCodeByNationMgnt/retrieveHsCodeRcepList")
	@ResponseBody
	public Result retrieveHsCodeRcepList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeByNationService.retrieveHsCodeRcepList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	/**
	 *  * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 하단 리스트 저장(양허표 리스트)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/ftaInfo/hsCodeByNationMgnt/saveHsCodeRcepList")
	@ResponseBody
	public Result saveHsCodeRcepList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = hsCodeByNationService.saveHsCodeRcepList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	


	
}