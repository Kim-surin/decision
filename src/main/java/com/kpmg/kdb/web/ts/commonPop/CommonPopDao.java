package com.kpmg.kdb.web.ts.commonPop;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface CommonPopDao {
	
	public List retrieveComCodeList(Map param);	
	public List retrieveComNationList(Map param);	
	public List retrieveComDivisionList(Map param);	
	
	
}


