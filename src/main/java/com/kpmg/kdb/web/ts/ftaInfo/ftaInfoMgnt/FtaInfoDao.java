package com.kpmg.kdb.web.ts.ftaInfo.ftaInfoMgnt;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface FtaInfoDao {
	
	public List retrieveFtaInfoList(Map param);
	public int insertFtaInfoList(Map param);
	public int updateFtaInfoList(Map param);
	public int deleteFtaInfoList(Map param);

	public List retrieveFtaNationAllList(Map param);
	public List retrieveFtaNationApplyList(Map param);
	

	public int deleteFtaNationList(Map param);
	public int insertFtaNation(Map param);
	
}


