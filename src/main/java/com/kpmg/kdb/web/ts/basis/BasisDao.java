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
	 * 회사관리 - 회사  1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	public Map retrieveCompanyFormData(Map param);
	
	/**
	 * 회사관리 - 플렌트 1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	public Map retrieveDivisionFormData(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  회사
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromCompany(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  플랜트
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromDivision(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  협정
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromFTA(Map param);
}
