package com.kpmg.kdb.web.ts.ftaInfo.hsCode;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface HsCodeDao {
	
	public List retrieveHsCodeList(Map param);
	public List retrieveHsCodePsrList(Map param);
	
	
	
}


