package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.FtaMasterActive;

/** FTA_MASTER(활성 FTA 목록) 조회 캐시(companyCode 단위 마스터성 데이터). */
@Service
public class CreateFcrReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "activeFtaMasters", key = "#companyCode")
	public List<FtaMasterActive> selectActiveFtaMasters(String companyCode) {
		return sqlSession.getMapper(CreateFcrDao.class).selectActiveFtaMasters(companyCode);
	}
}
