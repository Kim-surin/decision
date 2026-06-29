package com.kpmg.kdb.web.sales;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.sales.dto.SalesRequestDto;
import com.kpmg.kdb.web.sales.dto.SalesResponseDto;

@Service
public class SalesService extends GeneralService {
	public Result retrieveSales(SalesRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<SalesResponseDto> list = sqlSession.getMapper(SalesDao.class).retrieveSales(param);

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
