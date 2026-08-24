package com.kpmg.kdb.web.ts.individualCooTarget;

import java.util.ArrayList;
import java.util.HashMap;
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



@Service
@SuppressWarnings({ "rawtypes" })
public class IndividualCootargetService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(IndividualCootargetService.class);
    
    
    /**
	 * 확인서 수취대상 관리 조회 
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveIndividualCootargetList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IndividualCootargetDao.class).retrieveIndividualCootargetList(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional
    public Result deleteExtCooCertifyFile(Map<String, Object> param) {

        Result result = new Result();

        try {

            IndividualCootargetDao dao =
                    sqlSession.getMapper(IndividualCootargetDao.class);

            int deleteCount =
                    dao.deleteExtCooCertifyFile(param);

            if (deleteCount > 0) {

                result.setValue(deleteCount);
                result.setSuccess(true);
                result.setMessage(DEFAULT_MESSAGE_OK);

            } else {

                result.setValue(0);
                result.setSuccess(false);
                result.setMessage("삭제할 첨부파일이 없습니다.");
            }

        } catch (Exception e) {

            logger.error("deleteExtCooCertifyFile error", e);

            throw new RuntimeException(e);
        }

        return result;
    }
    
    /**
	 * 확인서 수취율 대시보드 조회 
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveIndividualCootargetDashboard(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IndividualCootargetDao.class).retrieveIndividualCootargetDashboard(param);
    		
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
	 * 확인서 수취율 팝업 조회 
	 * @param param
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveIndividualCootargetPopup(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IndividualCootargetDao.class).retrieveIndividualCootargetPopup(param);
    		
    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveIndividualCootargetRule(Map<String, Object> param){

        Result result = new Result();

        try {
            List<Map<String, Object>> list =
                sqlSession.getMapper(IndividualCootargetDao.class).retrieveIndividualCootargetRule(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result checkIndividualCootargetDuplicate(Map<String, Object> param) {

    	Result result = new Result();

    	try {

    		int duplicate = sqlSession.getMapper(IndividualCootargetDao.class).checkIndividualCootargetDuplicate(param);

    		result.setValue(duplicate);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);

    	} catch (Exception e) {
    		e.printStackTrace();
    		result.setSuccess(false);
    	}

    	return result;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional
    public Result insertExtCooCertify(Map<String, Object> param) {

        Result result = new Result();

        try {

            IndividualCootargetDao dao = sqlSession.getMapper(IndividualCootargetDao.class);

            List<MultipartFile> files =
                    (List<MultipartFile>) param.get("FILEUP_LIST");

            /* 파일 필수 */
            if (files == null || files.isEmpty()) {
                result.setSuccess(false);
                result.setMessage("파일을 첨부해주세요.");
                return result;
            }

            boolean hasFile = false;

            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    hasFile = true;
                    break;
                }
            }

            if (!hasFile) {
                result.setSuccess(false);
                result.setMessage("파일을 첨부해주세요.");
                return result;
            }

            /* 선택 데이터 확인 */
            List<Map<String, Object>> gridData =
                    (List<Map<String, Object>>) param.get("gridData");

            if (gridData == null || gridData.isEmpty()) {
                result.setSuccess(false);
                result.setMessage("등록할 자재를 선택해주세요.");
                return result;
            }

            /* 수동 증명번호 기등록 여부 확인 */
            if (!"true".equals(String.valueOf(param.get("AUTO_COO_CERTIFY_NO")))) {

                int duplicate = dao.checkIndividualCootargetDuplicate(param);

                if (duplicate > 0) {
                    result.setSuccess(false);
                    result.setMessage("이미 등록된 원산지증명번호입니다.");
                    return result;
                }
            }

            /* 자동채번 */
            if ("true".equals(String.valueOf(param.get("AUTO_COO_CERTIFY_NO")))) {

                param.put("AUTO_COO_YN", "Y");

                String cooCertifyNo = dao.selectCooCertifyNoGet(param);

                param.put("COO_CERTIFY_NO", cooCertifyNo);

            } else {

                param.put("AUTO_COO_YN", "N");
            }

            param.put("CREATE_BY", param.get("USER_ID"));
            param.put("UPDATE_BY", param.get("USER_ID"));

            /* MST 저장 */
            dao.insertExtCooCertifyMst(param);

            /* DTL 저장 */
            for (Map<String, Object> row : gridData) {

                row.put("COMPANY_CODE", param.get("COMPANY_CODE"));
                row.put("PARAM_DIVISION_CODE", param.get("PARAM_DIVISION_CODE"));
                row.put("PARAM_VENDOR_CODE", param.get("PARAM_VENDOR_CODE"));

                row.put("COO_CERTIFY_NO", param.get("COO_CERTIFY_NO"));
                row.put("COO_CERTIFY_TYPE", param.get("COO_CERTIFY_TYPE"));
                row.put("ISSUE_DATE", param.get("ISSUE_DATE"));

                row.put("USER_ID", param.get("USER_ID"));
                row.put("CREATE_BY", param.get("USER_ID"));
                row.put("UPDATE_BY", param.get("USER_ID"));

                dao.insertExtCooCertifyDtl(row);
            }

            /* PO_LEDGER 수정 */
            dao.updatePoLedger(param);

            /* 첨부파일 다중 저장 */
            for (MultipartFile file : files) {

                if (file == null || file.isEmpty()) {
                    continue;
                }

                Map<String, Object> fileMap = new HashMap<String, Object>();

                fileMap.put("COMPANY_CODE", param.get("COMPANY_CODE"));
                fileMap.put("PARAM_DIVISION_CODE", param.get("PARAM_DIVISION_CODE"));
                fileMap.put("VENDOR_CODE", param.get("PARAM_VENDOR_CODE"));
                fileMap.put("COO_CERTIFY_NO", param.get("COO_CERTIFY_NO"));

                fileMap.put("FILE_NAME", file.getOriginalFilename());
                fileMap.put("ORIGIN_FILE_NAME", file.getOriginalFilename());
                fileMap.put("FILE_PATH", "DB");
                fileMap.put("EXT_COO_FILE", file.getBytes());

                fileMap.put("CREATE_BY", param.get("USER_ID"));
                fileMap.put("UPDATE_BY", param.get("USER_ID"));

                dao.insertExtCooCertifyMstFile(fileMap);
            }

            result.setValue(param.get("COO_CERTIFY_NO"));
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {
            logger.error("insertExtCooCertify error", e);
            throw new RuntimeException(e);
        }

        return result;
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result selectExtCooCertifyFileList(Map<String, Object> param) {

        Result result = new Result();

        try {
            List<Map<String, Object>> list =
                    sqlSession.getMapper(IndividualCootargetDao.class).selectExtCooCertifyFileList(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }
    
    public Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param) {
        return sqlSession.getMapper(IndividualCootargetDao.class).extCooCertifyFileDownLoad(param);
    }
    
        
    public Result retrieveIndividualCootargetNationCode(Map<String, Object> param) {
        Result result = new Result();

        try {
            IndividualCootargetDao dao = sqlSession.getMapper(IndividualCootargetDao.class);
            result.setValue(dao.retrieveIndividualCootargetNationCode(param));
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }
    
}
