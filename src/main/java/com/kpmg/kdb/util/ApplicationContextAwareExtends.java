package com.kpmg.kdb.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

//@Service("applicationContextAwareExtends")
@Component
public class ApplicationContextAwareExtends   implements ApplicationContextAware  {
    private static final Log LOG = LogFactory.getLog(ApplicationContextAwareExtends.class);
    private static ApplicationContext ctx;

    public ApplicationContextAwareExtends() {
        LOG.info("init SpringApplicationContext");
    }

    @Override
    public void setApplicationContext(ApplicationContext context) throws BeansException {
        ctx = context;
    }
    
    public static ApplicationContext getApplicationContext() {
		return ctx;
	}

    /**
     * 스프링 빈 조회
     * 
     * @param beanName 스프링빈 이름
     * @return
     */
    public static Object getBean(String beanName) {
        return ctx.getBean(beanName);
    }

    /**
     * 스프링 빈 조회
     * 
     * @param beanName 스프링빈 이름
     * @param requiredType 클래스 타입
     * @return
     */
    public static <T> T getBean(String beanName, Class<T> requiredType) {
        return ctx.getBean(beanName, requiredType);
    }
}
