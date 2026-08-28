package com.kpmg.kdb.web.origindeterminationengine;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyDecisionFlags;

/** COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회. {@link CompanyDecisionFlagsService} 가 사용한다. */
public interface CompanyDecisionFlagsDao {

	CompanyDecisionFlags selectCompanyDecisionFlags(@Param("companyCode") String companyCode);
}
