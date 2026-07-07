package com.kpmg.kdb.web.division;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.common.CommonDao;


@Service
public class DivisionService extends GeneralService {
	@Cacheable(value = "division", key = "{#companyCode, #defaultLanguage}")
	public List<Map<String, String>> retrieveDevision(String companyCode, String defaultLanguage) throws Exception {
		return sqlSession.getMapper(DivisionDao.class).retrieveDevision(companyCode, defaultLanguage);
	}
}
