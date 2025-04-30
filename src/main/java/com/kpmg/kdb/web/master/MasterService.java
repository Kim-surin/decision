package com.kpmg.kdb.web.master;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.StringUtil;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class MasterService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(MasterService.class);

    /**
     * 회사정보 조회
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveCompanyInfo(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(MasterDao.class).retrieveCompanyInfo(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 회사정보 저장
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateCompanyInfo(Map<String, Object> param) throws Exception {
    	
    	int data = 0;
    	try {
    		data = sqlSession.getMapper(MasterDao.class).updateCompanyInfo(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 고객사 리스트 조회
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveCustomerList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(MasterDao.class).retrieveCustomerList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (Exception e) {
    		
    	}
    	
    	return gridData;
    }

    /**
     * 고객사 상세
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveCustomerDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(MasterDao.class).retrieveCustomerDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 고객사 상세 저장
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateCustomerDetail(Map<String, Object> param) throws Exception {
    	
    	int data = 0;
    	try {
    		data = sqlSession.getMapper(MasterDao.class).updateCustomerDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    
    /**
     * 협력사 리스트 조회
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveVendorList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(MasterDao.class).retrieveVendorList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (Exception e) {
    		
    	}
    	
    	return gridData;
    }

    /**
     * 협력사 상세
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveVendorDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(MasterDao.class).retrieveVendorDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 협력사 상세 저장
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateVendorDetail(Map<String, Object> param) throws Exception {
    	
    	int data = 0;
    	try {
    		data = sqlSession.getMapper(MasterDao.class).updateVendorDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    
    /**
     * 환급제한규정 리스트 조회
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveDrwbakLmttList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(MasterDao.class).retrieveDrwbakLmttList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (Exception e) {
    		
    	}
    	
    	return gridData;
    }

    /**
     * 환급제한규정상세
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveDrwbakLmttDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(MasterDao.class).retrieveDrwbakLmttDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 환급제한규정 상세 저장
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateDrwbakLmttDetail(Map<String, Object> param) throws Exception {
    	
    	int data = 0;
    	try {
    		data = sqlSession.getMapper(MasterDao.class).mergeDrwbakLmttDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 환급제한규정 상세 삭제
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deleteDrwbakLmttDetail(Map<String, Object> param) throws Exception {
    	
    	int data = 0;
    	try {
    		data = sqlSession.getMapper(MasterDao.class).deleteDrwbakLmttDetail(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
    
    /**
     * 자재마스터 리스트 
     * 
     * @author 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveItemList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(MasterDao.class).retrieveItemList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (Exception e) {
    		
    	}
    	
    	return gridData;
    }
}
