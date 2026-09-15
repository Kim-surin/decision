package com.kpmg.kdb.web.ts.inspection;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.RestfulClientUtil;

/*******************************************************************************************
 *
 * IssueCertController.class
 *
 * @since 2026.08
 * @author D.Cat
 *
 *         증명서 발급 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class InspectionResController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(InspectionResController.class);
	

	@Autowired
	protected InspectionResService service;

	/**
	 * 실사 대응 서류
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping("/inspection/CooAuditDocument")
	public String cooAuditDocument_view(Model model, HttpSession session) {
		return "inspection/cooAuditDocument";
	}
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping("/inspection/cooCertifyPopup")
	public String cooCertifyPopup_view(Model model, HttpSession session) {
		return "inspection/cooCertifyPopup";
	}
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooCertSearchPopupList")
	@ResponseBody
	public Result retrieveCooCertSearchPopupList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooCertSearchPopupList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList END");
		
		return result;
	}
	
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooAuditDocumentInfo")
	@ResponseBody
	public Result retrieveCooAuditDocumentInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooCertSearchPopupList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooAuditDocumentInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentInfo END");
		
		return result;
	}
	
	
	/**
	 * 실사 대응 서류 > 원산지확인서 검색 팝업 > 검색버튼
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveCooAuditDocumentDetailList")
	@ResponseBody
	public Result retrieveCooAuditDocumentDetailList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentDetailList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooAuditDocumentDetailList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooAuditDocumentDetailList END");
		
		return result;
	}
	
	
	/**
	 * 실사 대응 서류 > 소요량 명세서 다운로드
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/inspection/downloadBillOfMaterials", method = RequestMethod.POST)
	public ResponseEntity<byte[]> retrieveBillOfMaterials(@RequestParam Map<String, Object> param) throws Exception {

	    List<Map<String, Object>> list = service.retrieveBillOfMaterials(super.extendsMap(param));
	    byte[] excelBytes = service.createBomExcel(list);

	    	    String timestamp = new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());

	    String fileName = "BillOfMaterial_" + timestamp + ".xlsx";
	    String encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"));
	    headers.set(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename*=UTF-8''" + encodedFileName);

	    return ResponseEntity.ok().headers(headers).body(excelBytes);
	}
	
	
	
	
	/**
	 * 실사 대응 서류 > 협력사확인서 목록 팝업
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping("/inspection/cooAuditVendorCertifyDocumentPopup")
	public String cooAuditVendorCertifyDocumentPopup(@RequestParam Map param, Model model, HttpSession session) {
		
		model.addAllAttributes(param);
		return "inspection/cooAuditVendorCertifyDocumentPopup";
	}
	
	/**
	 * 실사 대응 서류 > 협력사확인서 목록 > 데이터 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/inspection/retrieveVendorCertFileList")
	@ResponseBody
	public Result retrieveVendorCertFileList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveVendorCertFileList ");
		Result result = new Result();
		try {
			
			result = service.retrieveVendorCertFileList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveVendorCertFileList END");
		
		return result;
	}
	
	/**
	 * 실사 대응 서류 > 협력사확인서 목록 > 확인서 다운로드 
	 * @param cooCertifyNo
	 * @param vendorCode
	 * @param divisionCode
	 * @param companyCode
	 * @param fileSeq
	 * @return
	 * @throws UnsupportedEncodingException
	 */
    @RequestMapping(value = "/inspection/retrieveVendorCertFile")
    public ResponseEntity<byte[]> retrieveVendorCertFile(@RequestParam Map<String, Object> param) throws UnsupportedEncodingException {

        
        Map<String, Object> resultMap = service.retrieveVendorCertFile(super.extendsMap(param));
        
        
        // ext_coo_file 데이터 추출
        byte[] fileData = (byte[]) resultMap.get("ext_coo_file");

        // 파일 데이터 없을 경우
        if (fileData == null || fileData.length == 0) {
            return ResponseEntity.noContent().build();
        }

        // 원본 파일명 추출 (origin_file_name 우선, 없으면 file_name)
        String originFileName = (String) resultMap.get("origin_file_name");
        String fileName       = (String) resultMap.get("file_name");
        String downloadName   = (originFileName != null && !originFileName.isEmpty()) ? originFileName : fileName;

        // 한글 파일명 인코딩
        String encodedFileName;
        try {
        	
            encodedFileName = URLEncoder.encode(downloadName, StandardCharsets.UTF_8).replace("+", "%20");
            
        } catch (Exception e) {
            encodedFileName = "download_file";
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", encodedFileName);
        headers.setContentLength(fileData.length);

        return ResponseEntity.ok().headers(headers).body(fileData);
    }
	
}