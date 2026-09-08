package com.kpmg.kdb.web.systemmgmt.interfaceManualExecution;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InterfaceManualExecutionService extends GeneralService {

    //private final JobLauncher jobLauncher;
    private final ApplicationContext applicationContext;

    public InterfaceManualExecutionService(ApplicationContext applicationContext) {
        //this.jobLauncher = jobLauncher;
        this.applicationContext = applicationContext;
    }

    public Result retrieveScheduleCombo(Map<String, Object> param) {
        return success(dao().retrieveScheduleCombo(param));
    }

    public Result retrieveInterfaceCombo(Map<String, Object> param) {
        return success(dao().retrieveInterfaceCombo(param));
    }

    public Result executeInterface(Map<String, Object> param) throws Exception {
        String scheduleCode = text(param.get("schedule_code"));
        String ifCode = text(param.get("if_code"));
        String fromDate = digits(param.get("from_date"));
        String toDate = digits(param.get("to_date"));

        if (!StringUtils.hasText(scheduleCode) || !StringUtils.hasText(ifCode)) {
            return failure("배치 명과 인터페이스 명을 선택해 주세요.");
        }
        if (fromDate.length() != 8 || toDate.length() != 8) {
            return failure("기준일자는 YYYYMMDD 형식으로 입력해 주세요.");
        }
        if (fromDate.compareTo(toDate) > 0) {
            return failure("기준 시작일자는 종료일자보다 클 수 없습니다.");
        }

        param.put("schedule_code", scheduleCode);
        param.put("if_code", ifCode);
        Map<String, Object> target = dao().retrieveExecutionTarget(param);
        if (target == null || !StringUtils.hasText(text(target.get("execution_program")))) {
            return failure("실행 프로그램이 등록되지 않은 스케줄입니다.");
        }

        String programName = text(target.get("execution_program"));
        if (!applicationContext.containsBean(programName)) {
            return failure("실행 프로그램 Bean을 찾을 수 없습니다. (" + programName + ")");
        }

		/*
		 * Job job = applicationContext.getBean(programName, Job.class); JobParameters
		 * jobParameters = new JobParametersBuilder() .addString("company_code",
		 * text(param.get("company_code"))) .addString("schedule_code", scheduleCode)
		 * .addString("if_code", ifCode) .addString("from_date", fromDate)
		 * .addString("to_date", toDate) .addLong("manual_request_time",
		 * System.currentTimeMillis()) .toJobParameters();
		 * 
		 * jobLauncher.run(job, jobParameters);
		 */
        return success(null);
    }

    public Result retrieveExecutionResultList(Map<String, Object> param) {
        normalizeDates(param);
        return success(dao().retrieveExecutionResultList(param));
    }

    public Result retrieveExecutionDetail(Map<String, Object> param) {
        Map<String, Object> value = new HashMap<String, Object>();
        value.put("columns", dao().retrieveExecutionDetailColumns(param));
        value.put("rows", dao().retrieveExecutionDetailList(param));
        return success(value);
    }

    private InterfaceManualExecutionDao dao() {
        return sqlSession.getMapper(InterfaceManualExecutionDao.class);
    }

    private void normalizeDates(Map<String, Object> param) {
        param.put("search_from_date", digits(param.get("search_from_date")));
        param.put("search_to_date", digits(param.get("search_to_date")));
    }

    private String digits(Object value) {
        return text(value).replaceAll("[^0-9]", "");
    }

    private String text(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }

    private Result success(Object value) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        result.setValue(value);
        return result;
    }

    private Result failure(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
