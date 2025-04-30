package com.kpmg.kdb.configuration;


import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // 캐시 정책 적용
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        CacheControl cacheControl = CacheControl.noCache();
        registry.addResourceHandler("**/*.*")
                .addResourceLocations("classpath:/static/")
                .setCacheControl(cacheControl);
    }
}

 