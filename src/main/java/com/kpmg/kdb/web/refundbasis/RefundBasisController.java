package com.kpmg.kdb.web.refundbasis;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.StringUtil;


/*******************************************************************************************
 * 
 * RefundBasisController.class
 * 
 * @since 2018.02.01
 * @author D.Cat
 *
 * 환급 기초 정보 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class RefundBasisController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(RefundBasisController.class);

	@Autowired
	protected RefundBasisService service;


	
	
	/**
	 * 구매처관리
	 * 
	 * @author  D.Cat
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-001")
	public String refundBasis_001_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-001 ");
		
		return "refundBasis/refundBasis-001";

	}
	
	/**
	 * 수입신고 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-002")
	public String refundBasis_002_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-002");
		
		return "refundBasis/refundBasis-002";

	}
	
	
	/**
	 * 수입신고 상세 팝업
	 * 
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-00201")
	public String rb_00201_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		
		return "refundBasis/refundBasis-00201";

	}
	
	/**
	 * 수입신고 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB002Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB002Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRf002Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB002Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 수입신고 데이터 상세
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/refundBasis/retrieveImpDetail")
	@ResponseBody
	public Result retrieveImpDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveImpDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveImpDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 수입신고 상세 란목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/refundBasis/retrieveImpDetail_LneList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveImpDetail_LneList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRf002Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveImpDetail_LneList(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 수입신고 상세 행목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/refundBasis/retrieveImpDetail_PouchList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveImpDetail_PouchList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRf002Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveImpDetail_PouchList(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 수출신고 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-009")
	public String refundBasis_009_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-009");
		
		return "refundBasis/refundBasis-009";

	}
		
	/**
	 * 수출신고 상세 팝업
	 * 
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-00901")
	public String rb_00901_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		
		return "refundBasis/refundBasis-00901";

	}
	
	/**
	 * 수출신고 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB009Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB009Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRB009Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB009Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 수출신고 데이터 상세
	 * 
	 * @author  피로물질
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/refundBasis/retrieveExpDetail")
	@ResponseBody
	public Result retrieveExpDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveExpDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveExpDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 수출신고 데이터 상세 란/행 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/refundBasis/retrieveExpDetail_Lne")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveExpDetail_Lne(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveExpDetail_Lne :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveExpDetail_Lne(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 부산물비율 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-010")
	public String refundBasis_010_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-010");
		
		return "refundBasis/refundBasis-010";

	}
		
	/**
	 * 부산물비율 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB010Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB010Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRB010Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB010Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 생산일자관리 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-011")
	public String refundBasis_011_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-011");
		
		return "refundBasis/refundBasis-011";

	}
		
	/**
	 * 생산일자관리 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB011Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB011Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRB011Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB011Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 월별수입물품집계 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-012")
	public String refundBasis_012_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-012");
		
		return "refundBasis/refundBasis-012";
		
	}
	
	/**
	 * 월별수입물품집계 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB012Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB012Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRB012Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB012Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 연간수입물량집계 화면 호출
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-013")
	public String refundBasis_013_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-013");
		
		return "refundBasis/refundBasis-013";
		
	}
	
	/**
	 * 연간수입물량집계 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/refundBasis/retrieveRB013Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRB013Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRB013Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRB013Grid(super.extendsMap(param));
		return gridData;
	}

	
	/**
	 * 구매원장
	 * 
	 * @author  
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-004")
	public String refundBasis_004_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-004 ");
		
		return "refundBasis/refundBasis-004";

	}
	
	/**
	 * 매출정보
	 * 
	 * @author  
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-006")
	public String refundBasis_006_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-006 ");
		
		return "refundBasis/refundBasis-006";

	}
	
	/**
	 * 자재수불부 관리
	 * 
	 * @author  
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-007")
	public String refundBasis_007_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-007 ");
		
		return "refundBasis/refundBasis-007";

	}
	
	/**
	 * 표준BOM 관리
	 * 
	 * @author  
	 * @param model 스프링 모델객체
	 * @param session HTTP세션객체
	 * @return 뷰 경로 문자열
	 */

	@RequestMapping(value = "/refundBasis-008")
	public String refundBasis_008_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-008 ");
		
		return "refundBasis/refundBasis-008";

	}
	
	/**
	 * 구매원장 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/selectPoList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectPoList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectPoList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 매출내역 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/selectSalesList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectSalesList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectSalesList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 자재수불부 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/selectMaterialList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectMaterialList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectMaterialList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 표준BOM 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/retrieveBomList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveBomList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveBomList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 표준BOM 원자재 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/selectItemList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectItemList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectItemList(super.extendsMap(param));
		
		return gridData;
	}
	
	
	
	/**  2019.02.18 : D.Cat 추가 **/
	
	
	/**
	 * 간이정액환급관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-014")
	public String refundBasis_014_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "refundBasis-014 ");
		
		return "refundBasis/refundBasis-014";

	}
	
	/**
	 * 간이정액환급 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/retrieveRefundBasis-014")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_014(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRefundBasis_014(super.extendsMap(param));
		
		return gridData;
	}
	
	
	/**
	 * 단축고시정보관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-015")
	public String refundBasis_015_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "/refundBasis-015 ");
		
		return "refundBasis/refundBasis-015";

	}
	
	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/refundbasis/retrieve_RB015_YearCodeList")
	@ResponseBody
	public Result retrieve_RB015_YearCodeList(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_RB015_YearCodeList(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 단축고시정보조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/retrieveRefundBasis-015")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_015(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRefundBasis_015(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-016")
	public String refundBasis_016_view(Model model, HttpSession session) {
		logger.debug("##### View Page : " + "/refundBasis-016 ");
		
		return "refundBasis/refundBasis-016";

	}
	
	/**
	 * 거래처 관리 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/retrieveRefundBasis-016")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveRefundBasis_016(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveRefundBasis_016(super.extendsMap(param));
		
		return gridData;
	}
	
	
	/**
	 * 파일 업로드 관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-021")
	public String refundBasis_021_view(Model model, HttpSession session) {
		return "refundBasis/refundBasis-021";

	}
	
	
	/**
	 * 파일 업로드 관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-02101")
	public String refundBasis_02101_view(Model model, HttpSession session) {
		return "refundBasis/refundBasis-02101";

	}
	
	
	/**
	 * 엑셀업로드 오류내역 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refundbasis/excelUpload_ErrorList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> excelUpload_ErrorList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.excelUpload_ErrorList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 기존데이터 체크 
	 * @param param
	 * @param files
	 * @param request
	 * @param mReq
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/refundbasis/retrievePreDataCheck", method = RequestMethod.POST)
	@ResponseBody
	public Result retrievePreDataCheck(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		try {
			rs = service.retrievePreDataCheck(super.extendsMap(param));
			
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 수입 데이터 엑셀 업로드
	 * @param param
	 * @param files
	 * @param request
	 * @param mReq
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/refundbasis/uploadImportExcelProcess", method = {RequestMethod.POST})
	@ResponseBody
	public Result uploadImportExcelProcess(@RequestParam Map param,  @RequestParam("file1") MultipartFile files, HttpServletRequest request, MultipartHttpServletRequest mReq) throws Exception {
		Result rs = new Result();
		
		try {
			param.put("WORK_TYPE", "IMP");
			//rs = service.uploadImportExportExcelProcess(super.extendsMap(param), files);
			rs = service.uploadImportExportExcelProcess_For_MultiMonthData(super.extendsMap(param), files);
			
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	
	
	/**
	 * 수출 데이터 엑셀 업로드  
	 * @param param
	 * @param files
	 * @param request
	 * @param mReq
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/refundbasis/uploadExportExcelProcess", method = RequestMethod.POST)
	@ResponseBody
	public Result uploadExportExcelProcess(@RequestParam Map param,  @RequestParam("file1") MultipartFile files, HttpServletRequest request, MultipartHttpServletRequest mReq) throws Exception {
		Result rs = new Result();
		
		try {
			param.put("WORK_TYPE", "EXP");
			rs = service.uploadImportExportExcelProcess_For_MultiMonthData(super.extendsMap(param), files);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 매각원장
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/refundBasis-022")
	public String refundBasis_022_view(Model model, HttpSession session) {
		return "refundBasis/refundBasis-022";

	}
	
	
	/**
	 * 매각원장 목록 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/refundBasis/retrievSalesLedgerList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrievSalesLedgerList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveRf002Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrievSalesLedgerList(super.extendsMap(param));
		return gridData;
	}
	
			
	
	
}