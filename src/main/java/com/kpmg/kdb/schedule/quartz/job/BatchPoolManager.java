package com.kpmg.kdb.schedule.quartz.job;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Hashtable;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronExpression;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.matchers.GroupMatcher;

import com.kpmg.kdb.util.StringUtil;


public class BatchPoolManager {
	
	private static Log log = LogFactory.getLog(BatchPoolManager.class);
	
	// 스케쥴 목록을 가지고 있는 테이블
	private static Hashtable<String, Object> batchJobClass = new Hashtable<String, Object>();
	
	public static Scheduler startBatch(Map<String, String> map) throws SchedulerException {
		
		// JobDetail Info
		String jobGroup = map.get("COMPANY_CODE");
		String jobName = map.get("SCHEDULE_CODE");
		String jobClass = "com.isource.schedule.quartz.job.BatchJobExecuter";
		//String jobClass = FixingVariables.PREFIX_CLASS_PACKAGE + "." + map.get("EXECUTION_PROGRAM");
		
		// CronTrigger Info
		String triggerGroup = map.get("COMPANY_CODE") + "_TRIGGER";
		String triggerName = map.get("SCHEDULE_CODE") + "Trigger";
		
		// Scheduler aliase name
		String scheduleName = jobName + "_" + jobGroup;

		Object batchObj = batchJobClass.get(scheduleName);
		if (batchObj != null) {
			Scheduler scheduler = (Scheduler) batchObj;

			if (scheduler.isStarted()) {
				if (log.isDebugEnabled()) {
					log.debug("batch is already running.(schedule name=" + scheduleName + ", class=" + jobClass + ")");
				}
			} else if(scheduler.isShutdown()){
				scheduler.start(); // 배치가 수행중인 상태가 아니라면 재시작한다.
			}
			
			return scheduler;
		} else {
			if (log.isDebugEnabled()) {
				log.debug("Create batch...(schedule name=" + scheduleName + ", class=" + jobClass + ")");
			}

			String cronExpress = makeCronExpression(map);

			SchedulerFactory schedulerFactory = new StdSchedulerFactory();
			Scheduler scheduler = schedulerFactory.getScheduler();

			
			JobDetail jobDetail = null;
			Trigger cronTrigger = null;
			
			
			try {
				jobDetail = JobBuilder.newJob((Class<? extends Job>) classForName(jobClass)).withIdentity(jobName, jobGroup).build();
				cronTrigger = TriggerBuilder.newTrigger().withIdentity(triggerName, triggerGroup).withSchedule(CronScheduleBuilder.cronSchedule(cronExpress)).build();
				
			} catch (Exception e) {
				
			}
			scheduler.scheduleJob(jobDetail, cronTrigger);

			scheduler.start();
			if (scheduler.isStarted()) {
				batchJobClass.put(scheduleName, scheduler);
			}

			return scheduler;
		}
	}

	@SuppressWarnings("rawtypes")
	public static void rescheduleJob(Scheduler scheduler, Map map) throws SchedulerException, ParseException {
		// JobDetail Info
		String jobGroup = StringUtil.null2String(map.get("COMPANY_CODE"));
		String jobName = StringUtil.null2String(map.get("SCHEDULE_CODE"));
		// CronTrigger Info
		String triggerGroup = map.get("COMPANY_CODE") + "_TRIGGER";
		String triggerName = map.get("SCHEDULE_CODE") + "Trigger";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String cronExpress = makeCronExpression(map);

		
		//JobKey jKey = new JobKey(jobName, jobGroup);
		TriggerKey trKey = new TriggerKey(triggerName, triggerGroup);
		//CronTrigger beforeTrigger = (CronTrigger) scheduler.getTrigger(trKey);

		//CronTrigger beforeTrigger = (CronTrigger) scheduler.getTrigger(trKey);
		Trigger beforeTrigger = scheduler.getTrigger(trKey);
		
		if (log.isDebugEnabled()) {
			log.info("[Before NextFireTime] 수정전 수행시간 : " + sdf.format(beforeTrigger.getNextFireTime()));
		}
		
		// 트리거 생성
		Trigger newCronTrigger = TriggerBuilder.newTrigger().withIdentity(triggerName, triggerGroup).withSchedule(CronScheduleBuilder.cronSchedule(cronExpress)).build();
		
		// Trigger의 스케쥴을 변경.
		//scheduler.rescheduleJob(triggerName, triggerGroup, beforeTrigger);
		scheduler.rescheduleJob(trKey, newCronTrigger);
		Trigger afterTrigger = scheduler.getTrigger(trKey);

		if (log.isInfoEnabled()) {
			log.info("[After NextFireTime] 수행후 수행시간 : " + sdf.format(afterTrigger.getNextFireTime()));
		}
	}
	
	@SuppressWarnings("rawtypes")
	public static String getNextFireTime(Scheduler scheduler, Map map)
			throws SchedulerException, ParseException {
		String returnValue = "";
		
		if(!scheduler.isStarted()) {
			return "--/--/-- --:--:--";
		}
		
		// CronTrigger Info
		String triggerGroup = map.get("COMPANY_CODE") + "_TRIGGER";
		String triggerName = map.get("SCHEDULE_CODE") + "Trigger";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

		TriggerKey trKey = new TriggerKey(triggerName, triggerGroup);
		
		Trigger beforeTrigger = scheduler.getTrigger(trKey);
		returnValue = sdf.format(beforeTrigger.getNextFireTime());
		
		return returnValue;
	}
	
	public static Scheduler getDefaultScheduler() throws SchedulerException {
		// Initiate a Schedule Factory
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		// Retrieve a scheduler from schedule factory
		Scheduler scheduler = schedulerFactory.getScheduler();
		
		return scheduler;
	}
	@SuppressWarnings("rawtypes")
	public static Scheduler getDefaultScheduler(Map map) {
		String jobGroup = StringUtil.null2String(map.get("COMPANY_CODE"));
		String jobName = StringUtil.null2String(map.get("SCHEDULE_CODE"));

		// scheduler aliase name
		String scheduleName = jobName + "_" + jobGroup;

		if (batchJobClass.get(scheduleName) != null) {
			return (Scheduler) batchJobClass.get(scheduleName);
		} else {
			return null;
		}
	}

	public static boolean startScheduler(Scheduler scheduler)
			throws SchedulerException {
		if (scheduler != null) {
			if (!scheduler.isStarted()) {
				scheduler.start();
			}

			return scheduler.isStarted();
		}

		return false;
	}
	
	@SuppressWarnings("rawtypes")
	public static boolean shutdownScheduler(Scheduler scheduler, Map map)
			throws SchedulerException {
		if (scheduler != null) {
			scheduler.shutdown();

			String jobGroup = StringUtil.null2String(map.get("COMPANY_CODE"));
			String jobName = StringUtil.null2String(map.get("SCHEDULE_CODE"));

			String scheduleName = jobName + "_" + jobGroup;
			batchJobClass.remove(scheduleName);

			return scheduler.isShutdown();
		}

		return false;
	}

	@SuppressWarnings("rawtypes")
	private static String makeCronExpression(Map map) {
		// cron 생성
		String yearExp = StringUtil.null2String(map.get("YEAR")); // 년 
		if (yearExp == null || yearExp.isEmpty()) {
			yearExp = "";
		}
		String weekExp = StringUtil.null2String(map.get("WEEK")); // 요일 
		if (weekExp == null || weekExp.isEmpty() || "*".equals(weekExp)) {
			weekExp = "?";
		}
		String monthExp = StringUtil.null2String(map.get("MONTH")); // 달 
		if (monthExp == null || monthExp.isEmpty()) {
			monthExp = "*";
		}
		String dayExp = StringUtil.null2String(map.get("DAY")); // 일 
		if (dayExp == null || dayExp.isEmpty()) {
			dayExp = "*";
		}
		String hourExp = StringUtil.null2String(map.get("HOUR")); // 시간 
		if (hourExp == null || hourExp.isEmpty()) {
			hourExp = "0";
		}
		String minuteExp = StringUtil.null2String(map.get("MINUTES")); // 분 
		if (minuteExp == null || minuteExp.isEmpty()) {
			minuteExp = "0";
		}
		String secondExp = StringUtil.null2String(map.get("SECOND")); // 초 
		if (secondExp == null || secondExp.isEmpty()) {
			secondExp = "0";
		}
		// 초 분 시 일 월 년 요일
		String cronExpress = secondExp + " " + minuteExp + " " + hourExp + " " + dayExp
				+ " " + monthExp + " " + weekExp + " " + yearExp;
		if (log.isDebugEnabled()) {
			log.debug("Cron Expression = " + cronExpress);
		}

		return cronExpress;
	}

	public static Class<?> classForName(String className) {
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
