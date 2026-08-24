package com.kpmg.kdb.web.ts.coverCooTarget;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.net.URLEncoder;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import java.util.List;

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
public class CoverCootargetController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CoverCootargetController.class);

	@Autowired
	protected CoverCootargetService service;


	/**
	 * 협력업체 원산지확인서 > 확인서 수취대상 관리
	 *
	 * @author D.Cat
	 * @return View Path String
	 */
	@RequestMapping(value = "/cover/CoverCooTargetList")
	public String coverCootarget000_view(Model model, HttpSession session) {
		return "covercootarget/covercootargetList";
	}

	
	@RequestMapping(value="/cover/deleteExtCooCertifyFile", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/cover/retrieveCoverCootargetOmission")
	@ResponseBody
	public Result retrieveCoverCootargetOmission(@RequestBody Map<String, Object> param) {

	    Result result = new Result();

	    try {

	        result = service.retrieveCoverCootargetOmission(
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
	
	@GetMapping("/cover/downloadExtCooCertifyFile")
	public ResponseEntity<byte[]> downloadExtCooCertifyFile(
			@RequestParam("COMPANY_CODE") String companyCode,
			@RequestParam("PARAM_DIVISION_CODE") String divisionCode,
			@RequestParam("PARAM_VENDOR_CODE") String vendorCode,
			@RequestParam("COO_CERTIFY_NO") String cooCertifyNo,
			@RequestParam("FILE_SEQ") Integer fileSeq) {

		try {

			Map<String, Object> param = new HashMap<String, Object>();

			param.put("COMPANY_CODE", companyCode);
			param.put("PARAM_DIVISION_CODE", divisionCode);
			param.put("PARAM_VENDOR_CODE", vendorCode);
			param.put("COO_CERTIFY_NO", cooCertifyNo);
			param.put("FILE_SEQ", fileSeq);

			Map<String, Object> file =
					service.selectExtCooCertifyFileDownload(
							super.extendsMap(param)
					);

			if (file == null || file.get("EXT_COO_FILE") == null) {
				return ResponseEntity.notFound().build();
			}

			byte[] fileData =
					(byte[]) file.get("EXT_COO_FILE");

			String fileName =
					file.get("ORIGIN_FILE_NAME") != null
					? String.valueOf(file.get("ORIGIN_FILE_NAME"))
					: String.valueOf(file.get("FILE_NAME"));

			String encodedFileName =
					URLEncoder.encode(fileName, "UTF-8")
							  .replace("+", "%20");

			HttpHeaders headers = new HttpHeaders();

			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.set(
					HttpHeaders.CONTENT_DISPOSITION,
					"attachment; filename*=UTF-8''" + encodedFileName
			);
			headers.setContentLength(fileData.length);

			return ResponseEntity
					.ok()
					.headers(headers)
					.body(fileData);

		} catch (Exception e) {

			e.printStackTrace();

			return ResponseEntity
					.internalServerError()
					.build();
		}
	}
	
	
	/**
	 * 확인서 수취율 정보 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/cover/retrieveCoverCootargetList")
	@ResponseBody
	public Result retrieveCoverCootargetList(@RequestBody Map param) {

		logger.debug("##### Request Type result Class : retrieveCootargetList ");

		Result result = new Result();

		try {

			result = service.retrieveCoverCootargetList(
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

		logger.debug("##### Request Type result Class : retrieveCoverCootargetList END");

		return result;
	}


	/**
	 * 확인서 수취율 팝업 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/cover/retrieveCoverCootargetPopup")
	@ResponseBody
	public Result retrieveCoverCootargetPopup(@RequestBody Map param) {

		logger.debug("##### Request Type result Class : retrieveCoverCootargetPopup ");

		Result result = new Result();

		try {

			result = service.retrieveCoverCootargetPopup(
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

		logger.debug("##### Request Type result Class : retrieveCoverCootargetPopup END");

		return result;
	}


	/**
	 * 확인서 수취율 대시보드 조회
	 * @param param
	 * @return
	 */
	@PostMapping("/cover/retrieveCoverCootargetDashboard")
	@ResponseBody
	public Result retrieveCoverCootargetDashboard(@RequestBody Map param) {

		Result result = new Result();

		try {

			result = service.retrieveCoverCootargetDashboard(
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


	@RequestMapping(value = "/covercootarget_pop")
	public String Covercootarget_pop(Model model, HttpSession session) {
		return "covercootarget/covercootarget_pop";
	}


	@RequestMapping(value="/cover/retrieveCoverCootargetRule")
	@ResponseBody
	public Result retrieveCoverCootargetRule(@RequestBody Map param) {

		Result result = new Result();

		try {

			result = service.retrieveCoverCootargetRule(
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


	@RequestMapping(value="/cover/retrieveCoverCootargetNoCode")
	@ResponseBody
	public Result retrieveCoverCootargetNoCode(@RequestBody Map param) {

		Result result = new Result();

		try {

			result = service.retrieveCoverCootargetNoCode(
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


	@RequestMapping(value="/cover/checkCoverCootargetDuplicate")
	@ResponseBody
	public Result checkCoverCootargetDuplicate(@RequestBody Map param) {

		Result result = new Result();

		try {

			result = service.checkCoverCootargetDuplicate(
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

	@RequestMapping(value="/cover/insertExtCooCertify", method=RequestMethod.POST)
	@ResponseBody
	public Result insertExtCooCertify(
			@RequestPart("data") Map<String, Object> param,
			@RequestPart(value="FILEUP", required=false) List<MultipartFile> files) {

		Result result = new Result();

		try {

			Map<String, Object> saveParam =
					super.extendsMap(param);

			if (files != null && !files.isEmpty()) {
				saveParam.put("FILEUP_LIST", files);
			}

			result =
					service.insertExtCooCertify(saveParam);

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
	 * 기등록 확인서 첨부파일 목록 조회
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/cover/selectExtCooCertifyFileList")
	@ResponseBody
	public Result selectExtCooCertifyFileList(@RequestBody Map<String, Object> param) {

		Result result = new Result();

		try {

			result = service.selectExtCooCertifyFileList(
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


	@RequestMapping(value="/cover/retrieveCoverCootargetNationCode")
	@ResponseBody
	public Result retrieveCoverCootargetNationCode(@RequestBody Map<String, Object> param) {

		return service.retrieveCoverCootargetNationCode(
				super.extendsMap(param)
		);
	}
	
	@GetMapping("/cover/extCooCertifyFileDownLoad")
	@ResponseBody
	public ResponseEntity<byte[]> extCooCertifyFileDownLoad(@RequestParam Map<String, Object> param) {

		Map<String, Object> fileMap = service.extCooCertifyFileDownLoad(super.extendsMap(param));

		if (fileMap == null || fileMap.get("EXT_COO_FILE") == null) {
			return ResponseEntity.notFound().build();
		}

		byte[] fileData = (byte[]) fileMap.get("EXT_COO_FILE");
		String fileName = String.valueOf(fileMap.get("ORIGIN_FILE_NAME"));
		String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replace("+", "%20");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName);
		headers.setContentLength(fileData.length);

		return ResponseEntity.ok().headers(headers).body(fileData);
	}

}