package com.kpmg.kdb.core.procedurelog;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.generic.GeneralService;

// AS-IS PKG00_PROCEDURE_LOG 대응. 각 메서드는 원본의 PRAGMA AUTONOMOUS_TRANSACTION과 동일하게
// 호출자 트랜잭션과 별도로 커밋되어야 하므로 REQUIRES_NEW로 실행하고, 로그 저장 실패가 호출자(실제
// 원산지 판정 로직)에 영향을 주지 않도록 예외를 흡수한다(원본의 EXCEPTION WHEN OTHERS THEN ROLLBACK 대응).
// REQUIRES_NEW가 실제로 걸리려면 반드시 스프링 빈(프록시)을 통해 호출해야 하며, 이 클래스 내부에서
// 메서드끼리 this로 직접 호출하면 안 된다(자기호출은 프록시를 우회해 새 트랜잭션이 시작되지 않는다).
// batchLogDtl/flushDtl처럼 같은 클래스의 다른 @Transactional 메서드를 내부에서 호출해야 하는 경우엔
// self(지연 주입된 자기 자신의 프록시)를 통해 부른다.
@Service
public class ProcedureLogService extends GeneralService {

	private static final String JOB_TYPE = "S";
	/** 이 개수만큼 쌓이면 즉시 flush한다. 무한정 메모리에 들고 있으면 프로세스가 죽었을 때 그만큼
	 * 통째로 유실되므로(로그를 남기는 목적 자체가 "죽어도 진행상황이 남아있게"), 너무 크게 잡지 않는다. */
	private static final int DTL_BUFFER_FLUSH_SIZE = 20;

	/** logId별로 아직 DB에 쓰지 않은 BATCH_LOG_DTL 내용을 순서대로 모아두는 버퍼 */
	private final Map<Long, List<String>> pendingDtl = new ConcurrentHashMap<>();

	@Autowired
	@Lazy
	private ProcedureLogService self;

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

	// BATCH_LOG_DTL 대응. 매 호출마다 즉시 커밋하는 대신 메모리에 모아뒀다가 DTL_BUFFER_FLUSH_SIZE만큼
	// 쌓이면 배치로 flush해 왕복 횟수를 줄인다. 남은 내용은 flushDtl(수동)이나 batchLogLast(자동)가 마저 비운다.
	public void batchLogDtl(Long logId, String logContents) {
		if (logId == null) {
			return;
		}
		List<String> buffered = pendingDtl.computeIfAbsent(logId, k -> new ArrayList<>());
		boolean shouldFlush;
		synchronized (buffered) {
			buffered.add(logContents);
			shouldFlush = buffered.size() >= DTL_BUFFER_FLUSH_SIZE;
		}
		if (shouldFlush) {
			self.flushDtl(logId);
		}
	}

	/** 버퍼에 쌓인 DTL을 지금 즉시 배치로 기록한다(REQUIRES_NEW). 실패해도 예외를 흡수해 호출자에
	 * 영향을 주지 않는다 — 이 경우 flush 시도했던 내용은 유실된다(원본도 로그 실패를 그냥 흡수한다). */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void flushDtl(Long logId) {
		if (logId == null) {
			return;
		}
		List<String> buffered = pendingDtl.get(logId);
		if (buffered == null) {
			return;
		}
		List<String> toFlush;
		synchronized (buffered) {
			if (buffered.isEmpty()) {
				return;
			}
			toFlush = new ArrayList<>(buffered);
			buffered.clear();
		}
		try {
			sqlSession.getMapper(ProcedureLogDao.class).insertDtlBatch(logId, toFlush);
		} catch (Exception e) {
			logger.error("BATCH_LOG_DTL(배치) 실패. logId={}, count={}", logId, toFlush.size(), e);
		}
	}

	/** BATCH_LOG_LAST 대응. status: 'N'(정상 종료)/'E'(오류). 남은 DTL 버퍼를 먼저 flush해
	 * 완료 표시보다 상세 로그가 늦게 찍히는 역전을 막는다. */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void batchLogLast(Long logId, String status, String resultCode, String resultMessage) {
		if (logId == null) {
			return;
		}
		self.flushDtl(logId);
		pendingDtl.remove(logId);
		try {
			sqlSession.getMapper(ProcedureLogDao.class).updateMstEnd(logId, status, resultCode, resultMessage);
		} catch (Exception e) {
			logger.error("BATCH_LOG_LAST 실패. logId={}", logId, e);
		}
	}
}
