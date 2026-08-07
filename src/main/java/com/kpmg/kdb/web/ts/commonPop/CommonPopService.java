package com.kpmg.kdb.web.ts.commonPop;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;




@Service
@SuppressWarnings({ "rawtypes" })
public class CommonPopService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(CommonPopService.class);
    
    /**
     *  공통 팝업 - 공통코드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComCodeList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComCodeList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *  공통 팝업 - 국가코드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComNationList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComNationList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     *  공통 팝업 - 사업장코드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComDivisionList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComDivisionList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *  공통 팝업 - 자재코드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComItemList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComItemList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *  공통 팝업 -  HS코드 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComHsCodePopList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComHsCodePopList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *  공통 팝업 -  FTA코드 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComFtaCodePopList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComFtaCodePopList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    

    /**
     *  공통 팝업 - 사업장코드 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveComCustomerList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(CommonPopDao.class).retrieveComCustomerList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
}
