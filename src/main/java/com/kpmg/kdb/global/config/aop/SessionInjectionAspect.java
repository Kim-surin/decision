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

				String companyCode = dto.getCompany_code();
				if (companyCode == null || companyCode.isBlank()) {
					dto.setCompany_code(companyCode);
				}

				String createBy = dto.getCreate_by();
				if (createBy == null || createBy.isBlank()) {
					dto.setCreate_by((String) userSession.get("user_id"));
				}

				String updateBy = dto.getUpdate_by();
				if (updateBy == null || updateBy.isBlank()) {
					dto.setUpdate_by((String) userSession.get("user_id"));
				}
				
				String defaultLanguage = dto.getDefault_language();
				if (defaultLanguage == null || defaultLanguage.isBlank()) {
					dto.setDefault_language((String) userSession.get("default_language"));
				}
			}
		}
	}
}
