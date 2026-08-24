package com.kpmg.kdb.web.ts.coverCooTarget;

import java.util.HashMap;
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
public class CoverCootargetService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(CoverCootargetService.class);
    
    
    /**
     * 확인서 수취대상 관리 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCoverCootargetList(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list =
    				sqlSession.getMapper(CoverCootargetDao.class).retrieveCoverCootargetList(param);
    		
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
     * 확인서 수취율 대시보드 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCoverCootargetDashboard(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list =
    				sqlSession.getMapper(CoverCootargetDao.class).retrieveCoverCootargetDashboard(param);
    		
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
    public Result retrieveCoverCootargetPopup(Map<String, Object> param){
    	
    	Result result = new Result();
    	
    	try {
    		List<Map<String, Object>> list =
    				sqlSession.getMapper(CoverCootargetDao.class).retrieveCoverCootargetPopup(param);
    		
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
    public Result retrieveCoverCootargetRule(Map<String, Object> param){

        Result result = new Result();

        try {
            List<Map<String, Object>> list =
            		sqlSession.getMapper(CoverCootargetDao.class).retrieveCoverCootargetRule(param);

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
    public Result retrieveCoverCootargetNoCode(Map<String, Object> param){

        Result result = new Result();

        try {
            List<Map<String, Object>> list =
            		sqlSession.getMapper(CoverCootargetDao.class).retrieveCoverCootargetNoCode(param);

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
    public Result checkCoverCootargetDuplicate(Map<String, Object> param) {

    	Result result = new Result();

    	try {

    		int duplicate =
    				sqlSession.getMapper(CoverCootargetDao.class).checkCoverCootargetDuplicate(param);

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

    		CoverCootargetDao dao =
    				sqlSession.getMapper(CoverCootargetDao.class);

    		/* 자동채번 */
    		if ("true".equals(String.valueOf(param.get("AUTO_COO_CERTIFY_NO")))) {

    			param.put("AUTO_COO_YN", "Y");

    			String cooCertifyNo =
    					dao.selectCooCertifyNoGet(param);

    			param.put("COO_CERTIFY_NO", cooCertifyNo);

    		} else {
    			param.put("AUTO_COO_YN", "N");
    		}

    		param.put("CREATE_BY", param.get("USER_ID"));
    		param.put("UPDATE_BY", param.get("USER_ID"));

    		/* MST 저장 */
    		dao.insertExtCooCertifyMst(param);

    		List<Map<String, Object>> gridData =
    				(List<Map<String, Object>>) param.get("gridData");

    		String tmpItemCode = "";

    		for (Map<String, Object> row : gridData) {

    			row.put("COMPANY_CODE", param.get("COMPANY_CODE"));
    			row.put("PARAM_DIVISION_CODE", param.get("PARAM_DIVISION_CODE"));
    			row.put("PARAM_VENDOR_CODE", param.get("PARAM_VENDOR_CODE"));

    			row.put("COO_CERTIFY_NO", param.get("COO_CERTIFY_NO"));
    			row.put("COO_CERTIFY_TYPE", param.get("COO_CERTIFY_TYPE"));

    			row.put("ISSUE_DATE", param.get("ISSUE_DATE"));
    			row.put("APPLY_DATE", param.get("APPLY_DATE"));
    			row.put("END_DATE", param.get("END_DATE"));

    			row.put("USER_ID", param.get("USER_ID"));
    			row.put("UPDATE_BY", param.get("USER_ID"));

    			dao.updateExtCooCertifyDtl(row);
    			dao.insertExtCooCertifyDtl(row);

    			String itemCode =
    					String.valueOf(row.get("ITEM_CODE"));

    			if (!itemCode.equals(tmpItemCode)) {

    				tmpItemCode = itemCode;

    				dao.updatePoLedger(row);
    			}
    		}

    		/* 첨부파일 다중 저장 */
    		List<MultipartFile> files =
    				(List<MultipartFile>) param.get("FILEUP_LIST");

    		if (files != null && !files.isEmpty()) {

    			for (MultipartFile file : files) {

    				if (file == null || file.isEmpty()) {
    					continue;
    				}

    				Map<String, Object> fileMap =
    						new HashMap<String, Object>();

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
    		}

    		result.setValue(param.get("COO_CERTIFY_NO"));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);

    	} catch (Exception e) {
    		e.printStackTrace();
    		throw new RuntimeException(e);
    	}

    	return result;
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public void insertCoverFile(Map<String, Object> param) throws Exception {

    	Object fileObj =
    			param.get("FILEUP");

    	if (fileObj == null) {
    		return;
    	}

    	MultipartFile mfile =
    			(MultipartFile) fileObj;

    	if (mfile.isEmpty()) {
    		return;
    	}

    	Map<String, Object> fileMap =
    			new HashMap<>();

    	fileMap.put("COMPANY_CODE", param.get("COMPANY_CODE"));
    	fileMap.put("PARAM_DIVISION_CODE", param.get("PARAM_DIVISION_CODE"));
    	fileMap.put("VENDOR_CODE", param.get("PARAM_VENDOR_CODE"));
    	fileMap.put("COO_CERTIFY_NO", param.get("COO_CERTIFY_NO"));

    	fileMap.put("FILE_NAME", mfile.getOriginalFilename());
    	fileMap.put("ORIGIN_FILE_NAME", mfile.getOriginalFilename());
    	fileMap.put("FILE_PATH", "DB");
    	fileMap.put("EXT_COO_FILE", mfile.getBytes());

    	fileMap.put("CREATE_BY", param.get("USER_ID"));
    	fileMap.put("UPDATE_BY", param.get("USER_ID"));

    	sqlSession.getMapper(CoverCootargetDao.class)
    		.insertExtCooCertifyMstFile(fileMap);
    }


    /**
     * 기등록 확인서 첨부파일 목록 조회
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result selectExtCooCertifyFileList(Map<String, Object> param) {

    	Result result = new Result();

    	try {

    		CoverCootargetDao dao =
    				sqlSession.getMapper(CoverCootargetDao.class);

    		List<Map<String, Object>> list =
    				dao.selectExtCooCertifyFileList(param);

    		result.setValue(list);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);

    	} catch (Exception e) {

    		e.printStackTrace();

    		result =
    				super.getResult(
    					false,
    					"MSG_UNSPECIFIED_ERROR",
    					new Object[] {}
    				);
    	}

    	return result;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<String, Object> selectExtCooCertifyFileDownload(Map<String, Object> param) throws Exception {

    	CoverCootargetDao dao =
    			sqlSession.getMapper(CoverCootargetDao.class);

    	Map<String, Object> file =
    			dao.selectExtCooCertifyFileDownload(param);

    	return file;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional
    public Result deleteExtCooCertifyFile(Map<String, Object> param) {

    	Result result = new Result();

    	try {

    		CoverCootargetDao dao =
    				sqlSession.getMapper(CoverCootargetDao.class);

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

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCoverCootargetOmission(Map<String, Object> param) {

        Result result = new Result();

        try {

            CoverCootargetDao dao =
                    sqlSession.getMapper(CoverCootargetDao.class);

            List<Map<String, Object>> list =
                    dao.retrieveCoverCootargetOmission(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            logger.error("retrieveCoverCootargetOmission error", e);

            result = super.getResult(
                    false,
                    "MSG_UNSPECIFIED_ERROR",
                    new Object[] {}
            );
        }

        return result;
    }

    public Result retrieveCoverCootargetNationCode(Map<String, Object> param) {

        Result result = new Result();

        try {

            CoverCootargetDao dao =
            		sqlSession.getMapper(CoverCootargetDao.class);

            result.setValue(
            		dao.retrieveCoverCootargetNationCode(param)
            );

            result.setSuccess(true);

        } catch (Exception e) {

            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }
    
    public Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param) {
    	 CoverCootargetDao dao =
         		sqlSession.getMapper(CoverCootargetDao.class);

    	return dao.extCooCertifyFileDownLoad(param);
    }
    
}