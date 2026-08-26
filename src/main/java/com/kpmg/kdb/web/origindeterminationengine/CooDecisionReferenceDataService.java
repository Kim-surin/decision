package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.BufferRates;

/** 버퍼율(법인/회사/사업부/FTA)/FTA 적용대상국 등 저카디널리티 기준정보 캐시. */
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
