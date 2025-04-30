package com.kpmg.kdb.web.ts.basis;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;




@Service
@SuppressWarnings({ "rawtypes" })
public class BasisService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(BasisService.class);
    
    public Result dbTest(Map<String, Object> param) throws Exception {
    	
    	Result result = new Result();
    	Map resultMap = sqlSession.getMapper(BasisDao.class).start_TestSql(param);
    	result.setValue(resultMap);
    	System.out.println(resultMap);
        return result;
    }
    
        
}
