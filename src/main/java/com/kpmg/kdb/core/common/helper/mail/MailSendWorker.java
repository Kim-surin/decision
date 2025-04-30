package com.kpmg.kdb.core.common.helper.mail;

import java.util.Properties;

import javax.mail.PasswordAuthentication;
import javax.mail.Session;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;


public class MailSendWorker {
	
	private static Log log = LogFactory.getLog(MailSendWorker.class);
	
	private static final String DEFAULT_CHARSET = ApplicationConstants.APPLICATION_CONTEXT_CHARSET;
	
	private static JavaMailSenderImpl mailSender;
	private static Properties props;
	private static Session session;
    
	public MailSendWorker(JavaMailSenderImpl sender) {
		if(mailSender == null) {
			mailSender = sender;
			
			props = sender.getSession().getProperties();
			
			props.setProperty("mail.smtp.host", sender.getHost());
			props.getProperty("mail.smtp.port", String.valueOf(sender.getPort()));
			props.setProperty("mail.mime.charset", DEFAULT_CHARSET);
			props.setProperty("mail.mime.encodefilename", "true");
			props.setProperty("mail.smtp.starttls.enable", "true");
			props.setProperty("mail.smtp.auth","true");
			
			if(log.isDebugEnabled()) log.debug("set Mail configration(" + props + ")");
			
			session = Session.getDefaultInstance(getProperties(), new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(mailSender.getUsername(), mailSender.getPassword());
	            }
	        });
		}
	}
	
	
	public static JavaMailSenderImpl getInstance() {
		return mailSender;
	}
	
	public static Properties getProperties() {
		return props;
	}
	
	public static Session getSession() {
		return session;
	}
	
}
