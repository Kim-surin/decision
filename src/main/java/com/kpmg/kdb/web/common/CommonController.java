package com.kpmg.kdb.web.common;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.home.HomeController;
import com.kpmg.kdb.web.home.HomeService;



/*******************************************************************************************
 * 
 * CommonController.class
 * 
 * @since 2018.02.01
 * @author D.Cat
 *
 * 시스템 전반에 걸친 공통으로 사용 될 수 있는 기능에 대한 구현을 담당하는 컨트롤러
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings("rawtypes")
public class CommonController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CommonController.class);

	@Autowired
	protected CommonService service;

	
	/**
	 * Page Not Found Error Mapping Page Call
	 * @author D.Cat
	 * @param param
	 * @param model
	 * @return
	 */
	@RequestMapping("/common/error404")
	public String error404(@RequestParam Map param, ModelMap model) {
		return "error/error404";
	}
	
	/**
	 * Formal Error Mapping Page Call
	 * @author D.Cat
	 * @param param
	 * @param model
	 * @return
	 */
	/*
	 * @RequestMapping("/common/error500") public String error500(@RequestParam Map
	 * param, ModelMap model) { return "error/error500"; }
	 */
	
	/**
	 * 오류 메세지를 확인할 수 있는 에러페이지(보안 정책상 사용하지 않음)
	 * @author D.Cat
	 * @param model
	 * @return
	 */
	@RequestMapping("/error/error")
	public String errorPage(ModelMap model) {
		logger.debug(model.toString());
		return "/error/error";
	}
	
	
	/****************************************************************************************************************************
     * Common Application 
     ****************************************************************************************************************************/
	/**
	 * emptytGridUrl 빈 그리드를 조회할 때 사용합니다. 
	 * 
	 * @author D.Cat
	 * @param param
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/commom/emptytGridUrl")
	@ResponseBody
	public GridOutputData<Map<String, Object>> emptytGridUrl(@RequestParam Map param) throws Exception {
	     GridOutputData<Map<String, Object>> gridData = new GridOutputData<Map<String,Object>>();
		return gridData;
	}

	/**
	 * 공통코드 리스트 조회
	 * 
	 * @author 피로물질
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/retrieveComCdList")
	@ResponseBody
	public Result retrieveComCdList(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveComCdList(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 공통코드 리스트 조회
	 * 
	 * @author 피로물질
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/retrievePlantCombo")
	@ResponseBody
	public Result retrievePlantCombo(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		try {
			rs.setValue(service.retrievePlantCombo(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
}
