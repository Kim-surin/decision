package com.kpmg.kdb.web.ts.ftaInfo.hsCodeByNation;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;




@Service
@SuppressWarnings({ "rawtypes" })
public class HsCodeByNationService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(HsCodeByNationService.class);
    
    /**
     * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 좌측 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveNationIncludeRcepCntList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(HsCodeByNationDao.class).retrieveNationIncludeRcepCntList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 상단 리스트 조회(국가별 HS코드)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveHsCodeByNationList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(HsCodeByNationDao.class).retrieveHsCodeByNationList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 상단 리스트 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveHsCodeByNationList(Map<String, Object> param){
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
        			int dupCnt = sqlSession.getMapper(HsCodeByNationDao.class).retrieveHsCodeByNationCnt(saveMap);
    			
        			if(dupCnt > 0) {
        				result.setSuccess(false);
        				result.setMessage("중복된 데이터가 존재합니다.");
        				return result;
        			}
    				
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).insertHsCodeByNation(saveMap);
    			}else if("e".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).updateHsCodeByNation(saveMap); 
    			}else if("r".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).deleteHsCodeByNation(saveMap);
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
    
    
    /**
     * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 하단 리스트 조회(양허표 리스트)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveHsCodeRcepList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(HsCodeByNationDao.class).retrieveHsCodeRcepList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * FTA 정보 관리 > 국가별 HS코드 관리(양허표) > 우측 하단 리스트 저장(양허표 리스트)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveHsCodeRcepList(Map<String, Object> param){
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
        			int dupCnt = sqlSession.getMapper(HsCodeByNationDao.class).retrieveHsCodeRcepListCnt(saveMap);
    			
        			if(dupCnt > 0) {
        				result.setSuccess(false);
        				result.setMessage("중복된 데이터가 존재합니다.");
        				return result;
        			}
    				
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).insertHsCodeRcepList(saveMap);
    			}else if("e".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).updateHsCodeRcepList(saveMap); 
    			}else if("r".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(HsCodeByNationDao.class).deleteHsCodeRcepList(saveMap);
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
