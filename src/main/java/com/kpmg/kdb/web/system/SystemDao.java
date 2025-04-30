package com.kpmg.kdb.web.system;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author D.Cat
 */
public interface SystemDao {
	
	/** 인터페이스 스케줄 List */
	public List<Map<String, Object>> retrieveInterfaceSch(Map<String, Object> param);
	
	/** 인터페이스 스케줄 Mapping List */
	public List<Map<String, Object>> retrieveInterfaceSchMapping(Map<String, Object> param);
	
	/** 인터페이스 아이템 마스터 조회 */
	public List<Map<String, Object>> retrieveInterfaceItemMaster(Map<String, Object> param);
	
	/** 인터페이스 아이템 상세 조회 */
	public List<Map<String, Object>> retrieveInterfaceItemDetail(Map<String, Object> param);
	
	/** 인터페이스 이력 마스터 조회 */
	public List<Map<String, Object>> retrieveInterfaceHistoryMaster(Map<String, Object> param);
	
	/** 인터페이스 스케줄 List */
	public List<Map<String, Object>> retrieveInterfaceHistoryLayout(Map<String, Object> param);
	
	/** 인터페이스 이력 상세 조회 */
	public List<Map<String, Object>> retrieveInterfaceHistoryDetail(Map<String, Object> param);
	
	/** 인터페이스 실행 상태 조회*/
	public List<Map<String, Object>> retrieveDataTransSchdule(Map param);
	
	
	
	/** D.Cat 추가 2019.0218  */
	public List<Map<String, Object>> retrieveComAuthorGroupList(Map param);

	/** 권한코드 중복체크*/
    public int retrieveDupAuthorGroupCode(Map param);

    /** 권한코드 저장*/
    public int updateComAuthorGroup(Map param);

    public List<Map<String, Object>> retrieveExistsMenuList(Map param);
    
    public int deleteAuthorMenuList(Map param);
    
    public int changeAuthorMenuList(Map param);
    
    public List<Map<String, Object>> retrieveSystemMenuList(Map param);

	/** 메뉴코드 중복체크*/
    public int retrieveDupMenuId(Map param);

	/** 메뉴코드 저장*/
    public int updateSystemMenu(Map param);
    
    public List<Map<String, Object>> retrieve_IncmeLocalBntHstry(Map param);

    /** 인터페이스 마스터 조회 */
    public List<Map<String, Object>> retrieve_interfaceMaster(Map param);
    
    /** 인터페이스 마스터 저장*/
    public int update_interfaceMaster(Map param);
    
    /** 인터페이스 복원*/
    public int update_interfaceMasterStatus(Map param);
    

    /**
     * 인터페이스 대상 데이터 확인 
     * @param param
     * @return
     */
    public int retrieve_M_Count_TargetTable(Map param);
    
    
    
    /**
     * 인터페이스 완료된 데이터 update  처리 
     * @param param
     * @return
     */
    public int update_M_IfDone_InterfaceData(Map param);
  
    
    /**
     * 수불부 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_M_Material_inv_val(Map param);		
    
    
    /**
     * 매출 마스터 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_M_Sales_Mst(Map param);	
    
    /**
     * 매출 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_M_Sales_Dtl(Map param);	
    
    /**
     * 고객사 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_M_Customer(Map param);	
    
    
    /**
     * Bom 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_M_Result_Bom_Ap(Map param);	
    
    
    /**
     * 아이템 마스터 INF Insert
     * @param param
     * @return
     */
    public int insert_M_ItemMstInf(Map param);	
    
    
    /**
     * 아이템 마스터 Merge
     * @param param
     * @return
     */
    public int merge_M_ItemMst(Map param);
    
    /**
     * 인터페이스 테이블 초기화
     * @param param
     * @return
     */
    public int delete_M_InfTable(Map param);
    
    
    /**
     * Vendor 마스터 INF Insert
     * @param param
     * @return
     */
    public int insert_M_VendorInf(Map param);	
    
    
    /**
     * Vendor 마스터 Merge
     * @param param
     * @return
     */
    public int merge_M_Vendor(Map param);
    
    
    /**
     * 구매원장 INF Insert
     * @param param
     * @return
     */
    public int insert_M_PoledgerInf(Map param);	
    
    
    /**
     * 구매원장 Merge
     * @param param
     * @return
     */
    public int merge_M_Poledger(Map param);
    
    /**
     * 인터페이스 상태값 변경
     * @param param
     * @return
     */
    public int updateInterfaceStatus(Map param);
    
    /**
     * 인터페이스 완료 처리
     * @param param
     * @return
     */
    public int updateIfDone_M_InterfaceData(Map param);
    
    /**
     * 인터페이스 완료 처리 - 매출 상세 전용
     * @param param
     * @return
     */
    public int updateIfDone_M_InterfaceDataForSales_dtl(Map param);
    
    
    /**
     * 매각원장 INF Insert
     * @param param
     * @return
     */
    public int insert_M_SalesLedgerInf(Map param);	
 
    
    /**
     * 매각원장 Merge
     * @param param
     * @return
     */
    public int merge_M_SalesLedge(Map param);
    
    
    /**
     * 분증 생성 프로시저 호출
     * @param param
     * @return
     */
    public void callCreatePartialV2Procedure(Map param);
    
    
    
    /**
     * 기초납입증명서(기납증) 생성 프로시저 호출
     * @param param
     * @return
     */
    public void callCreateInitialV2Procedure(Map param);
    
    
    public List<Map<String, Object>> retrieveInterfaceRunCheck(Map param);
    
    /**
     * 기납증/ 분증 from  to 처리기간 적용
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_Ctrm_TargetMonthList(Map param);
    
    
}