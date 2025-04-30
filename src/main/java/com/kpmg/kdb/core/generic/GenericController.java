package com.kpmg.kdb.core.generic;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.Result;


/**
 *	예외처리 및 입력값 다시 출력.
 *	입력으로도 받고, 만약 예외가 발생해서 다시 그 값을 화면에 뿌려야할 경우 
 *	그 모델을 그대로 다시 출력할 일이 생기는데, 이때 사용하는게
 *	즉 Request의 값도 받고, View에 다시 값을 넘길 때 동시에 쓰이는게 @ModelAttribute 이다.
 *	So, 스프링으로 짜여진 코드들을 보면 user.name 같은 태그 라이브러리들이 보인다.
 *	
 *	@RequestParam과 달리 @ModelAttribute는 예외 처리가 포함된다.
 *	
 *	@ModelAttribute를 통해 폼의 정보를 전달받을 때는 
 *	Errors나 BindingResult 파라메터를 함께 사용하지 않으면
 *	스프링은 요청 파라메터의 타입이나 값에 문제가 없도록 에플리켜이션이 보장해 준다고 생각한다.
 *	단지 파라메터의 개수가 여러개라 커멘드 오브젝트의 형태로 전달받을 뿐이라고 보는 것이다.
 *	이때는 BindingException을 던진다.
 * 
 * @author D.Cat
 *
 */
public class GenericController {

	/** 로거 */
	protected Logger logger = LoggerFactory.getLogger(this.getClass());	

	@Autowired
	private MessageSource messageSource;

	
	public String logText = "#####################################################################################";
	
	public String twoEnter = "\n\n";
	/**
	 * 결과 객체를 반환
	 * 
	 * @param 	msg
	 * @param 	count
	 * @return	결과 객체
	 */
	public Result result(String msg, int count ) {
		Result result = new Result();
		StringBuffer msgID = new StringBuffer();
		if ( count == 0 ) {
			msgID.append("msg.error" +"." + msg );			
			result.setSuccess( false );
		}
		else {
			msgID.append("msg.success" +"." + msg );
			result.setSuccess( true );
		}	
		result.setMessage(messageSource.getMessage(msgID.toString(), new Object[]{}, Locale.getDefault()));
		return result;
	}
	
	public Result resultDel( int count ) {
		return result("del", count);
	}
	
	public Result resultEdit( int count ) {
		return result("edit", count);
	}
	
	public Result resultSave( int count ) {
		return result("save", count);
	}	
	
	private String getBaseUrl() {
		RequestMapping rm = this.getClass().getAnnotation(RequestMapping.class);
		String url = rm.value()[0];
		logger.debug("BaseUrl : " + url);
		return url;
	}

	protected String getFormUrl() {
		String url = getBaseUrl().substring(1) + getBaseUrl()+"Form";
		logger.debug("FormUrl : " + url);
		return url;  		
	}

	
	protected String getMessage(String messageId) {
		return this.getMessage(messageId, new Object[]{});
	}
	
	protected String getMessage(String messageId,  Object[] args) {
		return messageSource.getMessage(messageId, args, Locale.getDefault());
	}

	/**
	 * 성공여부, 메시지ID, 메시지ID 파라미터로 결과 객체를 생성하여 반환
	 * 
	 * @param isSuccess	성공여부
	 * @param messageId	메시지ID
	 * @param args		메시지ID 파라미터
	 * @return	결과 객체
	 */
	protected Result getResult(boolean isSuccess, String messageId,  Object[] args) {
		Result result = new Result();

		String mesg = this.getMessage(messageId, args);
		if ( StringUtils.isBlank(mesg) ) {
			mesg = isSuccess ? "정상적으로 처리하였습니다." : "처리중 오류가 발생하였습니다!"; //default message!
		}

		result.setSuccess(isSuccess);
		result.setMessage(mesg);
		return result;
	}

	/**
	 * HTTP세션 객체를 구하여 반환
	 * 
	 * @return	HTTP세션 객체
	 */
	protected HttpSession getSession() {
		HttpSession session;

		try {
			ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			session = sra.getRequest().getSession();
		}
		catch (IllegalStateException e) {
			logger.error("<오류> 세션 조회 : (원인) " + e.getMessage());
			session = null;
		}
		return session;
	}
	
	/**
	 * 세션에 저장된 사용자맵 정보를 반환한다. 없으면 null 반환
	 * 
	 * @return	세션에 저장된 사용자맵
	 */
	protected Map getSessionUserMap() {
		Map sessionUserMap;

		try {
			
			ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			HttpSession session = sra.getRequest().getSession();
			sessionUserMap = null==session ? null : (Map) session.getAttribute(SystemConstant.session.USER_SESSION_KEY);
		}
		catch (IllegalStateException e) {
			logger.error("<오류> 세션 정보 조회 : (원인) " + e.getMessage());
			sessionUserMap = null;
		}

		return sessionUserMap;
	}

	/**
	 * 세션에 저장된 사용자맵에서 지정된 key의 값을 문자열로 반환한다. 없으면 null 반환
	 * 
	 * @param 	key	세션사용자맵에서 지정된 key 값(문자열)
	 * @return	세션에 저장된 사용자맵에서 지정된 key의 값
	 */
	protected String getSessionAttr(String key) {
		Map sessionUserMap = this.getSessionUserMap();
		
		String val = null==sessionUserMap ? null : (String)sessionUserMap.get(key);
		//logger.debug("(String)sessionUserMap "+ (String)sessionUserMap.get("REGION_LVL"));
		logger.debug("<콘트롤러#세션조회> key : '{}', 세션값 = '{}'", key, val);

		return val;
	}



    /**
     * 
     * @return
     */
    protected List<Map> getSessionDataList(String ObjectKey) {
        List<Map> returnList;

        try {
            ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = sra.getRequest().getSession();
            returnList = null==session ? null : (List<Map>) session.getAttribute(ObjectKey);
        }
        catch (IllegalStateException e) {
            logger.error("<오류> 세션 정보 조회 : (원인) " + e.getMessage());
            returnList = null;
        }

        return returnList;
    }
    
    /**
     * Session에 담은 Map 객체를 꺼낸다.
     * @return
     */
    protected Map getSessionDataMap(String ObjectKey) {
        Map returnMap;

        try {
            ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = sra.getRequest().getSession();
            returnMap = null==session ? null : (Map) session.getAttribute(ObjectKey);
        }
        catch (IllegalStateException e) {
            logger.error("<오류> 세션 정보 조회 : (원인) " + e.getMessage());
            returnMap = null;
        }

        return returnMap;
    }

    /**
     * Session에 담은 Map 객체를 꺼낸다.
     * @return
     */
    protected Object getSessionObject(String ObjectKey) {
        Object returnMap;

        try {
            ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = sra.getRequest().getSession();
            returnMap = null==session ? null : (Object) session.getAttribute(ObjectKey);
        }
        catch (IllegalStateException e) {
            logger.error("<오류> 세션 정보 조회 : (원인) " + e.getMessage());
            returnMap = null;
        }

        return returnMap;
    }
    
    /**
     * 전달받은 Map Object에 세션정보 및 페이징 기본정보를 추가하여 리턴한다.
     * 
     * @author D.Cat
     * @param reqParam
     * @return
     */
    protected Map<String, Object> extendsMap(Map reqParam){
    	
    	ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = sra.getRequest().getSession();
        Map returnMap = null==session ? null : (Map) session.getAttribute(SystemConstant.session.USER_SESSION_KEY);
        
        if(reqParam.get("CREATE_BY") == null || "".equalsIgnoreCase(""+reqParam.get("CREATE_BY"))){
        	reqParam.put("CREATE_BY", returnMap.get("user_id"));
        }
        
        if(reqParam.get("UPDATE_BY") == null || "".equalsIgnoreCase(""+reqParam.get("UPDATE_BY"))){
        	reqParam.put("UPDATE_BY", returnMap.get("user_id"));
        }
        
        
        
        if(reqParam.get("DIVISION_CODE") == null || "".equalsIgnoreCase(""+reqParam.get("DIVISION_CODE"))){
        	reqParam.put("DIVISION_CODE", returnMap.get("division_code"));
        }
        
        if(reqParam.get("COMPANY_CODE") == null || "".equalsIgnoreCase(""+reqParam.get("COMPANY_CODE"))){
        	reqParam.put("COMPANY_CODE", returnMap.get("company_code"));
        }

        if(reqParam.get("DEFAULT_LANGUAGE") == null || "".equalsIgnoreCase(""+reqParam.get("DEFAULT_LANGUAGE"))){
        	reqParam.put("DEFAULT_LANGUAGE", returnMap.get("default_language"));	
        }
        
        if(reqParam.get("page") == null || "".equalsIgnoreCase(""+reqParam.get("page"))){
        	reqParam.put("page", "1");	
        }
        
        if(reqParam.get("USER_ID") == null || "".equalsIgnoreCase(""+reqParam.get("USER_ID"))){
        	reqParam.put("USER_ID", returnMap.get("user_id"));
        }
        
        
        if(reqParam.get("rows") == null || "".equalsIgnoreCase(""+reqParam.get("rows"))){
        	reqParam.put("rows", String.valueOf(SystemConstant.EXCEL_MAX_ROWS));	
        }
        
        
        return reqParam; 
    	
    }
    
    /**
     * Object 를 Json String으로 변환
     * @param o
     * @return
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    protected String obj2JsonString(Object o) throws JsonGenerationException, JsonMappingException, IOException{
    	ObjectMapper mapper = new ObjectMapper();
    	return mapper.writeValueAsString(o);
    }
    
    /**
     * Json String을 List로 변환 
     * @param o
     * @return
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    protected List<Object> json2List(String o) throws JsonGenerationException, JsonMappingException, IOException{
    	ObjectMapper mapper = new ObjectMapper();
    	return mapper.readValue(o, new TypeReference<List<Object>>(){});
    }
    
    
    /**
     * Json String을 String Array로 변환 
     * @param o
     * @return
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    protected String [] json2StringArray(String o) throws JsonGenerationException, JsonMappingException, IOException{
    	ObjectMapper mapper = new ObjectMapper();
    	return mapper.readValue(o, String[].class);
    	
    }
}
