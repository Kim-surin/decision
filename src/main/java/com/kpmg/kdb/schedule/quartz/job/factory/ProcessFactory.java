package com.kpmg.kdb.schedule.quartz.job.factory;

import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.schedule.quartz.job.process.ProcedureProcess;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.schedule.quartz.job.vo.TransferJobValueObject;



public class ProcessFactory extends BatchFactory {
	
	
	public BatchProcess createProcess(BatchJobValueObject batchVo, TransferBatchLogger logger) throws Exception {
		return null;
	}
	
	
	public BatchProcess createProcess(TransferJobValueObject jobVo, BatchJobValueObject batchVo) throws Exception {
		BatchProcess process = null;
		process = new ProcedureProcess(jobVo, batchVo);
		
		return process;
	}

}
