package com.kpmg.kdb.schedule.quartz.job;

import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.kpmg.kdb.web.schedule.quartz.QuartzService;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLoggerImpl;
import com.kpmg.kdb.schedule.quartz.job.service.BatchService;
import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.DateUtil;
import com.kpmg.kdb.util.StringUtil;



public class S4QuartzJobBean extends QuartzJobBean {
	
	private static Log log = LogFactory.getLog(S4QuartzJobBean.class);
	TransferBatchLogger logger = null;

    
	
	private BatchService batchService;
	
	@Autowired
    protected QuartzService service;
	
	
    public S4QuartzJobBean() {
        logger = new TransferBatchLoggerImpl();
    }
    
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
    	
    	
    	Properties p = new Properties();
    	String serverIP = "";
    	

		try {
	        InputStream is = getClass().getClassLoader().getResourceAsStream("config/appBatchJob.properties");

	        p.load(is);
	        is.close();
		}
		catch(java.io.IOException ie) {
			log.error("executeInternal not found rfc.properties \n{}", ie);
			
		}

		// Get Server IP 
    	try {
    		InetAddress serverAddressObject = InetAddress.getLocalHost();
    		serverIP = serverAddressObject.getHostAddress();
		} catch (UnknownHostException e) {
			
		}
		
    	// 배치를 수행할 수 있는 서버 IP
    	String runningServerIp = p.getProperty("batch.running.serverIP");
    	// 배치 수행 여부
    	String runningBatchYn = p.getProperty("batch.running.yn");
    	
    	
    	boolean runningFlag = false;
    	// 설정한 IP와 동일한 서버인지 체크 후 배치를 수행합니다.
    	if(!StringUtil.isEmpty(runningServerIp)){
    		if(runningServerIp.equalsIgnoreCase(serverIP)){
    			runningFlag = true;
    		}else{
        		log.error("### [ Ip is inconsistent. ] - Abort the operation.");
        		log.error("### Runnuing Server Ip : " + runningServerIp);
        		log.error("### Server Ip : " + serverIP);
        	}
    	}else{
    		log.error("### [ Running Server Ip is Null ] - The operation can not be performed..");
    		log.error("### [ Running Server Ip is Null ] - Please check your settings.(file : db/batchJob.properties");
    		
    	}
    	
		
		try {
	    	//배치를 사용하도록 설정되고 배치를 수행할 수 있는 서버인 경우 배치 수행
	    	if("Y".equalsIgnoreCase(runningBatchYn) && runningFlag){
			//if(true){
	    		
	    		Map<String, Object> map = new HashMap<String, Object>();
	    		ApplicationContext ctx = ApplicationContextAwareExtends.getApplicationContext();
	    		
	    		batchService =  (BatchService)ctx.getBean("batchService");
	    		List<Object> resultList = batchService.selectInterfaceScheduleList(map);
	    		Map<String, String> paramMap = null;
	    		
	    		for (int i = 0; i < resultList.size(); i++) {
                    paramMap = (Map<String, String>) resultList.get(i);
                    
                    Scheduler scheduler = BatchPoolManager.startBatch(paramMap);
                    
                    String triggerGroup = paramMap.get("COMPANY_CODE") + "_TRIGGER";
                    String triggerName = paramMap.get("SCHEDULE_CODE") + "Trigger";
                    
                    // 서버가 이중화되어 있을 경우 중복 실행되는 문제가 발생하는 것을 막는다.
                    // 동시간대에 다른 동일 스케쥴이 구동중인지 확인하는 방식임(일자,시,분으로 체크)
                    if (scheduler.isStarted()) {
                        String runningTime = paramMap.get("CURRENT_BATCH_DATE");
                        // Calendar cd = new GregorianCalendar(Locale.KOREA);
                        String currentTime = DateUtil.getCurrentYearAsString() + DateUtil.getCurrentMonthAsString() + DateUtil.getCurrentDayAsString() + DateUtil.getCurrentHourAsString() + DateUtil.getCurrentMinuteAsString();
                        
                        if (log.isDebugEnabled()) log.debug("runningTime = " + runningTime + ", currentTime=" + currentTime);
                        
                        if (runningTime.equals(currentTime)) {
                            boolean kill = BatchPoolManager.shutdownScheduler(scheduler, paramMap);
                            
                            if (kill) {
                                if (log.isDebugEnabled()) log.debug("interrupt... killed then batch(by same scheduler)");
                            } else {
                                if (log.isErrorEnabled()) log.error("interrupt error... not kill then batch(same scheduler)");
                            }
                        } else {
                            paramMap.put("CREATE_BY", "scheduler");
                            
                            batchService.updateScheduleBatchDate(paramMap);
                        }
                    }
                    
                    
                    TriggerKey trKey = new TriggerKey(triggerName, triggerGroup);
            		String message = "Schedule-Job debug(" + "company code = " + paramMap.get("COMPANY_CODE") + " | schedule name = " + paramMap.get("SCHEDULE_CODE") + " | trigger info = " + scheduler.getTrigger(trKey) + ")";
                    
                    if (log.isDebugEnabled()) {
                        log.debug(message);
                    }
                }
			}else{
	    		Scheduler scheduler = jobExecutionContext.getScheduler();
	            try {
					scheduler.shutdown();
				} catch (SchedulerException e) {
					
				}
	    	}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
			try {
                logger.logMessage(e.getMessage());
                logger.logEnd(false);
            } catch (Exception logger_exp) {
            	
            }
		}
		
    	

        
    }


}