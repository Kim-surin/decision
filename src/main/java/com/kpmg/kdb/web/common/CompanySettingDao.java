package com.kpmg.kdb.web.common;

import org.apache.ibatis.annotations.Param;

/**
 * 법인별 운영 파라미터(COMPANY_SETTING) 조회 DAO.
 * 레거시 FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, P_SETTING_CODE) 함수 대체.
 *
 * 원본 함수 정의가 이관 대상 SQL 폴더에 포함되어 있지 않아 테이블/컬럼명은
 * COMPANY_SETTING(COMPANY_CODE, SETTING_CODE, SETTING_VALUE) 로 가정하였습니다.
 * 실제 스키마와 다를 경우 mapper/common/CompanySettingDaoMapper.xml 만 수정하면 됩니다.
 */
public interface CompanySettingDao {
	String selectSettingValue(@Param("companyCode") String companyCode, @Param("settingCode") String settingCode);
}
