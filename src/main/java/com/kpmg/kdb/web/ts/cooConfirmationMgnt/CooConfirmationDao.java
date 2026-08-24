package com.kpmg.kdb.web.ts.cooConfirmationMgnt;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface CooConfirmationDao {

	List<Map<String, Object>> retrieveCooConfirmationList(Map param);

	List<Map<String, Object>> retrieveCooConfirmationListPopup(Map param);

	List<Map<String, Object>> retrieveCooConfirmationListRule(Map param);

	int checkCooConfirmationListDuplicate(Map param);

	String selectCooCertifyNoGet(Map param);

	int insertExtCooCertifyMst(Map param);

	int updateExtCooCertifyDtl(Map param);

	int insertExtCooCertifyDtl(Map param);

	int updatePoLedger(Map param);

	int insertExtCooCertifyMstFile(Map param);

	int deleteExtCooCertifyFile(Map param);

	List<Map<String, Object>> retrieveCooConfirmationListNationCode(Map param);

	List<Map<String, Object>> selectExtCooCertifyFileList(Map<String, Object> param);

	Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param);

	List<Map<String, Object>> selectBeforeDtlData(Map param);

	int copyExtCooCertifyFiles(Map param);

}