package com.kpmg.kdb.core.procedurelog;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.generic.GeneralService;

// AS-IS PKG00_PROCEDURE_LOG 대응. 각 메서드는 원본의 PRAGMA AUTONOMOUS_TRANSACTION과 동일하게
// 호출자 트랜잭션과 별도로 커밋되어야 하므로 REQUIRES_NEW로 실행하고, 로그 저장 실패가 호출자(실제
// 원산지 판정 로직)에 영향을 주지 않도록 예외를 흡수한다(원본의 EXCEPTION WHEN OTHERS THEN ROLLBACK 대응).
// REQUIRES_NEW가 실제로 걸리려면 반드시 스프링 빈(프록시)을 통해 호출해야 하며, 이 클래스 내부에서
// 메서드끼리 this로 직접 호출하면 안 된다(자기호출은 프록시를 우회해 새 트랜잭션이 시작되지 않는다).
@Service
public class ProcedureLogService extends GeneralService {

	private static final String JOB_TYPE = "S";

	/** BATCH_LOG 대응. 새 로그 마스터를 만들고 log_id를 반환한다. 저장 자체가 실패하면 null을 반환한다
	 * (이후 batchLogDtl/batchLogLast는 logId가 null이면 아무 것도 하지 않는다). */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public Long batchLog(String procedureId, String companyCode, String inputParameter) {
		try {
			ProcedureLogDao dao = sqlSession.getMapper(ProcedureLogDao.class);
			Long logId = dao.nextLogId();
			dao.insertMst(logId, procedureId, JOB_TYPE, companyCode, inputParameter);
			return logId;
		} catch (Exception e) {
			logger.error("BATCH_LOG 실패. procedureId={}, companyCode={}", procedureId, companyCode, e);
			return null;
		}
	}

	/** BATCH_LOG_DTL 대응 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void batchLogDtl(Long logId, String logContents) {
		if (logId == null) {
			return;
		}
		try {
			sqlSession.getMapper(ProcedureLogDao.class).insertDtl(logId, logContents);
		} catch (Exception e) {
			logger.error("BATCH_LOG_DTL 실패. logId={}", logId, e);
		}
	}

	/** BATCH_LOG_LAST 대응. status: 'N'(정상 종료)/'E'(오류) */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void batchLogLast(Long logId, String status, String resultCode, String resultMessage) {
		if (logId == null) {
			return;
		}
		try {
			sqlSession.getMapper(ProcedureLogDao.class).updateMstEnd(logId, status, resultCode, resultMessage);
		} catch (Exception e) {
			logger.error("BATCH_LOG_LAST 실패. logId={}", logId, e);
		}
	}
}
