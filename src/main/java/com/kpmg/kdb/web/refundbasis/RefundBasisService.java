package com.kpmg.kdb.web.refundbasis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.ExcelUtil;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.web.system.SystemDao;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class RefundBasisService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(RefundBasisService.class);
        
    /**
     * 수입신고 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRB002Grid(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB002Grid(param);
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
     * 수입신고 상세
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveImpDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(RefundBasisDao.class).retrieveImpDetail(param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return data;
    }
    
    
    /**
     * 수입신고 상세 란목록
     * @param param
     * @return
     * @throws Exception
     */
    public GridOutputData<Map<String, Object>> retrieveImpDetail_LneList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveImpDetail_LneList(param);
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
     * 수입신고 상세 행목록
     * @param param
     * @return
     * @throws Exception
     */
    public GridOutputData<Map<String, Object>> retrieveImpDetail_PouchList(Map<String, Object> param) throws Exception {
	
		GridOutputData gridData = null;
		try {
			List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveImpDetail_PouchList(param);
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
     * 수출신고 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    public GridOutputData<Map<String, Object>> retrieveRB009Grid(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB009Grid(param);
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
     * 수출신고 상세
     * 
     * @author 피로물질
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieveExpDetail(Map<String, Object> param) throws Exception {
    	
    	Map data = new HashMap();
    	try {
    		data = sqlSession.getMapper(RefundBasisDao.class).retrieveExpDetail(param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return data;
    }
    /**
     * 수출신고 데이터 상세 란/행 목록
     * @param param
     * @return
     * @throws Exception
     */
    public GridOutputData<Map<String, Object>> retrieveExpDetail_Lne(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveExpDetail_Lne(param);
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
     * 부산물비율 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    public GridOutputData<Map<String, Object>> retrieveRB010Grid(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB010Grid(param);
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
     * 생산일자 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    public GridOutputData<Map<String, Object>> retrieveRB011Grid(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB011Grid(param);
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
     * 월별수입물품집계 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    public GridOutputData<Map<String, Object>> retrieveRB012Grid(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB012Grid(param);
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
     * 연간수입물량집계 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    public GridOutputData<Map<String, Object>> retrieveRB013Grid(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRB013Grid(param);
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
     * Po List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectPoList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).selectPoList(param);
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
	 * Po List Data 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> excelUpload_ErrorList(Map<String, Object> param) throws Exception {
		
		GridOutputData gridData = null;
		try {
			List<Map> list = sqlSession.getMapper(RefundBasisDao.class).excelUpload_ErrorList(param);
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
     * Sales List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectSalesList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).selectSalesList(param);
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
     * Material List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectMaterialList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).selectMaterialList(param);
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
     * BOM List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveBomList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveBomList(param);
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
     * BOM Item List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectItemList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).selectItemList(param);
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
	 * 간이정액환급 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_014(Map<String, Object> param) throws Exception {
		
		GridOutputData gridData = null;
		try {
			List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRefundBasis_014(param);
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
	 * 단축고시 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_015(Map<String, Object> param) throws Exception {
		
		GridOutputData gridData = null;
		try {
			List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRefundBasis_015(param);
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
	
	public List<Map> retrieve_RB015_YearCodeList(Map param){
    	return sqlSession.getMapper(RefundBasisDao.class).retrieve_RB015_YearCodeList(param); 
	}
	
	/**
	 * 거래처 관리
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_016(Map<String, Object> param) throws Exception {
		
		GridOutputData gridData = null;
		try {
			List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrieveRefundBasis_016(param);
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
	 * 기존데이터 체크 
	 * @param param
	 * @param files
	 * @param request
	 * @param mReq
	 * @return
	 * @throws Exception
	 */
	public Result retrievePreDataCheck(Map<String, Object> param) {
		Result result = new Result();
		String workType = StringUtil.null2String(param.get("WORK_TYPE"));
		
		if("EXP".equalsIgnoreCase(workType)) {
			result.setValue(sqlSession.getMapper(RefundBasisDao.class).retrievePreDataCheckForExport(param));
			result.setSuccess(true);
		}else if("IMP".equalsIgnoreCase(workType)) {
			result.setValue(sqlSession.getMapper(RefundBasisDao.class).retrievePreDataCheckForImport(param));
			result.setSuccess(true);
		}else {
			result.setSuccess(false);
			result.setMessage("데이터 업로드 전 검증 작업을 수행할 수 없습니다.");
		}
		return result;
	}

	@Transactional
	public List<Map<String, Object>> insertExcelTempData(Map<String, Object> param, List<Map> excelUploadFileData ) {
		List<Map<String, Object>> tempInsertList = new ArrayList<Map<String,Object>>();
		if(excelUploadFileData.size() > 0) {
			
			sqlSession.getMapper(RefundBasisDao.class).deleteExcelUploadTemp(param);
			
			int startRowNum = 2;
			
			for(int inx=0; inx < excelUploadFileData.size(); inx++) {
				Map rowMap = excelUploadFileData.get(inx);
				Map addMap = new HashMap<String, String>();
				char ch = 'A';
				for(int ji = 0 ; ji < 71; ji++) {
					if(ji > 9) {
						addMap.put("ATTR"+ji, rowMap.get(Character.toString(ch) + startRowNum));
					}else {
						addMap.put("ATTR0"+ji, rowMap.get(Character.toString(ch) + startRowNum));	
					}
					ch++;
				}
				startRowNum++;
				
				tempInsertList.add(addMap);
			}
			//logger.debug(tempInsertList.toString());
			for(int inx=0; inx < tempInsertList.size(); inx++) {
				Map rowMap = tempInsertList.get(inx);
				rowMap.put("COMPANY_CODE", param.get("COMPANY_CODE"));
				rowMap.put("USER_ID", param.get("USER_ID"));
				sqlSession.getMapper(RefundBasisDao.class).insertTempImportExcelData(rowMap);
			}
			//sqlBatchSession.flushStatements();
			
			
		}
		return tempInsertList;
	}
	
	
	/**
	 * 엑셀업로드 여러달 업로드 가능한 버전
	 * @param param
	 * @param file
	 * @return
	 */
	@Transactional
    public Result uploadImportExportExcelProcess_For_MultiMonthData(Map<String, Object> param, MultipartFile file) {
		
		Result result = new Result();
		if("".equalsIgnoreCase(StringUtil.null2String(param.get("WORK_TYPE")))){
			result.setSuccess(false);
			result.setMessage("수/출입 구분 값을 알 수 없습니다. 업로드에 실패하였습니다.");
			return result;
		}
		
		if(file != null) {
			String fileName = file.getOriginalFilename();
			String extn = fileName.substring(fileName.lastIndexOf(".") + 1);
			if (!"XLS".equalsIgnoreCase(StringUtil.null2String(extn))
						&& !"XLSX".equalsIgnoreCase(StringUtil.null2String(extn))) {
				result.setSuccess(false);
				result.setMessage("xls,xlsx 파일만 업로드할 수 있습니다.")                                                                                                                                                                                                                                                                                                 ;
				return result;
			}else {
				List<Map> excelUploadFileData = ExcelUtil.convertToList(file,1,0);
				
				// TempTable 데이터 입력 
				List<Map<String, Object>> tempInsertList = 	this.insertExcelTempData(param, excelUploadFileData);
				
				List<Map<String, Object>> tempWorkMonthList = null;
				
				
				// 업로드 된 데이터의 각각의 월 데이터를 추출함
				if("IMP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
					tempWorkMonthList = sqlSession.getMapper(RefundBasisDao.class).retrieveExcelWorkMonthFor_Import(param);
					
				}else if("EXP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
					tempWorkMonthList = sqlSession.getMapper(RefundBasisDao.class).retrieveExcelWorkMonthFor_Export(param);
				}
				
				
				String workMonth = "";
				String targetUsedYn = "";
				int errorCnt = 0;
				for(int inx = 0; inx < tempWorkMonthList.size(); inx++) {
					Map rowMap = tempWorkMonthList.get(inx);
					workMonth = StringUtil.null2String(rowMap.get("TARGET_MONTH"));
					param.put("WORK_MONTH", workMonth);
					if("IMP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
						//TODO: 월별 사용이력 체크 
						targetUsedYn = sqlSession.getMapper(RefundBasisDao.class).retrievePreDataCheckForImport(param);
						
						
						// 중복데이터 체크
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ImpDupData(param);
						
						if("N".equalsIgnoreCase(targetUsedYn) ) {
							result.setSuccess(false);
							result.setMessage("잔량 데이터 사용 이력이 있습니다. 사용한 이력이 있는 경우 업로드 할 수 없습니다.");
							return result;
						}
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("중복된 데이터가 존재합니다.");
							return result;
						}
						
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateImportEmptyItemCode(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("자재코드가 없습니다.");
							return result;
						}
						
						
					}else if("EXP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
						//TODO: 월별 사용이력 체크
						targetUsedYn = sqlSession.getMapper(RefundBasisDao.class).retrievePreDataCheckForExport(param);
						
						// 중복데이터 체크
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ExpDupData(param);
						
						
						if("N".equalsIgnoreCase(targetUsedYn) ) {
							result.setSuccess(false);
							result.setMessage("수출데이터 사용 이력이 있습니다. 사용한 이력이 있는 경우 업로드 할 수 없습니다.");
							return result;
						}
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("중복된 데이터가 존재합니다.");
							return result;
						}
						
						// 수출품목코드 누락
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateExportEmptyItemCode(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("수출 품목코드가 누락된 데이터가 있습니다. ");
							return result;
						}
						
					}
				}
				
				
				if(errorCnt == 0 && "Y".equalsIgnoreCase(targetUsedYn)) {
					
					
					for(int inx = 0; inx < tempWorkMonthList.size(); inx++) {
						Map rowMap = tempWorkMonthList.get(inx);
						param.put("WORK_MONTH", rowMap.get("TARGET_MONTH"));
						if("IMP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
							// 수입 업로드 로직 수행
							
							//기존 수입 해더 삭제
							sqlSession.getMapper(RefundBasisDao.class).deleteImportPreHderData(param);
							//신규 수입 해더 생성
							sqlSession.getMapper(RefundBasisDao.class).createImportHderData(param);
							
							//기존 수입 아이템 삭제
							sqlSession.getMapper(RefundBasisDao.class).deleteImportPreItemData(param);
							//신규 수입 아이템 생성
							sqlSession.getMapper(RefundBasisDao.class).createImportItemData(param);
											
							//기존 잔량 삭제
							sqlSession.getMapper(RefundBasisDao.class).deleteIncmeLocalBntSmPreData(param);
							//잔량 생성
							sqlSession.getMapper(RefundBasisDao.class).createIncmeLocalBntSmData(param);
						}else if("EXP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
							
							// 수출 업로드 로직 수행 
							sqlSession.getMapper(RefundBasisDao.class).deleteExportPreData(param);
							// 수출 데이터 생성
							sqlSession.getMapper(RefundBasisDao.class).createExporteData(param);
							 
							//ET, IN 의경우 수출물품을 가지고 BOM 을 생성한다.
							if("1200".equalsIgnoreCase(StringUtil.null2String(param.get("COMPANY_CODE"))) 
									|| "1300".equalsIgnoreCase(StringUtil.null2String(param.get("COMPANY_CODE")))) {
								sqlSession.getMapper(RefundBasisDao.class).createExporteDataToBom(param);
							}
						}
					}

					
					

					
				}
			}
			
			result.setSuccess(true);
			result.setMessage("업로드가 정상 수행되었습니다.");
		}else {
			result.setSuccess(false);
			result.setMessage("업로드할 파일을 찾을 수 없습니다.");
		}
		
		
		return result;
	}
	
	@Transactional
    public Result uploadImportExportExcelProcess(Map<String, Object> param, MultipartFile file) {
		Result result = new Result();
		if("".equalsIgnoreCase(StringUtil.null2String(param.get("WORK_TYPE")))){
			result.setSuccess(false);
			result.setMessage("수/출입 구분 값을 알 수 없습니다. 업로드에 실패하였습니다.");
			return result;
		}
		
		if(file != null) {
			String fileName = file.getOriginalFilename();
			String extn = fileName.substring(fileName.lastIndexOf(".") + 1);
			if (!"XLS".equalsIgnoreCase(StringUtil.null2String(extn))
						&& !"XLSX".equalsIgnoreCase(StringUtil.null2String(extn))) {
				result.setSuccess(false);
				result.setMessage("xls,xlsx 파일만 업로드할 수 있습니다.");
				return result;
			}else {
				List<Map> excelUploadFileData = ExcelUtil.convertToList(file,1,0);
				
				// TempTable 데이터 입력 
				List<Map<String, Object>> tempInsertList = 	this.insertExcelTempData(param, excelUploadFileData);
				
				if(tempInsertList.size() > 0) {
					String workMonth = "";
					if("IMP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
						workMonth = StringUtil.null2String(param.get("CAL_IMP_UPLOAD_MONTH"));
						param.put("WORK_MONTH", workMonth);
						
						// 입력한 월 이외의 데이터 체크
						int errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ImpAnotherMonth(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("업로드 된 데이터의 입력월과 다른 데이터가 존재 합니다.");
							return result;
						}
						
						// 중복데이터 체크
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ImpDupData(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("중복된 데이터가 존재합니다.");
							return result;
						}
						
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateImportEmptyItemCode(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("자재코드가 없습니다.");
							return result;
						}
						
						
						// 수입 업로드 로직 수행
					
						//기존 수입 해더 삭제
						sqlSession.getMapper(RefundBasisDao.class).deleteImportPreHderData(param);
						//신규 수입 해더 생성
						sqlSession.getMapper(RefundBasisDao.class).createImportHderData(param);
						
						//기존 수입 아이템 삭제
						sqlSession.getMapper(RefundBasisDao.class).deleteImportPreItemData(param);
						//신규 수입 아이템 생성
						sqlSession.getMapper(RefundBasisDao.class).createImportItemData(param);
						
						//기존 잔량 삭제
						sqlSession.getMapper(RefundBasisDao.class).deleteIncmeLocalBntSmPreData(param);
						//잔량 생성
						sqlSession.getMapper(RefundBasisDao.class).createIncmeLocalBntSmData(param);
						
					}else if("EXP".equalsIgnoreCase(param.get("WORK_TYPE")+"")) {
						workMonth = StringUtil.null2String(param.get("CAL_EXP_UPLOAD_MONTH"));
						param.put("WORK_MONTH", workMonth);
						
						// 입력한 월 이외의 데이터 체크
						int errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ExpAnotherMonth(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("업로드 된 데이터의 입력월과 다른 데이터가 존재 합니다.");
							return result;
						}
						
						// 중복데이터 체크
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateUploadDataCheck_ExpDupData(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("중복된 데이터가 존재합니다.");
							return result;
						}
						
						// 수출품목코드 누락
						errorCnt = sqlSession.getMapper(RefundBasisDao.class).updateExportEmptyItemCode(param);
						
						if(errorCnt > 0 ) {
							result.setSuccess(false);
							result.setMessage("수출 품목코드가 누락된 데이터가 있습니다. ");
							return result;
						}
						
						// 수출 업로드 로직 수행 
						sqlSession.getMapper(RefundBasisDao.class).deleteExportPreData(param);
						// 수출 데이터 생성
						sqlSession.getMapper(RefundBasisDao.class).createExporteData(param);
						 
						//ET, IN 의경우 수출물품을 가지고 BOM 을 생성한다.
						if("1200".equalsIgnoreCase(StringUtil.null2String(param.get("COMPANY_CODE"))) 
								|| "1300".equalsIgnoreCase(StringUtil.null2String(param.get("COMPANY_CODE")))) {
							sqlSession.getMapper(RefundBasisDao.class).createExporteDataToBom(param);
						}
					}
				}
			}
			
			result.setSuccess(true);
			result.setMessage("업로드가 정상 수행되었습니다.");
		}else {
			result.setSuccess(false);
			result.setMessage("업로드할 파일을 찾을 수 없습니다.");
		}
		
	
		return result;
	}
	
	

	/**
	 * 매각원장 목록 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrievSalesLedgerList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(RefundBasisDao.class).retrievSalesLedgerList(param);
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
}
