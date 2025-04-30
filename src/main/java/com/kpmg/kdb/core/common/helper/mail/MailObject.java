package com.kpmg.kdb.core.common.helper.mail;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kpmg.kdb.core.common.helper.excel.ExcelCommmonVo;
import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.util.FileUtil;
import com.kpmg.kdb.util.StringUtil;




@SuppressWarnings({ "unchecked", "rawtypes" })
public class MailObject {
	
	private static final Log log = LogFactory.getLog(MailObject.class);
	
	private static final String DEFAULT_CHARSET = ApplicationConstants.APPLICATION_CONTEXT_CHARSET;
    
    private String mailCharset = DEFAULT_CHARSET;
    
    private Session session;
    private MimeMessage message;
    
    @SuppressWarnings("static-access")
	private String contentType = "text/plain;charset=" + this.DEFAULT_CHARSET;
    
    
    public MailObject() {
    	session = MailSendWorker.getSession();
    	message = new MimeMessage(session);
    }

    public void setConfig(){
    	MailSendWorker.getInstance().setHost("127.0.0.1");
    	MailSendWorker.getInstance().setPort(25);
    }
    
    public String getCharset() {
        return this.mailCharset;
    }

    
    public String getHost() {
        return MailSendWorker.getInstance().getHost();
    }
    
    
    public String getUsername() {
        return MailSendWorker.getInstance().getUsername();
    }
    
    
    public int getPort() {
    	return MailSendWorker.getInstance().getPort();
    }
    
    
    public void setDebug(boolean enable) { 
    	session.setDebug(enable);
    }
    
    
    public void setFrom(String fromAddress) throws AllInOneException {
        try {
        	message.setFrom(new InternetAddress(fromAddress));
        } catch(MessagingException ee) {
            throw new AllInOneException("Mail send failed(by From address)", ee.getMessage());
        }
    }

    
    public void setFrom(String fromAddress, String fromName) throws AllInOneException, AddressException, UnsupportedEncodingException {
    	try {
        	message.setFrom(new InternetAddress(fromAddress, fromName));
        } catch(Exception ee) {
            throw new AllInOneException("Mail send failed(by From address)", ee.getMessage());
        }
    }

    
    public MailObject addTo(String toAddress) throws AllInOneException {
        try {
        	message.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(toAddress));
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by To address)", ee.getMessage());
        }

        return this;
    }

    
    public MailObject addTo(String toAddress, String toName) throws AllInOneException {
    	this.addTo(toAddress);
    	
        return this;
    }

   
    public MailObject setTo(List toList) throws AllInOneException {
    	ExcelCommmonVo toListVo = transformVO(toList, null);
    	InternetAddress[] address = new InternetAddress[toList.size()];
    	int idx = 0;
    	
    	try {
	        for (Iterator<String> i = toListVo.getRow(0).keySet().iterator(); i.hasNext();) {
	            String toAddress = i.next();
	            String toName = toListVo.getString(toAddress);
	            
	            address[idx] = new InternetAddress(toAddress, toName);
	            idx++;
	        }
	        
	        message.setRecipients(MimeMessage.RecipientType.TO, address);
    	} catch(Exception me) {
    		throw new AllInOneException("Mail send failed(by To address list)", me.getMessage());
    	}
    	
        return this;
    }

    
    public MailObject setTo(List toList, String addrKey) throws AllInOneException {
    	ExcelCommmonVo toListVO = transformVO(toList, null);
    	
    	return setTo(toListVO, addrKey, null);
    }
    
    
    public MailObject setTo(List toList, String addrKey, String nameKey) throws AllInOneException {
    	ExcelCommmonVo toListVO = transformVO(toList, null);
    	
    	return setTo(toListVO, addrKey, nameKey);
    }
    
    private MailObject setTo(ExcelCommmonVo toListVO, String addrKey, String nameKey) throws AllInOneException {
    	InternetAddress[] address = new InternetAddress[toListVO.size()];
    	int idx = 0;
    	try {
	    	for(int i=0;i<toListVO.size();i++) {
	    		String toAddress = toListVO.getString(i,addrKey);
				
	    		address[idx] = new InternetAddress(toAddress);
	            idx++;
	    	}
	    	
	    	message.setRecipients(MimeMessage.RecipientType.TO, address);
    	}  catch(MessagingException me) {
    		throw new AllInOneException("Mail send failed(by To address VO)", me.getMessage());
    	}
    	
    	return this;
    }
    
    /**
     * 
     * 참조 이메일 주소를 추가한다.
     */
    public MailObject addCC(String ccAddress) throws AllInOneException {
        try {
            message.setRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(ccAddress));
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by CC address)", ee.getMessage());
        }

        return this;
    }

    /**
     * 
     * 참조 이메일 주소를 추가한다.
     */
    public MailObject addCC(String ccAddress, String ccName) throws AllInOneException {
        this.addCC(ccAddress);
        
        return this;
    }

    /**
     * 
     * 참조 이메일 주소 리스트를 설정한다.
     */
    public MailObject setCC(Collection<String> ccList) throws AllInOneException {
    	InternetAddress[] address = new InternetAddress[ccList.size()];
    	int idx = 0;

        for (Iterator<String> i = ccList.iterator(); i.hasNext();) {
            try {
                address[idx] = new InternetAddress(i.next());
                idx++;
            } catch(AddressException ae) {
            	throw new AllInOneException("Mail send failed(by CC address list)", ae.getMessage());
            }
        }
        
        try {
            message.setRecipients(MimeMessage.RecipientType.CC, address);
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by CC address list)", ee.getMessage());
        }

        return this;
    }

    /**
     * 
     * 참조 이메일 주소와 참조 대상의 이름을 가지는 Object 로 메일 주소를 설정한다.
     */
    public MailObject setCC(List ccList) throws AllInOneException {
    	ExcelCommmonVo ccListVo = transformVO(ccList, null);
    	InternetAddress[] address = new InternetAddress[ccList.size()];
    	int idx = 0;
    	
    	try {
	        for (Iterator<String> i = ccListVo.getRow(0).keySet().iterator(); i.hasNext();) {
	            String ccAddress = i.next();
	            String ccName = ccListVo.getString(ccAddress);
	
	            address[idx] = new InternetAddress(ccAddress, ccName);
	            idx++;
	        }
	        
	        message.setRecipients(MimeMessage.RecipientType.CC, address);
    	} catch(Exception me) {
    		throw new AllInOneException("Mail send failed(by CC address list)", me.getMessage());
    	}
    	
        return this;
    }

    /**
     * 
     * 참조 이메일 주소를 가지는 Object 로 참조자의 메일 주소를 설정한다.
     * 이 때 참조자의 이메일주소가 담긴 Key를 지정해준다.
     */
    public MailObject setCC(List ccList,String addrKey) throws AllInOneException {
    	ExcelCommmonVo ccListVO = transformVO(ccList, null);
    	
    	return setCC(ccListVO,addrKey,null);
    }
    
    public MailObject setCC(List ccList,String addrKey, String nameKey) throws AllInOneException {
    	ExcelCommmonVo ccListVO = transformVO(ccList, null);
    	
    	return setCC(ccListVO, addrKey, nameKey);
    }
    /**
     * 
     * 참조 이메일 주소와 이름을 가지는 Object 로 참조자의 메일 주소를 설정한다.
     */
    private MailObject setCC(ExcelCommmonVo ccListVO,String addrKey, String nameKey) throws AllInOneException {
    	InternetAddress[] address = new InternetAddress[ccListVO.size()];
    	int idx = 0;
    	
    	try {
	    	for(int i=0;i<ccListVO.size();i++) {
				String toAddress = ccListVO.getString(i,addrKey);
				
				address[idx] = new InternetAddress(toAddress);
	            idx++;
			}
	    	
	    	message.setRecipients(MimeMessage.RecipientType.CC, address);
    	} catch(MessagingException me) {
    		throw new AllInOneException("Mail send failed(by CC address VO)", me.getMessage());
    	}
    	
		return this;
    }
    
    /**
     * 
     * 숨은 참조 이메일 주소를 추가한다.
     */
    public MailObject addBCC(String bccAddress) throws AllInOneException {
        try {
        	message.setRecipients(MimeMessage.RecipientType.BCC, InternetAddress.parse(bccAddress));
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by Hiden CC address)", ee.getMessage());
        }

        return this;
    }

    /**
     * 
     * 숨은 참조 이메일 주소와 숨은 참조 대상의 이름를 추가한다.
     */
    public MailObject addBCC(String bccAddress, String bccName) throws AllInOneException {
        this.addBCC(bccAddress);

        return this;
    }

    /**
     * 
     * 숨은 참조 이메일 주소 리스트를 셋팅한다.
     */
    public MailObject setBCC(Collection<String> bccList) throws AllInOneException {
    	InternetAddress[] address = new InternetAddress[bccList.size()];
    	int idx = 0;

        for (Iterator<String> i = bccList.iterator(); i.hasNext();) {
            try {
            	address[idx] = new InternetAddress(i.next());
                idx++;
            } catch(AddressException ae) {
            	throw new AllInOneException("Mail send failed(by Hiden CC address List)", ae.getMessage());
            }
        }

        try {
        	message.setRecipients(MimeMessage.RecipientType.BCC, address);
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by Hiden CC address List)", ee.getMessage());
        }

        return this;
    }

    /**
     * 
     * 숨은 참조 이메일 주소와 숨은 참조 대상의 이름을 가지는 Object 로 메일 주소를 설정한다.
     */
    public MailObject setBCC(List bccList) throws AllInOneException {
    	ExcelCommmonVo bccListVo = transformVO(bccList, null);
    	InternetAddress[] address = new InternetAddress[bccList.size()];
    	int idx = 0;
    	
    	try {
	        for (Iterator<String> i = bccListVo.getRow(0).keySet().iterator(); i.hasNext();) {
	            String bccAddress = i.next();
	            String bccName = bccListVo.getString(bccAddress);
	
	            address[idx] = new InternetAddress(bccAddress, bccName);
	            idx++;
	        }
	        
	        message.setRecipients(MimeMessage.RecipientType.BCC, address);
    	} catch(Exception me) {
    		throw new AllInOneException("Mail send failed(by hiden CC address list)", me.getMessage());
    	}
    	
        return this;
    }

    /**
     * 
     * 메일의 제목을 설정한다.
     */
    @SuppressWarnings("static-access")
	public MailObject setSubject(String subject) throws AllInOneException {
    	try {
    		message.setSubject(subject, this.DEFAULT_CHARSET);
    	} catch(MessagingException me) {
    		throw new AllInOneException("Mail send failed(by subject)", me.getMessage());
    	}
    	
        return this;
    }

    /**
     * 
     * 메일의 내용을 설정한다.
     */
    public MailObject setMsg(String msg) throws AllInOneException {
        try {
            message.setText(msg);
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by Contents)", ee.getMessage());
        }

        return this;
    }
    
    /**
     * 
     * HTML 형식의 메일의 내용을 설정한다.
     */
    @SuppressWarnings("static-access")
	public MailObject setHtmlMsg(String msg) throws AllInOneException {
        try {
        	contentType = "text/html;charset=" + this.DEFAULT_CHARSET;
        	message.setContent(msg, contentType); // 보낼 내용 설정 (HTML 형식)
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by HTML's contents)", ee.getMessage());
        }

        return this;
    }

    /**
     * 
     * 메일의 제목과 내용을 설정한다.
     */
    public MailObject setContext(String subject, String msg) throws AllInOneException {
        this.setSubject(subject);
        this.setMsg(msg);

        return this;
    }

    /**
     * 
     * 작성된 메일을 전송한다.
     */
    public void send() throws AllInOneException {
        try {
        	if(log.isDebugEnabled()) log.debug("Content type = " + contentType);
        	
        	message.setSentDate(new Date());
        	//this.setConfig();
        	Transport.send(message);
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(" + ee.getMessage() + ")", ee.getMessage());
        }
    }


    @SuppressWarnings("static-access")
	public MailObject attach(MailObjectAttach attachment) throws AllInOneException {
    	Multipart multipart = new MimeMultipart();
    	MimeBodyPart contents_mimeBodyPart = new MimeBodyPart();
    	MimeBodyPart attachFile_mimeBodyPart = new MimeBodyPart();
    	
        if (attachment == null) {
            throw new AllInOneException("Attachment file is null.");
        }

        try {
        	// 메일발송 내역 추가
        	contents_mimeBodyPart = new MimeBodyPart();
        	
        	contents_mimeBodyPart.setContent(message.getContent(), contentType);
        	contents_mimeBodyPart.setHeader("Content-Transfer-Encoding", "base64");
        	
        	multipart.addBodyPart(contents_mimeBodyPart);
        	
        	if(log.isDebugEnabled()) log.debug("Attachment file name = " + attachment.getName());
        	
        	// 파일 추가
        	attachFile_mimeBodyPart.setFileName(attachment.getName());
        	attachFile_mimeBodyPart.setDataHandler(new DataHandler(new FileDataSource(new File(attachment.getPath()))));
        	attachFile_mimeBodyPart.setDescription(new File(attachment.getPath()).getName().split("\\.")[0], this.DEFAULT_CHARSET);
        	multipart.addBodyPart(attachFile_mimeBodyPart);
        	
        	message.setContent(multipart);
        } catch(MessagingException ee) {
        	throw new AllInOneException("Mail send failed(by attachment file)", ee.getMessage());
        } catch(IOException ee) {
        	throw new AllInOneException("Mail send failed(by attachment file)", ee.getMessage());
        }

        return this;
    }

    public MailObject attach(Collection<Object> attachList) throws AllInOneException {
        if (attachList.size() < 1 || attachList == null) {
            throw new AllInOneException("Attachment file is null.");
        }
        
        for (Iterator<Object> i = attachList.iterator(); i.hasNext();) {
        	Object o = i.next();
            
        	if(o instanceof MailObjectAttach) this.attach((MailObjectAttach) o);
        	if(o instanceof Map) {
        		Map map = (Map) o;
        		this.attach((Blob) map.get("REALFILE"), StringUtil.null2String(map.get("FILE_NAME")));
        	}
        }
        
        return this;
    }
    
    public MailObject attach(Blob attach, String fileName) throws AllInOneException {
    	InputStream is = null;
    	OutputStream fileWriter = null;
    	
    	if (attach == null) {
            throw new AllInOneException("Attachment file date is null.");
        }
        
        try {
        	String path = FileUtil.getFullPath(null) + "/" + fileName;
        	is = attach.getBinaryStream();
        	File file = new File(path);
            fileWriter = new FileOutputStream(file);
             
            int read = 0;
            byte[] bytes = new byte[1024];
            
            while ((read = is.read(bytes)) != -1) { 
            	fileWriter.write(bytes, 0, read);
        	}
            
            MailObjectAttach attachment = new MailObjectAttach();
			
            attachment.setName(fileName);
            attachment.setPath(path);
			
			this.attach(attachment);
			
			FileUtil.deleteTo(path);
        } catch(IOException ioex) {
        	throw new AllInOneException("Mail send failed(by attachment file data)", ioex.getMessage());
        } catch(Exception e) {
        	throw new AllInOneException("Mail send failed(by attachment file data)", e.getMessage());
        } finally {
        	try {
	        	if(is != null) is.close();
	        	if(fileWriter != null) fileWriter.close();
        	} catch(IOException io) {
        		//io.printStackTrace();
        	}
        }

        return this;
    }
    
    
	private static ExcelCommmonVo transformVO(List list, String name) {
		ExcelCommmonVo vo = null;
		
		if(StringUtil.isNull(name)) {
			vo = new ExcelCommmonVo();
		} else {
			vo = new ExcelCommmonVo(name);
		}
		
		for(int i = 0; i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			
			vo.addRow(i, map);
		}
		
		if(log.isDebugEnabled()) log.debug("vo size = " + vo.size());
		
		return vo;
	}
}
