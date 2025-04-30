package com.kpmg.kdb.schedule.quartz.job.transfer;

import java.util.List;
import java.util.Map;

public interface ProcedureTransWorker {

	public Map<String, Object> executeRemoteProcedure(Map  param);

	public List<Object> retrieveGeneratedData(Map<String, Object> param);

}
