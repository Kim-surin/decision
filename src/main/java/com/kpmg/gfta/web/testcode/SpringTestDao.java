package com.kpmg.gfta.web.testcode;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface SpringTestDao {
	
	/**
     * @description : 
     * @since : 2025.04
     * @param param
     * @return
     */
    
	public Map start_TestSql(Map param);
	
	
	/**
	 * Sample001 page  조회 기능 샘플
	 * @param param
	 * @return
	 */
	public List retrieveTestSalesMaster(Map param);
	
}
