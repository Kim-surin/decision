package com.kpmg.kdb.schedule.quartz.job.logger;

import java.util.List;

import org.quartz.JobExecutionContext;

public interface TransferBatchLogger {

	
	public void setContext(JobExecutionContext ctx);

	
	public JobExecutionContext getContext();

	
	public void setTransactionID(String id);

	
	public void logStart(String batchTarget, List<Object> args)
			throws Exception;

	
	public void logEnd(boolean succ, String message) throws Exception;

	
	public void logEnd(boolean succ) throws Exception;

	
	public void logMessage(String message) throws Exception;

	public void logMessage(String message, List<Object> args) throws Exception;

	
	public void setStatus(String key, Object status);

	
	public Object getStatus(String key);

	
	public Object getStatus(String key, Object defValue);

	
	public void logStatus() throws Exception;
}
