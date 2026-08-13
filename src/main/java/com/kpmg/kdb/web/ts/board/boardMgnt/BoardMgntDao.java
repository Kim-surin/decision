package com.kpmg.kdb.web.ts.board.boardMgnt;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface BoardMgntDao {
	
	public List retrieveBoardMgntList(Map param);
	
	public Map<String, Object> retrieveBoardMgntDetail(Map param);
	public List retrieveBoardMgntFileList(Map param);
	
	public long retrieveNextBoardNo(Map param);
	public int insertBoardMgntDetail(Map param);
	public int updateBoardMgntDetail(Map param);
	public int deleteBoardFile(Map param);
	public int insertBoardFile(Map param);
	
	public Map<String, Object> retrieveBoardFile(Map param);
	
}


