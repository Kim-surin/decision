package com.kpmg.kdb.core.procedurelog;

import java.util.List;

import org.apache.ibatis.annotations.Param;

// AS-IS PKG00_PROCEDURE_LOG(PROCEDURE_LOG_MST/DTL) 대응. ProcedureLogService가 사용한다.
public interface ProcedureLogDao {

	/** BATCH_LOG 대응. logId는 호출측이 nextLogId()로 미리 채번해 그대로 넘긴다. */
	void insertMst(@Param("logId") Long logId, @Param("procedureId") String procedureId,
			@Param("jobType") String jobType, @Param("companyCode") String companyCode,
			@Param("inputParameter") String inputParameter);

	/** BATCH_LOG_LAST 대응 */
	void updateMstEnd(@Param("logId") Long logId, @Param("status") String status,
			@Param("resultCode") String resultCode, @Param("resultMessage") String resultMessage);

	/** BATCH_LOG_DTL 대응(배치). contents 리스트 순서 그대로 log_id의 현재 MAX(SEQ) 다음부터 이어서 채번한다. */
	void insertDtlBatch(@Param("logId") Long logId, @Param("contents") List<String> contents);

	Long nextLogId();
}
