package com.kpmg.kdb.core.procedurelog;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

// AS-IS PKG00_PROCEDURE_LOG(BATCH_LOG/BATCH_LOG_DTL/BATCH_LOG_LAST)를 대체한다. AS-IS가
// PRAGMA AUTONOMOUS_TRANSACTION으로 로그를 별도 트랜잭션에 남겨 상위 트랜잭션 롤백과 무관하게 로그가
// 남도록 한 것처럼, 여기서도 REQUIRES_NEW로 별도 물리 트랜잭션을 열어 즉시 커밋한다. 로그 기록 자체의
// 실패가 본 업무 트랜잭션에 영향을 주면 안 되므로 예외는 흡수하고 경고만 남긴다.
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
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	/** AS-IS BATCH_LOG 대응. procedure_log_mst 1건을 새로 만들고 log_id를 반환한다. 실패 시 -1을 반환한다. */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public long start(String procedureId, String companyCode, String inputParameter) {
		Map<String, Object> param = new HashMap<>();
		param.put("applyDate", LocalDate.now().format(YYYYMMDD));
		param.put("procedureId", procedureId);
		param.put("jobType", JOB_TYPE);
		param.put("companyCode", companyCode);
		param.put("inputParameter", truncate(inputParameter, 200));
		param.put("status", STATUS_START);

		try {
			sqlSession.getMapper(ProcedureLogDao.class).insertMst(param);
			return ((Number) param.get("logId")).longValue();
		} catch (Exception e) {
			logger.error("procedure_log_mst 기록 실패. procedureId={}", procedureId, e);
			return -1L;
		}
	}

	/** AS-IS BATCH_LOG_DTL 대응. */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public void detail(long logId, String message) {
		if (logId < 0) {
			return;
		}
		Map<String, Object> param = new HashMap<>();
		param.put("logId", logId);
		param.put("logContents", truncate(message, 4000));
		try {
			sqlSession.getMapper(ProcedureLogDao.class).insertDtl(param);
		} catch (Exception e) {
			logger.error("procedure_log_dtl 기록 실패. logId={}", logId, e);
		}
	}

	/** AS-IS BATCH_LOG_LAST(정상) 대응. */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public void success(long logId, String resultMessage) {
		end(logId, STATUS_SUCCESS, null, resultMessage);
	}

	/** AS-IS BATCH_LOG_LAST(오류) 대응. */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
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
			sqlSession.getMapper(ProcedureLogDao.class).updateMstEnd(param);
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
