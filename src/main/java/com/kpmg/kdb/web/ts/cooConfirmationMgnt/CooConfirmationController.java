package com.kpmg.kdb.web.ts.cooConfirmationMgnt;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/**************************************************************************************************
 *
 * CooConfirmationController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 * 협력업체 원산지확인서 수취내역 관리
 *
 **************************************************************************************************/
@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
public class CooConfirmationController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CooConfirmationController.class);

	@Autowired
	protected CooConfirmationService service;

	/**
	 * 협력업체 원산지확인서 > 수취확인서 내역
	 *
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/coomgt/CooConfirmationList")
	public String cooConfirmationList_view(Model model, HttpSession session) {
		return "coomgt/cooconfirmationlist";
	}

	/**
	 * 수취확인서 상세 팝업
	 *
	 * @return
	 */
	@RequestMapping({ "/cooconfirmationlist_pop", "/coomgt/CooConfirmationDetail" })
	public String cooconfirmationlist_pop() {
		return "coomgt/cooconfirmation_pop";
	}

	/**
	 * 수취확인서 내역 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/retrieveCooConfirmationList")
	@ResponseBody
	public Result retrieveCooConfirmationList(@RequestBody Map<String, Object> param) {
		logger.debug("##### retrieveCooConfirmationList START");

		Result result = new Result();

		try {
			result = service.retrieveCooConfirmationList(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveCooConfirmationList error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveCooConfirmationList END");

		return result;
	}

	/**
	 * 수취확인서 상세 Grid 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/retrieveCooConfirmationPopup")
	@ResponseBody
	public Result retrieveCooConfirmationPopup(@RequestBody Map<String, Object> param) {
		logger.debug("##### retrieveCooConfirmationPopup START");

		Result result = new Result();

		try {
			result = service.retrieveCooConfirmationListPopup(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveCooConfirmationPopup error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveCooConfirmationPopup END");

		return result;
	}

	/**
	 * 수취확인서 첨부파일 목록 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/retrieveCooConfirmationListgetFileList")
	@ResponseBody
	public Result retrieveCooConfirmationListgetFileList(@RequestBody Map<String, Object> param) {
		logger.debug("##### retrieveCooConfirmationListgetFileList START");

		Result result = new Result();

		try {
			result = service.selectExtCooCertifyFileList(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListgetFileList error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveCooConfirmationListgetFileList END");

		return result;
	}

	/**
	 * 수취확인서 결정기준 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/retrieveCooConfirmationListRule")
	@ResponseBody
	public Result retrieveCooConfirmationListRule(@RequestBody Map<String, Object> param) {
		logger.debug("##### retrieveCooConfirmationListRule START");

		Result result = new Result();

		try {
			result = service.retrieveCooConfirmationListRule(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListRule error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveCooConfirmationListRule END");

		return result;
	}

	/**
	 * 수취확인서 중복 여부 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/checkCooConfirmationListDuplicate")
	@ResponseBody
	public Result checkCooConfirmationListDuplicate(@RequestBody Map<String, Object> param) {
		logger.debug("##### checkCooConfirmationListDuplicate START");

		Result result = new Result();

		try {
			result = service.checkCooConfirmationListDuplicate(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("checkCooConfirmationListDuplicate error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### checkCooConfirmationListDuplicate END");

		return result;
	}

	/**
	 * 수취확인서 저장 / 포괄확인서 기간연장 저장
	 *
	 * @param param
	 * @param files
	 * @return
	 */
	@PostMapping("/coomgt/insertExtCooCertify")
	@ResponseBody
	public Result insertExtCooCertify(
			@RequestPart("data") Map<String, Object> param,
			@RequestPart(value = "FILEUP", required = false) List<MultipartFile> files) {

		logger.debug("##### insertExtCooCertify START");

		Result result = new Result();

		try {
			Map<String, Object> saveParam = super.extendsMap(param);

			if (files != null && !files.isEmpty()) {
				saveParam.put("FILEUP_LIST", files);
			}

			result = service.insertExtCooCertify(saveParam);

		} catch (Exception e) {
			logger.error("insertExtCooCertify error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### insertExtCooCertify END");

		return result;
	}

	/**
	 * 국가코드 조회
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/retrieveCooConfirmationListNationCode")
	@ResponseBody
	public Result retrieveCooConfirmationListNationCode(@RequestBody Map<String, Object> param) {
		logger.debug("##### retrieveCooConfirmationListNationCode START");

		Result result = new Result();

		try {
			result = service.retrieveCooConfirmationListNationCode(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListNationCode error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveCooConfirmationListNationCode END");

		return result;
	}

	/**
	 * 수취확인서 첨부파일 삭제
	 *
	 * @param param
	 * @return
	 */
	@PostMapping("/coomgt/deleteExtCooCertifyFile")
	@ResponseBody
	public Result deleteExtCooCertifyFile(@RequestBody Map<String, Object> param) {
		logger.debug("##### deleteExtCooCertifyFile START");

		Result result = new Result();

		try {
			result = service.deleteExtCooCertifyFile(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("deleteExtCooCertifyFile error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### deleteExtCooCertifyFile END");

		return result;
	}

	/**
	 * 수취확인서 첨부파일 다운로드
	 *
	 * @param param
	 * @return
	 */
	@GetMapping("/coomgt/extCooCertifyFileDownLoad")
	@ResponseBody
	public ResponseEntity<byte[]> extCooCertifyFileDownLoad(@RequestParam Map<String, Object> param) {
		logger.debug("##### extCooCertifyFileDownLoad START");

		try {
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

			logger.debug("##### DOWNLOAD FILE NAME : {}", fileName);
			logger.debug("##### DOWNLOAD FILE SIZE : {}", fileData.length);
			logger.debug("##### extCooCertifyFileDownLoad END");

			return ResponseEntity.ok()
					.headers(headers)
					.body(fileData);

		} catch (Exception e) {
			logger.error("extCooCertifyFileDownLoad error", e);
			return ResponseEntity.internalServerError().build();
		}
	}

}