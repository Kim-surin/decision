package com.kpmg.kdb.web.batch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorException;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

import com.kpmg.kdb.util.StringUtil;



/**
 * 시스템 배치 구현 Class
 * @author 망할고양이
 *
 */
@Service("InterfaceCronJobService")
@SuppressWarnings({ "rawtypes" })
public class InterfaceCronJobService extends GeneralService {

	@Autowired
	InterfaceService service;
	
    static Logger logger = LoggerFactory.getLogger(InterfaceCronJobService.class);
	/*
	 * 
	 * @Autowired protected RfcWorkerService rfcService;
	 */
    private StopWatch stopWatch;
    
    public InterfaceCronJobService() {	
    	stopWatch = new StopWatch();
    }

     
    public void interfaceBatchJob() {
    	
    	logger.debug("================= 일배치가 수행되었습니다. ================================");
		
		//stopWatch.start();
    	try {
    		
    		Map<String, Object> paramMap = new HashMap();
    		List<Map<String, Object>> companyList =  sqlSession.getMapper(InterfaceDao.class).retrieveBatchCompanyList(paramMap);
    		
    		for(int inx = 0; inx < companyList.size(); inx++) {
    			Map row = companyList.get(inx);
    			logger.debug("#### create Item Master 배치를 수행합니다. ");
    			this.createItemMstData(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### create Vendor 배치를 수행합니다. ");
    			this.createItemVendor(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### create Customer 배치를 수행합니다. ");
    			this.createCustomer(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### create Sales 배치를 수행합니다. ");
    			this.createSalesData(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### create po ledger 배치를 수행합니다. ");
    			this.createPoledger(row.get("COMPANY_CODE")+"");
    			
    			logger.debug("#### create Result Bom 배치를 수행합니다. ");
    			this.createResultBom(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### createMaterial_Inv_Bal 배치를 수행합니다. ");
    			this.createMaterial_Inv_Bal(row.get("COMPANY_CODE")+"");	
    			
    			logger.debug("#### create Sales_Ledger 배치를 수행합니다. ");
    			this.createSalesLedgerData(row.get("COMPANY_CODE")+"");	
    			
    		}
    		//stopWatch.stop();
			logger.debug("==================일배치 정상 종료  ::: " + stopWatch.getTotalTimeMillis()*1000 + "(초)");

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
			
		}finally {
			System.out.println("==================배치수행 완료 =======================================");
		}
    }
    
    
    
    /**
     * 수불부 데이터를 인터페이스 합니다. 
     * Material_inv_bal_inf table로 부터 데이터를  Material_inv_bal로 이관합니다. 
     * merge into를 수행한다. 
     * 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createMaterial_Inv_Bal(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "MATERIAL_INV_BAL_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	
    	// 인터페이스 할 물량이 있는지 확인 
    	int to_Do_InterfaceList_Count = service.retrieveCount_TargetTable(paramMap);
    	
    	int call_InterfaceCount = 0;
    	
    	if(to_Do_InterfaceList_Count > 0 ){
    		//수불부 인터페이스 수행
    		call_InterfaceCount = service.merge_Material_inv_val(paramMap);
    		//작업된 내역에 대해서 inf 데이터 완료처리 수행
    		service.updateIfDone_InterfaceData(paramMap);
    	}
    	rs.setMessage(call_InterfaceCount + "건 - 수불부 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    
    /**
     * 매출 데이터를 인터페이스 합니다. 
     * SALES_MST_INF, SALES_DTL_INF table로 부터 데이터를  SALES_MST, SALES_DTL로 이관합니다. 
     * merge into를 수행한다. 
     * 
     * @return Result
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createSalesData(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "SALES_MST_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	
    	// 인터페이스 할 물량이 있는지 확인 
    	int to_Do_InterfaceList_Count = service.retrieveCount_TargetTable(paramMap);
    	
    	int call_InterfaceMstCount = 0;
    	int call_InterfaceDtlCount = 0;
    	
    	if(to_Do_InterfaceList_Count > 0 ){
    		//수불부 인터페이스 수행
    		call_InterfaceMstCount = service.merge_Sales_Mst(paramMap);
    		call_InterfaceDtlCount = service.merge_Sales_Dtl(paramMap);
    		//작업된 내역에 대해서 inf 데이터 완료처리 수행
    		service.updateIfDone_InterfaceData(paramMap);
    		paramMap.put("TARGET_TABLE_NAME", "SALES_DTL_INF");
    		service.updateIfDone_InterfaceData(paramMap);
    	}
    	rs.setMessage(call_InterfaceMstCount + " / " + call_InterfaceMstCount + " 건 - 매출(마스터/상세) 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    /**
     * 고객사 데이터를 인터페이스 합니다. 
     * CUSTOMER_INF TABLE로 부터 데이터를  CUSTOMER로 이관합니다. 
     * MERGE INTO를 수행한다. 
     * 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createCustomer(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "CUSTOMER_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	
    	// 인터페이스 할 물량이 있는지 확인 
    	int to_Do_InterfaceList_Count = service.retrieveCount_TargetTable(paramMap);
    	
    	int call_InterfaceCount = 0;
    	
    	if(to_Do_InterfaceList_Count > 0 ){
    		//수불부 인터페이스 수행
    		call_InterfaceCount = service.merge_Customer(paramMap);
    		//작업된 내역에 대해서 inf 데이터 완료처리 수행
    		service.updateIfDone_InterfaceData(paramMap);
    	}
    	rs.setMessage(call_InterfaceCount + "건 - 고객사 마스터 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    /**
     * BOM 데이터를 인터페이스 합니다. 
     * RESULT_BOM_AP_INF TABLE로 부터 데이터를  RESULT_BOM_AP로 이관합니다. 
     * MERGE INTO를 수행한다. 
     * 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createResultBom(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "RESULT_BOM_AP_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	
    	// 인터페이스 할 물량이 있는지 확인 
    	int to_Do_InterfaceList_Count = service.retrieveCount_TargetTable(paramMap);
    	
    	int call_InterfaceCount = 0;
    	
    	if(to_Do_InterfaceList_Count > 0 ){
    		//수불부 인터페이스 수행
    		call_InterfaceCount = service.merge_Result_Bom_Ap(paramMap);
    		//작업된 내역에 대해서 inf 데이터 완료처리 수행
    		service.updateIfDone_InterfaceData(paramMap);
    	}
    	rs.setMessage(call_InterfaceCount + "건 - BOM 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    /**
     * 아이템 마스터 데이터를 인터페이스 합니다. 
     * Restful API 호출 후 INF에 적재 후 마스터 테이블로 이관을 수행
     * Insert / Merge into를 수행한다. 
     * 
     * @return Result
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createItemMstData(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "ITEM_MST_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	int call_InterfaceCount  = service.call_RestfulAPI_ItemMst(paramMap);
    	
    	rs.setMessage(call_InterfaceCount + "건 - 아이템 마스터 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    /**
     * 공급업체 마스터 데이터를 인터페이스 합니다. 
     * Restful API 호출 후 INF에 적재 후 마스터 테이블로 이관을 수행
     * Insert / Merge into를 수행한다. 
     * 
     * @return Result
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createItemVendor(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "VENDOR_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	int call_InterfaceCount  = service.call_RestfulAPI_Vendor(paramMap);
    	
    	rs.setMessage(call_InterfaceCount + "건 - 공급업체 마스터 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    
    /**
     * 구매원장 데이터를 인터페이스 합니다. 
     * Restful API 호출 후 INF에 적재 후 마스터 테이블로 이관을 수행
     * Insert / Merge into를 수행한다. 
     * 
     * @return Result
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createPoledger(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "PO_LEDGER_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	int call_InterfaceCount  = service.call_RestfulAPI_Poledger(paramMap);
    	
    	rs.setMessage(call_InterfaceCount + "건 - 구매원장 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
    
    /**
     * 매각원장 데이터를 인터페이스 합니다. 
     * @param tgt_company_code
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public Result createSalesLedgerData(String tgt_company_code) throws Exception{
    	
    	Result rs = new Result();
    	Map<String, Object> paramMap = new HashMap();
    	
    	// 인터페이스를 위한 파라메터 설정
    	paramMap.put("TARGET_TABLE_NAME", "ITEM_MST_INF");
    	paramMap.put("COMPANY_CODE", tgt_company_code);
    	
    	int call_InterfaceCount  = service.call_RestfulAPI_SalesLedger(paramMap);
    	
    	rs.setMessage(call_InterfaceCount + "건 - 매각원장 인터페이스 수행되었습니다.");
    	rs.setSuccess(true);
     	
    	
		return rs;
    }
}
