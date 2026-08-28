package com.kpmg.kdb.web.common;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * COMPANY_OPTION(법인별 운영 파라미터) 조회 전용 캐시. 
 */
@Service
public class CompanySettingReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "companySetting", key = "#companyCode + ':' + #settingCode")
	public String getSettingValue(String companyCode, String settingCode) {
		return sqlSession.getMapper(CompanySettingDao.class).selectSettingValue(companyCode, settingCode);
	}
}
