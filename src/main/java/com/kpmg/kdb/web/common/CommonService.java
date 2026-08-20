package com.kpmg.kdb.web.common;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.HttpUtils;

/**
 * 홈 경로 관련 처리 서비스 클래스
 * 
 * @author Damned Cat
 * @since 2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class CommonService extends GeneralService {

	static Logger logger = LoggerFactory.getLogger(CommonService.class);

	/**
	 * 공통코드 리스트 조회
	 * 
	 * @param param
	 * @return
	 */
	public List<Map> retrieveComCdList(Map param) {
		return sqlSession.getMapper(CommonDao.class).retrieveComCdList(param);
	}

	/**
	 * 플렌트 목록 조회
	 * 
	 * @param param
	 * @return
	 */
	public List<Map> retrievePlantCombo(Map param) {
		return sqlSession.getMapper(CommonDao.class).retrievePlantCombo(param);
	}
	/**
	 * 플렌트 목록 조회
	 * 
	 * @param param
	 * @return
	 */
	public List<Map> retrieveSignatureCombo(Map param) {
		return sqlSession.getMapper(CommonDao.class).retrieveSignatureCombo(param);
	}

	/**
	 * 공통코드 리스트 조회
	 * 
	 * @param param
	 * @return
	 */
	@Cacheable(value = "division", key = "{#companyCode, #defaultLanguage, #category}")
	public List<Map<String, String>> retrieveCodeCombo(String companyCode, String defaultLanguage, String category) {
		return sqlSession.getMapper(CommonDao.class).retrieveCodeCombo(companyCode, defaultLanguage, category);
	}
}
