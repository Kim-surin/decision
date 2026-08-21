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
import com.kpmg.kdb.web.origindetermination.dto.DomesticOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultRequestDto;

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
	
	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationDetailList")
	@ResponseBody
	public Result domesticOriginDeterminationDetailList(@RequestBody OriginDeterminationDetailRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDeterminationDetailList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationResultList")
	@ResponseBody
	public Result domesticOriginDeterminationResultList(@RequestBody OriginDeterminationResultRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDeterminationResultList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationResultDetailList")
	@ResponseBody
	public Result domesticOriginDeterminationResultDetailList(@RequestBody OriginDeterminationResultDetailRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDeterminationResultDetailList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationExecute")
	@ResponseBody
	public Result domesticOriginDeterminationExecute(@RequestBody DomesticOriginDeterminationExecuteRequestDto param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.executeDomesticOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDetermination_popup")
	public String domesticOriginDetermination_popup(
			@RequestParam(value = "datas", required = false) String datas,
	        Model model, HttpSession session) {
		model.addAttribute("datas", datas);

		return "origindetermination/domesticOriginDetermination_popup";
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
