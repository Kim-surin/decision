package com.kpmg.kdb.configuration;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.http.CacheControl;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AsyncConfigurer asyncConfigurer;

    // 캐시 정책 적용
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        CacheControl cacheControl = CacheControl.noCache();
        registry.addResourceHandler("**/*.*")
                .addResourceLocations("classpath:/static/")
                .setCacheControl(cacheControl);
    }

    // 컨트롤러가 Callable<T>를 반환하는 비동기 요청 처리(원산지판정 실행 API)에 AsyncConfig의 스레드풀을 재사용
    @Override
    public void configureAsyncSupport(AsyncSupportConfigurer configurer) {
        configurer.setTaskExecutor((AsyncTaskExecutor) asyncConfigurer.getAsyncExecutor());
        configurer.setDefaultTimeout(10 * 60 * 1000L);
    }
}

 