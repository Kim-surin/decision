package com.kpmg.kdb.core.procedurelog;

import org.apache.ibatis.annotations.Param;

// AS-IS PKG00_PROCEDURE_LOG(PROCEDURE_LOG_MST/DTL) 대응. ProcedureLogService가 사용한다.
public interface ProcedureLogDao {

	/** BATCH_LOG 대응. logId는 시퀀스로 채번해 파라미터 맵에 채워 넣는다(selectKey). */
	void insertMst(@Param("logId") Long logId, @Param("procedureId") String procedureId,
			@Param("jobType") String jobType, @Param("companyCode") String companyCode,
			@Param("inputParameter") String inputParameter);

	/** BATCH_LOG_LAST 대응 */
	void updateMstEnd(@Param("logId") Long logId, @Param("status") String status,
			@Param("resultCode") String resultCode, @Param("resultMessage") String resultMessage);

	/** BATCH_LOG_DTL 대응. seq는 log_id별로 순차 채번한다. */
	void insertDtl(@Param("logId") Long logId, @Param("logContents") String logContents);

	Long nextLogId();
}
