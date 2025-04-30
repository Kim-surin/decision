package com.kpmg.kdb.web.cusven;

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
import com.kpmg.kdb.web.drawback.DrawbackDao;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class CustomerVendorService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(CustomerVendorService.class);
    
    /**
     * 양수자통보 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveCV004Grid(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(CustomerVendorDao.class).retrieveCV004Grid(param);
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
			e.printStackTrace();
		}
    	
    	return gridData;
    }
    
    /**
	 * 양수자통보 조회 마스터 정보 조회 - 해더
	 * @param param
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveCV004GridDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(CustomerVendorDao.class).retrieveCV004GridDetail(param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return data;
    }
    
    /**
	 * 양수자통보 조회 마스터 정보 조회 - 리스트
	 * @param model
	 * @param session
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveCV004GridDetailList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(CustomerVendorDao.class).retrieveCV004GridDetailList(param);
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
			e.printStackTrace();
		}
    	
    	return gridData;
    }
    
    /**
     * 고객사 근거서류 목록 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_CV001List(Map<String, Object> param) throws Exception {
        
        GridOutputData gridData = null;
        try {
            List<Map> list = sqlSession.getMapper(CustomerVendorDao.class).retrieve_CV001List(param);
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
            e.printStackTrace();
        }
        
        return gridData;
    }
    
    /**
     * 고객사 근거서류 상세 Header 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_CV00101_header(Map<String, Object> param) throws Exception {
        
        Map<String, Object> data = new HashMap();
        try {
            data = sqlSession.getMapper(CustomerVendorDao.class).retrieve_CV00101_header(param);
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
        
        return data;
    }
    
    /**
     * 고객사 근거서류 상세 List 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_CV00101_List(Map<String, Object> param) throws Exception {
        
        GridOutputData gridData = null;
        try {
            List<Map> list = sqlSession.getMapper(CustomerVendorDao.class).retrieve_CV00101_List(param);
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
            e.printStackTrace();
        }
        
        return gridData;
    }
    
    
	/**
	 * BOM 제출 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_CV006List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(CustomerVendorDao.class).retrieve_CV006List(param);
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
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
	 * BOM 제출 목록 조회(기납증)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_CV007List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(CustomerVendorDao.class).retrieve_CV007List(param);
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
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
}
