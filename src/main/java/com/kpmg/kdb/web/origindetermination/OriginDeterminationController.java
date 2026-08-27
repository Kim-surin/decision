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
import com.kpmg.kdb.web.origindetermination.dto.ExportOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.MonthlyOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;

@Controller
public class OriginDeterminationController extends GenericController {
	@Autowired
	protected OriginDeterminationService originDeterminationService;

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDetermination")
	public String domesticOriginDetermination_view(Model model, HttpSession session) {
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
	
	@RequestMapping(value = "/origin/compliance/origindetermination/exportOriginDetermination")
	public String exportOriginDetermination_view(Model model, HttpSession session) {
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

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetail_popup")
	public String originDeterminationDetail_popup(@RequestParam(value = "datas", required = false) String datas,
			@RequestParam(value = "mode", required = false) String mode, Model model, HttpSession session) {
		model.addAttribute("datas", datas);
		model.addAttribute("mode", mode);

		return "origindetermination/originDeterminationDetail_popup";
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetailList")
	@ResponseBody
	public Result originDeterminationDetailList(@RequestBody OriginDeterminationDetailRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationDetailList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetailResultList")
	@ResponseBody
	public Result originDeterminationDetailResultList(@RequestBody OriginDeterminationDetailResultRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationDetailResultList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeDomesticOriginDetermination")
	@ResponseBody
	public Result executeDomesticOriginDetermination(@RequestBody DomesticOriginDeterminationExecuteRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.executeDomesticOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeExportOriginDetermination")
	@ResponseBody
	public Result executeExportOriginDetermination(@RequestBody ExportOriginDeterminationExecuteRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.executeExportOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeMonthlyOriginDetermination")
	@ResponseBody
	public Result executeMonthlyOriginDetermination(@RequestBody MonthlyOriginDeterminationExecuteRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.executeMonthlyOriginDetermination(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
