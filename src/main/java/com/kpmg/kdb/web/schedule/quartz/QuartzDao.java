package com.kpmg.kdb.web.schedule.quartz;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.core.form.Result;

/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author Damned Cat
 */
public interface QuartzDao {
	
	
    /**
     * Menu Data를 조회한다.
     * @since : 2016.01.01
     * @param param
     * @return
     */
    public List<Map> retrieveBachJobMst(Map param);
	
	
}
