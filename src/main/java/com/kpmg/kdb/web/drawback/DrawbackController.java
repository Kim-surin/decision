package com.kpmg.kdb.web.drawback;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
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

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.util.StringUtil;


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
public class DrawbackController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(DrawbackController.class);

	@Autowired
	protected DrawbackService service;


	

	
	/**
	 * 환급모니터링
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/db-001")
	public String db_001_view(Model model, HttpSession session) {
		
		return "drawback/db-001";
	}
	
	/**
	 * 문서발급관리
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/db-002")
	public String db_002_view(Model model, HttpSession session) {
		
		return "drawback/db-002";
	}
	
	/**
	 * 관세청관리 - 환급
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/db-003")
	public String db_003_view(Model model, HttpSession session) {
		
		return "drawback/db-003";
	}
	
	/**
	 * 관세청관리 - 기납증/분증
	 * 
	 * @author        D.Cat
	 * @param model   스프링 모델객체
	 * @param session HTTP세션객체
	 * @return        View Path String
	 */
	@RequestMapping(value = "/db-004")
	public String db_004_view(Model model, HttpSession session) {
		
		return "drawback/db-004";
	}


	/**
	 * 환급모니터링 준비그리드 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/drawback/selectTab1List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectTab1List(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectTab1List(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 고객사리스트
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieveDrawbackCtrmList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieveDrawbackCtrmList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieveDrawbackCtrmList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 환급모니터링 bom 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/drawback/selectTab1BomList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> selectTab1BomList(@RequestBody Map param) throws Exception {
		
		GridOutputData<Map<String, Object>> gridData = this.service.selectTab1BomList(super.extendsMap(param));
		
		return gridData;
	}
	
	/**
	 * 환급신청서 관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-005")
	public String db_005_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-005";
	}
	
	
	/**
	 * 환급신청서 정보 조회
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieve_DB005List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB005List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB005List(super.extendsMap(param));		
		
		return gridData;
	}
	
	@RequestMapping(value = "/db-00501")
	public String db_00501_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00501";
	}
	
	/**
	 * 환급신청서(갑)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00501_header")
	@ResponseBody
	public Result retrieve_DB00501_header(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB00501_header ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_DB00501_header(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 환급신청서 수출물품 (을) 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00501_trget")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00501_trget(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00501_trget(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 환급신청서 수입원재료 (병)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00501_rawmtrl")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00501_rawmtrl(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00501_rawmtrl(super.extendsMap(param));		
		
		return gridData;
	}
	
	

	/**
	 * 환급신청서 수입원재료 (병) - 제한규정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00501_RestrictRawmtrl")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00501_RestrictRawmtrl(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00501_RestrictRawmtrl(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	
	
	
	/**
	 * 환급신청서 수출 품목 삭제
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/cancel_DB00501_ConfirmProcess", method = RequestMethod.POST)
    @ResponseBody
    public Result cancel_DB00501_ConfirmProcess(@RequestBody List<Map> paramList) throws Exception {
        Map systemMap = super.extendsMap(new HashedMap());
        
        PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.return.log"));
        systemMap.put("logEnable_Flag", logEnable_Flag);
        
        return service.cancel_DB00501_ConfirmProcess(systemMap, paramList);
        
    }
    
    
	
	
	/**
	 * 수출확정
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-006")
	public String db_006_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-006";
	}
	
	
	/**
	 * 수출확정 정보 조회
	 * 
	 * @author  D.Cat
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieve_DB006List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB006List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB006List(super.extendsMap(param));		
		
		return gridData;
	}
	
	@RequestMapping(value = "/db-00601")
	public String db_00601_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00601";
	}
	
	/**
	 * 수출확정 상세 해더 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00601_header")
	@ResponseBody
	public Result retrieve_DB00601_header(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB00601_header ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_DB00601_header(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 수출확정 상세 수출 란 내역 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00601_exportList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00601_exportList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00601_exportList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 수출확정버튼 클릭
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/confirm_DB006_xportList", method = RequestMethod.POST)
	@ResponseBody
	public Result confirm_DB006_xportList(@RequestBody List<Map> paramList) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.use.log"));
        systemMap.put("logEnable_Flag", logEnable_Flag);
        
		return service.confirm_DB006_xportList(systemMap, paramList);
		
	}
	
	/**
	 * 수출확정버튼 클릭 (가능한 수량만 만들기)
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/confirm_DB006_xportList_extn", method = RequestMethod.POST)
	@ResponseBody
	public Result confirm_DB006_xportList_extn(@RequestBody List<Map> paramList) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.use.log"));
        systemMap.put("logEnable_Flag", logEnable_Flag);
        
		return service.confirm_DB006_xportList_extn(systemMap, paramList);
		
	}
	
	/**
	 * 수출확정버튼 클릭 (가능한 수량만 만들기) - 일괄실행(기간별)
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/confirm_DB006_xportList_extn2", method = RequestMethod.POST)
	@ResponseBody
	public Result confirm_DB006_xportList_extn2(@RequestBody Map param) throws Exception {
		
		Result rs = null;
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.use.log"));
        param.put("logEnable_Flag", logEnable_Flag);
        
        /** 기간별 환급신청서 생성시 월단위 작업 리스트 추출 */
        List workTarget_List = service.retrieve_Drwbak_TargetMonthList(super.extendsMap(param));
        
        for(int inx = 0; inx < workTarget_List.size(); inx++) {
        
        	Map rows = (Map)workTarget_List.get(inx);
        	param.put("TARGET_MONTH", rows.get("TARGET_MONTH"));

        	
        	service.createMonthly_StartEnd_logs(super.extendsMap(param), "DRWBAK_START");
        	
        	rs = service.confirm_DB006_xportList_extn2(super.extendsMap(param));
        	
        	service.createMonthly_StartEnd_logs(super.extendsMap(param), "DRWBAK_END");
        	
        }
        
        
		return rs; 
		
	}
	
	
	
	/**
	 * 수출확정취소버튼 클릭
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/cencel_DB006_xportList", method = RequestMethod.POST)
	@ResponseBody
	public Result cencel_DB006_xportList(@RequestBody List<Map> paramList) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("drwbak.rawmtrl.use.log"));
        systemMap.put("logEnable_Flag", logEnable_Flag);
        
		return service.cencel_DB006_xportList(systemMap, paramList);
		
	}
	
	
	
	
	
	/**
	 * 매출확정(내수) 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-007")
	public String db_007_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-007";
	}
	
	
	/**
	 * 매출확정(내수) 정보 조회
	 * 
	 * @author  D.Cat
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieve_DB007List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB007List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB007List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
     * 매출확정(내수) 
     * @param model
     * @param session
     * @return
     */
    @RequestMapping(value = "/db-00701")
    public String db_00701_view(@RequestParam Map param, Model model, HttpSession session) {
        model.addAttribute("reqParam", super.extendsMap(param));
        return "drawback/db-00701";
    }
	/**
	 * 매출확정(내수) 상세 목록 조회
	 * 
	 * @author  D.Cat
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieve_DB00701List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00701List(@RequestBody Map param) throws Exception {
	    GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00701List(super.extendsMap(param));		
	    
	    return gridData;
	}
	
	/**
	 * 기납증 생성
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/confirm_DB007_createCtrm", method = RequestMethod.POST)
	@ResponseBody
	public Result confirm_DB007_createCtrm(@RequestBody List<Map> paramList) throws Exception {
		
		Result rs = new Result();
		Map param = super.extendsMap(new HashedMap());
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("ctrm.rawmtrl.use.log"));
        param.put("logEnable_Flag", logEnable_Flag);
        param.put("TARGET_SALES_LIST", paramList);
        
        List<Map<String, Object>> confrim_CtrmTargetList =  service.retrieveConfrimCtrmTargetList(param);
        
        for(int inx=0; inx < confrim_CtrmTargetList.size(); inx++) {
        	Map rowMap = confrim_CtrmTargetList.get(inx);
        	rowMap.put("ISSUE_TYPE", "02"); // 기납증 
        	rowMap.put("logEnable_Flag", logEnable_Flag);
        	service.createCtrmProcess(super.extendsMap(rowMap));
        }
        
		return rs;
		
	}
	
	/**
	 * 매출확정(내수) 확정 Process
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/confirm_DB007_SelngList", method = RequestMethod.POST)
	@ResponseBody
	public Result confirm_DB007_SelngList(@RequestBody List<Map> paramList) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("ctrm.rawmtrl.use.log"));
        
        systemMap.put("logEnable_Flag", logEnable_Flag);
		return service.confirm_DB007_SelngList(systemMap, paramList);
		
	}
	
	/**
	 * 매출확정취소(내수) 확정 Process
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/cancel_DB007_SelngList", method = RequestMethod.POST)
	@ResponseBody
	public Result cancel_DB007_SelngList(@RequestBody List<Map> paramList) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		
		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("ctrm.rawmtrl.use.log"));
        
        systemMap.put("logEnable_Flag", logEnable_Flag);
		return service.cancel_DB007_SelngList(systemMap, paramList);
		
	}
	
	
	
	
	/**
	 * 환급신청서 관리
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-008")
	public String db008_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-008";
	}
	
	
	/**
	 * 기납/분증 정보 조회
	 * 
	 * @author  피로물질
	 * @param param
	 * @return gridData
	 */
	@RequestMapping(value="/drawback/retrieve_DB008List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB008List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB008List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 기납증 상세
	 * @param param
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-00801")
	public String db00801_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00801";
	}
	
	/**
	 * 분증 상세
	 * @param param
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-00802")
	public String db00802_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00802";
	}
	
	
	
	/**
     * 환급신청서 수출 품목 삭제
     * @param paramList
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/drawback/cancel_DB00801_ConfirmProcess", method = RequestMethod.POST)
    @ResponseBody
    public Result cancel_DB00801_ConfirmProcess(@RequestBody List<Map> paramList) throws Exception {
        Map systemMap = super.extendsMap(new HashedMap());
        
        PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();
        String logEnable_Flag = StringUtil.null2String(configurator.getString("ctrm.rawmtrl.return.log"));
        systemMap.put("logEnable_Flag", logEnable_Flag);
        
        return service.cancel_DB00801_ConfirmProcess(systemMap, paramList);
        
    }
    
    
    
	
	/**
	 * 기납/분증 상세 (갑) 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00801_header")
	@ResponseBody
	public Result retrieve_DB00801_header(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB00501_header ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_DB00801_header(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 기납/분증 상세 (을) 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00801_trget")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00801_trget(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00801_trget(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 기납/분증 상세 (을) 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00802_trget")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00802_trget(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00802_trget(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 기납/분증 상세 (병) 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00801_rawmtrl")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00801_rawmtrl(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00801_rawmtrl(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 과다환급자진신고
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-009")
	public String db_009_view(Model model, HttpSession session) {
		
		return "drawback/db-009";
	}
	
	
	/**
	 * 과다환급자진신고서 작성 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB009List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB009List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB009List(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 과다환급금 자진신고서 작성(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-00901")
	public String db00901_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00901";
	}
	
	/**
	 * 과다환급금 자진신고서 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_00901Detail")
	@ResponseBody
	public Result merge_OverDrwbak_Document(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB00501_header ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_00901Detail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 과다환급금 자진신고서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/merge_OverDrwbak_Document")
	@ResponseBody
	public Result retrieve_00901Detail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_00901Detail ");
		Result rs = new Result();
		try {
			rs = service.merge_OverDrwbak_Document(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 과다환급금 가산금액 산출(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-00902")
	public String db00902_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-00902";
	}
	
	
	/**
	 * 과다환급금 가산금액 산출(팝업) 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB009002List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB009002List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB009002List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	
	
	@RequestMapping(value = "/db-010")
	public String db_010_view(Model model, HttpSession session) {
		
		return "drawback/db-010";
	}
	
	
	/**
     * 가산금액 지급신청서
     * @param param
     * @return
     */
	@RequestMapping(value="/drawback/retrieve_DB010List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB010List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB010List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 가산금지급신청서 작성 및 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_01001Detail")
	@ResponseBody
	public Result retrieve_01001Detail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB00501_header ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_01001Detail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	
	
	
	/**
	 * 과가산금액 지급신청서 작성(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-01001")
	public String db01001_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-01001";
	}
	
	
	@RequestMapping(value = "/db-011")
	public String db_011_view(Model model, HttpSession session) {
		
		return "drawback/db-011";
	}
	
	/**
	 * 제증명서 정정 취하 승인신청서 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB011List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB011List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB011List(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 제증명서(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-01101")
	public String db01101_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-01101";
	}
	
	/**
	 * 제증명서 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB01101")
	@ResponseBody
	public Result retrieve_DB01101(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_DB01101 ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_00901Detail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 제증명서 정정 취하 승인신청서 작성(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-01102")
	public String db01102_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-01102";
	}
	
	/**
	 * 제증명서 정정 취하 승인 신청서 제증명내역 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB01102Detail")
	@ResponseBody
	public Result retrieve_DB01102Detail(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_01102Detail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_DB01102Detail(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 제증명서 정정 취하 승인 신청서 작성
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/create_DB01102Detail")
	@ResponseBody
	public Result update_DB01102Detail(@RequestBody Map param) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		return service.create_DB01102Detail(super.extendsMap(param));
	}
	
	
	
	/**
	 * 조견표
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-012")
	public String db012_view(Model model, HttpSession session) {
		
		return "drawback/db-012";
	}
	
	/**
	 * 조견표 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB012List")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB012List(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB012List(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 조견표(팝업)
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/db-01201")
	public String db01201_view(@RequestParam Map param, Model model, HttpSession session) {
		model.addAttribute("reqParam", super.extendsMap(param));
		return "drawback/db-01201";
	}
	
	/**
	 * 조견표(팝업) - 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB01201DetailList")
	@ResponseBody
	public Result retrieve_DB01201DetailList(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_01102Detail ");
		Result rs = new Result();
		try {
			rs.setValue(service.retrieve_DB01201DetailList(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	/**
	 * 조견표(팝업) - 기납증 or 환급신청서 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB01201RegistRcepMaterialtList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB01201RegistRcepMaterialtList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB01201RegistRcepMaterialtList(super.extendsMap(param));		
		
		return gridData;
	}
	
	
	/**
	 * 조견표(팝업) - 원재료 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB01201RegistRceptList")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB01201RegistRceptList(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB01201RegistRceptList(super.extendsMap(param));		
		
		return gridData;
	}
	
	/**
	 * 조견표(팝업) 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/update_DB01201DetailList")
	@ResponseBody
	public Result update_DB01201DetailList(@RequestBody Map param) throws Exception {
		Map systemMap = super.extendsMap(new HashedMap());
		
		return service.update_DB01201DetailList(super.extendsMap(param));
	}
	
	/**
	 * 관세청 수신 상태 유효 정보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/get_unipass_status_count", method = RequestMethod.POST)
	@ResponseBody
	public Result get_unipass_status_count(@RequestBody Map param) throws Exception {
		return service.get_unipass_status_count(param);
	}
	
	/**
	 * 관세청 접수통보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_notification", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_notification(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_notification(param);
	}
	
	/**
	 * 관세청 오류통보 master 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_error_master", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_error_master(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_error_master(param);
	}
	
	/**
	 * 관세청 오류통보 detail 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_error_details", method = RequestMethod.POST)
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_unipass_status_error_details(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_error_details(param);
	}
	
	/**
	 * 관세청 보완통보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_complement", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_complement(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_complement(param);
	}
	
	/**
	 * 관세청 자료제출요구통보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_request", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_request(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_request(param);
	}
	
	/**
	 * 관세청 완료통보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_complete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_complete(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_complete(param);
	}
	
	/**
	 * 관세청 지급통보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawback/retrieve_unipass_status_payment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> retrieve_unipass_status_payment(@RequestBody Map param) throws Exception {
		return service.retrieve_unipass_status_payment(param);
	}
	
	/**
	 * 가산금 지급신청서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/merge_adamtData")
	@ResponseBody
	public Result merge_adamtData(@RequestBody Map param) throws Exception {
		logger.debug("##### Request Type result Class : " + "retrieve_00901Detail ");
		Result rs = new Result();
		try {
			rs = service.merge_adamtData(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	@RequestMapping(value = "/drawback/retrieve_adamtDetailData", method = RequestMethod.POST)
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_adamtDetailData(@RequestBody Map param) throws Exception {
		return service.retrieve_adamtDetailData(super.extendsMap(param));
	}
	
	
	/**
	 * 기납증 연관 매출정보 조회
	 * @param param
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/drawback/initSalesDataPopup")
	public String initSalesDataPopup_view(@RequestParam Map param, Model model, HttpSession session) {
		
		String returnPageStr = "";
		model.addAttribute("reqParam", super.extendsMap(param));
		returnPageStr = "drawback/db-00803";
		
		
		return returnPageStr;
	}
	
	
	/**
	 * 기납증 연관 매출 데이터 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/drawback/retrieve_DB00803_trget")
	@ResponseBody
	public GridOutputData<Map<String, Object>> retrieve_DB00803_trget(@RequestBody Map param) throws Exception {
		GridOutputData<Map<String, Object>> gridData = this.service.retrieve_DB00803_trget(super.extendsMap(param));		
		
		return gridData;
	}
	
}