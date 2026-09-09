package com.kpmg.kdb.web.ts.inspection;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import com.kpmg.kdb.web.ts.issuecover.IssueCoverDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class InspectionResService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(InspectionResService.class);
    
    
    /**
     * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooCertSearchPopupList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(InspectionResDao.class).retrieveCooCertSearchPopupList(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 실사 대응 서류 > 마스터 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooAuditDocumentInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		Map<String, Object> cooAuditDocumentInfoMap = sqlSession.getMapper(InspectionResDao.class).retrieveCooAuditDocumentInfo(param);
    		
    		result.setValue(cooAuditDocumentInfoMap);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 실사 대응 서류 > 확인서 정보 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooAuditDocumentDetailList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(InspectionResDao.class).retrieveCooAuditDocumentDetailList(param);
    		
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
