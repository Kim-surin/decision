package com.kpmg.kdb.web.ts.issuecover;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.ExcelUtil;
import com.kpmg.kdb.util.FileUtil;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.web.refundbasis.RefundBasisDao;
import com.kpmg.kdb.web.testcode.SpringTestDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class IssueCoverService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(IssueCoverService.class);
    
    
    /**
     * 고객사 자재관리 목록 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooIssueCoverList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IssueCoverDao.class).retrieveCooIssueCoverList(param);
    		
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
