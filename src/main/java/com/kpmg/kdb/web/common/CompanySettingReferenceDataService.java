package com.kpmg.kdb.web.common;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * COMPANY_OPTION(법인별 운영 파라미터) 조회 전용 캐시. (companyCode,settingCode) 조합으로만 조회되는
 * 저카디널리티 마스터성 데이터라 배치 전체에서 캐시 적중률이 높다.
 *
 * <p>Spring {@code @Cacheable} 은 프록시를 거쳐야 동작한다. {@link CompanySettingService#isSettingValue}/
 * {@link CompanySettingService#getIntSettingValue} 가 같은 클래스 안에서 {@code getSettingValue}를
 * self-invocation 으로 호출하고 있었고, 실제 호출부(ItemOriginRateService/ItemPriceService)는 전부 이
 * 두 메서드를 통해서만 값을 조회해 {@code @Cacheable} 이 사실상 한 번도 적용되지 못했다(옵션값이 null인
 * 조합만 문제인 게 아니라 null/비null 관계없이 매번 DB 조회됨) — 별도 빈으로 분리해 해결한다.
 */
@Service
public class CompanySettingReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "companySetting", key = "#companyCode + ':' + #settingCode")
	public String getSettingValue(String companyCode, String settingCode) {
		return sqlSession.getMapper(CompanySettingDao.class).selectSettingValue(companyCode, settingCode);
	}
}
