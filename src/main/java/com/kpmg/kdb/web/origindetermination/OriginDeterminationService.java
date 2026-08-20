package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultResponseDto;

@Service
public class OriginDeterminationService extends GeneralService {
	public Result retrieveDomesticOriginDetermination(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDetermination(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	public Result retrieveExportOriginDetermination(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveExportOriginDetermination(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	public Result retrieveOriginDeterminationResult(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveOriginDeterminationResult(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveDomesticOriginDeterminationDetailList(OriginDeterminationDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationDetailResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationDetailList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveDomesticOriginDeterminationResultList(OriginDeterminationResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResultResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationResultList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveDomesticOriginDeterminationResultDetailList(OriginDeterminationResultDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResultDetailResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationResultDetailList(param);

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
