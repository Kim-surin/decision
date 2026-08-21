package com.kpmg.kdb.web.origindeterminationexecution;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationexecution.MonthlyDecisionDao;
import com.kpmg.kdb.web.origindeterminationexecution.dto.CompanyDecisionFlags;

/**
 * COMPANY.MATERIAL_USE_YN / CTC_DECISION_ONLY_YN 조회 캐시. {@link OriginDecisionPipelineFactory}
 * 가 판정 파이프라인을 만들 때마다(월/개별/수출 판정 호출 각각) 조회하지만 회사 단위 설정값이라 배치
 * 실행 중 거의 바뀌지 않는다 — {@code CompanySettingService} 와 같은 이유로 캐시를 적용한다.
 *
 * <p>{@link OriginDecisionPipelineFactory} 안에 이 메서드를 직접 두지 않고 별도 빈으로 분리한 이유:
 * {@code @Cacheable} 은 스프링 프록시를 거쳐야 동작하는데, 같은 클래스 안에서 this로 호출(self-invocation)
 * 하면 프록시를 우회해 캐시가 걸리지 않는다.
 */
@Service
public class CompanyDecisionFlagsService extends GeneralService {

	@Cacheable(cacheNames = "companyDecisionFlags", key = "#companyCode")
	public CompanyDecisionFlags getDecisionFlags(String companyCode) {
		return sqlSession.getMapper(MonthlyDecisionDao.class).selectCompanyDecisionFlags(companyCode);
	}
}
