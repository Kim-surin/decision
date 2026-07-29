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
		// 원산지판정 기초자료(Layer 3) 조회 결과 캐시.
		// 대량 배치 처리 중 동일 (회사/사업장/품목/기준일) 조합이 반복 조회되는 것을 막기 위해 사용한다.
		CaffeineCacheManager cacheManager = new CaffeineCacheManager("division", "companySetting", "hsCode",
				"incotermsRate", "itemPrice", "itemPriceNote", "itemOriginRate");
		return cacheManager;
	}
}
