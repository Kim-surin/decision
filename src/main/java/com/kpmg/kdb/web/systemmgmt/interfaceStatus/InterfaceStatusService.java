package com.kpmg.kdb.web.systemmgmt.interfaceStatus;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceStatusService extends GeneralService {

    public Result retrieveScheduleStatusList(Map<String, Object> param) {
        return success(sqlSession.getMapper(InterfaceStatusDao.class).retrieveScheduleStatusList(param));
    }

    public Result retrieveTransferList(Map<String, Object> param) {
        return success(sqlSession.getMapper(InterfaceStatusDao.class).retrieveTransferList(param));
    }

    public Result retrieveTransferDetail(Map<String, Object> param) {
        InterfaceStatusDao dao = sqlSession.getMapper(InterfaceStatusDao.class);
        Map<String, Object> value = new HashMap<String, Object>();
        value.put("columns", dao.retrieveTransferDetailColumns(param));
        value.put("rows", dao.retrieveTransferDetailList(param));
        return success(value);
    }

    private Result success(Object value) {
        Result result = new Result();
        result.setValue(value);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }
}
