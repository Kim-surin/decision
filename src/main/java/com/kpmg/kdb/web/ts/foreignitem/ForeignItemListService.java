package com.kpmg.kdb.web.ts.foreignitem;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes" })
public class ForeignItemListService extends GeneralService {

	static Logger logger = LoggerFactory.getLogger(ForeignItemListService.class);

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result retrieveForeignItem(Map<String, Object> param) {
		Result result = new Result();

		try {
			List<Map<String, Object>> list = sqlSession.getMapper(ForeignItemListDao.class).retrieveForeignItem(param);
			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			logger.error("retrieveForeignItem error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}