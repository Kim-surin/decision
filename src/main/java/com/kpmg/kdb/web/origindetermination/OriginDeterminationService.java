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
}
