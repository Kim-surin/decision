package com.kpmg.kdb.util;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.kpmg.kdb.configuration.SessionConfig;
import com.kpmg.kdb.core.code.SystemConstant;

/**
 * HTTP요청/응답 객체의 처리에 대한 도구 클래스
 * 
 * @author Damned Cat
 *
 */
public final class HttpUtils {

	/** 구글 크롬 브라우저 */
	public static final int BROWSER_Chrome = 1;

	/** 파이어폭스 브라우저 */
	public static final int BROWSER_Firefox = 2;

	/** 마이크로소프트 인터넷 익스플로러 브라우저 */
	public static final int BROWSER_MSIE = 3;

	/** 오페라 브라우저 */
	public static final int BROWSER_Opera = 4;
		

	/**
	 * HTTP요청의 헤더 정보를 분석하여 요청한 브라우저 종류를 반환
	 * 
	 * @param 	request	HTTP요청객체
	 * @return	요청한 브라우저타입
	 */
	public static int getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");

		if (header.indexOf("Chrome") > -1) {
			return BROWSER_Chrome;
		}
		else if (header.indexOf("Firefox") > -1) {
			return BROWSER_Firefox;
		}
		else if (header.indexOf("Opera") > -1) {
			return BROWSER_Opera;
		}
		return BROWSER_MSIE;
	}

	/**
	 * 다국어 한글파일명 처리
	 * 
	 * @param 	request		HTTP요청객체
	 * @param 	filename	파일명
	 * @return
	 */
	public static String getEncodedFilename(HttpServletRequest request, String filename) {
		int browser = getBrowser(request);
		return getEncodedFilename(browser, filename);
	}
	public static String getEncodedFilename(int browser, String filename) {
		String encodedFilename = null;

		try {
			if (browser == BROWSER_MSIE) {
				encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			}
			else if (browser == BROWSER_Firefox) {
				encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			}
			else if (browser == BROWSER_Opera) {
				encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			}
			else if (browser == BROWSER_Chrome) {
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < filename.length(); i++) {
					char c = filename.charAt(i);
					if (c > '~') {
						sb.append(URLEncoder.encode("" + c, "UTF-8"));
					} else {
						sb.append(c);
					}
				}
				encodedFilename = sb.toString();
			}
			else {
				throw new RuntimeException("Not supported browser");
			}
		}
		catch (UnsupportedEncodingException e) {
			encodedFilename = filename;
		}
		return encodedFilename;
	}

	
	/**
	 * 파일 다운로드시 HTTP응답객체의 헤더 정보에 파일명 설정
	 * 
	 * @param request	HTTP요청객체
	 * @param response	HTTP응답객체
	 * @param filename	설정할 파일명
	 */
	public static void setResponseHeaderDownload(HttpServletRequest request, HttpServletResponse response, String filename) {
		String encFilename = HttpUtils.getEncodedFilename(request, filename);
		String fileInfo = "attachment; filename=" + encFilename + ""; 
		//String.format("attachment; filename=" + encFilename + "");
		response.setHeader("Content-Disposition", fileInfo);
	}

	/**
	 * 세션 타임아웃 초(second) 설정
	 * @param 	session		HTTP세션객체
	 * @return	설정이 성공하면 true
	 */
	public static boolean setSessionTimeout(HttpSession session) {
		if (null==session) { 
			return false;
		}
		session.setMaxInactiveInterval(SystemConstant.session.SESSION_TIMEOUT_SECOND); //세션 타임아웃 설정
		return true;
	}
	

	
	
	/**
	 * 세션에 '사용자', '권한그룹목록', '(권한)메뉴목록' 정보 저장. 세션 타임아웃 설정
	 * 
	 * @param 	session		HTTP세션객체
	 * @param	userMap		세션에 저장할 '사용자' 정보(맵)
	 * @param	authList	세션에 저장할 '권한그룹목록' 정보(리스트)
	 * @param	topMenuList	세션에 저장할 '(권한)메뉴목록' 정보(리스트)
	 * @see		com.ImporterService.web.com.home.HomeService#login(Map, HttpSession)
	 */
	public static void setSessionData(HttpSession session, Map userMap) {
		if (null==session || null==userMap) { return; }
		
		// 중복로그인 제어 
		SessionConfig.getSessionidCheck(SystemConstant.session.USER_SESSION_KEY, userMap.get("USER_ID")+"");
		session.setAttribute(SystemConstant.session.USER_SESSION_KEY, userMap);
		session.setMaxInactiveInterval(SystemConstant.session.SESSION_TIMEOUT_SECOND); //세션 타임아웃 설정 : 30
	}
	
	/**
	 * 세션에 저장된 '사용자' 정보를 반환
	 * @param 	request	HTTP요청객체
	 * @return	세션에 저장된 '사용자' 정보(맵)
	 */
	public static Map getSessionUser(HttpServletRequest request) {
		if (null==request || null==request.getSession()) {
			return null;
		}

		Map sessionUser = (Map)request.getSession().getAttribute(SystemConstant.session.USER_SESSION_KEY);
		
		return sessionUser;
	}

	/**
	 * 세션에 저장된 '권한그룹목록' 리스트 를 반환
	 * @param 	request	HTTP요청객체
	 * @return	세션에 저장된 '권한그룹목록' 리스트
	 */
	public static List<Map> getSessionAuthGroupList(HttpServletRequest request) {
		if (null==request || null==request.getSession()) {
			return null;
		}

		List<Map> sagList = (List<Map>)request.getSession().getAttribute(SystemConstant.session.AUTH_LIST_SESSION_KEY);
		
		return sagList;
	}



}
