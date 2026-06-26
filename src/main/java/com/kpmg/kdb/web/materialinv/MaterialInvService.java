package com.kpmg.kdb.web.materialinv;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.materialinv.dto.MaterialInvRequestDto;
import com.kpmg.kdb.web.materialinv.dto.MaterialInvResponseDto;

@Service
public class MaterialInvService extends GeneralService {
	public Result retrieveMaterialInv(MaterialInvRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<MaterialInvResponseDto> list = sqlSession.getMapper(MaterialInvDao.class).retrieveMaterialInv(param);

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
