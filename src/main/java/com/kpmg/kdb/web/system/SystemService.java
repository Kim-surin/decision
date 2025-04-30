package com.kpmg.kdb.web.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class SystemService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(SystemService.class);
    
    
    @Value("${eai.call.url}")
    private String eaiCallUrl;
    
    @Autowired
    protected AsyncService asyncService;
    

    
    /**
     * GridOutputData 형태의 데이터를 리턴합니다.
     * 즉, 그리드 조회시 사용하게 됩니다.
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveInterfaceSch(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceSch(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    
    /**
     * 인터페이스 스케줄 관리 상세 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieveInterfaceDetailSch(Map<String, Object> param) throws Exception {
    	
    	return sqlSession.getMapper(SystemDao.class).retrieveInterfaceSch(param);
    }
    
    /**
     * 
     * 인터페이스 스케줄 Mapping List
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
   public GridOutputData<Map<String, Object>> retrieveInterfaceSchMapping(Map<String, Object> param) throws Exception{
    	
    	List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceSchMapping(param);
    	return this.gridProcessCommon(list, param);
    }
    
    
    /**
     * 인터페이스 스케줄 관리 상세 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveInterfaceItemMaster(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceItemMaster(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    
    /**
     * 인터페이스 스케줄 관리 상세 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveInterfaceItemDetail(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceItemDetail(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    
    
    /**
     * 인터페이스 이력 마스터 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveInterfaceHistoryMaster(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceHistoryMaster(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    /**
     * 인터페이스 스케줄 관리 상세 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieveInterfaceHistoryLayout(Map<String, Object> param) throws Exception {
    	
    	return sqlSession.getMapper(SystemDao.class).retrieveInterfaceHistoryLayout(param);
    }
    
    /**
     * 인터페이스 이력 상세 조회
     * 
     * @author D.Cat
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveInterfaceHistoryDetail(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveInterfaceHistoryDetail(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
        
    /**
	 * 스케줄 및 현황 > 스케줄 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
    public Result retrieveDataTransSchdule(Map<String, Object> param) throws Exception {
    	Result rs = new Result();
    	rs.setValue(sqlSession.getMapper(SystemDao.class).retrieveDataTransSchdule(param));
    	return rs;
    }
    
    
    
    
    /* D.Cat 추가 : 2019.02.18 **/
    
    public GridOutputData<Map<String, Object>> retrieveComAuthorGroupList(Map<String, Object> param){
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieveComAuthorGroupList(param);
    		gridData = this.gridProcessCommon(list, param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    /**
     * 권한그룹코드 저장
     * @param param
     * @return
     */
    public Result updateComAuthorGroup(Map param){
    	/*
    	 *  common.msg.saveok = 저장되었습니다.
    		common.msg.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		
    		//중복체크
    		int cnt = sqlSession.getMapper(SystemDao.class).retrieveDupAuthorGroupCode(param);
    		
    		
    		if(cnt > 0 && "I".equals(param.get("SAVE_STATUS"))) {
    			rs = super.getResult(false, "사용중인 권한그룹코드입니다.다른 권한그룹코드를 입력해주세요.", new Object[] {});
    			return rs;
    		}
    		
    		cnt = sqlSession.getMapper(SystemDao.class).updateComAuthorGroup(param);
    		if(cnt > 0) {
    			rs = super.getResult(true, "common.msg.saveok", new Object[] {});
    		}else {
    			rs = super.getResult(false, "common.msg.savefail", new Object[] {});
    		}
    		
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
    	
    	return rs;
    	
    }

    
    public Result retrieveExistsMenuList(Map param){
    	/*
    	 *  common.msg.saveok = 저장되었습니다.
    		common.msg.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
   		rs.setValue(sqlSession.getMapper(SystemDao.class).retrieveExistsMenuList(param));
    	
    	return rs;
    }
    
    /**
     * 권한그룹코드별 메뉴 저장
     * @param param
     * @return
     */
    @Transactional
    public Result changeAuthorMenuList(Map param){
    	/*
    	 *  common.msg.saveok = 저장되었습니다.
    		common.msg.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		int cnt = sqlSession.getMapper(SystemDao.class).deleteAuthorMenuList(param);
    		logger.debug("### 권한 메뉴 삭제 건수 : " + cnt);
    		
    		if(param.get("MENU_ID_LIST") !=null && ((List)param.get("MENU_ID_LIST")).size() > 0) {
	    		
	    		cnt = sqlSession.getMapper(SystemDao.class).changeAuthorMenuList(param);
	    		logger.debug("### 권한 메뉴 생성 건수 : " + cnt);
    		}
	    	
    		if(cnt > 0) {
    			rs = super.getResult(true, "common.msg.saveok", new Object[] {});
    		}else {
    			rs = super.getResult(false, "common.msg.savefail", new Object[] {});
    		}
    		
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
    	
    	return rs;
    }
    
    /**
     * 메뉴조회
     * @param param
     * @return
     */
    public Result retrieveSystemMenuList(Map param){
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> resultList =  sqlSession.getMapper(SystemDao.class).retrieveSystemMenuList(param);
    		if(resultList.size() > 0) {
    	    	List<Map> parentList = new ArrayList<Map>();
    			for (int inx = 0; inx < resultList.size(); inx++) {
    				Map rowMap = resultList.get(inx);
    				if (rowMap.get("PARENT_ID") == null) {
    					parentList.add(rowMap);
    				}
    			}
    			List<Map> lastList = new ArrayList<Map>();
    			for (int inx = 0; inx < parentList.size(); inx++) {
    				Map rowMap = parentList.get(inx);
    				List rowSubMenuList = new ArrayList<Map>();
    				for (int i = 0; i < resultList.size(); i++) {
    					Map sub_rowMap = resultList.get(i);
    					if ((String.valueOf(rowMap.get("ID"))).equalsIgnoreCase(String.valueOf(sub_rowMap.get("PARENT_ID")))) {
    						rowSubMenuList.add(sub_rowMap);
    					}
    				}
    				rowMap.put("SUB_MENU", rowSubMenuList);
    				lastList.add(rowMap);
    			}
    		
    			result.setSuccess(true);
    			result.setValue(lastList);
    		}else {
    			result.setSuccess(false);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return result;
    }

    /**
     * 메뉴 저장
     * @param param
     * @return
     */
    public Result updateSystemMenu(Map param) throws Exception {
    	
		Result rs = new Result();
		
		try {
			int result = sqlSession.getMapper(SystemDao.class).retrieveDupMenuId(param);
			
			if("I".equals(param.get("SAVE_STATUS"))  && result  > 0) {
				rs = super.getResult(false, "사용중인 MENU ID입니다.다른 ID를 사용해주세요.", new Object[] {});
				return rs;
			}
			
			
			rs.setValue(sqlSession.getMapper(SystemDao.class).updateSystemMenu(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
    	
    	return rs;
    }
    
    


    public GridOutputData<Map<String, Object>> retrieve_IncmeLocalBntHstry(Map<String, Object> param){
        
        GridOutputData gridData = null;
        try {
            List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieve_IncmeLocalBntHstry(param);
            gridData = this.gridProcessCommon(list, param);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return gridData;
    }
    
    /**
     * 인터페이스 마스터 조회
     * @param param
     * @return
     */
    public GridOutputData<Map<String, Object>> retrieve_interfaceMaster(Map<String, Object> param){
        
        GridOutputData gridData = null;
        try {
            List<Map<String, Object>> list = sqlSession.getMapper(SystemDao.class).retrieve_interfaceMaster(param);
            gridData = this.gridProcessCommon(list, param);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return gridData;
    }
    
    
    /**
     * 인터페이스 마스터 데이터 저장
     * @param param
     * @return
     */
    public Result update_interfaceMaster(Map param){
    	/*
    	 *  common.msg.saveok = 저장되었습니다.
    		common.msg.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		
    		int cnt = sqlSession.getMapper(SystemDao.class).update_interfaceMaster(param);
    		if(cnt > 0) {
    			rs = super.getResult(true, "common.msg.saveok", new Object[] {});
    		}else {
    			rs = super.getResult(false, "common.msg.savefail", new Object[] {});
    		}
    		
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
    	
    	return rs;
    }
    
    /**
     * 인터페이스 복원
     * @param param
     * @return
     */
    public Result update_interfaceMasterStatus(Map param){
    	/*
    	 *  common.msg.saveok = 저장되었습니다.
    		common.msg.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		
    		int cnt = sqlSession.getMapper(SystemDao.class).update_interfaceMasterStatus(param);
    		if(cnt > 0) {
    			rs = super.getResult(true, "common.msg.saveok", new Object[] {});
    		}else {
    			rs = super.getResult(false, "common.msg.savefail", new Object[] {});
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return rs;
    }
    
    public void updateInterfaceStatus(Map param){
    	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
    }
    

    @Async
    public Result runInterfaceItem(Map param){
    	Result rs = new Result();
    	try {
    		
    		int to_Do_InterfaceList_Count = 0;
    		param.put("FROM_DATE", param.get("START_YYYYMMDD"));
    		param.put("TO_DATE", param.get("END_YYYYMMDD"));
			
    		String if_code = StringUtil.null2String(param.get("IF_CODE"));
    		if("RFC001".equalsIgnoreCase(if_code)) { //	고객사마스터
    			param.put("TARGET_COL", "CREATE_DATE");
    			param.put("TARGET_TABLE_NAME", "CUSTOMER_INF");
    			asyncService.runRfc001(param);
    		} else if("RFC002".equalsIgnoreCase(if_code)) { //	자재마스터
    			param.put("TARGET_COL", "CREATE_DATE");
    			param.put("TARGET_TABLE_NAME", "ITEM_MST_INF");
    			asyncService.runRfc002(param);
    		} else if("RFC015".equalsIgnoreCase(if_code)) { //	매출상세
    			param.put("TARGET_COL", "INVOICE_DATE");
    			param.put("TARGET_TABLE_NAME", "SALES_MST_INF");
    			to_Do_InterfaceList_Count = sqlSession.getMapper(SystemDao.class).retrieve_M_Count_TargetTable(param);
    			if(to_Do_InterfaceList_Count > 0 ){
    				param.put("TARGET_TABLE_NAME", "SALES_DTL_INF");
    				asyncService.runRfc015(param);	
    			}
    			
    		} else if("RFC007".equalsIgnoreCase(if_code)) { //	구매원장
    			param.put("TARGET_TABLE_NAME", "PO_LEDGER_INF");
    			asyncService.runRfc007(param);
    		} else if("RFC010".equalsIgnoreCase(if_code)) { //	환급BOM
    			param.put("TARGET_COL", "BOM_VERSION");
    			param.put("TARGET_TABLE_NAME", "RESULT_BOM_AP_INF");
    			to_Do_InterfaceList_Count = sqlSession.getMapper(SystemDao.class).retrieve_M_Count_TargetTable(param);
    			if(to_Do_InterfaceList_Count > 0 ){
    				asyncService.runRfc010(param);
    			}
    		} else if("RFC004".equalsIgnoreCase(if_code)) { //	공급업체
    			param.put("TARGET_COL", "CREATE_DATE");
    			param.put("TARGET_TABLE_NAME", "VENDOR_INF");
    			asyncService.runRfc004(param);
    		} else if("RFC011".equalsIgnoreCase(if_code)) { //	원재료수불부
    			param.put("TARGET_COL", "YYYYMM||'01'");
    			param.put("TARGET_TABLE_NAME", "MATERIAL_INV_BAL_INF");
    			to_Do_InterfaceList_Count = sqlSession.getMapper(SystemDao.class).retrieve_M_Count_TargetTable(param);
    			if(to_Do_InterfaceList_Count > 0 ){
    				asyncService.runRfc011(param);
    			}
    		} else if("RFC014".equalsIgnoreCase(if_code)) { //	매출마스터
    			param.put("TARGET_COL", "INVOICE_DATE");
    			param.put("TARGET_TABLE_NAME", "SALES_MST_INF");
    			to_Do_InterfaceList_Count = sqlSession.getMapper(SystemDao.class).retrieve_M_Count_TargetTable(param);
    			if(to_Do_InterfaceList_Count > 0 ){
    				asyncService.runRfc014(param);
    			}
    		} else if("RFC020".equalsIgnoreCase(if_code)) { //	매각원장
    			
    			param.put("TARGET_COL", "CREATE_DATE");
    			param.put("TARGET_TABLE_NAME", "SALES_LEDGER_INF");
    			asyncService.runRfc020(param);
    	        
    	        
    		}else if("RFC099".equalsIgnoreCase(if_code)) { //	환급신청서 생성
    			
    			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
    	        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.use.log"));
    	        param.put("logEnable_Flag", logEnable_Flag);
    	        asyncService.runRfc099(param);    	        
    	        
    		}else if("RFC097".equalsIgnoreCase(if_code)) { //	분증 생성
    			param.put("P_TARGET_MONTH", param.get("CAL_F_CTRM_SEARCH_DATE"));
    			
    			asyncService.runRfc097(param);
    		}else if("RFC098".equalsIgnoreCase(if_code)) { //	기납증 생성 생성
    			param.put("P_TARGET_MONTH", param.get("CAL_F_CTRM_SEARCH_DATE"));
    			asyncService.runRfc098(param);
    		}
    		
    		rs.setSuccess(true);
    		rs.setMessage("인터페이스 수행을 요청하였습니다.");
    	} catch (Exception e) {
    		e.printStackTrace();
    		rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return rs;
    }
    
    /**
     * 고객사 마스터 
     * @param param
     */
    @Async
    public void runRfc001(Map param) {
    	
    	try {
    		param.put("STATUS_FLAG", "Y");
        	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
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
    		
    		param.put("STATUS_FLAG", "Y");
    		sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
        	
        	
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
    		param.put("STATUS_FLAG", "Y");
        	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
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
    		
    		param.put("STATUS_FLAG", "Y");
    		sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
        	
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
    		param.put("STATUS_FLAG", "Y");
        	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
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
    		param.put("STATUS_FLAG", "Y");
    		sqlBatchSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
        	
        	
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
    		param.put("STATUS_FLAG", "Y");
        	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
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
    		param.put("STATUS_FLAG", "Y");
        	sqlSession.getMapper(SystemDao.class).updateInterfaceStatus(param);
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
     * 인터페이스 수행 가능 여부 체크
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieveInterfaceRunCheck(Map<String, Object> param) throws Exception {
    	return sqlSession.getMapper(SystemDao.class).retrieveInterfaceRunCheck(param);
    }
    
    

}