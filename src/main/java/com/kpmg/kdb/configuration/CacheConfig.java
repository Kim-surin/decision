package com.kpmg.kdb.configuration;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableCaching
public class CacheConfig {
	@Bean
	public CacheManager cacheManager() {
		CaffeineCacheManager cacheManager = new CaffeineCacheManager("division", "companySetting",
				"bufferOptionValue", "companyBuffer", "divisionBuffer", "ftaBuffer", "ftaApplyNations",
				"companyDecisionFlags", "activeFtaMasters", "incotermsInfo");
		return cacheManager;
	}
}
