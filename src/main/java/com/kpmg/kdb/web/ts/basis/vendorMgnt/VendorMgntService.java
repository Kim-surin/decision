package com.kpmg.kdb.web.ts.basis.vendorMgnt;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
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
    
    
}