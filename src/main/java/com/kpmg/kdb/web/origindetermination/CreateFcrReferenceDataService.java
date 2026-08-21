package com.kpmg.kdb.web.origindetermination;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.FtaMasterActive;

/**
 * FTA_MASTER(활성 FTA 목록) 조회 전용 캐시. {@link CreateFcrDao#selectActiveFtaMasters} 는 companyCode
 * 단위로만 조회되는 저카디널리티 마스터성 데이터라 대량 배치 전체에서 캐시 적중률이 높다.
 *
 * <p>Spring {@code @Cacheable} 은 프록시를 거쳐야 동작해 {@link CreateFcrService} 안에서
 * self-invocation 으로 두면 캐싱되지 않는다 — 별도 빈으로 분리했다.
 */
@Service
public class CreateFcrReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "activeFtaMasters", key = "#companyCode")
	public List<FtaMasterActive> selectActiveFtaMasters(String companyCode) {
		return sqlSession.getMapper(CreateFcrDao.class).selectActiveFtaMasters(companyCode);
	}
}
