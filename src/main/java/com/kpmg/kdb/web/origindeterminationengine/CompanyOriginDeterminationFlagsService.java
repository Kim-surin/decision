package com.kpmg.kdb.web.origindeterminationengine;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyOriginDeterminationFlags;

/** COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회 캐시 */
@Service
public class CompanyOriginDeterminationFlagsService extends GeneralService {

	@Cacheable(cacheNames = "companyOriginDeterminationFlags", key = "#companyCode")
	public CompanyOriginDeterminationFlags getDecisionFlags(String companyCode) {
		return sqlSession.getMapper(CompanyOriginDeterminationFlagsDao.class).selectCompanyDecisionFlags(companyCode);
	}
}
