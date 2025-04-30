package com.kpmg.kdb.web.report;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/*******************************************************************************************
 * 
 * ReportController.class
 * 
 * @since 2018.07
 * @author user03
 *
 * 레포트 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ReportController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(ReportController.class);

	@Autowired
	protected ReportService service;

	/**
	 * 기간별 환급레포트
	 * 
	 * @author user03
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/report-001")
	public String report_001_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-001 ");
		
		return "report/report-001";

	}
	
	/**
	 * 기간별 환급레포트 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R001List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R001List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R001List :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R001List(super.extendsMap(param));
		return gridData;
	}
	
	
	/**
	 * 잔여수량 레포트
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-002")
	public String report_002_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-002");

		return "report/report-002";

	}

	/**
	 * 잔량레포트 - 거래처별 Pie Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getExporterBalanceTax", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getExporterBalanceTax(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getExporterBalanceTax(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 - 거래처별 Bar Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getExporterBalanceQty", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getExporterBalanceQty(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getExporterBalanceQty(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 - 자재코드별 Bar Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getItemCodeBalanceTax", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getItemCodeBalanceTax(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getItemCodeBalanceTax(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 - 자재코드별 Pie Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getItemCodeBalanceQty", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getItemCodeBalanceQty(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getItemCodeBalanceQty(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 - HS CODE별 Bar Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getHsCodeBalanceTax", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getHsCodeBalanceTax(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getHsCodeBalanceTax(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 - HS CODE별 Pie Chart Data
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt002_getHsCodeBalanceQty", method = RequestMethod.POST)
	public @ResponseBody Result rpt002_getHsCodeBalanceQty(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt002_getHsCodeBalanceQty(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 잔량레포트 우측상단 그리드 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveRpt00201List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRpt00201List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRpt00201List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRpt00201List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 잔량레포트 우측상단 그리드 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveRpt0020XList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRpt00203List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRpt0020XList :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRpt0020XList(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 잔여수량 상세 레포트 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveRpt00202List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRpt00202List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRpt00202List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRpt00202List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 조건표 관리
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-003")
	public String report_003_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-003");

		return "report/report-003";

	}

	/**
	 * 조건표 데이터 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R003List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R003List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R003List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R003List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 기납증/분증 수취레포트
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-004")
	public String report_004_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-004");

		return "report/report-004";

	}

	/**
	 * 기납증/분증 수취 데이터 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R004List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R004List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R004List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R004List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 월별 협력업체 정산레포트
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-005")
	public String report_005_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-005");

		return "report/report-005";

	}

	/**
	 * 월별 고객사 기납증 레포트
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-006")
	public String report_006_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-006");

		return "report/report-006";

	}

	/**
	 * 구매확인서/기납증 비교 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R006List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R006List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R006List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R006List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * hs code 비교레포트
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-007")
	public String report_007_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-007");

		return "report/report-007";

	}

	/**
	 * 환급금액 레포트
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/report-008")
	public String report_008_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-008");

		return "report/report-008";

	}

	/**
	 * 환급금액 레포트 - 거래처별 - [Pie Chart Data] 수출액 대비 환급액 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getVendorDrwbak_Rate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getVendorDrwbak_Rate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getVendorDrwbak_Rate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - 거래처별 - [Bar Chart Data] 환급수량별 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getVendorDrwbakUsedQtyData", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getVendorDrwbakUsedQtyData(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getVendorDrwbakUsedQtyData(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - 거래처별 - [Bar Chart Data] 납부세액 대비 환급비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getVendorTaxByDrwBakRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getVendorTaxByDrwBakRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getVendorTaxByDrwBakRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - 제품코드 별 - [Pie Chart Data] 수출액 대비 환급액 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getItemCodeDrwbak_Rate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getItemCodeDrwbak_Rate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getItemCodeDrwbak_Rate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - 제품코드 별 - [Bar Chart Data] 환급수량별 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getItemCodeDrwbakUsedQtyData", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getItemCodeDrwbakUsedQtyData(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getItemCodeDrwbakUsedQtyData(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - 제품코드 별 - [Bar Chart Data] 납부세액 대비 환급비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getItemCodeTaxByDrwBakRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getItemCodeTaxByDrwBakRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getItemCodeTaxByDrwBakRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - HS Code 별 - [Pie Chart Data] 수출액 대비 환급액 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getHsCodeDrwbak_Rate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getHsCodeDrwbak_Rate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getHsCodeDrwbak_Rate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - HS Code 별 - [Bar Chart Data] 환급수량별 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getHsCodeDrwbakUsedQtyData", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getHsCodeDrwbakUsedQtyData(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getHsCodeDrwbakUsedQtyData(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 - HS Code 별 - [Bar Chart Data] 납부세액 대비 환급비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getHsCodeTaxByDrwBakRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getHsCodeTaxByDrwBakRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getHsCodeTaxByDrwBakRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 -목적국 별 - [Pie Chart Data] 수출액 대비 환급액 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getNationCodeDrwbak_Rate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getNationCodeDrwbak_Rate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getNationCodeDrwbak_Rate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 -목적국 별 - [Bar Chart Data] 환급수량별 비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getNationCodeDrwbakUsedQtyData", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getNationCodeDrwbakUsedQtyData(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getNationCodeDrwbakUsedQtyData(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 -목적국 별 - [Bar Chart Data] 납부세액 대비 환급비율
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getNationCodeTaxByDrwBakRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getNationCodeTaxByDrwBakRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getNationCodeTaxByDrwBakRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 기납증/분증 수취금액 비율 -[Pie Chart Data] 금액
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getCcpyAmountRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getCcpyAmountRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getCcpyAmountRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 기납증/분증 수취금액 비율 -[Pie Chart Data] 수량
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getCcpyQtyRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getCcpyQtyRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getCcpyQtyRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 구매확인서 대비 기납증/분증 발급금액 비율 -[Pie Chart Data] 금액
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getCtrmAmountRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getCtrmAmountRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getCtrmAmountRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 구매확인서 대비 기납증/분증 발급금액 비율 -[Pie Chart Data] 수량
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/rpt008_getCtrmQtyRate", method = RequestMethod.POST)
	public @ResponseBody Result rpt008_getCtrmQtyRate(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.rpt008_getCtrmQtyRate(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급금액 레포트 상세 레포트 조회
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveRpt0080XList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRpt0080XList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieverpt00802List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRpt0080XList(super.extendsMap(param));
		return gridData;
	}


	/**
	 * 환급금액 레포트 상세 레포트 조회(납부세액 상세)
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveRpt0080XList_IMPDEC")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRpt0080XList_IMPDEC(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieverpt00802List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRpt0080XList_IMPDEC(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 수출입 데이터 중복
	 * 
	 * @author user03
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/report-010")
	public String report_010_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-010 ");

		return "report/report-010";

	}

	/**
	 * 수출입 데이터 중복 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R010List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R010List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R010List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R010List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 수입 자재코드 분석
	 * 
	 * @author user03
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/report-011")
	public String report_011_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-011 ");

		return "report/report-011";

	}

	/**
	 * 수입 자재코드 분석 하단 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R011List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R011List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R011List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R011List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 수출입 분석(HS_CODE 차이)
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_diffHsCodeList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_diffHsCodeList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_diffHsCodeList :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_diffHsCodeList(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 수출입 분석(자재코드명 차이)
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_diffItemNmList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_diffItemNmList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_diffItemNmList :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_diffItemNmList(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 수출입 분석(단가 차이)
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_diffPriceList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_diffPriceList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_diffPriceList :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_diffPriceList(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 환급대상 수출
	 * 
	 * @author user03
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/report-012")
	public String report_012_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-012 ");

		return "report/report-012";

	}

	/**
	 * 환급대상 수출 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R012List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R012List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R012List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R012List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * 환급대상 수출조회 - 수출금액 -[Pie Chart Data] 제조자 또는 환급신청인 오류 건 수출금액 /총 수출금액 *100
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveErrorByExportAmountRatePieChart", method = RequestMethod.POST)
	public @ResponseBody Result retrieveErrorByExportAmountRatePieChart(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.retrieveErrorByExportAmountRatePieChart(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급대상 수출조회 - 수출수량 -[Pie Chart Data] 제조자 또는 환급신청인 오류 건 수출수량 /총 수출수량 *100
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveErrorByExportQtyRatePieChart", method = RequestMethod.POST)
	public @ResponseBody Result retrieveErrorByExportQtyRatePieChart(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.retrieveErrorByExportQtyRatePieChart(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}

	/**
	 * 환급대상 수출조회 - 환급금액 -[Pie Chart Data] 제조자 또는 환급신청인 오류 건 환급금액 /총 환급금액 *100
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/report/retrieveErrorByDrwbAmountRatePieChart", method = RequestMethod.POST)
	public @ResponseBody Result retrieveErrorByDrwbAmountRatePieChart(@RequestBody Map param) {
		Result rs = new Result();
		try {
			rs = service.retrieveErrorByDrwbAmountRatePieChart(super.extendsMap(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			rs.setSuccess(false);
			
			rs.setMessage(e.getMessage());
		}
		return rs;
	}


	/**
	 * BOM 검증
	 * 
	 * @author user03
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/report-013")
	public String report_013_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "report-013 ");

		return "report/report-013";
	}


	/**
	 * BOM 검증 상단 조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R013List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R013List(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R013List :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R013List(super.extendsMap(param));
		return gridData;
	}

	/**
	 * BOM 검증 하단조회
	 * 
	 * @param model
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/report/retrieve_R013DetailList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_R013DetailList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieve_R013DetailList :" + param.toString());

		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_R013DetailList(super.extendsMap(param));
		return gridData;
	}

}