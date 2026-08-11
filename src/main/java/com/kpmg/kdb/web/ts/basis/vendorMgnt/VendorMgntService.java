package com.kpmg.kdb.web.ts.basis.vendorMgnt;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.ts.ftaInfo.ftaIncoterms.FtaIncotermsDao;
import com.kpmg.kdb.web.ts.ftaInfo.ftaInfoMgnt.FtaInfoDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class VendorMgntService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(VendorMgntService.class);
    
    /**
     *  기초 정보 관리 > 협력업체 > 리스트 조회(Vendor)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveVendorList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(VendorMgntDao.class).retrieveVendorList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *  기초 정보 관리 > 협력업체 > 리스트 조회(Vendor 담당자)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveVendorInChargeList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(VendorMgntDao.class).retrieveVendorInChargeList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     *기초 정보 관리 > 협력업체 > 협력업체 정보저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateVendorData(Map<String, Object> param){
    	Result result = new Result();
    	int resultCnt = 0;
    	
    	try {
    		result.setValue(sqlSession.getMapper(VendorMgntDao.class).updateVendorData(param));
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
     *  기초 정보 관리 > 협력업체 > 협력업체 담당자 정보 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveVendorInchargeList(Map<String, Object> param){
    	Result result = new Result();
    	int resultCnt = 0;
    	
    	try {
    		List saveList = (List)param.get("SAVE_LIST");
    		Map selMaster = (Map)param.get("SEL_MASTER");
    		
    		for(Object obejctMap : saveList) {
    			Map<String, Object> saveMap = (Map<String, Object>) obejctMap;
    			saveMap.put("company_code", param.get("company_code"));
    			saveMap.put("update_by", param.get("update_by"));
    			saveMap.put("vendorCode", selMaster.get("vc_code"));
    			
    			if("a".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(VendorMgntDao.class).insertVendorIncharge(saveMap);
    			}else if("e".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(VendorMgntDao.class).updateVendorIncharge(saveMap); 
    			}else if("r".equals(saveMap.get("state"))) {
    				resultCnt += sqlSession.getMapper(VendorMgntDao.class).deleteVendorIncharge(saveMap);
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
     *  기초 정보 관리 > 협력업체 > 리스트 조회(Customer)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCustomerList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		result.setValue(sqlSession.getMapper(VendorMgntDao.class).retrieveCustomerList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 기초 정보 관리 > 협력업체 > 리스트 조회(Customer) > 협력업체 정보저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateCustomerData(Map<String, Object> param){
    	Result result = new Result();
    	int resultCnt = 0;
    	
    	try {
    		result.setValue(sqlSession.getMapper(VendorMgntDao.class).updateCustomerData(param));
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