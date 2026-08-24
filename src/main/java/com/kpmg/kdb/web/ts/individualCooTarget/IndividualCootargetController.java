package com.kpmg.kdb.web.ts.individualCooTarget;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.RestfulClientUtil;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestPart;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/*******************************************************************************************
 *
 * targetreceiptController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 *         기초정보 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class IndividualCootargetController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(IndividualCootargetController.class);
	

	@Autowired
	protected IndividualCootargetService service;
	
	
	
	/*
	 * @RequestMapping(value = "/targetReceiptList") public String
	 * targetReceiptList_view(Model model, HttpSession session) { return
	 * "targetreceipt/targetReceiptList"; }
	 */

	/**
	 * 협력업체 원산지확인서 > 확인서 수취대상 관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/individual/IndividualCooTargetList")
	public String individualCootarget000_view(Model model, HttpSession session) {
		return "individualcootarget/individualcootargetList";
	}
	
	
	@RequestMapping(value="/individual/deleteExtCooCertifyFile", method=RequestMethod.POST)
	@ResponseBody
	public Result deleteExtCooCertifyFile(@RequestBody Map<String, Object> param) {

	    Result result = new Result();

	    try {

	        result = service.deleteExtCooCertifyFile(
	                super.extendsMap(param)
	        );

	    } catch (Exception e) {

	        e.printStackTrace();

	        result = super.getResult(
	                false,
	                "MSG_UNSPECIFIED_ERROR",
	                new Object[] {}
	        );
	    }

	    return result;
	}
	
	
	/**
	 * 확인서 수취율 정보 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/individual/retrieveIndividualCootargetList")
	@ResponseBody
	public Result retrieveIndividualCootargetList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCootargetList ");
		Result result = new Result();
		try {
			
			result = service.retrieveIndividualCootargetList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveIndividualCootargetList END");
		
		return result;
	}
	
	/**
	 * 확인서 수취율 팝업 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/individual/retrieveIndividualCootargetPopup")
	@ResponseBody
	public Result retrieveIndividualCootargetPopup(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveIndividualCootargetPopup ");
		Result result = new Result();
		try {
			
			result = service.retrieveIndividualCootargetPopup(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveIndividualCootargetPopup END");
		
		return result;
	}
	
	@RequestMapping("/individual/retrieveIndividualCootargetFileList")
	@ResponseBody
	public Result retrieveIndividualCootargetFileList(@RequestBody Map<String, Object> param) {
	    return service.selectExtCooCertifyFileList(param);
	}
	
	/**
	 * 확인서 수취율 대시보드 조회 
	 * @param param
	 * @return
	 */
	@PostMapping("/individual/retrieveIndividualCootargetDashboard")
	@ResponseBody
	public Result retrieveIndividualCootargetDashboard(@RequestBody Map param) {
	    Result result = new Result();

	    try {
	        result = service.retrieveIndividualCootargetDashboard(super.extendsMap(param));
	    } catch (Exception e) {
	        e.printStackTrace();
	        result = super.getResult(
	            false,
	            "MSG_UNSPECIFIED_ERROR",
	            new Object[] {}
	        );
	    }

	    return result;
	}
	
	
	

	@RequestMapping(value = "/individualcootarget_pop")
	public String Individualcootarget_pop(Model model, HttpSession session) {
		return "individualcootarget/individualcootarget_pop";
	}
	
	
	@RequestMapping(value="/individual/retrieveIndividualCootargetRule")
	@ResponseBody
	public Result retrieveIndividualCootargetRule(@RequestBody Map param) {

	    Result result = new Result();

	    try {
	        result = service.retrieveIndividualCootargetRule(super.extendsMap(param));
	    } catch (Exception e) {
	        e.printStackTrace();
	        result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
	    }

	    return result;
	}
	
	@RequestMapping(value="/individual/checkIndividualCootargetDuplicate")
	@ResponseBody
	public Result checkIndividualCootargetDuplicate(@RequestBody Map param) {

		Result result = new Result();

		try {
			result = service.checkIndividualCootargetDuplicate(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	
	
	@RequestMapping(value="/individual/insertExtCooCertify", method=RequestMethod.POST)
	@ResponseBody
	public Result insertExtCooCertify(
			@RequestPart("data") Map<String, Object> param,
			@RequestPart(value="FILEUP", required=false) List<MultipartFile> files) {

		Result result = new Result();

		try {

			Map<String, Object> saveParam = super.extendsMap(param);

			if (files != null && !files.isEmpty()) {
				saveParam.put("FILEUP_LIST", files);
			}

			result = service.insertExtCooCertify(saveParam);

		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	@RequestMapping(value="/individual/retrieveIndividualCootargetNationCode")
	@ResponseBody
	public Result retrieveIndividualCootargetNationCode(@RequestBody Map<String, Object> param) {
	    return service.retrieveIndividualCootargetNationCode(super.extendsMap(param));
	}
	
	@GetMapping("/individual/extCooCertifyFileDownLoad")
	@ResponseBody
	public ResponseEntity<byte[]> extCooCertifyFileDownLoad(@RequestParam Map<String, Object> param) {

	    Map<String, Object> fileMap =
	            service.extCooCertifyFileDownLoad(super.extendsMap(param));

	    if (fileMap == null || fileMap.get("EXT_COO_FILE") == null) {
	        return ResponseEntity.notFound().build();
	    }

	    byte[] fileData = (byte[]) fileMap.get("EXT_COO_FILE");
	    String fileName = String.valueOf(fileMap.get("ORIGIN_FILE_NAME"));

	    String encodedFileName = URLEncoder.encode(
	            fileName,
	            StandardCharsets.UTF_8
	    ).replace("+", "%20");

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    headers.add(
	            HttpHeaders.CONTENT_DISPOSITION,
	            "attachment; filename*=UTF-8''" + encodedFileName
	    );
	    headers.setContentLength(fileData.length);

	    return ResponseEntity.ok()
	            .headers(headers)
	            .body(fileData);
	}
	
}