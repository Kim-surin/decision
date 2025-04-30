package com.kpmg.kdb.schedule.quartz.job.logger;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;

import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;
import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;



public class TransferBatchLoggerImpl implements TransferBatchLogger {

	private static Log log = LogFactory.getLog(TransferBatchLoggerImpl.class);

	private static String filePath = null;

	private JobExecutionContext context = null;
	
	private BufferedWriter write = null;

	private String target = null;

	private String transID = null;

	
	static {
		configure();
	}

	
	private static void configure() {
		try {
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
			
			filePath = ApplicationConstants.APPLICATION_REAL_PATH + configurator.getString("batch.log.path");
			
			if(log.isDebugEnabled()) {
				log.debug("log file path=" + filePath);
			}
		} catch (Exception ex) {
			if(log.isErrorEnabled()) {
				log.error("exception: \n" + ex);
			}
		}
	}

	public void setContext(JobExecutionContext ctx) {
		this.context = ctx;
	}

	public JobExecutionContext getContext() {
		return this.context;
	}

	public void setTransactionID(String id) {
		this.transID = id;
	}
	
	
	@SuppressWarnings("rawtypes")
	public void logStart(String batchTarget, List<Object> args)
			throws Exception {
		StringBuffer buf = new StringBuffer();
		target = batchTarget;

		if(args != null) {
			buf.append("[ dataSet = ");
			for (int i = 0; i < args.size(); i++) {
				if(args.get(i) instanceof Map) {
					Map map = (Map) args.get(i);
					Iterator iter = map.entrySet().iterator();
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						buf.append(entry.getKey());
						buf.append("=");
						buf.append(entry.getValue());
						buf.append(" ");
					}
				} else {
					buf.append(args.get(i));
					buf.append(" ");
				}
			}
			buf.append("]");
		} else {
			transID = null;
			buf.append("stat new batch");
		}

		this.logMessage(buf.toString());
	}

	@SuppressWarnings("rawtypes")
	public void logMessage(String message, List<Object> args) throws Exception {
		StringBuffer buf = new StringBuffer();

		buf.append("[");
		buf.append(message);
		buf.append(" = ");
		for (int i = 0; i < args.size(); i++) {
			if(args.get(i) instanceof Map) {
				Map map = (Map) args.get(i);
				Iterator iter = map.entrySet().iterator();
				while (iter.hasNext()) {
					Map.Entry entry = (Map.Entry) iter.next();
					buf.append(entry.getKey());
					buf.append("=");
					buf.append(entry.getValue());
					buf.append(" ");
				}
			} else {
				buf.append(args.get(i));
				buf.append(" ");
			}
		}
		buf.append("]");

		this.logMessage(buf.toString());
	}

	public void logMessage(String message) throws Exception {
		StringBuffer buf = new StringBuffer();

		buf.append("[");
		buf.append(this.getDateFormat("yyyy.MM.dd HH:mm:ss"));
		buf.append("] ");

		if(transID != null) {
			buf.append("[");
			buf.append(transID);
			buf.append("] ");
		}

		if(target != null) {
			buf.append("[target-");
			buf.append(target);
			buf.append("] ");
		}

		buf.append(message);

		if(write == null) {
			this.write = (BufferedWriter) this.getOutFileWriter(null);
		}

		write.append(buf.toString());
		write.newLine();
		write.flush();

		if(log.isDebugEnabled()) {
			log.debug("write message : " + message);
		}
	}

	private Writer getOutFileWriter(String outFileName) throws Exception {
		File file = new File(filePath);
		if(!file.exists()) {
			file.mkdir();
		}
		String fileName = outFileName;
		if(fileName == null) {
			fileName = "batch_" + getDateFormat("yyyyMMdd") + ".log";
		}
		file = new File(filePath + fileName);

		FileWriter file_write = new FileWriter(file, true);
		write = new BufferedWriter(file_write);

		return this.write;
	}

	private void closeOutFileWriter(String outFileName) {
		try {
			if(this.write != null) {
				write.close();
				write = null;
			}
		} catch (IOException io) {
			try {
				this.logMessage("[ERROR] " + io.getCause().toString());
			} catch (Exception exp) {
				if(log.isErrorEnabled()) {
					log.error(exp);
				}
			}
		}
	}

	private String getDateFormat(String format) {
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat(format);

		return sdf.format(date);
	}

	public void logEnd(boolean succ, String message) throws Exception {
		StringBuffer buf = new StringBuffer();
		buf.append("[result=");
		if(succ) {
			buf.append("successed");
		} else {
			buf.append("failed");
		}
		buf.append("]");
		buf.append(message);
		
		if(this.write != null) {
			this.logMessage(buf.toString());
		}

		this.closeOutFileWriter(null);
	}

	public void logEnd(boolean succ) throws Exception {
		StringBuffer buf = new StringBuffer();
		buf.append("[result=");
		if(succ) {
			buf.append("successed");
		} else {
			buf.append("failed");
		}
		buf.append("]");
		
		if(this.write != null) {
			this.logMessage(buf.toString());
		}
		this.closeOutFileWriter(null);
	}

	public void setStatus(String key, Object status) {
		// TODO Auto-generated method stub

	}

	public Object getStatus(String key) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getStatus(String key, Object defValue) {
		// TODO Auto-generated method stub
		return null;
	}

	public void logStatus() throws Exception {
		// TODO Auto-generated method stub

	}
}