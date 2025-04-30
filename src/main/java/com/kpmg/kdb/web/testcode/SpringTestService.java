package com.kpmg.kdb.web.testcode;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;




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
    
        
}
