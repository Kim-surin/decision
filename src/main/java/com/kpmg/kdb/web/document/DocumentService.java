package com.kpmg.kdb.web.document;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.ts.issuecover.IssueCoverDao;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class DocumentService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(DocumentService.class);
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooIssueDocumentInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DocumentDao.class).retrieveCooIssueDocumentInfo(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
}
