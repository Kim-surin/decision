package com.kpmg.kdb.web.ts.targetreceipt;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface TargetreceiptDao {
	
	/**
     * @description : 
     * @since : 2025.04
     * @param param
     * @return
     */
    
	public Map start_TestSql(Map param);
	
	
	/**
	 * 확인서 수취대상 관리 조회 
	 * @param param
	 * @return
	 */
	public List retrieveTargetReceiptList(Map param);
}


