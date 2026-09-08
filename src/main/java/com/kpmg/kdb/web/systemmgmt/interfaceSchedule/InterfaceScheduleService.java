package com.kpmg.kdb.web.systemmgmt.interfaceSchedule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceScheduleService extends GeneralService {

    private static final Logger logger = LoggerFactory.getLogger(InterfaceScheduleService.class);

    public Result retrieveScheduleList(Map<String, Object> param) {
        Result result = new Result();
        result.setValue(sqlSession.getMapper(InterfaceScheduleDao.class).retrieveScheduleList(param));
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    public Result retrieveScheduleDetail(Map<String, Object> param) {
        InterfaceScheduleDao dao = sqlSession.getMapper(InterfaceScheduleDao.class);
        Map<String, Object> value = new HashMap<String, Object>();
        value.put("schedule", dao.retrieveScheduleDetail(param));
        value.put("mappings", dao.retrieveScheduleMappingList(param));

        Result result = new Result();
        result.setValue(value);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    /** 사용 중인 인터페이스 항목 Combo 목록 조회 */
    public Result retrieveInterfaceItemCombo(Map<String, Object> param) {
        Result result = new Result();
        result.setValue(sqlSession.getMapper(InterfaceScheduleDao.class).retrieveInterfaceItemCombo(param));
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    public Result saveSchedule(Map<String, Object> param) {
        String saveType = text(param.get("save_type"));
        String scheduleCode = text(param.get("schedule_code"));

        // 기존 데이터의 선택값이 NULL이거나 상세 팝업에서 hidden 값이 누락된 경우 기본값을 적용한다.
        if (text(param.get("system_batch_yn")).isEmpty()) {
            param.put("system_batch_yn", "N");
        }
        if (text(param.get("batch_yyyymm_yn")).isEmpty()) {
            param.put("batch_yyyymm_yn", "N");
        }

        if (scheduleCode.length() == 0 || text(param.get("schedule_name")).length() == 0) {
            return failure("스케줄 코드와 스케줄 명을 입력해 주세요.");
        }
        if (text(param.get("schedule_desc")).length() == 0) {
            return failure("스케줄 설명을 입력해 주세요.");
        }
        if (!isDate(text(param.get("apply_from_date")))
                || (!text(param.get("apply_to_date")).isEmpty() && !isDate(text(param.get("apply_to_date"))))) {
            return failure("적용기간은 YYYYMMDD 형식으로 입력해 주세요.");
        }
        if (!isYn(param.get("system_batch_yn"))) {
            return failure("시스템 실행 여부를 올바르게 선택해 주세요.");
        }
        if (!isYn(param.get("batch_yyyymm_yn"))) {
            return failure("배치 적용 기준년월 반영 여부를 올바르게 선택해 주세요.");
        }

        InterfaceScheduleDao dao = sqlSession.getMapper(InterfaceScheduleDao.class);
        if ("I".equals(saveType)) {
            if (dao.retrieveScheduleCount(param) > 0) {
                return failure("이미 등록된 스케줄 코드입니다.");
            }
            dao.insertSchedule(param);
        } else if ("U".equals(saveType)) {
            if (dao.updateSchedule(param) == 0) {
                return failure("수정할 스케줄을 찾을 수 없습니다.");
            }
        } else {
            return failure("저장 구분값이 올바르지 않습니다.");
        }

        // Grid에서 삭제된 행까지 DB에 확실히 반영되도록 기존 매핑을 모두 삭제한 뒤
        // 화면에서 전달된 현재 행만 순서대로 재등록한다.
        dao.deleteScheduleMapping(param);
        List<Map<String, Object>> mappings = mappingList(param.get("mappings"));
        short seq = 1;
        for (Map<String, Object> mapping : mappings) {
            if (text(mapping.get("if_code")).isEmpty()) {
                continue;
            }
            mapping.put("schedule_code", scheduleCode);
            mapping.put("company_code", param.get("company_code"));
            mapping.put("schedule_seq", seq++);
            mapping.put("update_by", param.get("update_by"));
            if (!isYn(mapping.get("required_yn"))) mapping.put("required_yn", "N");
            if (!isYn(mapping.get("auto_batch_yn"))) mapping.put("auto_batch_yn", "Y");
            dao.insertScheduleMapping(mapping);
        }

        Map<String, Object> value = new HashMap<String, Object>();
        value.put("schedule_code", scheduleCode);
        Result result = new Result();
        result.setValue(value);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    public Result restoreScheduleStatus(Map<String, Object> param) {
        if (sqlSession.getMapper(InterfaceScheduleDao.class).restoreScheduleStatus(param) == 0) {
            return failure("복원할 스케줄을 찾을 수 없습니다.");
        }
        Result result = new Result();
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    private List<Map<String, Object>> mappingList(Object value) {
        return value instanceof List ? (List<Map<String, Object>>) value : new ArrayList<Map<String, Object>>();
    }

    private boolean isDate(String value) {
        return value.matches("\\d{8}");
    }

    private boolean isYn(Object value) {
        return "Y".equals(text(value)) || "N".equals(text(value));
    }

    private String text(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }

    private Result failure(String message) {
        logger.warn(message);
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
