package com.kpmg.kdb.web.ts.individualCooTarget;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface IndividualCootargetDao {
	
	/**
     * @description : 
     * @since : 2025.04
     * @param param
     * @return
     */
    
	
	/**
	 * 확인서 수취대상 관리 조회 
	 * @param param
	 * @return
	 */
	public List retrieveIndividualCootargetList(Map param);
	
	/**
	 * 확인서 수취율 대시보드 조회 
	 * @param param
	 * @return
	 */
	public List retrieveIndividualCootargetDashboard(Map param);
	
	/**
	 * 확인서 수취율 팝업 조회 
	 * @param param
	 * @return
	 */
	public List retrieveIndividualCootargetPopup(Map param);
	
	public List retrieveIndividualCootargetRule(Map param);

	public int checkIndividualCootargetDuplicate(Map param);
	
	public String selectCooCertifyNoGet(Map param);

	public int insertExtCooCertifyMst(Map param);

	public int updateExtCooCertifyDtl(Map param);

	public int insertExtCooCertifyDtl(Map param);

	public int updatePoLedger(Map param);
	
	public int insertExtCooCertifyMstFile(Map param);
	
	public int deleteExtCooCertifyFile(Map param);
	
	public List<Map<String, Object>> retrieveIndividualCootargetNationCode(Map param);
	
	List<Map<String, Object>> selectExtCooCertifyFileList(Map<String, Object> param);
	
	Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param);
}


