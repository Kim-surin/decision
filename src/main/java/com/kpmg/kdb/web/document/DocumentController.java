package com.kpmg.kdb.web.document;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.common.helper.ReportPrintHelper;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.ReportsPrintView;
import com.kpmg.kdb.util.StringUtil;

import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;


/*******************************************************************************************
 * 
 * SystemController.class
 * 
 * @since 2019.06.25
 * @author D.Cat
 *
 * 시스템 관리 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class DocumentController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(DocumentController.class);

	@Autowired
	protected DocumentService service;


	
	/**
	 * 확인서 / 증명서 문서 목록 정보
	 */
	@RequestMapping(value="/ireport/retrieveCooIssueDocumentInfo")
	@ResponseBody
	public Result retrieveCooIssueDocumentInfo(@RequestBody Map param) {
		logger.debug("##### Request Type result Class : " + "retrieveCooIssueDocumentInfo ");
		Result result = new Result();
		try {
			
			result = service.retrieveCooIssueDocumentInfo(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### Request Type result Class : " + "retrieveCooIssueDocumentInfo END");
		
		return result;
	}
	
	
	/**
     * downloadFtaDocument : Jasper Report
     * @param req
     * @param response
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/ireport/downloadFtaDocument")
 	public ModelAndView thirdParty_ReportApplication(HttpServletRequest req, HttpServletResponse response, @RequestParam Map param) throws Exception {
 		String message = null;
 		List<JasperPrint> jasList = null;
 		Map<String, Object> extendsParamMap = super.extendsMap(param);
 		response.addHeader("X-FRAME-OPTIONS", "SAMEORIGIN");
 		try {
 			ReportsPrintView view = new ReportsPrintView();
			
			ByteArrayOutputStream bops = null;
			
			// Form ID에 맞게 파라메터를 설정합니다.
			String formId = StringUtil.null2String(extendsParamMap.get("form_id"));
			
 			// parameter set
 			ModelMap parameter = this.makePrintParam(extendsParamMap, formId);
 			param.put("P_FILE_NAME", param.get("form_file_name"));
 			
 			
 			ReportPrintHelper operator = new ReportPrintHelper();
 			jasList = operator.getJasperPrintOfList(param, parameter);
 			
			
 			if(jasList == null || jasList.size() == 0) {
 				message = "JasperPrint is null.";
 			}
 			
			// export설정
			Map exportParameter = new HashMap();
			
			bops = new ByteArrayOutputStream();
			
			exportParameter.put(JRExporterParameter.OUTPUT_STREAM, bops);
			exportParameter.put(JRExporterParameter.JASPER_PRINT_LIST, jasList);
	
			view.setExportParameter(exportParameter);
			view.setReportOutputType(StringUtil.null2String(param.get("report_file_type")));
			
			// export 생성
			view.createExporter();
			
			// 레포트 뷰
			view.renderReport(response, param); 			
 			
 		} catch(Exception e) {
 			e.printStackTrace();
 			message = super.getMessage("MSG_UNSPECIFIED_ERROR", new Object[]{}); 
 		}
 		return null;
 	}
    
    
    /**
     * 인쇄에 필요한 파라메터를 생성합니다.
     * @param extendsParamMap
     * @return
     * @throws Exception
     */
    protected ModelMap makePrintParam(Map<String, Object> extendsParamMap, String formId) throws Exception {
    	ModelMap parameter = new ModelMap();
    	
    	/* 파라메터 셋팅 */
		parameter.put("P_COMPANY_CODE", StringUtil.null2String(extendsParamMap.get("company_code")));
		
		if (java.util.Arrays.asList("19", "2").stream().anyMatch(code -> code.equalsIgnoreCase(formId))) {
			// 19 : 원산지포괄 확인서
			//  2 : 소명서 공통 로직
			parameter.put("P_COO_CERTIFY_NO", StringUtil.null2String(extendsParamMap.get("coo_certify_no")));
		    parameter.put("P_DIVISION_CODE", StringUtil.null2String(extendsParamMap.get("division_code")));
		    
		} else {
			parameter.put("P_KEY_PARAM1", StringUtil.null2String(extendsParamMap.get("KEY_PARAM1")));
			parameter.put("P_KEY_PARAM2", StringUtil.null2String(extendsParamMap.get("KEY_PARAM2")));
			parameter.put("P_KEY_PARAM3", StringUtil.null2String(extendsParamMap.get("KEY_PARAM3")));
			parameter.put("P_KEY_PARAM4", StringUtil.null2String(extendsParamMap.get("KEY_PARAM4")));
			parameter.put("P_KEY_PARAM5", StringUtil.null2String(extendsParamMap.get("KEY_PARAM5")));
		}
    	
    	return parameter;
    }


}