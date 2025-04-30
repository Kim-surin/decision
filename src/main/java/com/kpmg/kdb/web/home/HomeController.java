package com.kpmg.kdb.web.home;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.StringUtil;


/*******************************************************************************************
 * 
 * HomeController.class
 * 
 * @since 2018.02.01
 * @author D.Cat
 *
 * Login, LoginPage, Dash Board 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class HomeController extends GenericController {

	/**
	 * 로그인 페이지 URI 경로
	 */
	public static final String LOGIN_FORM_VIEW_PATH = "redirect:/loginform";

	protected Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	protected HomeService service;


	@Autowired
	private JavaMailSender mailSender;

	/**
	 * Welcome Page Call
	 * 
	 * @author 
	 * 			  D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @param session
	 *            HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		
		String returl = LOGIN_FORM_VIEW_PATH;

		if (null == super.getSessionUserMap()) {
			logger.info("##### 로그인 되지 않았음! 뷰경로 : '" + returl + "'");
			return returl;
		}
		
		Map<String, Object> emptyMap = new HashedMap();
		List<Map> sideMenuList = service.retrieveAllMenuList(super.extendsMap(emptyMap));

		List<Map> lv01_List = new ArrayList<Map>();
		for (int inx = 0; inx < sideMenuList.size(); inx++) {
			Map rowMap = sideMenuList.get(inx);
			if ("1".equalsIgnoreCase(rowMap.get("depth")+"")) {
				lv01_List.add(rowMap);
			}
		}
		
		List<Map> lv02_List = new ArrayList<Map>();
		for (int inx = 0; inx < sideMenuList.size(); inx++) {
			Map rowMap = sideMenuList.get(inx);
			if ("2".equalsIgnoreCase(rowMap.get("depth")+"")) {
				lv02_List.add(rowMap);
			}
		}
		
		List<Map> lv03_List = new ArrayList<Map>();
		for (int inx = 0; inx < sideMenuList.size(); inx++) {
			Map rowMap = sideMenuList.get(inx);
			if ("3".equalsIgnoreCase(rowMap.get("depth")+"")) {
				lv03_List.add(rowMap);
			}
		}
		
		
		// 2 level에 3 level 담기
		for (int inx = 0; inx < lv02_List.size(); inx++) {
			Map rowMap = lv02_List.get(inx);
			List rowSubMenuList = new ArrayList<Map>();
			for (int i = 0; i < lv03_List.size(); i++) {
				Map sub_rowMap = lv03_List.get(i);
				if (("" + rowMap.get("id")).equalsIgnoreCase("" + sub_rowMap.get("parent_id"))) {
					rowSubMenuList.add(sub_rowMap);
				}
			}
			rowMap.put("SUB_MENU", rowSubMenuList);
		}
		
		// 1 level에 2 level 담기
		for (int inx = 0; inx < lv01_List.size(); inx++) {
			Map rowMap = lv01_List.get(inx);
			List rowSubMenuList = new ArrayList<Map>();
			for (int i = 0; i < lv02_List.size(); i++) {
				Map sub_rowMap = lv02_List.get(i);
				if (("" + rowMap.get("id")).equalsIgnoreCase("" + sub_rowMap.get("parent_id"))) {
					rowSubMenuList.add(sub_rowMap);
				}
			}
			rowMap.put("SUB_MENU", rowSubMenuList);
		}

		model.addAttribute("sideMenuList", lv01_List);
		
		return "mainPage";

	}

	
	/**
	 * Undefined 오류 처리 
	 * @author D.Cat
	 * @param model
	 * @param session
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/undefined")
	public void undefined(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.getRequestDispatcher("/dashBoard").forward(request, response);
	}

	/**
	 * 로그인 폼 페이지로 이동 
	 * @author D.Cat
	 * @param model
	 *            스프링 모델객체
	 * @return 로그인 뷰페이지 경로
	 */
	@RequestMapping("/loginform")
	public String loginform(ModelMap model) {
		HttpSession session = super.getSession();

		if (null != super.getSessionUserMap()) {
			logger.debug("##### 새로운 세션이 아닙니다. 세션ID = '{}'", session.getId());
			return "redirect:/"; // 홈페이지로 리다이렉트
		}

		logger.debug("loginform ------------------------------------------");

		return "login";
	}
	
	@RequestMapping("/loginFail")
	public String loginFail(ModelMap model) {
		HttpSession session = super.getSession();
		return "loginf";
	}
	
	@RequestMapping("/loginFailTimeout")
	public String loginFailTimeout(ModelMap model) {
		HttpSession session = super.getSession();
		return "logint";
	}

	/**
	 * @description : 사용자의 사용 가능여부를 리턴
	 * @author D.Cat
	 * @since : 2018.02.01
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/common/retrieveUserCheck")
	public @ResponseBody
	Result retrieveUserCheck(@RequestBody Map param) {
		logger.debug("\n\n\n\n");
		logger.debug("[사용자의 사용 가능여부 찾기] 입력파라미터 : " + param);
		Result rs = new Result();
		try {
			rs = service.retrieveUserCheck(param);
		} catch (Exception e) {
			rs.setSuccess(false);
			rs.setMessage(e.getMessage());
			
		}
		return rs;
	}

	/**
	 * 로그인 처리
	 * @author D.Cat
	 * @param param
	 *            화면 요청파라미터맵(ID, 비밀번호)
	 * @param session
	 *            HTTP세션객체
	 * @param model
	 *            스프링 모델객체
	 * @return 로그인 성공시 'home' 뷰로 리다이렉트, 실패시 로그인폼 뷰
	 */
	@RequestMapping({"/login","/common/login"})
	public String login(@RequestParam Map param, HttpServletRequest req, HttpSession session, Model model) {
		if (null != super.getSessionUserMap()) {
			logger.debug("##### 이미 로그인된 세션. 세션ID : '{}'", session.getId());
			return "redirect:/"; // 홈페이지로 리다이렉트
		}
		
		String returl = "/loginform"; // "redirect:/loginform";
		
		logger.debug("\n\n\n----------------------------------------------------------------");
		
		String EMP_NO = StringUtil.null2String(param.get("EMP_NO"), "");
        String id = StringUtil.null2String(EMP_NO, StringUtil.null2String(param.get("USERID")));
        String pwd = StringUtil.null2String(param.get("PASSWORD"));
        String company_code = StringUtil.null2String(param.get("COMPANY_CODE"));
		String strHost = req.getHeader("X-Forwarded-For");
		
		if(strHost == null) {
			strHost = req.getRemoteAddr();
		}
		
		param.put("USERID", id);
        param.put("PASSWORD", pwd);
        param.put("COMPANY_CODE_S", company_code);
        param.put("COMPANY_CODE", company_code);
        param.put("IP", strHost);
		
        // 로그인 처리
		Result result = this.service.retrieveLoginUserInfo(param, session);

		String reqUrl = (String) param.get("goPage");
		if (result.getSuccess()) {
			// 성공후 home로 이동(리다이렉트 : 브라우저의 경로를 /로 표시되도록 처리)
			returl = "redirect:/" + (StringUtils.isBlank(reqUrl) ? "#dashBoard" : reqUrl); // 경로로  리다이렉트
		} else {
			model.addAttribute("result", result);
			logger.warn("<LOGIN> 실패! message :: " + result.getMessage());
			returl = "redirect:/loginFail";
		}
		logger.debug("<LOGIN> 뷰경로 : '" + returl + "'");
		

		return returl;
	}

	/**
	 * 로그아웃 처리
	 * @author D.Cat
	 * @param session
	 *            HTTP세션객체
	 * @return 로그인폼 뷰 경로
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		if (null == session) {
			logger.debug("##### Logout process end.");
			return LOGIN_FORM_VIEW_PATH;
		}

		logger.debug("##### Logout Session ID : '{}', 사용자정보 : {}", session.getId(), super.getSessionUserMap());

		session.setAttribute(SystemConstant.session.USER_SESSION_KEY, null);
		session.invalidate();
		logger.debug("##### Logout process end.");

		return LOGIN_FORM_VIEW_PATH;
	}
	
	
	@RequestMapping("/mainPage")
	public ModelAndView mainPage(@RequestParam Map param) throws Exception {
		ModelAndView mv = new ModelAndView();
		return mv;
	}

	

	@RequestMapping(value = "/favicon.ico", method = RequestMethod.GET)
	public void favicon(HttpServletRequest request, HttpServletResponse reponse) {
		try {
			reponse.sendRedirect("");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * DashBoard Page Call
	 * @author D.Cat
	 * @param param
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/dashBoard")
	public String viewDashBoard(@RequestParam Map param, HttpServletRequest request, HttpSession session, Model model) {
		
		String agent = request.getHeader("User-Agent");
		// 브라우져 구분
		boolean ieFlag = false;
		if (agent != null) {
			if (agent.indexOf("Trident") > -1) {
				ieFlag = true;
			}
		}
		
		String returnPage = "home/dashBoard";
		
		if(ieFlag) {
			logger.debug("###### [Call DashBoard Page] IE에 대한 PAGE를 호출합니다.");
			returnPage = "home/dashBoard_ie";
		}
		
		return returnPage;

	}
	

	
}