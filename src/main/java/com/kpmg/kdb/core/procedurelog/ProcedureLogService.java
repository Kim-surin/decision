package com.kpmg.kdb.core.procedurelog;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// AS-IS PKG00_PROCEDURE_LOG 대체. 실제 기록은 REQUIRES_NEW로 여는 ProcedureLogTransactionalWriter가 하고,
// 이 클래스는 그 호출(트랜잭션 시작/커밋 실패 포함)을 통째로 try/catch로 감싸 실패가 호출자에 전파되지 않게 한다.
@Service
public class ProcedureLogService {

	private static final Logger logger = LoggerFactory.getLogger(ProcedureLogService.class);

	/** AS-IS BATCH_LOG 호출부에서 관찰된 고정 리터럴. status(진행상태)와는 별개 컬럼이다. */
	private static final String JOB_TYPE = "S";
	private static final String STATUS_START = "S";
	private static final String STATUS_SUCCESS = "N";
	private static final String STATUS_ERROR = "E";

	private static final DateTimeFormatter YYYYMMDD = DateTimeFormatter.ofPattern("yyyyMMdd");

	@Autowired
	private ProcedureLogTransactionalWriter writer;

	/** AS-IS BATCH_LOG 대응. procedure_log_mst 1건을 새로 만들고 log_id를 반환한다. 실패 시 -1을 반환한다. */
	public long start(String procedureId, String companyCode, String inputParameter) {
		Map<String, Object> param = new HashMap<>();
		param.put("applyDate", LocalDate.now().format(YYYYMMDD));
		param.put("procedureId", procedureId);
		param.put("jobType", JOB_TYPE);
		param.put("companyCode", companyCode);
		param.put("inputParameter", truncate(inputParameter, 200));
		param.put("status", STATUS_START);

		try {
			return writer.insertMst(param);
		} catch (Exception e) {
			logger.error("procedure_log_mst 기록 실패. procedureId={}", procedureId, e);
			return -1L;
		}
	}

	/** AS-IS BATCH_LOG_DTL 대응. */
	public void detail(long logId, String message) {
		if (logId < 0) {
			return;
		}
		Map<String, Object> param = new HashMap<>();
		param.put("logId", logId);
		param.put("logContents", truncate(message, 4000));
		try {
			writer.insertDtl(param);
		} catch (Exception e) {
			logger.error("procedure_log_dtl 기록 실패. logId={}", logId, e);
		}
	}

	/** AS-IS BATCH_LOG_LAST(정상) 대응. */
	public void success(long logId, String resultMessage) {
		end(logId, STATUS_SUCCESS, null, resultMessage);
	}

	/** AS-IS BATCH_LOG_LAST(오류) 대응. */
	public void error(long logId, String resultCode, String resultMessage) {
		end(logId, STATUS_ERROR, resultCode, resultMessage);
	}

	private void end(long logId, String status, String resultCode, String resultMessage) {
		if (logId < 0) {
			return;
		}
		Map<String, Object> param = new HashMap<>();
		param.put("logId", logId);
		param.put("status", status);
		param.put("resultCode", truncate(resultCode, 40));
		param.put("resultMessage", truncate(resultMessage, 500));
		try {
			writer.updateMstEnd(param);
		} catch (Exception e) {
			logger.error("procedure_log_mst 종료처리 실패. logId={}", logId, e);
		}
	}

	private static String truncate(String value, int maxLength) {
		if (value == null) {
			return null;
		}
		return value.length() <= maxLength ? value : value.substring(0, maxLength);
	}
}
