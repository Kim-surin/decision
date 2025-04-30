package com.kpmg.kdb.web.report;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.StringUtil;

/**
 * 레포트 관련 처리 서비스 클래스
 *  
 * @author  
 * @since   2018.07
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class ReportService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(ReportService.class);
    
    /**
     * 기간별 환급레포트 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R001List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_R001List(param);
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
     * 잔량레포트 
	 *  - 거래처별 Pie Chart Data 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt002_getExporterBalanceTax(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt002_getExporterBalanceTax(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
     * 잔량레포트 
	 *  - 거래처별 Bar Chart Data 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt002_getExporterBalanceQty(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt002_getExporterBalanceQty(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
	 * 잔량레포트 
	 *  - 자재코드별 Bar Chart Data
	 * @param param
	 * @return
	 */
    public Result rpt002_getItemCodeBalanceTax(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	result.setValue(sqlSession.getMapper(ReportDao.class).rpt002_getItemCodeBalanceTax(param));
    	return result;
    }
    /**
	 * 잔량레포트 
	 *  - 자재코드별 Pie Chart Data  
	 * @param param
	 * @return
	 */
    public Result rpt002_getItemCodeBalanceQty(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	result.setValue(sqlSession.getMapper(ReportDao.class).rpt002_getItemCodeBalanceQty(param));
    	return result;
    }
    
    /**
	 * 잔량레포트 
	 *  - HS CODE별 Bar Chart Data
	 * @param param
	 * @return
	 */
    public Result rpt002_getHsCodeBalanceTax(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	result.setValue(sqlSession.getMapper(ReportDao.class).rpt002_getHsCodeBalanceTax(param));
    	return result;
    }
    /**
	 * 잔량레포트 
	 *  - HS CODE별 Pie Chart Data  
	 * @param param
	 * @return
	 */
    public Result rpt002_getHsCodeBalanceQty(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	result.setValue(sqlSession.getMapper(ReportDao.class).rpt002_getHsCodeBalanceQty(param));
    	return result;
    }
    
    
    /**
     * 잔량레포트 우측상단 그리드 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRpt00201List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieveRpt00201List(param);
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
     * 잔량레포트 우측상단 그리드 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRpt00202List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieveRpt00202List(param);
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
	 * 잔여수량 상세 레포트 조회
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRpt0020XList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = null;
    		String searchType = StringUtil.null2String(param.get("TAB_SEARCH_TYPE"));
    		if("VENDOR".equalsIgnoreCase(searchType)) {
    			list = sqlSession.getMapper(ReportDao.class).retrieveRpt00203List(param);
    		}else if("ITEM".equalsIgnoreCase(searchType)) {
    			list = sqlSession.getMapper(ReportDao.class).retrieveRpt00204List(param);
    		}else if("HSCODE".equalsIgnoreCase(searchType)) {
    			list = sqlSession.getMapper(ReportDao.class).retrieveRpt00205List(param);
    		}
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
     * 조건표 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R003List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_R003List(param);
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
     * 기납증/분증 수취 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R004List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_R004List(param);
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
     * 구매확인서/기납증 비교 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R006List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_R006List(param);
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
     * 환급금액 레포트 
	 *  - 거래처별 
	 *     - [Pie Chart Data] 수출액 대비 환급액 비율 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getVendorDrwbak_Rate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getVendorDrwbak_Rate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
     * 환급금액 레포트 
	 *  - 거래처별 
	 *     - [Bar Chart Data] 환급수량별 비율a 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getVendorDrwbakUsedQtyData(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getVendorDrwbakUsedQtyData(param);
    	result.setValue(rtnValue);
    	return result;
    }
    /**
	 * 환급금액 레포트 
	 *  - 거래처별 
	 *     - [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
    public Result rpt008_getVendorTaxByDrwBakRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getVendorTaxByDrwBakRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    
    /**
     * 환급금액 레포트 
	 *  - 제품코드 별  
	 *     - [Pie Chart Data] 수출액 대비 환급액 비율 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getItemCodeDrwbak_Rate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getItemCodeDrwbak_Rate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
     * 환급금액 레포트 
	 *  - 제품코드 별  
	 *     - [Bar Chart Data] 환급수량별 비율
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getItemCodeDrwbakUsedQtyData(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getItemCodeDrwbakUsedQtyData(param);
    	result.setValue(rtnValue);
    	return result;
    }
    /**
	 * 환급금액 레포트 
	 *  - 제품코드 별  
	 *     - [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
    public Result rpt008_getItemCodeTaxByDrwBakRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getItemCodeTaxByDrwBakRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    
    
    /**
     * 환급금액 레포트 
	 *  - HS Code  별  
	 *     - [Pie Chart Data] 수출액 대비 환급액 비율 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getHsCodeDrwbak_Rate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getHsCodeDrwbak_Rate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
     * 환급금액 레포트 
	 *  - HS Code  별  
	 *     - [Bar Chart Data] 환급수량별 비율
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getHsCodeDrwbakUsedQtyData(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getHsCodeDrwbakUsedQtyData(param);
    	result.setValue(rtnValue);
    	return result;
    }
    /**
	 * 환급금액 레포트 
	 *  - HS Code  별  
	 *     - [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
    public Result rpt008_getHsCodeTaxByDrwBakRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getHsCodeTaxByDrwBakRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    
    
    /**
     * 환급금액 레포트 
	 *  - 목적국  별  
	 *     - [Pie Chart Data] 수출액 대비 환급액 비율 
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getNationCodeDrwbak_Rate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getNationCodeDrwbak_Rate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    /**
     * 환급금액 레포트 
	 *  - 목적국  별  
	 *     - [Bar Chart Data] 환급수량별 비율
     * @param param
     * @return
     * @throws Exception
     */
    public Result rpt008_getNationCodeDrwbakUsedQtyData(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getNationCodeDrwbakUsedQtyData(param);
    	result.setValue(rtnValue);
    	return result;
    }
    /**
	 * 환급금액 레포트 
	 *  - 목적국  별  
	 *     - [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
    public Result rpt008_getNationCodeTaxByDrwBakRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getNationCodeTaxByDrwBakRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    
	/**
	 * 기납증/분증 수취금액 비율
	 *  -[Pie Chart Data]  금액
	 * @param param
	 * @return
	 */
    public Result rpt008_getCcpyAmountRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getCcpyAmountRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
	/**
	 * 기납증/분증 수취금액 비율
	 *  -[Pie Chart Data]  수량
	 * @param param
	 * @return
	 */
    public Result rpt008_getCcpyQtyRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getCcpyQtyRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    /**
	 * 구매확인서 대비 기납증/분증 발급금액 비율
	 *  -[Pie Chart Data]  금액
	 * @param param
	 * @return
	 */
    public Result rpt008_getCtrmAmountRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getCtrmAmountRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
	/**
	 * 구매확인서 대비 기납증/분증 발급금액 비율
	 *  -[Pie Chart Data]  수량
	 * @param param
	 * @return
	 */
    public Result rpt008_getCtrmQtyRate(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).rpt008_getCtrmQtyRate(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
    
    
    /**
	 * 환급금액 레포트 상세 레포트 조회
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRpt0080XList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = null;
    		String searchType = StringUtil.null2String(param.get("TAB_SEARCH_TYPE"));
    		list = sqlSession.getMapper(ReportDao.class).retrieveRpt00801List(param);
    		/*
    		if("VENDOR_PIE_01".equalsIgnoreCase(searchType)) {
    			
    		}else if("VENDOR_BAR_01".equalsIgnoreCase(searchType)) {
    			list = sqlSession.getMapper(ReportDao.class).retrieveRpt00802List(param);
    		}else if("VENDOR_BAR_02".equalsIgnoreCase(searchType)) {
    			list = sqlSession.getMapper(ReportDao.class).retrieveRpt00803List(param);
    		}
    		*/
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
	 *  환급금액 레포트 상세 레포트 조회(납부세액 상세)
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveRpt0080XList_IMPDEC(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map> list = null;
    		String searchType = StringUtil.null2String(param.get("TAB_SEARCH_TYPE"));
    		list = sqlSession.getMapper(ReportDao.class).retrieveRpt0080XList_IMPDEC(param);
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
     * 수출입 데이터 중복 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R010List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list  = null;
    		String searchGubun = String.valueOf(param.get("SEARCH_GUBUN"));
    		
    		if("E".equals(searchGubun)){
    			list = sqlSession.getMapper(ReportDao.class).retrieve_R010ExportList(param);
    		}else {
    			list = sqlSession.getMapper(ReportDao.class).retrieve_R010ImportList(param);
    		}
    	
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
     * 수입 자재코드 분석 하단 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R011List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list  = sqlSession.getMapper(ReportDao.class).retrieve_R011List(param);
    	
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
     * 수출입 분석(HS_CODE 차이)
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_diffHsCodeList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_diffHsCodeList(param);
    	
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
     * 수출입 분석(자재코드명 차이)
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_diffItemNmList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_diffItemNmList(param);
    	
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
     * 수출입 분석(단가 차이)
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_diffPriceList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_diffPriceList(param);
        	
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
     * 환급대상 수출 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R012List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list  = sqlSession.getMapper(ReportDao.class).retrieve_R012List(param);
    	
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
	 * 환급대상 수출조회 -
	 *  -[Pie Chart Data]  제조자 또는 환급신청인 오류 건 수출금액 /총 수출금액 *100
	 * @param param
	 * @return
	 */
    public Result retrieveErrorByExportAmountRatePieChart(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).retrieveErrorByExportAmountRatePieChart(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
	/**
	 * 환급대상 수출조회 -
	 *  -[Pie Chart Data]  제조자 또는 환급신청인 오류 건 수출건수 /총 수출건수 *100
	 * @param param
	 * @return
	 */
    public Result retrieveErrorByExportQtyRatePieChart(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).retrieveErrorByExportQtyRatePieChart(param);
    	result.setValue(rtnValue);
    	return result;
    }
    
	/**
	 * 환급대상 수출조회 -
	 *  -[Pie Chart Data]  제조자 또는 환급신청인 오류 건 환급금액 /총 환급금액 *100
	 * @param param
	 * @return
	 */
    public Result retrieveErrorByDrwbAmountRatePieChart(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	
    	List<Map> rtnValue = sqlSession.getMapper(ReportDao.class).retrieveErrorByDrwbAmountRatePieChart(param);
    	result.setValue(rtnValue);
    	return result;
    }
  
    
    
    /**
     * BOM 검증 상단 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R013List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list  = sqlSession.getMapper(ReportDao.class).retrieve_R013List(param);
    	
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
     *BOM 검증 하단 조회
     * 
     * @param    param    입력파라미터
     * @return   
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_R013DetailList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(ReportDao.class).retrieve_R013DetailList(param);
    	
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