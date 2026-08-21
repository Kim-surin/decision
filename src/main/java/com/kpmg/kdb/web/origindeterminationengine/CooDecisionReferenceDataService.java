package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.BufferRates;

/**
 * GET_BUFFER / GET_RCEP_NATION / GET_RCEP_RVC_NATION 이 참조하는 저카디널리티 기준정보
 * (법인 버퍼 산정기준, 회사/사업부/FTA 버퍼율, FTA 적용대상국) 캐시 전용 서비스.
 *
 * 회사코드·사업부코드·FTA코드는 종류가 적고 값이 거의 바뀌지 않는 마스터성 데이터라
 * 대량 배치 처리 중 반복 조회를 캐시로 제거할 가치가 크다(Layer3의 품목/기준일 단위
 * 고카디널리티 조회와는 달리 캐시 적중률이 높고 힙 사용량도 작다).
 *
 * Spring @Cacheable 은 프록시 기반이라 같은 클래스 내부에서 self-invocation 으로 호출하면
 * 캐시가 적용되지 않는다. 그래서 {@link OriginDeterminationSupportService} 와 별도의 빈으로 분리해
 * 반드시 프록시를 거쳐 호출되도록 했다.
 */
@Service
public class CooDecisionReferenceDataService extends GeneralService {

	@Cacheable(cacheNames = "bufferOptionValue", key = "#companyCode")
	public String getBufferOptionValue(String companyCode) {
		return sqlSession.getMapper(OriginDeterminationSupportDao.class).selectBufferOptionValue(companyCode);
	}

	@Cacheable(cacheNames = "companyBuffer", key = "#companyCode")
	public BufferRates getCompanyBuffer(String companyCode) {
		return sqlSession.getMapper(OriginDeterminationSupportDao.class).selectCompanyBuffer(companyCode);
	}

	@Cacheable(cacheNames = "divisionBuffer", key = "#companyCode + ':' + #divisionCode")
	public BufferRates getDivisionBuffer(String companyCode, String divisionCode) {
		return sqlSession.getMapper(OriginDeterminationSupportDao.class).selectDivisionBuffer(companyCode, divisionCode);
	}

	@Cacheable(cacheNames = "ftaBuffer", key = "#companyCode + ':' + #ftaCode")
	public BufferRates getFtaBuffer(String companyCode, String ftaCode) {
		return sqlSession.getMapper(OriginDeterminationSupportDao.class).selectFtaBuffer(companyCode, ftaCode);
	}

	@Cacheable(cacheNames = "ftaApplyNations", key = "#ftaCode")
	public List<String> getFtaApplyNations(String ftaCode) {
		return sqlSession.getMapper(OriginDeterminationSupportDao.class).selectFtaApplyNations(ftaCode);
	}
}
