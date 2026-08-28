package com.kpmg.kdb.web.common;

import org.apache.ibatis.annotations.Param;

/**
 * 법인별 운영 파라미터(COMPANY_OPTION) 조회 DAO.
 * 레거시 FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, P_SETTING_CODE) 함수 대체.
 */
public interface CompanySettingDao {
	String selectSettingValue(@Param("companyCode") String companyCode, @Param("settingCode") String settingCode);
}
