package com.kpmg.kdb.web.ts.basis;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.testcode.SpringTestDao;




@Service
@SuppressWarnings({ "rawtypes" })
public class BasisService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(BasisService.class);
    
    public Result dbTest(Map<String, Object> param) throws Exception {
    	
    	Result result = new Result();
    	Map resultMap = sqlSession.getMapper(BasisDao.class).start_TestSql(param);
    	result.setValue(resultMap);
    	System.out.println(resultMap);
        return result;
    }
    
    
    /**
     * 회사관리 - 왼쪽 트리 목록 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCompanyDivisionList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(BasisDao.class).retrieveCompanyDivisionList(param);
    		
    		List<Map<String, Object>> rst = new ArrayList<>();
    	    Map<String, Map<String, Object>> companyMap = new LinkedHashMap<>();

    	    int companyIndex = 0;
    	    int divisionIndex = 1;

    	    for (Map<String, Object> row : list) {
    	        String companyCode = (String) row.get("company_code");

    	        Map<String, Object> companyNode = companyMap.get(companyCode);

    	        if (companyNode == null) {
    	            companyNode = new LinkedHashMap<>();

    	            companyNode.put("company_code", companyCode);
    	            companyNode.put("company_name", (String) row.get("company_name"));
    	            companyNode.put("children", new ArrayList<Map<String, Object>>());

    	            companyMap.put(companyCode, companyNode);
    	            rst.add(companyNode);
    	        }

    	        if (row.get("division_code") != null) {
    	            Map<String, Object> divisionNode = new LinkedHashMap<>();
    	            String divisionUid = "T" + divisionIndex++;

    	            divisionNode.put("company_code", (String) row.get("division_code"));
    	            divisionNode.put("company_name", (String) row.get("division_name"));

    	            List<Map<String, Object>> children = (List<Map<String, Object>>) companyNode.get("children");
    	            children.add(divisionNode);
    	        }
    	    }
    		
    		result.setValue(rst);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 회사관리 - 회사 또는 플렌트 1건 정보 조회 (폼데이터 용)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCompanyDivisionFormData(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		Map<String, Object> formData = null;
    		
    		
    		if("COMPANY".equalsIgnoreCase((String)param.get("search_type"))) {
    			param.put("p_param_code", param.get("COMPANY_CODE"));
    			formData = sqlSession.getMapper(BasisDao.class).retrieveCompanyFormData(param);
    		}else {
    			
    			param.put("p_param_code", param.get("COMPANY_CODE"));
    			formData = sqlSession.getMapper(BasisDao.class).retrieveDivisionFormData(param);
    		}
    				
    				
    		
    		result.setValue(formData);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    
    
    /**
     * 회사관리 - 회사 또는 플렌트 1건 정보 조회 (폼데이터 용)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveBufferDatalist(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list = null;
    		//회사 버퍼 설정 기준 값
    		String bf_company_option = (String)param.get("p_bf_company_option");
    		
    		
    		if("COM".equalsIgnoreCase(bf_company_option)) {

    			list = sqlSession.getMapper(BasisDao.class).retrieveBufferFromCompany(param);
    			
    		}else if("DIV".equalsIgnoreCase(bf_company_option)) {
    			
    			list = sqlSession.getMapper(BasisDao.class).retrieveBufferFromDivision(param);
    			
    		}else if("FTA".equalsIgnoreCase(bf_company_option)) {
    			
    			list = sqlSession.getMapper(BasisDao.class).retrieveBufferFromFTA(param);
    		}
    				
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
        
}
