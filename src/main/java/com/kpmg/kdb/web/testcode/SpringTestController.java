package com.kpmg.kdb.web.testcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.RestfulClientUtil;

/*******************************************************************************************
 *
 * SpringTestController.class
 *
 * @since 2018.02.01
 * @author D.Cat
 *
 *         각종 프로그램 개발에 관련된 샘플 기능을 구현하는 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class SpringTestController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(SpringTestController.class);
	
	@Value("${eai.call.url}")
	private String EAI_URL_PREFIX;

	@Autowired
	protected SpringTestService service;

	@RequestMapping("/asdfasdfsaf")
	public ModelAndView testController(@RequestParam Map param) throws Exception {
		ModelAndView mv = new ModelAndView();

		service.dbTest(param);
		mv.addObject("helloWorld", "hello~ Spring World");
		mv.setViewName("helloSpring");
		return mv;
	}

	/**
	 * sample06
	 * 
	 * @author D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return View Path String
	 */
	@RequestMapping(value = "/sample-000")
	public String sample000_view(Model model, HttpSession session) {
		return "sample/sample-000";
	}
	
	/**
	 * sample06
	 * 
	 * @author D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return View Path String
	 */
	@RequestMapping(value = "/sample-001")
	public String sample001_view(Model model, HttpSession session) {
		return "sample/sample-001";
	}
	
	
	@RequestMapping(value = "/sample-001-pop01")
	public String sample001pop01_view(Model model, HttpSession session) {
		return "sample/sample-001-pop01";
	}
	@RequestMapping(value = "/sample-001-pop02")
	public String sample001pop02_view(Model model, HttpSession session) {
		return "sample/sample-001-pop02";
	}
	
	
	/**
	 * chart document api
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/sample-002")
	public String sample002_view(Model model, HttpSession session) {
		return "sample/sample-002";
	}
	
	
	/**
	 * Sample001 page  조회 기능 샘플
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/sample/retrieveTestSalesMaster")
	@ResponseBody
	public Result retrieveTestSalesMaster(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveTestSalesMaster ");
		Result result = new Result();
		try {
			
			result = service.retrieveTestSalesMaster(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveTestSalesMaster END");
		
		return result;
	}

}