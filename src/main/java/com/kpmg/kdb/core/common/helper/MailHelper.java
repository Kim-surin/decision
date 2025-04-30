package com.kpmg.kdb.core.common.helper;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;

import com.kpmg.kdb.core.common.helper.mail.MailObject;
import com.kpmg.kdb.util.StringUtil;



public class MailHelper extends MailObject {
	
	private static Log log = LogFactory.getLog(MailHelper.class);
	
	public MailHelper() {
		super();
	}
	
	public String getSmtpUserMail() {
		String mailAdr = "";
		
		if(this.getUsername().indexOf("@") <= 0) {
			if(this.getHost().indexOf("naver") > 0) mailAdr = this.getUsername() + "@naver.com";
			else if(this.getHost().indexOf("gmail") > 0) mailAdr = this.getUsername() + "@gmail.com";
			else if(this.getHost().indexOf("daum") > 0) mailAdr = this.getUsername() + "@daum.net";
			else mailAdr = this.getUsername() + "@" + this.getHost();
		} else {
			mailAdr = StringUtil.null2String(this.getUsername());
		}
		
		if(log.isDebugEnabled()) log.debug("SMTP's user name = " + mailAdr);
		
		return mailAdr;
	}
	
	
	public String getCooContents(Map map, List ilist, MessageSource messageSource) throws Exception {
		StringBuffer mailMsg = new StringBuffer();
		StringBuffer requestHtml = new StringBuffer();
		StringBuffer itemHtml = new StringBuffer();
		StringBuffer signHtml = new StringBuffer();
        String css_header =  "font-size:9pt;background:#f1f1f1;padding:1px 5px 0px 5px;color:#484242;font-weight:bold;height:26px;padding-bottom:1px;border-right:1px solid #b0bcd3;border-bottom:1px solid #b0bcd3;";
        String css_contens = "font-size:9pt;background:#ffffff;padding:0px 5px 0px 5px;height:26px;padding-bottom:1px;border-right:1px solid #b0bcd3;border-bottom:1px solid #b0bcd3;";
        String css_title = "color:#545454;font-weight:bold;padding:0;padding:5px 0 5px 3px;height:20px;font-size:10pt; letter-spacing:-1px;";
        String css_sign = "color:#545454;font-family:Dotum, Gulim, Arial, Helvetica, sans-serif;font-size:11px;font-weight:normal;text-align:left;padding:10px 0px;";
        
        String coments = StringUtil.null2String(map.get("COMMENTS"));
        
        if(!coments.isEmpty()) {
            coments = coments.replaceAll("\n", "<br>");
        }
        
        requestHtml.append("<div style=\""+css_title+"\">"+messageSource.getMessage("TXT.REQUEST_INFO", null, null)+"</div>");
        requestHtml.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-left:1px solid #b0bcd3;border-top:1px solid #b0bcd3;width: 100%;\">");
        requestHtml.append("<colgroup><col style=\"width:110px;\"/><col style=\"width:160px;\"/><col style=\"width:110px;\"/><col style=\"width:160px;\"/></colgroup>");
        requestHtml.append("<tr>");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("COMPANY_NAME", null, null)+"</td>");
        requestHtml.append("<td colspan=\"3\" style=\""+css_contens+"\">"+StringUtil.null2String(map.get("COMPANY_NAME"))+"</td>");
        requestHtml.append("</tr>");
        requestHtml.append("<tr>");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("TXT.SENDER_NAME", null, null)+"</td>");
        requestHtml.append("<td style=\""+css_contens+"\">"+StringUtil.null2String(map.get("WRITER"))+"</td>");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("TXT.SENDER_MOBILE", null, null)+"</td>");
        requestHtml.append("<td style=\""+css_contens+"\">"+StringUtil.null2String(map.get("WRITE_CONTECTS"))+"</td>");
        requestHtml.append("</tr>");
        requestHtml.append("<tr>");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("TXT.SUBMIT_RANGE_DATE", null, null)+"</td>");
        requestHtml.append("<td style=\""+css_contens+"\">"+StringUtil.null2String(map.get("CAL_APPLY_DATE")) +" ~ " + StringUtil.null2String(map.get("CAL_END_DATE")) +"</td>");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("TXT.SUBMIT_REASON", null, null)+"</td>");
        requestHtml.append("<td style=\""+css_contens+"\">"+StringUtil.null2String(map.get("REQUEST_TYPE_NAME"))+"</td>");
        requestHtml.append("</tr>");
        requestHtml.append("<tr height=\"150px\">");
        requestHtml.append("<td style=\""+css_header+"\">"+messageSource.getMessage("TXT.MAIL_CONTENTS_REMARK", null, null)+"</td>");
        requestHtml.append("<td valign=\"top\" colspan=\"3\" style=\""+css_contens+"\">"+coments+"</td>");
        requestHtml.append("</tr>");
        requestHtml.append("</table>");
        requestHtml.append("<br/>");
        requestHtml.append("<br/>");
        
        itemHtml.append("<div style=\""+css_title+"\">"+messageSource.getMessage("TXT.PO_ITEM_LIST", null, null)+"</div>");
        itemHtml.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-left:1px solid #b0bcd3;border-top:1px solid #b0bcd3;width: 100%;\">");
        itemHtml.append("<colgroup><col style=\"width:50px;\"/><col style=\"width:160px;\"/><col style=\"width:210px;\"/><col style=\"width:100px;\"/></colgroup>");
        itemHtml.append("<tr>");
        itemHtml.append("<td style=\""+css_header+"\">No</td>");
        itemHtml.append("<td style=\"width:115px;"+css_header+"\">"+messageSource.getMessage("TXT.ITEM_CODE", null, null)+"</td>");
        itemHtml.append("<td style=\"width:180px;"+css_header+"\">"+messageSource.getMessage("TXT.ITEM_NAME", null, null)+"</td>");
        itemHtml.append("<td style=\"width:60px;"+css_header+"\">"+messageSource.getMessage("TXT.HS_CODE", null, null)+"</td>");
        itemHtml.append("<td style=\"width:40px;"+css_header+"\">"+messageSource.getMessage("TXT.COUNT_UNIT", null, null)+"</td>");
        itemHtml.append("<td style=\"width:80px;"+css_header+"\">"+messageSource.getMessage("TXT.CURRENT_PO_DATE", null, null)+"</td>");
        itemHtml.append("</tr>");
        
        for(int i = 0; i < ilist.size(); i++) {
        	Map iMap = (Map) ilist.get(i);
        	
            itemHtml.append("<tr>");
            itemHtml.append("<td style=\""+css_contens+"\"><center>" + (i+1) + "</center></td>");
            itemHtml.append("<td style=\""+css_contens+"\">" + StringUtil.null2String(iMap.get("ITEM_CODE")) + "</td>");
            itemHtml.append("<td style=\""+css_contens+"\">" + StringUtil.null2String(iMap.get("ITEM_NAME")) + "</td>");
            itemHtml.append("<td style=\""+css_contens+"\">" + StringUtil.null2String(iMap.get("HS_CODE")) + "</td>");
            itemHtml.append("<td style=\""+css_contens+"\">" + StringUtil.null2String(iMap.get("UNIT")) + "</td>");
            itemHtml.append("<td style=\""+css_contens+"\">" + StringUtil.null2String(iMap.get("WAREHOUSING_DATE")) + "</td>");
            itemHtml.append("</tr>");
        }
        
        itemHtml.append("</table>");

        signHtml.append("<br/>");
        signHtml.append("<div style=\""+css_sign+"\">"+StringUtil.null2String(map.get("SIGNATURE"))+"</div>");
        
        mailMsg.append(requestHtml.toString());
        mailMsg.append(itemHtml.toString());
        mailMsg.append(signHtml.toString());
        
		return mailMsg.toString();
	}
	
	
	public String getPendingContent(String pendCnt) throws Exception {
		StringBuffer html = new StringBuffer();

		html.append("<html>");
		html.append("  <head>");
		html.append("  <title>FTA CERTIFICATE OF ORIGIN </title>");
		html.append("  </head>");
		html.append("  <body style='font-family: Gulim, arial; font-size:9pt; color:#333333; margin:0; padding:0; line-height:160%;'>");
		html.append("  <table width='100%' height='100%' cellpadding='0' cellspacing='0' border='0'>");
		html.append("    <tr>");
		html.append("      <td align='center' valign='top'>");
		html.append("        <table width='770' height='' cellpadding='0' cellspacing='0' border='0'>");
		html.append("          <tr>");
		html.append("            <td height='30' style='font-weight:bold; color:#002f81; font-size:10pt; padding:0 0 0 0px;'> FTA?��?���? �?�? ?��?��?��?��?�� 발송?�� 메일?��?��?��.</td>");
		html.append("          </tr>");
		html.append("          <tr>");
		html.append("            <td height='30' style='font-weight:bold; color:#002f81; font-size:10pt; padding:0 0 0 0px;'> ?��?�� ?��?���? 미결?���??��  " + pendCnt + " �? ?��?��?��?��?��?��?��.</td>");
		html.append("          </tr>");
		html.append("          <tr>");
		html.append("            <td height='30' style='font-weight:bold; color:#002f81; font-size:10pt; padding:0 0 0 0px;'> FTA?��?���? �?�? ?��?��?��?�� ?��?�� ?��?���? 증명?���? ?��록해 주시�? 바랍?��?��.</td>");
		html.append("          </tr>");
		html.append("          <tr>");
		html.append("            <td height='30' style='font-weight:bold; color:#ff0000; font-size:10pt; padding:0 0 0 0px;'> [�? 메일?? ?��?��?�� ?���? ?�� 바츠ID?�� 기록?�� ?��?��?��?��게만 ?��?��?��?�� 메시�??��?��?��.]</td>");
		html.append("          </tr>");
		html.append("        </table>");
		html.append("      </td>");
		html.append("    </tr>");
		html.append("  </table>");
		html.append("  </body>");
		html.append("  </html>");

		return html.toString();
	}
	
}
