package com.kpmg.kdb.web.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.RestfulClientUtil;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.web.drawback.DrawbackService;



/**
 * AsyncService
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class AsyncService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(AsyncService.class);
    
    
    @Value("${eai.call.url}")
    private String eaiCallUrl;
    
    
    @Autowired
	protected DrawbackService drwbService;
    
    /**
     * 고객사 마스터 
     * @param param
     */
    @Async
    public void runRfc001(Map param) {
    	
    	try {
    		sqlSession.getMapper(SystemDao.class).merge_M_Customer(param);	
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateIfDone_M_InterfaceData(param);
	    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    	
    	
    	
    }
    
    /**
     * 자재 마스터
     * @param param
     */
    @Async
    @Transactional
    public void runRfc002(Map param){
    	try {
    		
    		
        	
        	
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_MST.api:restMMI0255_DUTY_RETURN_SAP/MMI0255";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			bodyParam.put("FROM_DATE", param.get("START_YYYYMMDD"));
			bodyParam.put("TO_DATE", param.get("END_YYYYMMDD"));
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
					row.putAll(param);
					sqlBatchSession.getMapper(SystemDao.class).insert_M_ItemMstInf(row); 
				}
				// 마스터 테이블로 데이터 이관
				sqlBatchSession.getMapper(SystemDao.class).merge_M_ItemMst(param); 
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 인터페이스 테이블 데이터를 정리
			param.put("TARGET_TABLE_NAME", "ITEM_MST_INF");
			sqlBatchSession.getMapper(SystemDao.class).delete_M_InfTable(param); 
	    	param.put("STATUS_FLAG", "N");
	    	sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
	    	sqlBatchSession.flushStatements();
		}
    }
    
    /**
     * 매출 상세
     * @param param
     */
    @Async
    public void runRfc015(Map param){
    	
    	
    	try {
        	sqlSession.getMapper(SystemDao.class).merge_M_Sales_Dtl(param);	
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateIfDone_M_InterfaceDataForSales_dtl(param);
	    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    	
    }
    
    /**
     * 구매원장
     * @param param
     */
    @Async
    @Transactional
    public void runRfc007(Map param){
    	try {
    		
        	
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_PURCHASE_LEDGER.api:restMMI0257_DUTY_RETURN_SAP/MMI0257";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			bodyParam.put("FROM_DATE", param.get("START_YYYYMMDD"));
			bodyParam.put("TO_DATE", param.get("END_YYYYMMDD"));
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
					row.putAll(param);
					sqlBatchSession.getMapper(SystemDao.class).insert_M_PoledgerInf(row); 
				}
				// 마스터 테이블로 데이터 이관
				sqlBatchSession.getMapper(SystemDao.class).merge_M_Poledger(param); 
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 인터페이스 테이블 데이터를 정리
			param.put("TARGET_TABLE_NAME", "PO_LEDGER_INF");
			sqlBatchSession.getMapper(SystemDao.class).delete_M_InfTable(param); 
	    	param.put("STATUS_FLAG", "N");
	    	sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
	    	sqlBatchSession.flushStatements();
		}
    	
    	
    }
    
    /**
     * 환급 bom
     * @param param
     */
    @Async
    public void runRfc010(Map param){
    	
    	try {
        	sqlSession.getMapper(SystemDao.class).merge_M_Result_Bom_Ap(param);	
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateIfDone_M_InterfaceData(param);
	    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    	
    }
    
    /**
     * 공급업체 마스터 
     * @param param
     */
    @Async
    @Transactional
    public void runRfc004(Map param){
    	
    	try {
        	
        	
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_VENDER.api:restMMI0254_DUTY_RETURN_SAP/MMI0254";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			bodyParam.put("FROM_DATE", param.get("START_YYYYMMDD"));
			bodyParam.put("TO_DATE", param.get("END_YYYYMMDD"));
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
					row.putAll(param);
					sqlBatchSession.getMapper(SystemDao.class).insert_M_VendorInf(row); 
				}
				// 마스터 테이블로 데이터 이관
				sqlBatchSession.getMapper(SystemDao.class).merge_M_Vendor(param); 
				
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 인터페이스 테이블 데이터를 정리
			param.put("TARGET_TABLE_NAME", "VENDOR_INF");
			sqlBatchSession.getMapper(SystemDao.class).delete_M_InfTable(param); 
	    	param.put("STATUS_FLAG", "N");
	    	sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
	    	sqlBatchSession.flushStatements();
		}
    	
    }
    
    /**
     * 수불부
     * @param param
     */
    @Async
    public void runRfc011(Map param){
    	try {
        	sqlSession.getMapper(SystemDao.class).merge_M_Material_inv_val(param);	
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateIfDone_M_InterfaceData(param);
	    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    }
    
    /**
     * 매출 마스터
     * @param param
     */
    @Async
    public void runRfc014(Map param){
    	
    	try {
        	sqlSession.getMapper(SystemDao.class).merge_M_Sales_Mst(param);	
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateIfDone_M_InterfaceData(param);
	    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    	
    }
    
    /**
     * 환급신청서 생성
     * @param param
     */
    @Async
    public void runRfc099(Map param){
    	
    	try {

	        /** 기간별 환급신청서 생성시 월단위 작업 리스트 추출 */
	        List workTarget_List = drwbService.retrieve_Drwbak_TargetMonthList(param);
	        
	        for(int inx = 0; inx < workTarget_List.size(); inx++) {
	        	Map rows = (Map)workTarget_List.get(inx);
	        	param.put("TARGET_MONTH", rows.get("TARGET_MONTH"));
	        	drwbService.createMonthly_StartEnd_logs(param, "DRWBAK_START");
	        	drwbService.confirm_DB006_xportList_extn2(param);
	        	drwbService.createMonthly_StartEnd_logs(param, "DRWBAK_END");
	        }
    	}catch (Exception e) {
			logger.debug(e.getMessage());
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);	
		}
    	
    }
    
    
    /**
     * 매각원장
     * @param param
     */
    @Async
    @Transactional
    public void runRfc020(Map param){
    	try {
    		
        	
			String callUrl = eaiCallUrl + "/restv2/AP_MM_06.Z_DUTY_RETURN_GI_SEND_INFO.api:restMMI0260_DUTY_RETURN_SAP/MMI0260";
			// 인증정보 URL에 붙여서 요청 함
			callUrl = callUrl + "?USER=DUTY_RETURN&PW=DUTY_RETURN!";
			Map<String, Object> bodyParam = new HashMap<String, Object>();
			/* 파라메터 Setting */
			bodyParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
			bodyParam.put("FROM_DATE", param.get("START_YYYYMMDD"));
			bodyParam.put("TO_DATE", param.get("END_YYYYMMDD"));
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
					row.putAll(param);
					sqlBatchSession.getMapper(SystemDao.class).insert_M_SalesLedgerInf(row); 
				}
				// 마스터 테이블로 데이터 이관
				sqlBatchSession.getMapper(SystemDao.class).merge_M_SalesLedge(param); 
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 인터페이스 테이블 데이터를 정리
			param.put("TARGET_TABLE_NAME", "SALES_LEDGER_INF");
			sqlBatchSession.getMapper(SystemDao.class).delete_M_InfTable(param); 
	    	param.put("STATUS_FLAG", "N");
	    	sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
	    	sqlBatchSession.flushStatements();
		}
    }
    
    
    /**
     * 분증 생성 프로시저 호출
     * @param param
     */
    @Async
    @Transactional
    public void runRfc097(Map param){
    	try {
    		/** 기간별 환급신청서 생성시 월단위 작업 리스트 추출 */
	        List workTarget_List = sqlSession.getMapper(SystemDao.class).retrieve_Ctrm_TargetMonthList(param);
	        
	        for(int inx = 0; inx < workTarget_List.size(); inx++) {
	        	Map rows = (Map)workTarget_List.get(inx);
	        	param.put("P_TARGET_MONTH", rows.get("TARGET_MONTH"));
	        	
	        	sqlSession.getMapper(SystemDao.class).callCreatePartialV2Procedure(param);
	        }
    		
        	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
		}
    }
    
    /**
     * 기초납입증명서(기납증) 생성 프로시저 호출
     * @param param
     */
    @Async
    @Transactional
    public void runRfc098(Map param){
    	try {
    		
    		/** 기간별 환급신청서 생성시 월단위 작업 리스트 추출 */
	        List workTarget_List = sqlSession.getMapper(SystemDao.class).retrieve_Ctrm_TargetMonthList(param);
	        
	        for(int inx = 0; inx < workTarget_List.size(); inx++) {
	        	Map rows = (Map)workTarget_List.get(inx);
	        	param.put("P_TARGET_MONTH", rows.get("TARGET_MONTH"));
	        	sqlSession.getMapper(SystemDao.class).callCreateInitialV2Procedure(param);	
	        }
    		
        	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			param.put("STATUS_FLAG", "N");
			sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
		}
    }
    

}