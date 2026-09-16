package com.kpmg.kdb.core.procedurelog;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

// procedure_log_mst/dtl 실제 기록. 별도 빈이라 ProcedureLogService가 프록시로 호출 — 트랜잭션 시작/커밋
// 실패까지 호출자 try/catch로 잡힌다(같은 클래스 self-invocation이었다면 이 경계를 못 잡았을 것).
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
