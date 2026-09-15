package com.kpmg.kdb.core.procedurelog;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

// procedure_log_mst/dtl에 대한 실제 DB 기록. ProcedureLogService(별도 빈)가 이 빈의 메서드를 프록시를 통해
// 호출하므로, 트랜잭션 시작/커밋 단계에서 나는 예외(예: 커넥션풀 고갈에 의한 CannotCreateTransactionException)까지도
// 호출자 쪽 try/catch로 잡힌다 — 같은 클래스 안에서 @Transactional 메서드를 호출(self-invocation)했다면 이 경계를
// try/catch로 감싸도 트랜잭션 시작/커밋 실패 자체는 잡을 수 없었다.
@Service
class ProcedureLogTransactionalWriter {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public long insertMst(Map<String, Object> param) {
		sqlSession.getMapper(ProcedureLogDao.class).insertMst(param);
		return ((Number) param.get("logId")).longValue();
	}

	/** MAX(seq)+1 채번이 log_id 단위로 직렬화되도록 부모 MST 행을 먼저 잠근 뒤(FOR UPDATE) DTL을 넣는다. */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public void insertDtl(Map<String, Object> param) {
		ProcedureLogDao dao = sqlSession.getMapper(ProcedureLogDao.class);
		dao.lockMstForUpdate(param);
		dao.insertDtl(param);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public void updateMstEnd(Map<String, Object> param) {
		sqlSession.getMapper(ProcedureLogDao.class).updateMstEnd(param);
	}
}
