package com.kpmg.kdb.web.common;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * 레거시 FC01_GET_COMPANY_SETING_VALUE(companyCode, settingCode) 대체 서비스.
 *
 * 원산지판정 배치는 동일 법인의 설정값(예: 수불부 참조 개월수 'MA', 원산지비율 계산방식 'ME')을
 * 대량의 매출/BOM 라인을 순회하며 반복 조회한다. 값 자체는 배치 실행 중 거의 변하지 않으므로
 * 캐시를 적용해 동일 (companyCode, settingCode) 조합에 대한 반복 DB 호출을 제거한다.
 */
@Service
public class CompanySettingService extends GeneralService {

	@Cacheable(cacheNames = "companySetting", key = "#companyCode + ':' + #settingCode")
	public String getSettingValue(String companyCode, String settingCode) {
		return sqlSession.getMapper(CompanySettingDao.class).selectSettingValue(companyCode, settingCode);
	}

	/** NVL(FC01_GET_COMPANY_SETING_VALUE(...), defaultValue) 형태의 숫자 설정값 조회 */
	public int getIntSettingValue(String companyCode, String settingCode, int defaultValue) {
		String value = getSettingValue(companyCode, settingCode);
		if (value == null || value.isBlank()) {
			return defaultValue;
		}
		try {
			return Integer.parseInt(value.trim());
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	/** FC01_GET_COMPANY_SETING_VALUE(...) = expectedValue 형태의 조건 조회 */
	public boolean isSettingValue(String companyCode, String settingCode, String expectedValue) {
		String value = getSettingValue(companyCode, settingCode);
		return expectedValue.equalsIgnoreCase(value == null ? null : value.trim());
	}
}
