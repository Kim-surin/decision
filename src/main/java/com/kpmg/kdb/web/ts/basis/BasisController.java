package com.kpmg.kdb.web.ts.basis;

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
 * BasisController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 *         기초정보 관리 구현 클래스
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class BasisController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(BasisController.class);
	

	@Autowired
	protected BasisService service;

	/**
	 * 기초정보관리 > 회사관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/companyMgmt")
	public String basis000_view(Model model, HttpSession session) {
		return "basis/companyMgmt";
	}
	
	
	/**
	 * 회사관리 - 왼쪽 트리 목록 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveCompanyDivisionList")
	@ResponseBody
	public Result retrieveCompanyDivisionList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionList ");
		Result result = new Result();
		try {
			
			result = service.retrieveCompanyDivisionList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionList END");
		
		return result;
	}
	
	/**
	 * 회사관리 - 회사 또는 플렌트 1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveCompanyDivisionFormData")
	@ResponseBody
	public Result retrieveCompanyDivisionFormData(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData ");
		Result result = new Result();
		try {
			
			result = service.retrieveCompanyDivisionFormData(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData END");
		
		return result;
	}
	
	/**
	 * 회사관리 - 회사 또는 플렌트 1건 데이터 update
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateCompanyDivisionFormData")
	@ResponseBody
	public Result updateCompanyDivisionFormData(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData ");
		Result result = new Result();
		try {
			
			result = service.updateCompanyDivisionFormData(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCompanyDivisionFormData END");
		
		return result;
	}
	
	
	/**
	 * 회사 버퍼 설정 
	 * 회사 버퍼  설정값에  따른 해당 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveBufferDatalist")
	@ResponseBody
	public Result retrieveBufferDatalist(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveBufferDatalist ");
		Result result = new Result();
		try {
			
			result = service.retrieveBufferDatalist(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveBufferDatalist END");
		
		return result;
	}
	
	
	/**
	 * 회사관리 - 인증수출자 정보 저장
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateCertificationInfo")
	@ResponseBody
	public Result updateCertificationInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "updateCertificationInfo ");
		Result result = new Result();
		try {
			
			result = service.updateCertificationInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "updateCertificationInfo END");
		
		return result;
	}
	
	
	/**
	 * 회사관리 - 인증수출자 정보 저장
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateCompanyBuffer")
	@ResponseBody
	public Result updateCompanyBuffer(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "updateCompanyBuffer ");
		Result result = new Result();
		try {
			
			result = service.updateCompanyBuffer(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "updateCompanyBuffer END");
		
		return result;
	}
	
	
	/**
	 * 회사관리 - 수불부 설정 정보 저장
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateCompanyMaOption")
	@ResponseBody
	public Result updateCompanyMaOption(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "updateCompanyMaOption ");
		Result result = new Result();
		try {
			
			result = service.updateCompanyMaOptionValue(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "updateCompanyMaOption END");
		
		return result;
	}
	
	
	/**
	 * 회사관리 - 확인서 등록 기준 정보 저장
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateCompanyRuOption")
	@ResponseBody
	public Result updateCompanyRuOption(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "updateCompanyRuOption ");
		Result result = new Result();
		try {
			
			result = service.updateCompanyOptionValue(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "updateCompanyRuOption END");
		
		return result;
	}
	
	
	/**
	 * 기초정보관리 > 사용자관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/userSignatureMgmt")
	public String basis001_view(Model model, HttpSession session) {
		return "basis/userSignatureMgmt";
	}
	
	
	
	/**
	 * 회사 버퍼 설정 
	 * 회사 버퍼  설정값에  따른 해당 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveUserinfoList")
	@ResponseBody
	public Result retrieveUserinfoList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveUserinfoList ");
		Result result = new Result();
		try {
			
			result = service.retrieveUserinfoList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveUserinfoList END");
		
		return result;
	}
	
	/**
	 * 서명권자 이미지 1건 가져오기
	 * 화면 렌더링 용
	 * @param userId
	 * @return
	 */
	@GetMapping("/basis/signature/{empno}")
	@ResponseBody
	public ResponseEntity<byte[]> viewSignatureImageByUserId(@PathVariable("empno") String emp_no) {

	    Map<String, Object> defaultMap = new HashMap<>();
	    defaultMap.put("emp_no", emp_no);

	    Map<String, Object> signature = service.getSignatureByUserId(super.extendsMap(defaultMap));

	    if (signature == null || signature.get("real_file") == null) {
	        return ResponseEntity.notFound().build();
	    }

	    String fileName = (String) signature.get("sign_file_name");
	    byte[] realFile = (byte[]) signature.get("real_file");

	    MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;

	    if (fileName != null) {
	        String lowerFileName = fileName.toLowerCase();
	        if (lowerFileName.endsWith(".png")) {
	            mediaType = MediaType.IMAGE_PNG;
	        } else if (lowerFileName.endsWith(".jpg") || lowerFileName.endsWith(".jpeg")) {
	            mediaType = MediaType.IMAGE_JPEG;
	        } else if (lowerFileName.endsWith(".gif")) {
	            mediaType = MediaType.IMAGE_GIF;
	        }
	    }

	    return ResponseEntity.ok()
	            .contentType(mediaType)
	            .body(realFile);
	}
	
    
	/**
	 * 기초정보관리 > 사용자관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/userSignatureDetail_pop")
	public String basis00101_view(@RequestParam Map param, Model model, HttpSession session) {
		
		model.addAllAttributes(param);
		
		return "basis/userSignatureDetail_pop";
	}
	
	
	/**
	 * 사용자관리 - 사용자 상세
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveUserinfoDetail")
	@ResponseBody
	public Result retrieveUserinfoDetail(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveUserinfoDetail ");
		Result result = new Result();
		try {
			
			result = service.retrieveUserinfoDetail(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveUserinfoDetail END");
		
		return result;
	}
	/**
	 * 사용자관리 - 서명권자 정보
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveSignatureInfo")
	@ResponseBody
	public Result retrieveSignatureInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveSignatureInfo ");
		Result result = new Result();
		try {
			
			result = service.retrieveSignatureInfo(super.extendsMap(param));
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		
		logger.debug("##### Request Type result Class : " + "retrieveSignatureInfo END");
		
		return result;
	}
	
	
	
	/**
	 * 서명권자 이미지 미리보기 
	 * @param param
	 * @param files
	 * @param request
	 * @param mReq
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/basis/saveUserSignatureInfo", method = {RequestMethod.POST})
	@ResponseBody
	public Result uploadImportExcelProcess(@RequestParam Map param,  @RequestParam(value = "file1", required = false) MultipartFile files, HttpServletRequest request, MultipartHttpServletRequest mReq) throws Exception {
		Result rs = new Result();
		
		try {
			rs = service.saveUserSignatureInfo(super.extendsMap(param), files);
			
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 사용자 중복 체크
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/checkDuplicateUserId")
	@ResponseBody
	public Result checkDuplicateUserId(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "checkDuplicateUserId ");
		Result result = new Result();
		try {
			
			result = service.checkDuplicateUserId(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "checkDuplicateUserId END");
		
		return result;
	}
	
	
	/**
	 * 서명권자 해지
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/cancelUserSignatureInfo")
	@ResponseBody
	public Result cancelUserSignatureInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "cancelUserSignatureInfo ");
		Result result = new Result();
		try {
			
			result = service.cancelUserSignatureInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "cancelUserSignatureInfo END");
		
		return result;
	}
	
	
	
	/**
	 * 기초정보관리 > 자재관리
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/itemList")
	public String basis002_view(Model model, HttpSession session) {
		return "basis/itemList";
	}
	
	/**
	 * 자재관리 - 목록조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveItemList")
	@ResponseBody
	public Result retrieveItemList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveItemList ");
		Result result = new Result();
		try {
			
			result = service.retrieveItemList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveItemList END");
		
		return result;
	}
	
	
	/**
	 * HS CODE 누락 비율 chart UPDATE 용 데이터 조회 
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveMissingHsCodeCount")
	@ResponseBody
	public Result retrieveMissingHsCodeCount(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveMissingHsCodeCount ");
		Result result = new Result();
		try {
			
			result = service.retrieveMissingHsCodeCount(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveMissingHsCodeCount END");
		
		return result;
	}
	
	
	/**
	 * 기초정보관리 > 자재관리 > 상세
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/itemDetail")
	public String basis00201_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);  
		return "basis/itemDetail";
	}
	
	
	/**
	 * 기초정보관리 > 자재관리 > 협정별 / 국가별 HS CODE
	 * 
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/basis/itemAgreemenNationtHsCode")
	public String basis00202_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAllAttributes(param);
		return "basis/itemAgreemenNationtHsCode";
	}
	
	
	/**
	 * 자재관리 - 상세 - 마스터정보 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveItemDetailMasterInfo")
	@ResponseBody
	public Result retrieveItemDetailMasterInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveItemDetailMasterInfo ");
		Result result = new Result();
		try {
			
			result = service.retrieveItemDetailMasterInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveItemDetailMasterInfo END");
		
		return result;
	}
	
	/**
	 * 자재관리 - 상세 - 목록조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveItemDetailList")
	@ResponseBody
	public Result retrieveItemDetailList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveItemDetailList ");
		Result result = new Result();
		try {
			
			result = service.retrieveItemDetailList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveItemDetailList END");
		
		return result;
	}
	
	
	
	/**
	 * 자재관리 - 상세 - 마스터정보 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/checkHsCodeExists")
	@ResponseBody
	public Result checkHsCodeExists(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "checkHsCodeExists ");
		Result result = new Result();
		try {
			
			int cnt = service.checkHsCodeExists(super.extendsMap(param));
			result.setValue(cnt > 0 ? "Y" : "N");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "checkHsCodeExists END");
		
		return result;
	}
	
	
	/**
	 * 자재관리 - 상세 - hscode 저장
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/updateItemHsCode")
	@ResponseBody
	public Result updateItemHsCode(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "updateItemHsCode ");
		Result result = new Result();
		try {
			
			result = service.updateItemHsCode(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "updateItemHsCode END");
		
		return result;
	}
	
	
	
	/**
	 * 자재관리 - 협정별 / 국가별 hscode 팝업 hscode 데이터 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveHsCodeDetail")
	@ResponseBody
	public Result retrieveHsCodeDetail(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveHsCodeDetail ");
		Result result = new Result();
		try {
			
			result = service.retrieveHsCodeDetail(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveHsCodeDetail END");
		
		return result;
	}
	
	/**
	 * 자재관리 - 협정별 / 국가별 hscode 팝업 데이터 리스트 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/basis/retrieveAgreementNationHsCodeList")
	@ResponseBody
	public Result retrieveAgreementNationHsCodeList(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveAgreementNationHsCodeList ");
		Result result = new Result();
		try {
			
			result = service.retrieveAgreementNationHsCodeList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveAgreementNationHsCodeList END");
		
		return result;
	}
	
}