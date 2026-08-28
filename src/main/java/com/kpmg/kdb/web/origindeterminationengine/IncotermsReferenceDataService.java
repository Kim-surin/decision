package com.kpmg.kdb.web.origindeterminationengine;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.IncotermsRateRow;

/** FTA_INCOTERMS_INFO(인코텀즈 환산율) 조회 캐시. */
@Service
public class IncotermsReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "incotermsInfo", key = "#criteria.divisionCode + ':' + #criteria.exportFlag + ':' "
			+ "+ #criteria.nationCode + ':' + #criteria.stdYyyy")
	public IncotermsRateRow selectIncotermsInfo(IncotermsChangeRateCriteria criteria) {
		return sqlSession.getMapper(IncotermsRateDao.class).selectIncotermsInfo(criteria);
	}
}
