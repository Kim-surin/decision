package com.kpmg.kdb.configuration;


import java.util.concurrent.Executor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * 
 * CorePoolSize : 최초 동작 시에 corePoolSize만큼 스레드가 생성하여 사용된다.(Default 1)
 * MaxPoolSize : Queue 사이즈 이상의 요청이 들어오게 될 경우, 스레드의 개수를 MaxPoolSize만큼 늘린다.(Default : Integer.MAX_VAULE)
 * QueueCapacity : CorePoolSize 이상의 요청이 들어올 경우, LinkedBlockingQueue에서 대기하게 되는데 그 Queue의 사이즈를 지정해주는 것이다.(Default : Integer.MAX_VAULE)
 * SetThreadNamePrefix : 스레드명 설정
 * 
 */
@Configuration
@EnableAsync
public class AsyncConfig  implements AsyncConfigurer{

    private int CORE_POOL_SIZE = 3;
    private int MAX_POOL_SIZE = 10;
    private int QUEUE_CAPACITY = 100_000;

    @Override
    public Executor getAsyncExecutor(){

        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();

        taskExecutor.setCorePoolSize(CORE_POOL_SIZE);
        taskExecutor.setMaxPoolSize(MAX_POOL_SIZE);
        taskExecutor.setQueueCapacity(QUEUE_CAPACITY);
        taskExecutor.setThreadNamePrefix("Executor-");
        
        taskExecutor.setRejectedExecutionHandler((r, exec) -> {
        	throw new IllegalArgumentException("더 이상 요청을 수행할 수 없습니다. ");
        });
        
        taskExecutor.initialize();

        return taskExecutor;
    }
}