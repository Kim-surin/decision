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
		// companySetting, bufferOptionValue, companyBuffer, divisionBuffer, ftaBuffer, ftaApplyNations:
		// 회사코드/사업부코드/FTA코드 단위의 저카디널리티 마스터성 데이터라 배치 전체에서
		// 반복 조회되고 캐시 적중률이 높다.
		// HS코드/인코텀즈환산율/재료비/원산지비율 캐시는 (회사/사업장/품목/기준일) 조합이 대량 배치에서
		// 사실상 매번 달라져 캐시 적중률이 낮고 힙 메모리만 계속 쌓이는 문제가 있어 두지 않는다.
		CaffeineCacheManager cacheManager = new CaffeineCacheManager("division", "companySetting",
				"bufferOptionValue", "companyBuffer", "divisionBuffer", "ftaBuffer", "ftaApplyNations");
		return cacheManager;
	}
}
