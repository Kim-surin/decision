package com.kpmg.kdb.web.cusven;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;


/*******************************************************************************************
 * 
 * CustomerVendorController.class
 * 
 * @since 2018.06.25
 * @author D.Cat
 *
 * 거래처 관리 관련 기능 구현 클래스
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class CustomerVendorController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(CustomerVendorController.class);

	@Autowired
	protected CustomerVendorService service;


	

	
	/**
	 * 고객 구매확인서 관리
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-001")
	public String customerPurchaseConfirmation_View(Model model, HttpSession session) {
		
		return "cusven/cv-001";
	}
	
	/**
     * 고객사 근거서류 목록 조회 
     * @param param
     * @return
     */
	@RequestMapping(value="/cusven/retrieve_CV001List")
    @ResponseBody
    public GridOutputData<Map<String, Object>> retrieve_CV001List(@RequestBody Map param) throws Exception {
        GridOutputData<Map<String, Object>> gridData = this.service.retrieve_CV001List(super.extendsMap(param));        
        
        return gridData;
    }


	/**
     * 고객 구매확인서 관리
     * 
     * @author        D.Cat
     * @param model   스프링 모델객체
     * @param session HTTP세션객체
     * @return        View Path String
     */
    @RequestMapping(value = "/cv-00101")
    public String customerPurchaseConfirmationDetail_View(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
        return "cusven/cv-00101";
    }
    
    
	/**
     * 고객사 근거서류 상세 Header 조회 
     * @param param
     * @return
     */
	@RequestMapping(value="/drawback/retrieve_CV00101_header")
    @ResponseBody
    public Result retrieve_DB00801retrieve_CV00101_header_header(@RequestBody Map param) throws Exception {
        logger.debug("##### Request Type result Class : " + "retrieve_DB00501_header ");
        Result rs = new Result();
        try {
            rs.setValue(service.retrieve_CV00101_header(super.extendsMap(param)));
            rs.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return rs;
    }
	
	/**
     * 고객사 근거서류 상세 List 조회 
     * @param param
     * @return
     */
	@RequestMapping(value="/cusven/retrieve_CV00101_List")
    @ResponseBody
    public GridOutputData<Map<String, Object>> retrieve_CV00101_List(@RequestBody Map param) throws Exception {
        GridOutputData<Map<String, Object>> gridData = this.service.retrieve_CV00101_List(super.extendsMap(param));        
        
        return gridData;
    }
	
	/**
	 * 매매 계약서 관리
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-002")
	public String salesContract_View(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-002";
	}
	
	/**
	 * 공급사 구매확인서 관리
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-003")
	public String vendorPurchaseConfirmation_View(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-003";
	}
	
	/**
	 * 양수자 통보 관리
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-004")
	public String noticeOfTransfer_View(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-004";
	}
	
	/**
	 * 양수자 통보 데이터 조회
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/cusven/retrieveCV004Grid")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveCV004Grid(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveCV004Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveCV004Grid(super.extendsMap(param));
		return gridData;
	}
	
	/**
	 * 양수자 통보 관리 상세
	 * 
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-00401")
	public String cusven_00401_View(@RequestParam Map param, Model model, HttpSession session) {
		
		model.addAttribute("reqParam", param);
		return "cusven/cv-00401";
	}
	
	/**
	 * 양수자통보 조회 마스터 정보 조회 - 해더
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cusven/retrieveCV004GridDetail")
	@ResponseBody
	public Result retrieveCV004GridDetail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieveImpDetail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieveCV004GridDetail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 양수자통보 조회 마스터 정보 조회 - 리스트
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/cusven/retrieveCV004GridDetailList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveCV004GridDetailList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type GridOutputData : " + "retrieveCV004Grid :" + param.toString());
		
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveCV004GridDetailList(super.extendsMap(param));
		return gridData;
	}
	
	
	
	/**
	 * 협력업체 차이정산
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-005")
	public String differenceAdjustmentc_View(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-005";
	}

	
	/**
	 * BOM제출
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-006")
	public String view_BomSubmit(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-006";
	}
	
	
	/**
	 * BOM 제출 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_CV006List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_CV006List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_CV006List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * BOM제출(기납증)
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/cv-007")
	public String view_BomSubmit_forInit(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
		return "cusven/cv-007";
	}
	
	
	/**
	 * BOM 제출 목록 조회(기납증)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_CV007List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_CV007List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_CV007List(super.extendsMap(param));		
		
		return gridData;
	}

}