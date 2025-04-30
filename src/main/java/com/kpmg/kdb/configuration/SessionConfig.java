package com.kpmg.kdb.configuration;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.util.StringUtil;

@WebListener
public class SessionConfig implements HttpSessionListener{
	
    private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();

    //중복로그인 지우기
    public synchronized static String getSessionidCheck(String type,String compareId){
        String result = "";
        
        for( String key : sessions.keySet() ){
        	
        	HttpSession value = sessions.get(key);
        	Map userMap = (Map)value.getAttribute(type);
        	if(userMap != null) {
        		String userId = StringUtil.null2String(userMap.get("USER_ID"));
        		if(value != null &&  value.getAttribute(type) != null && userId.equals(compareId) ){
                    //System.out.println(value.getAttribute(type).toString());
                    result =  key.toString();
                }	
        	}
            
        }
        removeSessionForDoubleLogin(result);
        return result;
    }
    
    private static void removeSessionForDoubleLogin(String userId){    	
        System.out.println("remove userId : " + userId);
        if(userId != null && userId.length() > 0){
            sessions.get(userId).invalidate();
            sessions.remove(userId);    		
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent hse) {
        System.out.println(hse);
        sessions.put(hse.getSession().getId(), hse.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent hse) {
        if(sessions.get(hse.getSession().getId()) != null){
            sessions.get(hse.getSession().getId()).invalidate();
            sessions.remove(hse.getSession().getId());	
        }
    }
}    