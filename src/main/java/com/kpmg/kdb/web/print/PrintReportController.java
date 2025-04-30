package com.kpmg.kdb.web.print;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kpmg.kdb.core.common.helper.ReportPrintHelper;
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
public class PrintReportController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(PrintReportController.class);

	@Autowired
	protected PrintReportService service;


	

	
	/**
	 * 출력물 Ready Page
	 * @param param
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewPreviewDocumentPage")
    public String viewPreviewDocumentPage(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "print/previewDocumentPage";
	}

	/**
     * thirdParty_ReportApplication : Jasper Report
     * @param req
     * @param response
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/thirdParty_ReportApplication")
 	public ModelAndView thirdParty_ReportApplication(HttpServletRequest req, HttpServletResponse response, @RequestParam Map param) throws Exception {
 		String message = null;
 		List<JasperPrint> jasList = null;
 		Map<String, Object> extendsParamMap = super.extendsMap(param);
 		response.addHeader("X-FRAME-OPTIONS", "SAMEORIGIN");
 		try {
 			ReportsPrintView view = new ReportsPrintView();
			
			ByteArrayOutputStream bops = null;
			
			
			// Form ID에 맞게 파라메터를 설정합니다.
			String formId = StringUtil.null2String(extendsParamMap.get("P_FORM_ID"));
			
			// 사용할 Jasper 문서 정보를 조회한다.
			extendsParamMap.putAll(service.retrievePrintDocumentInformation(super.extendsMap(extendsParamMap)));
			
 			// parameter set
 			ModelMap parameter = this.makePrintParam(extendsParamMap, formId);

 			
			
 			String report_type = StringUtil.null2String(param.get("P_JASPER_TYPE"));
 			ReportPrintHelper operator = new ReportPrintHelper();

			// JasperPrint 생성
			if("basic".equals(report_type)){
				jasList = operator.getJasperPrintOfList(param, parameter);
			} else {
				jasList = operator.getJasperPrintOfCooList(param, parameter);
			} 			
 			
 			if(jasList == null || jasList.size() == 0) {
 				message = "JasperPrint is null.";
 			}
 			
			// export설정
			Map exportParameter = new HashMap();
			
			bops = new ByteArrayOutputStream();
			
			exportParameter.put(JRExporterParameter.OUTPUT_STREAM, bops);
			exportParameter.put(JRExporterParameter.JASPER_PRINT_LIST, jasList);
	
			view.setExportParameter(exportParameter);
			view.setReportOutputType(StringUtil.null2String(param.get("REPORT_FILE_TYPE")));
			
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
		parameter.put("P_COMPANY_CODE", StringUtil.null2String(extendsParamMap.get("COMPANY_CODE")));
		
		if(formId.equalsIgnoreCase("PRT00000")) {
		    parameter.put("P_OVER_DRWBAK_PRESENTN_NO", StringUtil.null2String(extendsParamMap.get("KEY_PARAM1")));
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