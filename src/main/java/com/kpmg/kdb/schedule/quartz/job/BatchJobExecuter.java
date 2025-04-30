package com.kpmg.kdb.schedule.quartz.job;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.schedule.quartz.job.factory.BatchFactory;
import com.kpmg.kdb.schedule.quartz.job.factory.BatchProcess;
import com.kpmg.kdb.schedule.quartz.job.factory.ProcessFactory;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLoggerImpl;
import com.kpmg.kdb.schedule.quartz.job.service.BatchService;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.schedule.quartz.job.vo.ParameterVo;
import com.kpmg.kdb.schedule.quartz.job.vo.TransferJobValueObject;
import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.DateUtil;
import com.kpmg.kdb.util.StringUtil;

public class BatchJobExecuter implements Job {

	private static Log log = LogFactory.getLog(BatchJobExecuter.class);
	    
    private static String memberID;
    
    private TransferJobValueObject jobVo;
    
    private BatchService batchTarget;
    
    private long stime = 0;
    
    /**
     * class initializer
     */
    static {
        configure();
    }
    
    /**
     * properties 파일에 설정된 값을 구한다.
     */
    private static void configure() {
        try {
            PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
            
            memberID = StringUtil.null2String(configurator.getString("batch.worker.name"));
            
            if (log.isDebugEnabled()) {
                log.debug("user id=" + memberID);
            }
        } catch (Exception ex) {
            if (log.isErrorEnabled()) {
                log.error("exception: \n" + ex);
            }
        }
    }
    
    public BatchJobExecuter() {
        stime = System.currentTimeMillis(); // 수행 시간 계산용
        
        if (jobVo == null) {
            jobVo = new TransferJobValueObject();
        }
        
        jobVo.setCreateBy(memberID);
        jobVo.setUpdateBy(memberID);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void execute(JobExecutionContext context) throws JobExecutionException {
        stime = System.currentTimeMillis(); // 수행 시간 계산용
        
        TransferBatchLogger logger = new TransferBatchLoggerImpl();
        
        String divisionCode = null;
        String fromDate = null;
        String toDate = null;
        String itemCode = null;
        String batchFlag = null;
        
        boolean result = true;
        BatchJobValueObject batchVo = null;
        
        
        String scheduleCode = StringUtil.null2String(context.getJobDetail().getKey().getName());
        String companyCode = StringUtil.null2String(context.getJobDetail().getKey().getGroup());
        
        
        jobVo.setScheduleCode(scheduleCode);
        jobVo.setCompanyCode(companyCode);
        jobVo.setBatchLogger(logger);
        
        if (log.isDebugEnabled()) {
            log.debug("Job Information : " + jobVo.toString());
        }
        
        ApplicationContext ctx = ApplicationContextAwareExtends.getApplicationContext();
        
		
        batchTarget =  (BatchService)ctx.getBean("batchService");
        
        try {
            // 배치 실행중으로 업데이트 수행
            jobVo.setStatus("1");
            batchTarget.updateInterfaceScheduleDate(jobVo.getMap());
            
            if(scheduleCode.equals("PENDING_BATCH")) {
            	this.excute(jobVo, batchVo);
            } else {
	            // 사용자 지정 정산월을 조회
	            List<Object> yyyymmList = batchTarget.selectBatchYYYYMM(jobVo.getMap());
	            
	            // 현재 년/월/일 구하기
	            String toYear = DateUtil.getSimpleDate("yyyy");
	            String toMonth = DateUtil.getSimpleDate("MM");
	            String toDay = DateUtil.getSimpleDate("dd");
	            
	            // Job 주기별로 기준일자를 구한다.
	            if (StringUtil.null2String(jobVo.getScheduleCode()).toUpperCase().startsWith("DAILY")) { // 일마감 배치
	                String period = StringUtil.null2String(((Map) yyyymmList.get(0)).get("EXEC_DAILY_PERIOD"), "1");
	                fromDate = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -(Integer.parseInt(period)), "day");
	                toDate = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -1, "day");
	                
	                batchFlag = "D";
	                
	                this.execute(jobVo, batchVo, fromDate, toDate, batchFlag);
	            } else if (StringUtil.null2String(jobVo.getScheduleCode()).toUpperCase().startsWith("MONTHLY")) { // 월마감 배치
	                String targetYear = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -1, "month", "year");
	                String targetMonth = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -1, "month", "month");
	                String lastDay = DateUtil.getLastDay(toYear, targetMonth);
	                
	                // default 로 현재월 기준으로 한달전을 적용하나, 등록된 값이 있으면 이를 적용된다.
	                if (yyyymmList != null && yyyymmList.size() > 0) {
	                    String execType = StringUtil.null2String(((Map) yyyymmList.get(0)).get("EXEC_TYPE"));
	                    int execPeriod = Integer.parseInt(StringUtil.null2String(((Map) yyyymmList.get(0)).get("EXEC_MONTHLY_PERIOD"), "0"));
	                    String execStartYymm = StringUtil.null2String(((Map) yyyymmList.get(0)).get("EXEC_MANUAL_START_YYYYMM"));
	                    String execEndYymm = StringUtil.null2String(((Map) yyyymmList.get(0)).get("EXEC_MANUAL_END_YYYYMM"));
	                    batchFlag = "M";
	                    
	                    if (execType.equals("1")) { // 개월지정
	                        for (int i = 1; i <= execPeriod; i++) {
	                            targetYear = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -(execPeriod - i + 1), "month", "year");
	                            targetMonth = DateUtil.getCalcDateAsString(toYear, toMonth, toDay, -(execPeriod - i + 1), "month", "month");
	                            lastDay = DateUtil.getLastDay(targetYear, targetMonth);
	                            
	                            if (StringUtil.null2String(jobVo.getScheduleCode()).toUpperCase().equals("MONTHLY_DECISION")) {
	                                fromDate = targetYear + targetMonth;
	                            } else {
	                            	fromDate = targetYear + targetMonth + "01";
	                            }
	                            toDate = targetYear + targetMonth + lastDay;
	                            
	                            if(log.isDebugEnabled()) log.debug("call MONTHLY_BATCH(about month) : " + "from=" + fromDate + ", to=" + toDate + ", info=" + jobVo.getMap());
	                            
	                            this.execute(jobVo, batchVo, fromDate, toDate, batchFlag);
	                        }
	                    } else if (execType.equals("2")) { // 기간지정
	                        String strtDate = execStartYymm;
	                        String endDate = execEndYymm;
	                        
	                        int strtYear = Integer.parseInt(strtDate.substring(0, 4));
	                        int strtMonth = Integer.parseInt(strtDate.substring(4, 6));
	                        int endYear = Integer.parseInt(endDate.substring(0, 4));
	                        int endMonth = Integer.parseInt(endDate.substring(4, 6));
	                        int month_diff = (endYear - strtYear) * 12 + (endMonth - strtMonth); // strtDate - endDate (개월수 차이)
	                        
	                        for (int i = 0; i <= month_diff; i++) {
	                            targetYear = DateUtil.getCalcDateAsString(strtYear + "", strtMonth + "", "01", i, "month", "year");
	                            targetMonth = DateUtil.getCalcDateAsString(strtYear + "", strtMonth + "", "01" + "", i, "month", "month");
	                            lastDay = DateUtil.getLastDay(targetYear, targetMonth);
	                            
	                            if (StringUtil.null2String(jobVo.getScheduleCode()).toUpperCase().equals("MONTHLY_DECISION")) {
	                                fromDate = targetYear + targetMonth;
	                            } else {
	                            	fromDate = targetYear + targetMonth + "01";
	                            }
	                            toDate = targetYear + targetMonth + lastDay;
	                            
	                            if(log.isDebugEnabled()) log.debug("call MONTHLY_BATCH(about priod) : " + "from=" + fromDate + ", to=" + toDate + ", info=" + jobVo.getMap());
	                            
	                            this.execute(jobVo, batchVo, fromDate, toDate, batchFlag);
	                        }
	                    }
	                }
	            }
            }
            
            if (log.isDebugEnabled()) log.debug("batch result = " + result);
        } catch (Exception exp) {
            try {
                // exp.printStackTrace();
                logger.logMessage("[ERROR] " + exp.getMessage());
            } catch (Exception ex) {
                // ex.printStackTrace();
            }
        } finally {
            try {
                // Job 상태를 대기중으로 변경, 최종 완료된 시간을 기록하고 사용자 배치 시간을 초기화한다.
                jobVo.setStatus("0");
                batchTarget.updateInterfaceScheduleDate(jobVo.getMap());

                long ftime = System.currentTimeMillis();
                
                if (log.isInfoEnabled()) {
                    log.info("finished batch(execute time = " + (ftime - stime) + " msec.)");
                }
                logger.logMessage("finished batch(execute time = " + (ftime - stime) + " msec.)");
            } catch (Exception exp) {
                try {
                    // exp.printStackTrace();
                    logger.logMessage("[ERROR] " + exp.getMessage());
                } catch (Exception ex) {
                    // ex.printStackTrace();
                }                
            }
        }
    }
    

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public void execute(TransferJobValueObject jobVo, BatchJobValueObject batchVo, String fromDate, String toDate, String batchFlag) throws Exception {
        TransferBatchLogger logger = new TransferBatchLoggerImpl();
        BatchFactory factory = new ProcessFactory();
        BatchProcess process = null;
        boolean result = true;
        
        try {
            // 타 시스템간의 인터페이스 수행
            List mappingList = batchTarget.selectInterfaceMappingList(jobVo.getMap());
            String interfaceId = batchTarget.selectTransKey();
            
            if (mappingList == null || mappingList.size() < 1) {
                logger.logMessage("Can not run the interface. interface item is empty");
            } else {
                if (log.isDebugEnabled()) log.debug("interface start for batch....");
                
                // 해당 Job에서 지정한 인터페이스 항목에 대해 배치를 수행한다.
                for (int i = 0; i < mappingList.size(); i++) {
                    Map<String, String> mappingMap = (Map<String, String>) mappingList.get(i);
                    
                    batchVo = new BatchJobValueObject();
                    
                    batchVo.setPutAll(mappingMap);
                    batchVo.setInterfaceId(interfaceId);
                    batchVo.setJcoId(mappingMap.get(Consistent.IF_BATCH_INTERFACE_CODE));
                    
                    // 파라메터 설정
                    ParameterVo paramVo = new ParameterVo();
                    
                    paramVo.setCompanyCode(jobVo.getCompanyCode());
                    paramVo.setFromDate(fromDate);
                    paramVo.setToDate(toDate);
                    // paramVo.setDivisionCode("");
                    // paramVo.setItemCode(itemCode);
                    paramVo.setBatchFlag(batchFlag);
                    paramVo.setIfCode(mappingMap.get(Consistent.IF_BATCH_INTERFACE_CODE));
                    
                    // 파라메터를 BatchVo에 저장
                    batchVo.setParameter(paramVo);
                    batchVo.setInterfaceParam(paramVo.toString());
                    
                    if (StringUtil.null2String(batchVo.getItemType()).equals("P")) { // 프로시져 타입
                        batchVo.setTotalRows("0");
                        batchVo.setJobInfo(jobVo.getMap());
                        batchVo.setTransStatus("1"); // 인터페이스 데이터 추출 작업이 없기 때문에 성공으로 등록함.
                    }
                    
                    process = factory.cerate(jobVo, batchVo);
                    result = process.applyBatch();
                    
                    if (result) {
                        batchVo.setTransStatus("1");
                        batchVo.setBatchStatus("S");
                        
                        // 배치가 완료된 최종 시간 및 상태를 업데이트한다.
                        batchTarget.updateFinishedTime(batchVo.getMap());
                    } else {
                        batchVo.setTransStatus("2");
                        batchVo.setBatchStatus("E");
                        batchVo.setErrorMessage(StringUtil.null2String(batchVo.getErrorMessage(), "An error occurred during the procedure is driven."));
                        
                        break;
                    }
                }
            }
        } catch (Exception exp) {
        	// exp.printStackTrace();
            try {
                logger.logMessage("[ERROR] " + exp.getMessage());
                // exp.printStackTrace();
                batchVo.setErrorMessage(exp.getCause().getMessage());
                result = false;                
            } catch (Exception ex) {
                // ex.printStackTrace();
            }
            
        } finally {
            try {
                // 배치가 완료된 최종 시간 및 상태를 업데이트한다.
                batchTarget.updateFinishedTime(batchVo.getMap());                
                
                long ftime = System.currentTimeMillis();
                
                if (log.isInfoEnabled()) {
                    log.info("finished batch(execute time = " + (ftime - stime) + " msec.)");
                }
                logger.logMessage("finished batch(execute time = " + (ftime - stime) + " msec.)");
                logger.logEnd(result);
            } catch (Exception exp) {
                try {
                    logger.logMessage("[ERROR] " + exp.getMessage());
                    // exp.printStackTrace();
                } catch (Exception ex) {
                    // ex.printStackTrace();
                }
                
            }
        }
    }
    

    public void excute(TransferJobValueObject jobVo, BatchJobValueObject batchVo) throws Exception {
    	TransferBatchLogger logger = new TransferBatchLoggerImpl();
    	BatchFactory factory = new ProcessFactory();
        BatchProcess process = null;
        boolean result = true;
        
        try {
        	batchVo = new BatchJobValueObject();
        	
        	ParameterVo paramVo = new ParameterVo();
            
            paramVo.setCompanyCode(jobVo.getCompanyCode());
            batchVo.setParameter(paramVo);
            batchVo.setItemType("X"); // xml
            batchVo.setInterfaceMethod("X"); // xml
            
	    	process = factory.cerate(jobVo, batchVo);
	        result = process.applyBatch();
        } catch (Exception exp) {
            try {
                logger.logMessage("[ERROR] " + exp.getMessage());
                // exp.printStackTrace();
                
                batchVo.setErrorMessage(exp.getCause().getMessage());
                result = false;                
            } catch (Exception ex) {
                // ex.printStackTrace();
            }
        } finally {
            try {
                // 배치가 완료된 최종 시간 및 상태를 업데이트한다.
                batchTarget.updateFinishedTime(batchVo.getMap());                
                
                long ftime = System.currentTimeMillis();
                
                if (log.isInfoEnabled()) {
                    log.info("finished batch(execute time = " + (ftime - stime) + " msec.)");
                }
                
                logger.logMessage("finished batch(execute time = " + (ftime - stime) + " msec.)");
                logger.logEnd(result);
            } catch (Exception exp) {
                try {
                    logger.logMessage("[ERROR] " + exp.getMessage());
                    // exp.printStackTrace();
                } catch (Exception ex) {
                    // ex.printStackTrace();
                }
                
            }
        }
    }
    
}
