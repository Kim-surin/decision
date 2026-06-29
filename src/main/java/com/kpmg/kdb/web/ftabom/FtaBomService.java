package com.kpmg.kdb.web.ftabom;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailResponseDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomMasterRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomMasterResponseDto;

@Service
public class FtaBomService extends GeneralService {
	public Result retrieveftaBomMaster(FtaBomMasterRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<FtaBomMasterResponseDto> list = sqlSession.getMapper(FtaBomDao.class).retrieveftaBomMaster(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveftaBomDetail(FtaBomDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<FtaBomDetailResponseDto> list = sqlSession.getMapper(FtaBomDao.class).retrieveftaBomDetail(param);

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
