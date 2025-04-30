package com.kpmg.kdb.core.common.helper.mail;

import java.io.UnsupportedEncodingException;
import java.net.URL;

import javax.mail.internet.MimeUtility;

import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.util.StringUtil;

//import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailAttachment;



public class MailObjectAttach {
    private String DEFAULT_FILE_CHARSET = ApplicationConstants.APPLICATION_CONTEXT_CHARSET;
    
    private EmailAttachment emailAttachment;
    
    
    public MailObjectAttach() { 
    	emailAttachment = new EmailAttachment();
    }
    
    
    public void setCharset(String charset) throws Exception {
    	this.DEFAULT_FILE_CHARSET = charset;
    }

    
    public String getCharset() {
        return this.DEFAULT_FILE_CHARSET;
    }

    
    public void setPath(String path) {
        emailAttachment.setPath(path);
    }

    
    public String getPath() {
        return emailAttachment.getPath();
    }

    
    public void setURL(URL url) {
        emailAttachment.setURL(url);
    }

    
    public URL getURL() {
        return emailAttachment.getURL();
    }

    
    public void setName(String name) throws AllInOneException {
        try {
            emailAttachment.setName(MimeUtility.encodeText(name, StringUtil.null2String(this.getCharset(), this.DEFAULT_FILE_CHARSET), "B"));
        } catch (UnsupportedEncodingException uee) {
            throw new AllInOneException("인코딩 형식이 올바르지 않습니다.", uee);
        }
    }

    
    public String getName() {
        return emailAttachment.getName();
    }

    
    public void setDisposition(String disposition) {
        emailAttachment.setDisposition(disposition);
    }

    
    public String getDisposition() {
        return emailAttachment.getDisposition();
    }

    
    public EmailAttachment getAttachment() throws AllInOneException {
        if (this.getPath() == "" && this.getURL().toString() == "") {
            throw new AllInOneException("첨부파일의 위치와 URL를 찾을 수 없습니다.");
        }
        
        return this.emailAttachment;
    }
}
