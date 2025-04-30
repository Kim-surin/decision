package com.kpmg.kdb.web.master;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author Damned Cat
 */
public interface MasterDao {

    /**
     * 회사정보 조회
     * @param param
     * @return
     */
	public Map retrieveCompanyInfo(Map<String, Object> param);

    /**
     * 회사정보 저장
     * @param param
     * @return
     */
	public int updateCompanyInfo(Map<String, Object> param);
    
    
    /**
     * 고객사 리스트 조회
     * @param param
     * @return
     */
	public List<Map<String, Object>> retrieveCustomerList(Map<String, Object> param);
	
    /**
     * 고객사 상세
     * @param param
     * @return
     */
	public Map retrieveCustomerDetail(Map<String, Object> param);

    /**
     * 고객사 저장
     * @param param
     * @return
     */
	public int updateCustomerDetail(Map<String, Object> param);
    
    /**
     * 협력사 리스트 조회
     * @param param
     * @return
     */
	public List<Map<String, Object>> retrieveVendorList(Map<String, Object> param);
	
    /**
     * 협력사 상세
     * @param param
     * @return
     */
	public Map retrieveVendorDetail(Map<String, Object> param);

    /**
     * 협력사 저장
     * @param param
     * @return
     */
	public int updateVendorDetail(Map<String, Object> param);
    
    /**
     * 환급제한규정 리스트 조회
     * @param param
     * @return
     */
	public List<Map<String, Object>> retrieveDrwbakLmttList(Map<String, Object> param);
	
    /**
     * 환급제한규정상세
     * @param param
     * @return
     */
	public Map retrieveDrwbakLmttDetail(Map<String, Object> param);

    /**
     * 환급제한규정 상세 저장
     * @param param
     * @return
     */
	public int mergeDrwbakLmttDetail(Map<String, Object> param);

    /**
     * 환급제한규정 상세 삭제
     * @param param
     * @return
     */
	public int deleteDrwbakLmttDetail(Map<String, Object> param);
	

    /**
     * 자재마스터 리스트 조회
     * @param param
     * @return
     */
	public  List<Map<String, Object>> retrieveItemList(Map<String, Object> param);
}