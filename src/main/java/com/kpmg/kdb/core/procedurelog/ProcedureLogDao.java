package com.kpmg.kdb.core.procedurelog;

import java.util.Map;

/**
 * PROCEDURE_LOG_MST / PROCEDURE_LOG_DTL 로그 테이블 DAO.
 */
public interface ProcedureLogDao {

	void insertMst(Map<String, Object> param);

	void updateMstEnd(Map<String, Object> param);

	void insertDtl(Map<String, Object> param);
}
