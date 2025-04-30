package com.kpmg.kdb.web.cusven;

import java.util.List;
import java.util.Map;


/**
 * 거래처 관리 관련 DAO Class
 * 
 * @author D.Cat
 */
public interface CustomerVendorDao {
	
	/** Sample 인터페이스 스케줄 List
	public List<Map<String, Object>> retrieveInterfaceSch(Map<String, Object> param);
	 */

	/**
     * 양수자통보 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieveCV004Grid(Map param);
	
	
	/**
	 * 양수자통보 조회 마스터 정보 조회 - 해더
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map retrieveCV004GridDetail(Map<String, Object> param);
	
	/**
	 * 양수자통보 조회 마스터 정보 조회 - 리스트
	 * @param model
	 * @param session
	 * @return
	 */
	public List<Map> retrieveCV004GridDetailList(Map param);
	
	
	/**
	 * 고객사 근거서류 목록 조회 
	 * @param param
	 * @return
	 */
	public List<Map> retrieve_CV001List(Map param);
	
	
	/**
	 * 고객사 근거서류 상세 Header 조회 
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_CV00101_header(Map<String, Object> param);
	
	
	/**
     * 고객사 근거서류 상세 List 조회 
     * @param param
     * @return
     */
    public List<Map> retrieve_CV00101_List(Map param);
    
    
    /**
     * BOM 제출 목록 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_CV006List(Map param);
    
    
    /**
     * BOM 제출 목록 조회(기납증)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_CV007List(Map param);
}