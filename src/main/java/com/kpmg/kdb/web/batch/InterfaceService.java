package com.kpmg.kdb.web.batch;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.HttpUtils;
import com.kpmg.kdb.util.RestfulClientUtil;
import com.kpmg.kdb.util.StringUtil;



/**
 * AP Interface Service 구현 Class
 *  
 * @author  Damned Cat
 * @since   2024.04
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(InterfaceService.class);
    
    @Value("${eai.call.url}")
    private String eaiCallUrl;
    
    /**
     * 인터페이스 대상 테이블의 인터페이스 수량을 조회합니다. 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveBatchCompanyList(Map param){
    	
    	return sqlSession.getMapper(InterfaceDao.class).retrieveBatchCompanyList(param); 
    }
    
    
    
    
    /**
     * 인터페이스 대상 테이블의 인터페이스 수량을 조회합니다. 
     * @param param
     * @return
     */
    public int retrieveCount_TargetTable(Map param){
    	return sqlSession.getMapper(InterfaceDao.class).retrieveCount_TargetTable(param); 
    }
    
    
    public int updateIfDone_InterfaceData(Map param){
    	return sqlSession.getMapper(InterfaceDao.class).updateIfDone_InterfaceData(param);
    }
    
        
    
    /**
     * 수불부 인터페이스 수행 
     * merge into 
     * @param param
     * @return
     */
    public int merge_Material_inv_val(Map param){
    	return sqlSession.getMapper(InterfaceDao.class).merge_Material_inv_val(param); 
    }
    
    
    /**
     * 매출 마스터 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Sales_Mst(Map param){
    	return sqlSession.getMapper(InterfaceDao.class).merge_Sales_Mst(param); 
    }
    
    
    /**
     * 매출 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Sales_Dtl(Map param){
        return sqlSession.getMapper(InterfaceDao.class).merge_Sales_Dtl(param); 
    }
    
    
    /**
     * 고객사 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Customer(Map param){
        return sqlSession.getMapper(InterfaceDao.class).merge_Customer(param); 
    }
    
    /**
     * Bom 상세 데이터 인터페이스
     * @param param
     * @return
     */
    public int merge_Result_Bom_Ap(Map param){
        return sqlSession.getMapper(InterfaceDao.class).merge_Result_Bom_Ap(param); 
    }
    
    
    
    /**
     * 아이템 마스터 데이터 이관 
     * @param param
     * @return
     */
    public int call_RestfulAPI_ItemMst(Map param){
    	
    	int workCnt = 0;
    	
		try {
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_MST.api:restMMI0255_DUTY_RETURN_SAP/MMI0255";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
		
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String toDate = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE, -3);
			String fromDate = sdf.format(cal.getTime());
			
			
			bodyParam.put("FROM_DATE", fromDate);
			bodyParam.put("TO_DATE", toDate);
			
			// Call API
			Map<String, Object> interfaceMap = RestfulClientUtil.requestToFlask(callUrl, bodyParam);

			Map response = (Map)interfaceMap.get("RESPONSE");
			Map header = (Map)response.get("HEADER");
			String rtnType = StringUtil.null2String(header.get("RTN_TYPE"));
			String rtnMessage = StringUtil.null2String(header.get("RTN_MESSAGE"));
			
			logger.debug("### RTN_TYPE : " + rtnType);
			logger.debug("### RTN_MESSAGE : " + rtnMessage);
			// 오류가 아닌경우 인터페이스 데이터 이관 작업 수행 
			if(!"E".equalsIgnoreCase(rtnType)) {
				logger.debug("### I/F Size : " + ((List)response.get("OUTPUT")).size() + "건");
				List<Map> outputDataList = (List)response.get("OUTPUT");
				for(int inx = 0; inx < outputDataList.size(); inx++) {
					Map row = outputDataList.get(inx);
					sqlSession.getMapper(InterfaceDao.class).insert_ItemMstInf(param); 
				}
			}
			// 마스터 테이블로 데이터 이관
			workCnt = sqlSession.getMapper(InterfaceDao.class).merge_ItemMst(param); 
			
			
		} catch (Exception e) {
			
			
		}finally {
			// 인터페이스 테이블 데이터를 정리
			sqlSession.getMapper(InterfaceDao.class).delete_InfTable(param); 
		}
    	
		return workCnt;
         
    }
    
    
    /**
     * 공급업체 마스터 데이터 이관 
     * @param param
     * @return
     */
    public int call_RestfulAPI_Vendor(Map param){
    	
    	int workCnt = 0;
    	
		try {
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_VENDER.api:restMMI0254_DUTY_RETURN_SAP/MMI0254";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
		
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String toDate = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE, -3);
			String fromDate = sdf.format(cal.getTime());
			
			
			bodyParam.put("FROM_DATE", fromDate);
			bodyParam.put("TO_DATE", toDate);
			
			// Call API
			Map<String, Object> interfaceMap = RestfulClientUtil.requestToFlask(callUrl, bodyParam);

			Map response = (Map)interfaceMap.get("RESPONSE");
			Map header = (Map)response.get("HEADER");
			String rtnType = StringUtil.null2String(header.get("RTN_TYPE"));
			String rtnMessage = StringUtil.null2String(header.get("RTN_MESSAGE"));
			
			logger.debug("### RTN_TYPE : " + rtnType);
			logger.debug("### RTN_MESSAGE : " + rtnMessage);
			// 오류가 아닌경우 인터페이스 데이터 이관 작업 수행 
			if(!"E".equalsIgnoreCase(rtnType)) {
				logger.debug("### I/F Size : " + ((List)response.get("OUTPUT")).size() + "건");
				List<Map> outputDataList = (List)response.get("OUTPUT");
				for(int inx = 0; inx < outputDataList.size(); inx++) {
					Map row = outputDataList.get(inx);
					sqlSession.getMapper(InterfaceDao.class).insert_VendorInf(param); 
				}
			}
			// 마스터 테이블로 데이터 이관
			workCnt = sqlSession.getMapper(InterfaceDao.class).merge_Vendor(param); 
			
			
		} catch (Exception e) {
			
			
		}finally {
			// 인터페이스 테이블 데이터를 정리
			sqlSession.getMapper(InterfaceDao.class).delete_InfTable(param); 
		}
    	
		return workCnt;
         
    }
    
    
    
    /**
     * 구매원장 데이터 이관 
     * @param param
     * @return
     */
    public int call_RestfulAPI_Poledger(Map param){
    	
    	int workCnt = 0;
    	
		try {
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_PURCHASE_LEDGER.api:restMMI0257_DUTY_RETURN_SAP/MMI0257";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
		
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String toDate = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE, -3);
			String fromDate = sdf.format(cal.getTime());
			
			
			bodyParam.put("FROM_DATE", fromDate);
			bodyParam.put("TO_DATE", toDate);
			
			// Call API
			Map<String, Object> interfaceMap = RestfulClientUtil.requestToFlask(callUrl, bodyParam);

			Map response = (Map)interfaceMap.get("RESPONSE");
			Map header = (Map)response.get("HEADER");
			String rtnType = StringUtil.null2String(header.get("RTN_TYPE"));
			String rtnMessage = StringUtil.null2String(header.get("RTN_MESSAGE"));
			
			logger.debug("### RTN_TYPE : " + rtnType);
			logger.debug("### RTN_MESSAGE : " + rtnMessage);
			// 오류가 아닌경우 인터페이스 데이터 이관 작업 수행 
			if(!"E".equalsIgnoreCase(rtnType)) {
				logger.debug("### I/F Size : " + ((List)response.get("OUTPUT")).size() + "건");
				List<Map> outputDataList = (List)response.get("OUTPUT");
				for(int inx = 0; inx < outputDataList.size(); inx++) {
					Map row = outputDataList.get(inx);
					sqlSession.getMapper(InterfaceDao.class).insert_PoledgerInf(param); 
				}
			}
			// 마스터 테이블로 데이터 이관
			workCnt = sqlSession.getMapper(InterfaceDao.class).merge_Poledger(param); 
			
			
		} catch (Exception e) {
			
			
		}finally {
			// 인터페이스 테이블 데이터를 정리
			sqlSession.getMapper(InterfaceDao.class).delete_InfTable(param); 
		}
    	
		return workCnt;
         
    }
    
    
    /**
     * 아이템 마스터 데이터 이관 
     * @param param
     * @return
     */
    public int call_RestfulAPI_SalesLedger(Map param){
    	
    	int workCnt = 0;
    	
		try {
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_GI_SEND_INFO.api:restMMI0260_DUTY_RETURN_SAP/MMI0260";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
		
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			String toDate = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE, -3);
			String fromDate = sdf.format(cal.getTime());
			
			
			bodyParam.put("FROM_DATE", fromDate);
			bodyParam.put("TO_DATE", toDate);
			
			// Call API
			Map<String, Object> interfaceMap = RestfulClientUtil.requestToFlask(callUrl, bodyParam);

			Map response = (Map)interfaceMap.get("RESPONSE");
			Map header = (Map)response.get("HEADER");
			String rtnType = StringUtil.null2String(header.get("RTN_TYPE"));
			String rtnMessage = StringUtil.null2String(header.get("RTN_MESSAGE"));
			
			logger.debug("### RTN_TYPE : " + rtnType);
			logger.debug("### RTN_MESSAGE : " + rtnMessage);
			// 오류가 아닌경우 인터페이스 데이터 이관 작업 수행 
			if(!"E".equalsIgnoreCase(rtnType)) {
				logger.debug("### I/F Size : " + ((List)response.get("OUTPUT")).size() + "건");
				List<Map> outputDataList = (List)response.get("OUTPUT");
				for(int inx = 0; inx < outputDataList.size(); inx++) {
					Map row = outputDataList.get(inx);
					sqlSession.getMapper(InterfaceDao.class).insert_ItemMstInf(param); 
				}
			}
			// 마스터 테이블로 데이터 이관
			workCnt = sqlSession.getMapper(InterfaceDao.class).merge_ItemMst(param); 
			
			
		} catch (Exception e) {
			
			
		}finally {
			// 인터페이스 테이블 데이터를 정리
			sqlSession.getMapper(InterfaceDao.class).delete_InfTable(param); 
		}
    	
		return workCnt;
         
    }
    
}
