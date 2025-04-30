package com.kpmg.kdb.schedule.quartz.job;

import java.util.Hashtable;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;



public class QuartzManger {
	
	private static Log log = LogFactory.getLog(QuartzManger.class);
	
	
	private static Hashtable<String, Object> jobClassTable = new Hashtable<String, Object>();	
	
	public static Scheduler startBatch(Map<String, String> map) throws SchedulerException {
		
		
		Object batchObj = jobClassTable.get("testScheduleName");
		
		if (batchObj != null) {
			Scheduler schdr = (Scheduler) batchObj;
			if (schdr.isStarted()) {
				log.debug("batch is already running.");
			} else if(schdr.isShutdown()){
				schdr.start(); // 배치가 수행중인 상태가 아니라면 재시작한다.
			}
			return schdr;
		}else{
			
			String cronExpress = "0/5 * * * * ?";
			
			SchedulerFactory schedulerFactory = new StdSchedulerFactory();
			Scheduler schdr = schedulerFactory.getScheduler();
			
			
			
			JobDetail jb = JobBuilder.newJob(BatchJobExecuter.class).withIdentity("testName", "testGroup").build();
			Trigger tttr = TriggerBuilder.newTrigger().withIdentity("testName", "testGroup").withSchedule(CronScheduleBuilder.cronSchedule(cronExpress)).startNow().build();
			
			
			schdr.scheduleJob(jb, tttr);
			schdr.start();
			
			
			return schdr;
		}
		
		
		
	}

	
	
	public static Class<?> string2Class(String className) {
		Class<?> ldclass = null;
		ClassLoader cloader = Thread.currentThread().getContextClassLoader();
		try {
			ldclass = cloader.loadClass(className);
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		}

		return ldclass;
	}
	
}
