package com.kpmg.kdb.web.ts.ftaInfo.ftaIncoterms;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface FtaIncotermsDao {
	
	public List retrieveFtaIncotermsList(Map param);
	public int retrieveFtaIncoterms(Map param);
	public int insertFtaIncoterms(Map param);
	public int updateFtaIncoterms(Map param);
	public int deleteFtaIncoterms(Map param);
	
	
}


