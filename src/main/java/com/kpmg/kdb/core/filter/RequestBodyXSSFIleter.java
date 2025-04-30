package com.kpmg.kdb.core.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.kpmg.kdb.configuration.ConstantBox;

@Component
public class RequestBodyXSSFIleter implements Filter {
	private List<String> excludedUrls = new ArrayList<String>();

	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		RequestWrapper requestWrapper = null;
		String path = ((HttpServletRequest) req).getServletPath();
		
		String excludePattern = ConstantBox.excludePattern;
		
		
		excludedUrls = Arrays.asList(excludePattern.split(","));
		
		
		try {
			if (!excludedUrls.contains(path)) {
				// 제외 URL이 아닌경우 동작
				requestWrapper = new RequestWrapper(request);
				chain.doFilter(requestWrapper, response);
			} else {
				chain.doFilter(request, response);
			}

		} catch (Exception e) {
			
		}

	}

	/*
	 * @Override public void init(FilterConfig filterConfig) throws ServletException
	 * { String excludePattern = filterConfig.getInitParameter("excludedUrls");
	 * excludedUrls = Arrays.asList(excludePattern.split(",")); }
	 */
	@Override
	public void destroy() {
	}
}
