package com.kpmg.kdb.web.ts.basis;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface BasisDao {
	
	/**
     * @description : 
     * @since : 2025.04
     * @param param
     * @return
     */
    
	public Map start_TestSql(Map param);
	
	
	/**
	 * 회사관리 - 왼쪽 트리 목록 조회
	 * @param param
	 * @return
	 */
	public List retrieveCompanyDivisionList(Map param);
	
	
	/**
	 * 회사관리 - 회사 정보
	 * @param param
	 * @return
	 */
	public Map retrieveCompanyFormData(Map param);
	
	/**
	 * 회사관리 - 플렌트 정보
	 * @param param
	 * @return
	 */
	public Map retrieveDivisionFormData(Map param);
}
