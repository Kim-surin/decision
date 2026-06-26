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
	 * 회사관리 - 회사 또는 플렌트 1건 데이터 update
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateCompanyDivisionFormData(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		int resultCount = 0;
    		
    		
    		if("COMPANY".equalsIgnoreCase((String)param.get("search_type"))) {
    			resultCount = sqlSession.getMapper(BasisDao.class).updateCompanyFormData(param);
    		}else {
    			resultCount = sqlSession.getMapper(BasisDao.class).updateDivisionFormData(param);
    		}
    				
    		
    		if(resultCount > 0) {
    			result.setSuccess(true);
        		result.setMessage(DEFAULT_MESSAGE_OK);	
    		}else {
    			result.setSuccess(false);
        		result.setMessage(DEFAULT_MESSAGE_ERROR);
    		}
    				
    		
    		result.setValue(resultCount);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
	 * 회사관리 - 인증수출자 정보 저장
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateCertificationInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		int resultCount = sqlSession.getMapper(BasisDao.class).updateCertificationInfo(param);
    		
    		if(resultCount > 0) {
    			result.setSuccess(true);
    			result.setMessage(DEFAULT_MESSAGE_OK);	
    		}else {
    			result.setSuccess(false);
    			result.setMessage(DEFAULT_MESSAGE_ERROR);
    		}
    		
    		
    		result.setValue(resultCount);
    		
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
    
    
    /**
     * 회사관리 - 회사 또는 플렌트 1건 정보 조회 (폼데이터 용)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateCompanyBuffer(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		int resultCount = 0;
    		//회사 버퍼 설정 기준 값
    		String bf_company_option = (String)param.get("bf_company_option");
    		 
    		/* Grid Data */
    		List<Map<String, Object>> settingValueList = (List)param.get("buffer_setting_value");
    		
    		/*회사관리 - 회사버퍼 옵션 정보 저장*/
    		param.put("option_code", "BF"); // 회사 버퍼 설정
    		param.put("option_value", bf_company_option);
    		resultCount = sqlSession.getMapper(BasisDao.class).updateCompanyOptionValue(param);
 
    		for(int inx = 0; inx < settingValueList.size(); inx++) {
    			Map rowMap = settingValueList.get(inx);
    			
    			rowMap.put("company_code", param.get("company_code"));
    			rowMap.put("option_code", param.get("option_code")); // 회사 버퍼 설정 
    			
    			switch (bf_company_option.toUpperCase()) {
		    	    case "COM":
		    	    	//회사관리 - 회사버퍼 정보 저장
		    	        resultCount += sqlSession.getMapper(BasisDao.class).updateCompanyBuffer(rowMap);
		    	        break;
		    	    case "DIV":
		    	    	//회사관리 - 플랜트 버퍼 정보 저장
		    	        resultCount += sqlSession.getMapper(BasisDao.class).updateDivisionBuffer(rowMap);
		    	        break;
		    	    case "FTA":
		    	    	//회사관리 - FTA 협정 버퍼 정보 저장
		    	        resultCount += sqlSession.getMapper(BasisDao.class).updateAgreementBuffer(rowMap);
		    	        break;
		    	    default:
		    	        throw new IllegalArgumentException("지원하지 않는  회사버퍼 옵션입니다: " + bf_company_option);
    			}
    		}
    		

    		
    		result.setValue(resultCount);
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
    public Result updateCompanyMaOptionValue(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		int resultCount = 0;
    		//회사 옵션정보 설정
    		resultCount = sqlSession.getMapper(BasisDao.class).updateCompanyMaOption(param);
    		resultCount += sqlSession.getMapper(BasisDao.class).updateCompanyOptionValue(param);

    		
    		result.setValue(resultCount);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 회사관리 - 회사 옵션 정보 저장
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateCompanyOptionValue(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		int resultCount = 0;
    		//회사 옵션정보 설정
    		resultCount = sqlSession.getMapper(BasisDao.class).updateCompanyOptionValue(param);

    		
    		result.setValue(resultCount);
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
    public Result retrieveUserinfoList(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(BasisDao.class).retrieveUserinfoList(param);
    		//회사 버퍼 설정 기준 값
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 서명파일 이미지 조회 img src 용도 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<String, Object> getSignatureByUserId(Map<String, Object> param){
    	
    	Map<String, Object> returnMap = null;
    	try {
    		returnMap = sqlSession.getMapper(BasisDao.class).getSignatureByUserId(param);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return returnMap;
    }
    
    
    

    /**
     * 사용자관리 - 사용자 상세
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveUserinfoDetail(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		Map<String, Object> resultMap = sqlSession.getMapper(BasisDao.class).retrieveUserinfoDetail(param);
    		//회사 버퍼 설정 기준 값
    		result.setValue(resultMap);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
        
}
