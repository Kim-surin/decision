package com.kpmg.kdb.schedule.quartz.job.service;

import java.util.List;
import java.util.Map;

public interface BatchDao {

	public Map<String, Object> retrieveDataTransferMaster(Map<String, Object> param);

	public List<Map<String, Object>> retrieveDataTransferDetail(Map<String, Object> param);

	public List<Map<String, Object>> retrieveBatchDate(Map<String, Object> param);

	public List<Map<String, Object>> retrieveResultMessage(Map<String, Object> param);

	public int modifyFinishedTime(Map<String, Object> param);

	public int modifyProcedureResult(Map<String, Object> param);

	@SuppressWarnings("rawtypes")
	public Map executeProcedureMaster(Map<String, Object> param);
	
	@SuppressWarnings("rawtypes")
	public Map executeProcedureMonthly(Map<String, Object> param);
	
	@SuppressWarnings("rawtypes")
	public Map executeProcedureDaily(Map<String, Object> param);

	int modifyInterfaceScheduleDate(Map<String, Object> param);

	public int deleteInterfaceTable(Map<String, Object> param);

	public List<Map<String, Object>> retrieveBatchResultInfo(Map<String, Object> param);

	public List<Map<String, Object>> retrieveInterfaceMappingList(Map<String, Object> param);

	public List<Map<String, Object>> retrieveInterfaceScheduleList(Map<String, Object> param);

	public int createToTargetData(Map<String, Object> param);

	public List<Map<String, Object>> retrieveSchedulerItemList(Map<String, Object> param);

	int modifyTransInfoData(Map<String, Object> param);

	public int createTransDtlData(Map<String, Object> param);
	int modifyJcoCountData(Map<String, Object> param);

	public int createTransInfoData(Map<String, Object> param);

	public String retrieveTransKey();

	int modifyScheduleBatchDate(Map<String, Object> param);

}
