package com.kpmg.kdb.web.schedule.quartz;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.util.HttpUtils;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.core.form.Result;

/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
public class QuartzService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(QuartzService.class);
    
    public List<Map> retrieveBachJobMst(Map param){
    	return sqlSession.getMapper(QuartzDao.class).retrieveBachJobMst(param); 
    }
    
    
}
