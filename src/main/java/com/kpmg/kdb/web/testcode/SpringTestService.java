package com.kpmg.kdb.web.testcode;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.system.SystemDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class SpringTestService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(SpringTestService.class);
    
    public Result dbTest(Map<String, Object> param) throws Exception {
    	
    	Result result = new Result();
    	Map resultMap = sqlSession.getMapper(SpringTestDao.class).start_TestSql(param);
    	result.setValue(resultMap);
    	System.out.println(resultMap);
        return result;
    }
    
    
    /**
	 * Sample001 page  조회 기능 샘플
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveTestSalesMaster(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SpringTestDao.class).retrieveTestSalesMaster(param);
    		
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
