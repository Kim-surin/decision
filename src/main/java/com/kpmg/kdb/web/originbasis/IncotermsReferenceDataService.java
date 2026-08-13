package com.kpmg.kdb.web.originbasis;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.IncotermsRateRow;

/**
 * FTA_INCOTERMS_INFO(인코텀즈 환산율) 조회 전용 캐시. {@link IncotermsRateDao#selectIncotermsInfo} 는
 * (divisionCode, exportFlag, nationCode, stdYyyy) 로만 조회되는 저카디널리티 마스터성 데이터라(품목/
 * 거래처 등 고카디널리티 축과 무관 — companyCode 조차 조회 조건에 쓰이지 않는다,
 * {@link IncotermsChangeRateCriteria} 클래스 주석 참고) 대량 배치 전체에서 캐시 적중률이 높다.
 *
 * <p>Spring {@code @Cacheable} 은 프록시를 거쳐야 동작해 {@link IncotermsRateService} 안에서
 * self-invocation 으로 두면 캐싱되지 않는다 — 별도 빈으로 분리했다.
 */
@Service
public class IncotermsReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "incotermsInfo", key = "#criteria.divisionCode + ':' + #criteria.exportFlag + ':' "
			+ "+ #criteria.nationCode + ':' + #criteria.stdYyyy")
	public IncotermsRateRow selectIncotermsInfo(IncotermsChangeRateCriteria criteria) {
		return sqlSession.getMapper(IncotermsRateDao.class).selectIncotermsInfo(criteria);
	}
}
