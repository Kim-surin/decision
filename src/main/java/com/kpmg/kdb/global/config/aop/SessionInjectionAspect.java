package com.kpmg.kdb.global.config.aop;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.global.config.aop.dto.BaseRequestDto;

@Aspect
@Component
public class SessionInjectionAspect {
	@Before("execution(* com.kpmg..*Controller.*(..))")
	public void injectSession(JoinPoint joinPoint) {
		ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes();
		if (servletRequestAttributes == null) {
			return;
		}

		HttpServletRequest request = servletRequestAttributes.getRequest();
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}

		Map<String, Object> userSession = (Map<String, Object>) session
				.getAttribute(SystemConstant.session.USER_SESSION_KEY);

		if (userSession == null) {
			return;
		}

		Object[] args = joinPoint.getArgs();
		for (Object arg : args) {
			if (arg instanceof BaseRequestDto) {
				BaseRequestDto dto = (BaseRequestDto) arg;

				String companyCode = dto.getCompanyCode();
				if (companyCode == null || companyCode.isBlank()) {
					dto.setCompanyCode((String) userSession.get("company_code"));
				}

				String createBy = dto.getCreateBy();
				if (createBy == null || createBy.isBlank()) {
					dto.setCreateBy((String) userSession.get("create_by"));
				}

				String updateBy = dto.getUpdateBy();
				if (updateBy == null || updateBy.isBlank()) {
					dto.setUpdateBy((String) userSession.get("update_by"));
				}

				String divisionCode = dto.getDivisionCode();
				if (divisionCode == null || divisionCode.isBlank()) {
					dto.setDivisionCode((String) userSession.get("division_code"));
				}
				
				String defaultLanguage = dto.getDefaultLanguage();
				if (defaultLanguage == null || defaultLanguage.isBlank()) {
					dto.setDefaultLanguage((String) userSession.get("default_language"));
				}
			}
		}
	}
}
