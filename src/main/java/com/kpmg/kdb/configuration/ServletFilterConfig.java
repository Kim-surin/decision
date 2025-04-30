package com.kpmg.kdb.configuration;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kpmg.kdb.core.filter.RequestBodyXSSFIleter;


@Configuration
public class ServletFilterConfig implements WebMvcConfigurer {
	
    @Bean
    public FilterRegistrationBean<RequestBodyXSSFIleter> firstFilter(){
        FilterRegistrationBean<RequestBodyXSSFIleter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new RequestBodyXSSFIleter());
        registrationBean.addUrlPatterns("/*");
        registrationBean.setOrder(1);
        registrationBean.setName("XssFilterBean");
        return registrationBean;
    }
}
