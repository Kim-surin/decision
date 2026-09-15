package com.kpmg.kdb.core.procedurelog;

import java.util.Map;

/**
 * PROCEDURE_LOG_MST / PROCEDURE_LOG_DTL 로그 테이블 DAO.
 */
public interface ProcedureLogDao {

	void insertMst(Map<String, Object> param);

	void updateMstEnd(Map<String, Object> param);

	/** DTL의 seq 채번을 log_id 단위로 직렬화하기 위해 부모 MST 행을 잠근다. insertDtl과 같은 트랜잭션 안에서만 호출해야 한다. */
	Long lockMstForUpdate(Map<String, Object> param);

	void insertDtl(Map<String, Object> param);
}
