package com.kpmg.kdb.core.extendz;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.StringTokenizer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import com.kpmg.kdb.util.StringUtil;

public class IscReloadableResourceBundleMessageSource extends ReloadableResourceBundleMessageSource {
    private static Log logger = LogFactory.getLog(IscReloadableResourceBundleMessageSource.class);

    public IscReloadableResourceBundleMessageSource() { }

    protected String resolveCodeWithoutArguments(String code, Locale locale) {
        StringBuffer parseMsg = new StringBuffer();
        MessageFormat format = null;
        
        if (!StringUtil.isNull(code)) {
            StringTokenizer splist = new StringTokenizer(this.getLanguageMessage(code, locale), ",");
            
            int cnt = 0;
            
            while(splist.hasMoreElements()) {
                String str = splist.nextToken();
                
                if(Locale.ENGLISH == locale || locale.getCountry() == "EN") {
                	// 영문인 경우에는 무조건 공백을 추가한다.
                    if(cnt != 0) {
                        parseMsg.append(" ");
                    }
                } else {
                	// 공백이 있을 경우 공백을 추가한다.
                    if(str.startsWith(" ")) parseMsg.append(" ");
                    if(str.endsWith(" ")) parseMsg.append(" ");
                }
                
                str = str.trim();
                format = this.resolveCode(str, locale);
                
                if (format == null) {
                    parseMsg.append(str);
                } else {
                    parseMsg.append(super.resolveCodeWithoutArguments(str, locale));
                }
                
                cnt++;
            }
        }
        
        return parseMsg.toString();
    }
    
    protected Object[] resolveArguments(Object[] args, Locale locale) {
    	MessageFormat format = null;
    	
        for(int i = 0; i < args.length; i++) {
        	String code = StringUtil.null2String(args[i]);
        	StringBuffer parseMsg = new StringBuffer();
        	
        	if(!code.isEmpty()) {
        		StringTokenizer splist = new StringTokenizer(this.getLanguageMessage(code, locale), ",");
        		
        		int cnt = 0;
        		
        		while(splist.hasMoreElements()) {
        			String str = splist.nextToken();
        			
        			if(Locale.ENGLISH == locale || locale.getCountry() == "EN") {
                    	// 영문인 경우에는 무조건 공백을 추가한다.
                        if(cnt != 0) {
                            parseMsg.append(" ");
                        }
                    } else {
                    	// 공백이 있을 경우 공백을 추가한다.
                        if(str.startsWith(" ")) parseMsg.append(" ");
                        if(str.endsWith(" ")) parseMsg.append(" ");
                    }
        			
        			str = str.trim();
                    format = this.resolveCode(str, locale);
                    
                    if (format == null) {
                        parseMsg.append(str);
                    } else {
                        parseMsg.append(super.resolveCodeWithoutArguments(str, locale));
                    }
                    
                    cnt++;
        		}
        		args[i] = parseMsg.toString();
        		

        	}
        }
        
        return args;
    }
    
    
    private String getLanguageMessage(String messageCode, Locale locale) {
        String message = null;
        String[] language = {"^EN", "^JP", "^KR"};
        String delimiter = null;
        int lastIndex = 0;
        int langIndex = 0;
        
        if(Locale.ENGLISH == locale || locale.getCountry() == "EN") {
        	delimiter = language[0];
        } else if(Locale.JAPAN == locale || Locale.JAPANESE == locale || locale.getCountry() == "JP") {
        	delimiter = language[1];
        } else if(Locale.KOREA == locale || Locale.KOREAN == locale || locale.getCountry() == "KR") {
        	delimiter = language[2];
        }
        
        if(delimiter == null) {
        	return messageCode;
        }
        
        int startIndex = messageCode.indexOf(delimiter);
        
        if(startIndex < 0) {
        	startIndex = 0;
        } else {
        	startIndex = startIndex + 4;
        }

    	// 마지막 인덱스 번호 구하기
    	for(int i = 0; i < language.length; i++) {
    		langIndex = messageCode.indexOf(language[i]);
    		
        	if(startIndex < langIndex && (lastIndex == 0 || lastIndex >= langIndex)) {
        		lastIndex = langIndex;
        	}
        }
    	
    	if(lastIndex == 0) {
    		message = messageCode.substring(startIndex);
    	} else {
    		message = messageCode.substring(startIndex, lastIndex - 1);
    	}
        
    	if(lastIndex > 0) {
    		if(logger.isDebugEnabled()) logger.debug("Origin message = " + messageCode + ", Code = " + message + "[start = " + startIndex + ", last = " + (lastIndex-1) + "]");
    	}
    	
        return message;
    }
}
