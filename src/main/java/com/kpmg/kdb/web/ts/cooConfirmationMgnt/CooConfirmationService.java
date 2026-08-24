package com.kpmg.kdb.web.ts.cooConfirmationMgnt;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes" })
public class CooConfirmationService extends GeneralService {

	static Logger logger = LoggerFactory.getLogger(CooConfirmationService.class);

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result retrieveCooConfirmationList(Map<String, Object> param) {

		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(CooConfirmationDao.class).retrieveCooConfirmationList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("retrieveCooConfirmationList error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result retrieveCooConfirmationListPopup(Map<String, Object> param) {

		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(CooConfirmationDao.class).retrieveCooConfirmationListPopup(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListPopup error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result selectExtCooCertifyFileList(Map<String, Object> param) {

		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(CooConfirmationDao.class).selectExtCooCertifyFileList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("selectExtCooCertifyFileList error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result retrieveCooConfirmationListRule(Map<String, Object> param) {

		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(CooConfirmationDao.class).retrieveCooConfirmationListRule(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListRule error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result checkCooConfirmationListDuplicate(Map<String, Object> param) {

		Result result = new Result();

		try {
			int duplicate = sqlSession.getMapper(CooConfirmationDao.class).checkCooConfirmationListDuplicate(param);

			result.setValue(duplicate);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("checkCooConfirmationListDuplicate error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	public Result insertExtCooCertify(Map<String, Object> param) {

		Result result = new Result();

		try {
			CooConfirmationDao dao = sqlSession.getMapper(CooConfirmationDao.class);

			List<MultipartFile> files = (List<MultipartFile>) param.get("FILEUP_LIST");
			List<Map<String, Object>> gridData = (List<Map<String, Object>>) param.get("gridData");

			boolean renew = "Y".equals(String.valueOf(param.get("RENEW")));
			boolean cover = "C".equals(String.valueOf(param.get("COO_CERTIFY_TYPE")));
			boolean hasNewFile = false;

			if (files != null) {
				for (MultipartFile file : files) {
					if (file != null && !file.isEmpty()) {
						hasNewFile = true;
						break;
					}
				}
			}

			if (gridData == null || gridData.isEmpty()) {
				result.setSuccess(false);
				result.setMessage("등록할 자재가 없습니다.");
				return result;
			}

			if (renew && !cover) {
				result.setSuccess(false);
				result.setMessage("포괄 확인서만 기간연장이 가능합니다.");
				return result;
			}

			if (cover) {

				String applyDate = String.valueOf(param.get("APPLY_DATE"));
				String endDate = String.valueOf(param.get("END_DATE"));

				if (applyDate.length() != 8 || endDate.length() != 8) {
					result.setSuccess(false);
					result.setMessage("포괄확인기간을 확인해주세요.");
					return result;
				}

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");

				LocalDate apply = LocalDate.parse(applyDate, formatter);
				LocalDate end = LocalDate.parse(endDate, formatter);

				if (apply.isAfter(end)) {
					result.setSuccess(false);
					result.setMessage("포괄확인 시작일자는 종료일자보다 늦을 수 없습니다.");
					return result;
				}

				if (ChronoUnit.DAYS.between(apply, end) > 365) {
					result.setSuccess(false);
					result.setMessage("포괄확인기간은 365일을 초과할 수 없습니다.");
					return result;
				}

				Set<String> itemSet = new HashSet<String>();

				for (Map<String, Object> row : gridData) {
					if (row.get("ITEM_CODE") != null) {
						itemSet.add(String.valueOf(row.get("ITEM_CODE")));
					}
				}

				param.put("itemCodes", new ArrayList<String>(itemSet));

				List<Map<String, Object>> beforeList = dao.selectBeforeDtlData(param);

				if (beforeList != null && !beforeList.isEmpty()) {

					Map<String, Object> before = beforeList.get(0);

					result.setSuccess(false);
					result.setMessage(
						"[자재코드 : "
						+ before.get("ITEM_CODE")
						+ ", 원산지확인서번호 : "
						+ before.get("COO_CERTIFY_NO")
						+ "("
						+ before.get("APPLY_DATE")
						+ "~"
						+ before.get("END_DATE")
						+ ")] 기간이 중복됩니다."
					);

					return result;
				}
			}

			if (!renew && !hasNewFile) {
				result.setSuccess(false);
				result.setMessage("파일을 첨부해주세요.");
				return result;
			}

			if (renew && !hasNewFile) {

				Map<String, Object> beforeFileParam = new HashMap<String, Object>();

				beforeFileParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
				beforeFileParam.put("PARAM_DIVISION_CODE", param.get("PARAM_DIVISION_CODE"));
				beforeFileParam.put("PARAM_VENDOR_CODE", param.get("PARAM_VENDOR_CODE"));
				beforeFileParam.put("COO_CERTIFY_NO", param.get("BEFORE_COO_CERTIFY_NO"));

				List<Map<String, Object>> beforeFiles = dao.selectExtCooCertifyFileList(beforeFileParam);

				if (beforeFiles == null || beforeFiles.isEmpty()) {
					result.setSuccess(false);
					result.setMessage("첨부파일을 추가해주세요.");
					return result;
				}
			}

			if (!"true".equals(String.valueOf(param.get("AUTO_COO_CERTIFY_NO")))) {

				if (param.get("COO_CERTIFY_NO") == null || String.valueOf(param.get("COO_CERTIFY_NO")).trim().isEmpty()) {
					result.setSuccess(false);
					result.setMessage("원산지확인서번호를 입력해주세요.");
					return result;
				}

				int duplicate = dao.checkCooConfirmationListDuplicate(param);

				if (duplicate > 0) {
					result.setSuccess(false);
					result.setMessage("이미 등록된 원산지확인서번호입니다.");
					return result;
				}

				param.put("AUTO_COO_YN", "N");

			} else {

				param.put("AUTO_COO_YN", "Y");
				param.put("COO_CERTIFY_NO", dao.selectCooCertifyNoGet(param));
			}

			param.put("CREATE_BY", param.get("USER_ID"));
			param.put("UPDATE_BY", param.get("USER_ID"));

			dao.insertExtCooCertifyMst(param);

			Set<String> poUpdatedItemSet = new HashSet<String>();

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
				row.put("CREATE_BY", param.get("USER_ID"));
				row.put("UPDATE_BY", param.get("USER_ID"));

				if (cover) {
					dao.updateExtCooCertifyDtl(row);
				}

				dao.insertExtCooCertifyDtl(row);

				if (cover) {

					String itemCode = String.valueOf(row.get("ITEM_CODE"));

					if (!poUpdatedItemSet.contains(itemCode)) {
						dao.updatePoLedger(row);
						poUpdatedItemSet.add(itemCode);
					}
				}
			}

			if (!cover) {
				dao.updatePoLedger(param);
			}

			if (renew) {
				dao.copyExtCooCertifyFiles(param);
			}

			if (files != null) {

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
	@Transactional
	public Result deleteExtCooCertifyFile(Map<String, Object> param) {

		Result result = new Result();

		try {
			CooConfirmationDao dao = sqlSession.getMapper(CooConfirmationDao.class);

			int deleteCount = dao.deleteExtCooCertifyFile(param);

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

	public Map<String, Object> extCooCertifyFileDownLoad(Map<String, Object> param) {
		return sqlSession.getMapper(CooConfirmationDao.class).extCooCertifyFileDownLoad(param);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result retrieveCooConfirmationListNationCode(Map<String, Object> param) {

		Result result = new Result();

		try {
			CooConfirmationDao dao = sqlSession.getMapper(CooConfirmationDao.class);

			result.setValue(dao.retrieveCooConfirmationListNationCode(param));
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);

		} catch (Exception e) {
			logger.error("retrieveCooConfirmationListNationCode error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

}