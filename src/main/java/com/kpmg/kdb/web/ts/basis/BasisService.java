package com.kpmg.kdb.web.ts.basis;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.ExcelUtil;
import com.kpmg.kdb.util.FileUtil;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.web.refundbasis.RefundBasisDao;
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
        
    
    /**
     * 사용자관리 - 서명권자 정보
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveSignatureInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		Map<String, Object> resultMap = sqlSession.getMapper(BasisDao.class).retrieveSignatureInfo(param);
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
    
    
    /**
	 * 엑셀업로드 여러달 업로드 가능한 버전
	 * @param param
	 * @param file
	 * @return
	 */
	@Transactional
    public Result saveUserSignatureInfo(Map<String, Object> param, MultipartFile file) {
		
		Result result = new Result();
		
		try {
			
			String userId = param.get("user_id") == null ? "" : String.valueOf(param.get("user_id")).trim();
	        String empNo = param.get("emp_no") == null ? "" : String.valueOf(param.get("emp_no")).trim();
	        String password = param.get("password") == null ? "" : String.valueOf(param.get("password")).trim();
	        String passwordConfirm = param.get("password_confirm") == null ? "" : String.valueOf(param.get("password_confirm")).trim();
	        
	        String seq = param.get("seq") == null ? "" : String.valueOf(param.get("seq")).trim();
	        
	        String signFileName = "";
	        String signFilePath = "";

	        
	        // 필수값 체크
	        if (userId.isEmpty()) {
	            throw new IllegalArgumentException("사용자ID는 필수입니다.");
	        }

	        if (empNo.isEmpty()) {
	            throw new IllegalArgumentException("사원번호는 필수입니다.");
	        }

	        // 사용자 신규/수정 판별
	        int userCnt = sqlSession.getMapper(BasisDao.class).selectUserCount(param);
	        boolean isNewUser = (userCnt == 0);

	     // 비밀번호 체크
	        if (isNewUser) {
	            if (password.isEmpty()) {
	                throw new IllegalArgumentException("신규 사용자는 비밀번호가 필수입니다.");
	            }
	            if (passwordConfirm.isEmpty()) {
	                throw new IllegalArgumentException("비밀번호 확인은 필수입니다.");
	            }
	            if (!password.equals(passwordConfirm)) {
	                throw new IllegalArgumentException("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	            }
	        } else {
	            if (!password.isEmpty() || !passwordConfirm.isEmpty()) {
	                if (!password.equals(passwordConfirm)) {
	                    throw new IllegalArgumentException("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	                }
	            }
	        }
	        
	        if (isNewUser) {
	            sqlSession.getMapper(BasisDao.class).insertUserInfo(param);
	        } else {
	        	sqlSession.getMapper(BasisDao.class).updateUserInfo(param);
	        }
	        
	        
	        // 4. 서명 처리 여부 판단
	        boolean hasSignatureSection = hasSignatureData(param, file);
	        
	        if (hasSignatureSection) {
	        	// 5. 서명 신규/수정 저장
	            saveSignature(param, seq);

	            // 6. 파일이 있으면 이미지 업데이트
	            if (file != null && !file.isEmpty()) {
	                saveSignatureFile(param, file);
	            }
	        }
	        result.setSuccess(true);
	        result.setMessage("저장되었습니다.");
	        
		} catch (IllegalArgumentException e) {
	        result.setSuccess(false);
	        result.setMessage(e.getMessage());
	        return result;
	    } catch (Exception e) {
	        result.setSuccess(false);
	        result.setMessage("저장 처리 중 오류가 발생했습니다.");
	        throw new RuntimeException(e);
	    }
		
		return result;
	}
	
	private boolean hasSignatureData(Map<String, Object> param, MultipartFile file) {
	    String seq = param.get("seq") == null ? "" : String.valueOf(param.get("seq")).trim();
	    String startDate = param.get("start_date") == null ? "" : String.valueOf(param.get("start_date")).trim();
	    String endDate = param.get("end_Date") == null ? "" : String.valueOf(param.get("end_Date")).trim();
	    String remark = param.get("remark") == null ? "" : String.valueOf(param.get("remark")).trim();

	    return !seq.isEmpty()
	            || !startDate.isEmpty()
	            || !endDate.isEmpty()
	            || !remark.isEmpty()
	            || (file != null && !file.isEmpty());
	}
	
	private void saveSignature(Map<String, Object> param, String seq) {
	    param.put("signature_name", param.get("name_kor"));
	    param.put("department_name", param.get("dept_name"));
	    param.put("position", param.get("position_name"));

	    int signatureCount = 0;
	    if (!seq.isEmpty()) {
	        signatureCount = sqlSession.getMapper(BasisDao.class).selectSignatureCount(param);
	    }

	    boolean isNewSignature = (signatureCount == 0);

	    if (isNewSignature) {
	        int nextSeq = sqlSession.getMapper(BasisDao.class).selectNextSignatureSeq(param);
	        param.put("seq", nextSeq);
	        sqlSession.getMapper(BasisDao.class).insertSignatureInfo(param);
	    } else {
	        sqlSession.getMapper(BasisDao.class).updateSignatureInfo(param);
	    }
	}
	
	private void saveSignatureFile(Map<String, Object> param, MultipartFile file) throws Exception {
	    if (!FileUtil.isImageFile(file)) {
	        throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
	    }

	    param.put("sign_file_name", file.getOriginalFilename());
	    param.put("real_file", file.getBytes());

	    sqlSession.getMapper(BasisDao.class).updateSignatureImage(param);
	}
	
	/**
	 * 사용자 중복 체크
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result checkDuplicateUserId(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		int userCount = sqlSession.getMapper(BasisDao.class).checkDuplicateUserId(param);
    		//회사 버퍼 설정 기준 값
    		result.setValue(userCount);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
     * 서명권자 해지
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result cancelUserSignatureInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		int resultCount = sqlSession.getMapper(BasisDao.class).cancelUserSignatureInfo(param);
    		//회사 버퍼 설정 기준 값
    		result.setValue(resultCount);
    		if(resultCount > 0) {
        		result.setSuccess(true);
        		result.setMessage(DEFAULT_MESSAGE_OK);    			
    		}else {
        		result.setSuccess(false);
        		result.setMessage(DEFAULT_MESSAGE_ERROR);
    		}

    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    
    /**
	 * 자재관리 - 목록조회
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveItemList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(BasisDao.class).retrieveItemList(param);
    		
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
    public Result retrieveMissingHsCodeCount(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(BasisDao.class).retrieveMissingHsCodeCount(param);
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
}
