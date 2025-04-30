package com.kpmg.kdb.schedule.quartz.job.factory;

import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.schedule.quartz.job.vo.TransferJobValueObject;



public abstract class BatchFactory {
	
	
	public final BatchProcess cerate(BatchJobValueObject batchVo, TransferBatchLogger logger) throws Exception {
		BatchProcess processor = this.createProcess(batchVo, logger);
		
		return processor;
	}
	
	public final BatchProcess cerate(TransferJobValueObject jobVo, BatchJobValueObject batchVo) throws Exception {
		BatchProcess processor = this.createProcess(jobVo, batchVo);
		
		return processor;
	}
	
	// 인터페이스 완료 후 실업무 테이블로 이관하기 위한 프로시져 호출
	protected abstract BatchProcess createProcess(BatchJobValueObject batchVo, TransferBatchLogger logger) throws Exception;
	
	// 외부 시스템간의 인터페이스를 처리하기 위한 배치 프로세스 실행
	protected abstract BatchProcess createProcess(TransferJobValueObject jobVo, BatchJobValueObject batchVo) throws Exception;
	
}
