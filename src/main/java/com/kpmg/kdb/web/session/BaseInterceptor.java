package com.kpmg.kdb.web.session;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.util.StringUtil;

/**
 * 콘트롤러 인터셉터 클래스로 세션 체크 처리등 수행
 * 
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Component
public class BaseInterceptor extends HandlerInterceptorAdapter {

    protected Logger logger = LoggerFactory.getLogger(BaseInterceptor.class);



    /**
     * 컨트롤러 선 처리함수
     * 
     * @param request   HTTP요청객체
     * @param response  HTTP응답객체
     * @param handler   핸들러
     */
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {

        Object sessionUserObject = request.getSession().getAttribute(SystemConstant.session.USER_SESSION_KEY);
        String uri = request.getRequestURI();
        String urL = request.getRequestURL().toString();
        String qs = request.getQueryString();
        String uriqs = uri + (StringUtils.isBlank(qs) ? "" : "?" + qs);
        String xreq = request.getHeader("X-Requested-With");
        boolean isMultipart = BaseInterceptor.isMultipartContent(request);
        String redirectUrl = request.getContextPath() + "/";
        
        StringBuffer s = new StringBuffer("\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n");
        s.append("+--------------------------------------------------------------------------+\n");
        s.append("+                    Interceptor Information(preHandle)                    +\n");
        s.append("+--------------------------------------------------------------------------+\n");
        s.append("+ URI = '").append(uri).append("', URL = '").append(urL).append("'\n");
        s.append("+ X-Requested-With = [").append(xreq).append("], isMultipartContent = [").append(isMultipart).append("]\n");
        s.append("+ Query String = [").append(qs).append("]\n");
        
        
        // 임시 코드 
        if(true) {
        	return true;
        }

        if ( null!=uri && uri.startsWith("/common") ) { // '/common' 으로 시작하는 경우 세션체크하지 않음
            s.append("+--------------------------------------------------------------------------+\n");
            s.append("+                             common request                               +\n");
            s.append("+--------------------------------------------------------------------------+\n");
            logger.debug(s.toString());
            return true;
        }

        if (null==sessionUserObject) {
            redirectUrl = request.getContextPath() + "/loginform";
            s.append("+ No session information!\n");
            s.append("+ Redirect to login form page : '").append(redirectUrl).append("'\n");
            s.append("+--------------------------------------------------------------------------+\n");
            logger.debug(s.toString());
            response.sendRedirect(redirectUrl);
            return false;
        }
        if ( StringUtils.equalsIgnoreCase("XMLHttpRequest", xreq) ) {
            s.append("+--------------------------------------------------------------------------+\n");
            s.append("+                          XMLHttpRequest : ajax                           +\n");
            s.append("+--------------------------------------------------------------------------+\n");
            
            //화면을 호출하는 요청인경우 화면 권한을 체크합니다. 
            if(uri.startsWith("/sm-")||uri.startsWith("/refundBasis-")||uri.startsWith("/db-")||uri.startsWith("/refundBasis-")
                    ||uri.startsWith("/sm-")||uri.startsWith("/report-")||uri.startsWith("/fta-")||uri.startsWith("/cv-")||uri.startsWith("/sample-")) {
            	Map sessionUserMap = (Map)sessionUserObject;
            	String authStr = StringUtil.null2String(sessionUserMap.get("AUTH_MENU_STR"));
            	//popup 대응 코드
            	String uriPopup = uri.substring(0,7);
            	if(authStr.indexOf(uriPopup) == -1) {
            		s.append("+                          No authority request                            +\n");
            		s.append("+--------------------------------------------------------------------------+\n");
            		logger.debug(s.toString());
                    response.getWriter().write("<script>alert('NO authority!'); window.location.href = '/';</script>"); //권한없음
            		return false;
            	}
            }
            logger.debug(s.toString());
            return true;
        }
        //multipart/form-data
        if(isMultipart){
        	s.append("+--------------------------------------------------------------------------+\n");
            s.append("+                          XMLHttpRequest : multipart/form-data            +\n");
            s.append("+--------------------------------------------------------------------------+\n");
            logger.debug(s.toString());
            return true;
        }
        


        s.append("+--------------------------------------------------------------------------+\n");
        s.append("+                             OTHER request                               +\n");
        s.append("+--------------------------------------------------------------------------+\n");
        logger.info(s.toString());

        if ( StringUtils.equals("/", uri) || StringUtils.equals("/logout", uri) ||
                uri.startsWith("/common") || uri.endsWith("Popup") ||
                uri.indexOf("excel") >= 0 || uri.indexOf("Excel") >= 0 ||
                uri.indexOf("upload") >= 0 || uri.indexOf("Upload") >= 0 || uri.indexOf("UpLoad") >= 0 ||
                uri.indexOf("download") >= 0 || uri.indexOf("Download") >= 0 || uri.indexOf("thirdParty_ReportApplication") >= 0 ) {
            return true; //홈페이지 등 공통적인 요청이면 true 반환
        }
        else {
            redirectUrl = request.getContextPath() + "/";
            s.append("+ maybe no authority for '").append(uri).append("'. so redirect to HOME\n");
            s.append("+--------------------------------------------------------------------------+\n");
            logger.warn(s.toString());
            response.sendRedirect(redirectUrl); //redirectUrl
            response.getWriter().write("<script>alert('NO authority!'); window.location.href = '/';</script>"); //권한없음
            return false;
        }
    }


    public void after(HttpServletRequest request, HttpServletResponse response,
                      Object handler, ModelAndView modelAndView) throws Exception {
        StringBuffer s = new StringBuffer("##### Interceptor Information(after) #####\n");
        s.append("+--------------------------------------------------------------------------+\n");

        if (null!=modelAndView) {
            s.append("+ ViewName : '").append( modelAndView.getViewName() ).append("'\n");
        }

        s.append("+--------------------------------------------------------------------------+ ::: ");
        logger.debug(s.toString());
    }

    /**
     * 컨트롤러 후 처리함수
     */
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object controller, Exception e) throws Exception {

        StringBuffer s = new StringBuffer("##### Interceptor Information(afterCompletion) #####\n");
        s.append("+--------------------------------------------------------------------------+\n");

        if (null!=e) {
            s.append("+ Exception occurred! (ERROR MESSAGE) ").append(e.getMessage()).append("\n");
            
        }
        s.append("+--------------------------------------------------------------------------+\n");
        if (null==e) {
            logger.debug(s.toString());
        }else{
            logger.error(s.toString());
            
        }
    }

    /**
     * 컨트롤러 후 처리함수
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object controller, ModelAndView modelAndView) throws Exception {
        StringBuffer s = new StringBuffer("##### Interceptor Information(postHandle) #####\n");
        s.append("+--------------------------------------------------------------------------+\n");

        if (null!=modelAndView) {
            s.append("+ ViewName : '").append( modelAndView.getViewName() ).append("'\n");

            Map model = modelAndView.getModel();
            Set<String> keys = model.keySet();
            Iterator<String> keyIter = keys.iterator();

            while ( keyIter.hasNext() ) {
                s.append("+ Model : name = '").append( keyIter.next() ).append("'\n");
            }
        }
        else {
            s.append("+ ModelAndView is NULL!\n");
        }

        s.append("+--------------------------------------------------------------------------+ ::: ");
        logger.debug(s.toString());
    }

    /**
     * 파일업로드 요청인지 판단하여 반환
     *
     * @param   request HTTP요청객체
     * @return  파일업로드 요청이면 true
     */
    public static final boolean isMultipartContent(HttpServletRequest request) {
    	
    	String contentType = request.getContentType();
    	
        if (!"post".equals(request.getMethod().toLowerCase())) {
            return false;
        }
        
        
        
        
        if (contentType == null) {
            return false;
        }
        if (contentType.toLowerCase().startsWith("multipart/")) {
            return true;
        }
        return false;
    }
}