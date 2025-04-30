package com.kpmg.kdb.web.batch;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author D.Cat
 */
public interface InterfaceDao {
	
	
	
	/**
     * 인터페이스 대상 법인 목록 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveBatchCompanyList(Map param);
    
    
    /**
     * 인터페이스 대상 데이터 확인 
     * @param param
     * @return
     */
    public int retrieveCount_TargetTable(Map param);
    
    
    /**
     * 인터페이스 완료된 데이터 update  처리 
     * @param param
     * @return
     */
    public int updateIfDone_InterfaceData(Map param);
  
    
    /**
     * 수불부 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Material_inv_val(Map param);		
    
    
    /**
     * 매출 마스터 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Sales_Mst(Map param);	
    
    /**
     * 매출 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Sales_Dtl(Map param);	
    
    /**
     * 고객사 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Customer(Map param);	
    
    
    /**
     * Bom 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Result_Bom_Ap(Map param);	
    
    
    /**
     * 아이템 마스터 INF Insert
     * @param param
     * @return
     */
    public int insert_ItemMstInf(Map param);	
    
    
    /**
     * 아이템 마스터 Merge
     * @param param
     * @return
     */
    public int merge_ItemMst(Map param);
    
    /**
     * 인터페이스 테이블 초기화
     * @param param
     * @return
     */
    public int delete_InfTable(Map param);
    
    
    /**
     * Vendor 마스터 INF Insert
     * @param param
     * @return
     */
    public int insert_VendorInf(Map param);	
    
    
    /**
     * Vendor 마스터 Merge
     * @param param
     * @return
     */
    public int merge_Vendor(Map param);
    
    
    /**
     * 구매원장 INF Insert
     * @param param
     * @return
     */
    public int insert_PoledgerInf(Map param);	
    
    
    /**
     * 구매원장 Merge
     * @param param
     * @return
     */
    public int merge_Poledger(Map param);
    
    
    /**
     * 매각원장 INF Insert
     * @param param
     * @return
     */
    public int insert_SalesledgerInf(Map param);	
    
    
    /**
     * 매각원장 Merge
     * @param param
     * @return
     */
    public int merge_Salesledger(Map param);
 
}