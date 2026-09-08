package com.kpmg.kdb.web.ftabom;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
public class FtaBomService extends GeneralService {
	public Result retrieveftaBomMaster(Map param) throws Exception {
		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(FtaBomDao.class).retrieveftaBomMaster(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveftaBomDetail(Map param) throws Exception {
		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(FtaBomDao.class).retrieveftaBomDetail(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	public Result retrieveftaBomDetailVendor(Map param) throws Exception {
		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(FtaBomDao.class).retrieveftaBomDetailVendor(param);

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
