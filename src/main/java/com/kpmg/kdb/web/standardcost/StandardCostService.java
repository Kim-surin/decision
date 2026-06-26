package com.kpmg.kdb.web.standardcost;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.standardcost.dto.StandardCostRequestDto;
import com.kpmg.kdb.web.standardcost.dto.StandardCostResponseDto;

@Service
public class StandardCostService extends GeneralService {
	public Result retrieveStandardCost(StandardCostRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<StandardCostResponseDto> list = sqlSession.getMapper(StandardCostDao.class)
					.retrieveStandardCost(param);

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
