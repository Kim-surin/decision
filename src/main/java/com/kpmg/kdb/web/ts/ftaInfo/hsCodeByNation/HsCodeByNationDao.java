package com.kpmg.kdb.web.ts.ftaInfo.hsCodeByNation;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface HsCodeByNationDao {
	
	public List retrieveHsCodeList(Map param);
	public List retrieveHsCodePsrList(Map param);
	public List retrieveNationIncludeRcepCntList(Map param);
	public List retrieveHsCodeByNationList(Map param);
	public List retrieveHsCodeRcepList(Map param);
	
	public int retrieveHsCodeByNationCnt(Map param);
	public int insertHsCodeByNation(Map param);
	public int updateHsCodeByNation(Map param);
	public int deleteHsCodeByNation(Map param);
	public int retrieveHsCodeRcepListCnt(Map param);
	public int insertHsCodeRcepList(Map param);
	public int updateHsCodeRcepList(Map param);
	public int deleteHsCodeRcepList(Map param);
	
	
}


