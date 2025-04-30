package com.kpmg.kdb.web.ts.basis;

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
 * BasisController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 *         기초정보 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class BasisController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(BasisController.class);
	

	@Autowired
	protected BasisService service;

	/**
	 * 기초정보관리 > 회사관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/basis000")
	public String sample001_view(Model model, HttpSession session) {
		return "basis/basis-000";
	}
	

}