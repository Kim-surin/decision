package com.kpmg.kdb.web.origindeterminationengine;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.CompanyDecisionFlags;

/** COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회 캐시(회사 단위 설정값이라 자주 바뀌지 않음). */
@Service
public class CompanyDecisionFlagsService extends GeneralService {

	@Cacheable(cacheNames = "companyDecisionFlags", key = "#companyCode")
	public CompanyDecisionFlags getDecisionFlags(String companyCode) {
		return sqlSession.getMapper(CompanyDecisionFlagsDao.class).selectCompanyDecisionFlags(companyCode);
	}
}
