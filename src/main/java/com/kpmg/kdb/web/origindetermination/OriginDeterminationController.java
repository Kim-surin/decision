package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;

@Controller
public class OriginDeterminationController extends GenericController {
	@Autowired
	protected OriginDeterminationService originDeterminationService;
	
	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDetermination")
	public String domesticOriginDetermination_view(Model model, HttpSession session) {
		try {
		} catch(Exception e) {
			
		}
		return "origindetermination/domesticOriginDetermination_view";
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationList")
	@ResponseBody
	public Result domesticOriginDetermination_list(@RequestBody OriginDeterminationRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	@RequestMapping(value = "/origin/compliance/origindetermination/individualDomesticOriginDetermination_popup")
	public String individualDomesticOriginDetermination_view(
			@RequestParam(value = "status", required = false) String status,
	        @RequestParam(value = "datas", required = false) String datas, 
	        Model model, HttpSession session) {
		try {
			 model.addAttribute("datas", datas); 
			 
			 switch(status){
				case "0": // 미판정
				case "1":
					return "origindetermination/individualDomesticOriginUnDetermined_popup";
				case "4": // 판정 완료
					return "origindetermination/individualDomesticOriginDetermined_popup";
				case "5": // 판정 실패
					return "origindetermination/individualDomesticOriginFailed_popup";
			}
		} catch(Exception e) {
			
		}
		
		return "origindetermination/individualDomesticOriginDetermination_view";
	}
	
	@RequestMapping(value = "/origin/compliance/origindetermination/exportOriginDetermination")
	public String exportOriginDetermination_view(Model model, HttpSession session) {
		try {
		} catch(Exception e) {
			
		}
		return "origindetermination/exportOriginDetermination_view";
	}
	
	@RequestMapping(value = "/origin/compliance/origindetermination/exportOriginDeterminationList")
	@ResponseBody
	public Result exportOriginDetermination_list(@RequestBody OriginDeterminationRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveExportOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationResult")
	public String originDeterminationResult_view(Model model, HttpSession session) {
		try {
		} catch(Exception e) {
			
		}
		return "origindetermination/originDeterminationResult_view";
	}
	
	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationResultList")
	@ResponseBody
	public Result originDeterminationResult_list(@RequestBody OriginDeterminationRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationResult(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
