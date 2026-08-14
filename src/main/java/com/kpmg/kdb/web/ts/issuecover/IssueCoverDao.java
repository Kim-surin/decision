package com.kpmg.kdb.web.ts.issuecover;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface IssueCoverDao {
	
	/**
	 * 고객사 자재관리 목록 데이터 조회
	 * @param param
	 * @return
	 */
	public List retrieveCooIssueCoverList(Map param);
}


