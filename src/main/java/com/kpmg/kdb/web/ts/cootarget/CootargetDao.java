package com.kpmg.kdb.web.ts.cootarget;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface CootargetDao {
	
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
	public List retrieveCootargetList(Map param);
	
	/**
	 * 확인서 수취율 대시보드 조회 
	 * @param param
	 * @return
	 */
	public List retrieveCootargetDashboard(Map param);
	
	/**
	 * 확인서 수취율 팝업 조회 
	 * @param param
	 * @return
	 */
	public List retrieveCootargetPopup(Map param);
	
	
}


