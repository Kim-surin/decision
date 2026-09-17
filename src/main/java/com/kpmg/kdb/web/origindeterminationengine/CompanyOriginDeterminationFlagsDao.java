package com.kpmg.kdb.web.origindeterminationengine;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyOriginDeterminationFlags;

/** COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회. {@link CompanyOriginDeterminationFlagsService} 가 사용한다. */
public interface CompanyOriginDeterminationFlagsDao {

	CompanyOriginDeterminationFlags selectCompanyDecisionFlags(@Param("companyCode") String companyCode);
}
