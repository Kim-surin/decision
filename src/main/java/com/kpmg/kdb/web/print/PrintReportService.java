package com.kpmg.kdb.web.print;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class PrintReportService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(PrintReportService.class);
    
    
    
    public Map<String, Object> retrieveSystemMenuList(Map<String, Object> param){
    	
    	Map<String, Object> rtnMap = null;
    	
    	try {
    		rtnMap = sqlSession.getMapper(PrintReportDao.class).retrieveIssueReport_One(param);
    	} catch (Exception e) {
    		
    		throw new RuntimeException();
    	}
    	return rtnMap;
    }
    
    
    public Map<String, Object> retrievePrintDocumentInformation(Map<String, Object> param){
        
        Map<String, Object> rtnMap = null;
        
        try {
            rtnMap = sqlSession.getMapper(PrintReportDao.class).retrievePrintDocumentInformation(param);
        } catch (Exception e) {
            
            throw new RuntimeException();
        }
        return rtnMap;
    }
}
