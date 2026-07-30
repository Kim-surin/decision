package com.kpmg.kdb.web.ts.basis.ftaInfo;

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
import com.kpmg.kdb.web.ts.basis.BasisDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class FtaInfoService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(FtaInfoService.class);
    
    /**
     * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveFtaInfoList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(FtaInfoDao.class).retrieveFtaInfoList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 리스트 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveFtaInfoList(Map<String, Object> param){
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
    				saveMap.put("searchFtaCode", saveMap.get("fta_code"));
        			List dupCheckList = sqlSession.getMapper(FtaInfoDao.class).retrieveFtaInfoList(saveMap);
    			
        			if(dupCheckList.size() > 0) {
        				result.setSuccess(false);
        				result.setMessage("중복된 FTA CODE가 존재합니다. 등록할 수 없습니다.");
        				return result;
        			}
    				
    				resultCnt += sqlSession.getMapper(FtaInfoDao.class).insertFtaInfoList(saveMap);
    			}else if("e".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(FtaInfoDao.class).updateFtaInfoList(saveMap); 
    			}else if("r".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(FtaInfoDao.class).deleteFtaInfoList(saveMap);
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
     * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 좌측 그리드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveFtaNationAllList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(FtaInfoDao.class).retrieveFtaNationAllList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveFtaNationApplyList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(FtaInfoDao.class).retrieveFtaNationApplyList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 기초정보관리 > FTA RULE 관리 > FTA 협정 정보 관리 > 협정국가 지정 팝업 > 우측 그리드 리스트 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveFtaNationList(Map<String, Object> param){
    	Result result = new Result();
    	int resultCnt = 0;
    	
    	try {
    		List saveList = (List)param.get("SAVE_LIST");
    		
    		//FTA에 대해 전체 삭제 후 모든 데이터를 다시 INSERT 한다. 
    		sqlSession.getMapper(FtaInfoDao.class).deleteFtaNationList(param);
    		
    		for(Object obejctMap : saveList) {
    			Map<String, Object> saveMap = (Map<String, Object>) obejctMap;
    			saveMap.put("company_code", param.get("company_code"));
    			saveMap.put("fta_code", param.get("fta_code"));
    			saveMap.put("update_by", param.get("update_by"));
    			
    			
    			sqlSession.getMapper(FtaInfoDao.class).insertFtaNation(saveMap);
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
