package com.kpmg.kdb.global.web.advice;

import java.time.LocalDate;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.web.common.CommonService;
import com.kpmg.kdb.web.division.DivisionService;

@ControllerAdvice
public class GlobalJspCacheAdvice {

	private final DivisionService divisionService;
	private final CommonService commonService;

	public GlobalJspCacheAdvice(DivisionService divisionService, CommonService commonService) {
		this.divisionService = divisionService;
		this.commonService = commonService;
	}

	@ModelAttribute("division")
	public List<Map<String, String>> division(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession(false);

			if (session == null) {
				return null;
			}

			// [TODO] context 생성
			Map<String, Object> userSession = (Map<String, Object>) session
					.getAttribute(SystemConstant.session.USER_SESSION_KEY);

			if (userSession == null) {
				return null;
			}

			String companyCode = (String) userSession.get("company_code");
			String defaultLanguage = (String) userSession.get("default_language");
			return divisionService.retrieveDevision(companyCode, defaultLanguage);
		} catch (Exception e) {
			return null;
		}
	}

	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-mm-dd");

	@ModelAttribute("from_date")
	public String ftomDate(HttpServletRequest request) {
		return "2026-01-01";
	}

	@ModelAttribute("to_date")
	public String toDate(HttpServletRequest request) {
		return "2026-12-31";
	}

	@ModelAttribute("warehousing_type")
	public List<Map<String, String>> warehousingType(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession(false);

			if (session == null) {
				return null;
			}

			Map<String, Object> userSession = (Map<String, Object>) session
					.getAttribute(SystemConstant.session.USER_SESSION_KEY);

			if (userSession == null) {
				return null;
			}

			String companyCode = (String) userSession.get("company_code");
			String defaultLanguage = (String) userSession.get("default_language");
			return commonService.retrieveCodeCombo(companyCode, defaultLanguage, "WT");
		} catch (Exception e) {
			return null;
		}
	}
}
