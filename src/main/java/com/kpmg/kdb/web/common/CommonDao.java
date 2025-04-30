package com.kpmg.kdb.web.common;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author D.Cat
 */
public interface CommonDao {
	
    
    /**
     * 공통코드 리스트 조회
     * @param param
     * @return
     */
    public List<Map> retrieveComCdList(Map param);
    
    /**
     * 공통코드 리스트 조회
     * @param param
     * @return
     */
    public List<Map> retrievePlantCombo(Map param);
}