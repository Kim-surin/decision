package com.kpmg.kdb.web.ts.issuecert;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
public class IssueCertService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(IssueCertService.class);
    
    
    /**
     * 증명서 발급 대상 목록 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooIssueCertList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IssueCertDao.class).retrieveCooIssueCertList(param);
    		
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
     * 선택한 판정결과를 이용하여 고객사 정보를 조회
	 * 증명서 발급버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooIssueTargetCustomerInfo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		Map<String, Object> customerInfo = sqlSession.getMapper(IssueCertDao.class).retrieveCooIssueTargetCustomerInfo(param);
    		
    		result.setValue(customerInfo);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 선택한 판정결과를 이용하여 발급 대상 목록을 조회
	 * 증명서 발급버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooIssueTargetList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IssueCertDao.class).retrieveCooIssueTargetList(param);
    		
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
     * 포괄 증명서 발급 > 중복체크
	 * 증명서 발급버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result checkDuplicateCertifyNo(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		int checkCount = sqlSession.getMapper(IssueCertDao.class).checkDuplicateCertifyNo(param);
    		
    		if(checkCount > 0) {
    			result.setSuccess(false);
    		}else {
    			result.setSuccess(true);
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 포괄증명서 발급
     * @param param
     * @return
     * @throws Exception
     */
 	@Transactional
 	public String confirmIssue(Map<String, Object> param) throws Exception {

 		Map<String, Object> mstMap = new HashMap<>();
 		
 		mstMap.putAll(param);
 		mstMap.remove("coo_issue_target");
 		
 		mstMap.put("apply_date", StringUtil.replace((String)param.get("cover_from_date"),"-", ""));
 		mstMap.put("end_date", StringUtil.replace((String)param.get("cover_to_date"),"-", ""));

 		// 1. COO_CERTIFY_LEDGER_DTL 삭제
 		String cooCertifyNo = (String) param.get("coo_certify_no");		// 발행한 증명서 번호(상세에서 가져온 번호)
 		
 		if (cooCertifyNo == null || "".equalsIgnoreCase(cooCertifyNo)) {
 			cooCertifyNo = sqlSession.getMapper(IssueCertDao.class).makeCooCertifyNo(param);
 		}
 		mstMap.put("coo_certify_no", cooCertifyNo);
 		mstMap.put("origin_coo_certify_no", param.get("origin_coo_certify_no"));
 		
 		
 		mstMap.put("apply_date", mstMap.get("cert_from_date"));
 		mstMap.put("end_date", mstMap.get("cert_to_date"));
 		
 		
 		// 2-1. COO_CERTIFY_LEDGER 등록
 		int resultCount = sqlSession.getMapper(IssueCertDao.class).insertCooCertifyLedger(mstMap);
 	
 		if(resultCount < 1) {
 			throw new RuntimeException("원산지 증명서 마스터 정보 생성에 실패하였음.");
 		}
 		
 		// 2-2. COO_CERTIFY_LEDGER_DTL 등록
 		List<Map<String, Object>> issueTargetList = (List<Map<String, Object>>) param.get("coo_issue_cert_target");
 	    if (issueTargetList == null || issueTargetList.isEmpty()) {
 	        throw new RuntimeException("발급 대상 상세 정보가 없습니다.");
 	    }
 	    
		for (Map<String, Object> target : issueTargetList) {
			Map<String, Object> rowMap = new HashMap<>(target);

			rowMap.put("coo_certify_no", mstMap.get("coo_certify_no"));
			rowMap.put("company_code", mstMap.get("company_code"));
			rowMap.put("division_code", mstMap.get("division_code"));
			rowMap.put("customer_code", mstMap.get("customer_code"));
			rowMap.put("invoice_date", mstMap.get("invoice_date"));
			rowMap.put("apply_date", mstMap.get("cert_from_date"));
			rowMap.put("issue_date", mstMap.get("issue_date"));
			rowMap.put("end_date", mstMap.get("cert_to_date"));
			rowMap.put("coo_type", mstMap.get("coo_type"));
			rowMap.put("update_by", mstMap.get("update_by"));
			rowMap.put("create_by", mstMap.get("create_by"));

			rowMap.put("org_coo_certify_no", mstMap.get("origin_coo_certify_no"));

			int dtlResult = sqlSession.getMapper(IssueCertDao.class).insertCooCertifyLedgerDtl(rowMap);
			if (dtlResult < 1) {
				throw new RuntimeException("원산지 증명서 상세 정보 생성에 실패하였음.");
			}
		}
 		
 		// 4. SALES_MST 수정
 		sqlSession.getMapper(IssueCertDao.class).updateSalesMst(mstMap);
 		sqlSession.getMapper(IssueCertDao.class).updateProdSalesMst(mstMap);  // 제품별 원산지판정에 의한 PROD_SALES_MST UPDATE

 		// 5. SALES_DTL 수정
 		sqlSession.getMapper(IssueCertDao.class).updateSalesDtl(mstMap);
 		sqlSession.getMapper(IssueCertDao.class).updateProdSalesDtl(mstMap);  // 제품별 원산지판정에 의한 PROD_SALES_DTL UPDATE

 		// 6. 원산지 증명 BOM MASTER 삭제
 		sqlSession.getMapper(IssueCertDao.class).deleteFcrMst(mstMap);

 		// 7. 원산지 증명 BOM 상세 삭제
 		sqlSession.getMapper(IssueCertDao.class).deleteFcrDtl(mstMap);

 		// 8. 원산지증명 결과 삭제
 		sqlSession.getMapper(IssueCertDao.class).deleteFcrResult(mstMap);

 		// 9. 원산지 증명 BOM MASTER 등록
 		sqlSession.getMapper(IssueCertDao.class).insertFcrMst(mstMap);

 		// 10. 원산지 증명 BOM 상세 등록
 		sqlSession.getMapper(IssueCertDao.class).insertFcrDtl(mstMap);

 		// 11. 원산지증명 결과 등록
 		sqlSession.getMapper(IssueCertDao.class).insertResult(mstMap);
 		
 		if (cooCertifyNo != null && !"".equals(cooCertifyNo.trim())
 		        && param.get("origin_coo_certify_no") != null
 		        && !"".equals(String.valueOf(param.get("origin_coo_certify_no")).trim())) {

 			 /**
 		     * 증명서 수정발급 후 히스토리 입력
 		     * @param param
 		     * @return
 		     */
 			sqlSession.getMapper(IssueCertDao.class).insertIssuHistory(mstMap);
 		}

 		return cooCertifyNo;
 	}
 	
 	
    /**
     * FTA C/O 발급 > 증명서 발급 > 증명서상세 팝업 > 그리드 데이터 조회
	 * 증명서 발급버튼
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveIssuedCertList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IssueCertDao.class).retrieveIssuedCertList(param);
    		
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
     * FTA C/O 발급 > 증명서 발급 > 증명서 상세 > 증명서 수정 발급 (대상 데이터 조회 포함)
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map selectCooFcrMstOne(Map<String, Object> param){
    	
    	Result result = new Result();
    	Map<String, Object> rowData = null;
    	try {
    		rowData = sqlSession.getMapper(IssueCertDao.class).selectCooFcrMstOne(param);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return rowData;
    }
    
    /**
     * 수정발급 대상 데이터 조회 
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveCooModifyCertList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(IssueCertDao.class).retrieveCooModifyCertList(param);
    		
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
