package com.kpmg.kdb.core.extendz;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;

import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.util.SystemHelper;



public class MessageResourceExtends {
	private static final Log log = LogFactory.getLog(MessageResourceExtends.class);
	
	
	public ApplicationContext applicationContext;

	
	private MessageResourceMap resource;

	 
	private static MessageResourceExtends message;

	public MessageResourceExtends() { }

	 
	public static void initMessageInstance(ApplicationContext applicationContext) {
		initMessageInstance(applicationContext, "message");
	}

	 
	public static void clearMessageResource() {
		if (message != null) {
			message.getResource().clear();
		}
	}

	 
	private static void initMessageInstance(ApplicationContext applicationContext, String resouceName) {
		if (message == null) {
			message = new MessageResourceExtends();
		}
		message.setApplicationContext(applicationContext);

		if (message.getResource() == null) {
			message.setResourceMap(new MessageResourceMap(resouceName));
		}
	}

	 
	public static MessageResourceExtends getMessageInstance() {
		if(message == null) {
			initMessageInstance(ApplicationContextAwareExtends.getApplicationContext());
		}
		
		return message;
	}

	 
	@SuppressWarnings("unused")
	private MessageResourceMap getResourceInstance() {
		// initMessageInstance();
		return getResource();
	}

	 
	public String getMessage(String messageCode) {
		return this.getMessage(messageCode, null, null);
	}

	 
	public String getMessage(String messageCode, Object[] massageArgs) {
		return this.getMessage(messageCode, massageArgs, null);

	}

	 
	public String getMessage(String messageCode, Object[] massageArgs, Object locale) {
		String message = "";
		
		try {
			Locale rLocale = null;
			if(locale instanceof String) {
				rLocale = SystemHelper.getLocale(locale.toString());
			} else if(locale instanceof Locale) {
				rLocale = (Locale) locale;
			} else {
				rLocale = SystemHelper.getLocale(null);
			}
			
			Map<String, String> map = new HashMap<String, String>();

			map.put("messageName", messageCode);

			MessageSource messageSource = (MessageSource) applicationContext.getBean("messageSource");

			message = messageSource.getMessage(messageCode, massageArgs, null, rLocale);
			if (message == null) {
				message = "message code is not defined (" + messageCode + ")";
			}
		} catch (Exception e) {
			message = "Message Resouce Exception " + e.toString();
		}
		
		return message;
	}
	
	 
	public String getLocaleMessage(LinkedHashMap<String, Object> list,
			String messageCode, Object[] massageArgs, String locale) {
		String messageTxt;

		// 한글....
		if ("KOR".equals(locale)) {
			messageTxt = StringUtil.null2String(list.get("MESSAGE_KOR"));
		} else if ("ENG".equals(locale)) {
			messageTxt = StringUtil.null2String(list.get("MESSAGE_ENG"));
		} else {
			messageTxt = StringUtil.null2String(list.get("MESSAGE_LOC"));
		}
		
		if(log.isDebugEnabled()) {
			log.debug(locale + "'s message = " + messageTxt);
		}
		return (massageArgs != null) ? new MessageFormat(messageTxt).format(massageArgs) : messageTxt;
	}

	public void setResourceMap(MessageResourceMap resource) {
		this.resource = resource;
	}

	 
	public MessageResourceMap getResource() {
		return resource;
	}

	 
	public void setResource(MessageResourceMap resource) {
		this.resource = resource;
	}

	 
	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	 
	public void setApplicationContext(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}

}
