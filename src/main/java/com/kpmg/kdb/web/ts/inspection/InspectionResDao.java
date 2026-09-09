package com.kpmg.kdb.web.ts.inspection;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface InspectionResDao {
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * @param param
	 * @return
	 */
	public List retrieveCooCertSearchPopupList(Map param);
	
	/**
	 * 실사 대응 서류 > 마스터 데이터 조회
	 * @param param
	 * @return
	 */
	public Map retrieveCooAuditDocumentInfo(Map param);
	
	/**
	 * 실사 대응 서류 > 확인서 정보 조회 
	 * @param param
	 * @return
	 */
	public List retrieveCooAuditDocumentDetailList(Map param);
}


