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
		// companySetting: 법인별 설정값(FC01_GET_COMPANY_SETING_VALUE 대체)은 값의 종류가 적고
		// 배치 전체에서 반복 조회되므로 캐시를 유지한다.
		// HS코드/인코텀즈환산율/재료비/원산지비율 캐시는 (회사/사업장/품목/기준일) 조합이 대량 배치에서
		// 사실상 매번 달라져 캐시 적중률이 낮고 힙 메모리만 계속 쌓이는 문제가 있어 제거했다.
		CaffeineCacheManager cacheManager = new CaffeineCacheManager("division", "companySetting");
		return cacheManager;
	}
}
