package com.kpmg.kdb.web.ts.coverCooTarget;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface CoverCootargetDao {
	
	/**
	 * 확인서 수취대상 관리 조회
	 * @param param
	 * @return
	 */
	public List retrieveCoverCootargetList(Map param);
	
	/**
	 * 확인서 수취율 대시보드 조회
	 * @param param
	 * @return
	 */
	public List retrieveCoverCootargetDashboard(Map param);
	
	/**
	 * 확인서 수취율 팝업 조회
	 * @param param
	 * @return
	 */
	public List retrieveCoverCootargetPopup(Map param);
	
	public List retrieveCoverCootargetRule(Map param);

	public List retrieveCoverCootargetNoCode(Map param);
	
	public int checkCoverCootargetDuplicate(Map param);
	
	public String selectCooCertifyNoGet(Map param);

	public int insertExtCooCertifyMst(Map param);

	public int updateExtCooCertifyDtl(Map param);

	public int insertExtCooCertifyDtl(Map param);

	public int updatePoLedger(Map param);
	
	public int insertExtCooCertifyMstFile(Map param);
	
	public List<Map<String, Object>> selectExtCooCertifyFileList(Map param);

	public Map<String, Object> selectExtCooCertifyFileDownload(Map param);
	
	public List<Map<String, Object>> retrieveCoverCootargetNationCode(Map param);
	
	public int deleteExtCooCertifyFile(Map param);
	
	public List<Map<String, Object>> retrieveCoverCootargetOmission(Map param);
	
	Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param);
}