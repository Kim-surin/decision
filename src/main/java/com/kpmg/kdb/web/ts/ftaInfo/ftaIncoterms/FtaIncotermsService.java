package com.kpmg.kdb.web.ts.ftaInfo.ftaIncoterms;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.ts.ftaInfo.ftaInfoMgnt.FtaInfoDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class FtaIncotermsService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(FtaIncotermsService.class);
    
    /**
     *  FTA 정보 관리 > FTA별 INCOTERMS > 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveFtaIncotermsList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(FtaIncotermsDao.class).retrieveFtaIncotermsList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * FTA 정보 관리 > FTA별 INCOTERMS > 리스트 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveFtaIncotermsList(Map<String, Object> param){
    	Result result = new Result();
    	int resultCnt = 0;
    	
    	try {
    		List saveList = (List)param.get("SAVE_LIST");
    		
    		for(Object obejctMap : saveList) {
    			Map<String, Object> saveMap = (Map<String, Object>) obejctMap;
    			saveMap.put("company_code", param.get("company_code"));
    			saveMap.put("update_by", param.get("update_by"));
    			
    			if("a".equals(saveMap.get("state"))) {
    				
    				//중복체크
        			int dupCnt = sqlSession.getMapper(FtaIncotermsDao.class).retrieveFtaIncoterms(saveMap);
    			
        			if(dupCnt > 0) {
        				result.setSuccess(false);
        				result.setMessage("중복된 데이터가 존재합니다.");
        				return result;
        			}
    				
    				resultCnt += sqlSession.getMapper(FtaIncotermsDao.class).insertFtaIncoterms(saveMap);
    			}else if("e".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(FtaIncotermsDao.class).updateFtaIncoterms(saveMap); 
    			}else if("r".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(FtaIncotermsDao.class).deleteFtaIncoterms(saveMap);
    			}
    		}
    		
    		result.setValue(resultCnt);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
}