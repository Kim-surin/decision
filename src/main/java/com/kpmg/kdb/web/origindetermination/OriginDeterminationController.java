package com.kpmg.kdb.web.origindetermination;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.origindetermination.dto.DomesticOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.ExportOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.MonthlyOriginDeterminationExecuteRequestDto;

@Controller
public class OriginDeterminationController extends GenericController {
	@Autowired
	protected OriginDeterminationService originDeterminationService;

	@Autowired
	protected ConversionStrategyService conversionStrategyService;

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDetermination")
	public String domesticOriginDetermination_view(Model model, HttpSession session) {
		return "origindetermination/domesticOriginDetermination_view";
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/domesticOriginDeterminationList")
	@ResponseBody
	public Result domesticOriginDetermination_list(@RequestBody Map param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDetermination(super.extendsMap(param));
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
	public Result exportOriginDetermination_list(@RequestBody Map param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveExportOriginDetermination(super.extendsMap(param));
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
	public Result originDeterminationResult_list(@RequestBody Map param) throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationResult(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	// JSON 바디로 받아 datas를 그대로 재직렬화해 뷰에 넘긴다. 폼인코딩 문자열을 거치지 않아 이중 이스케이프가 생기지 않는다.
	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetail_popup")
	public String originDeterminationDetail_popup(@RequestBody(required = false) Map param, Model model, HttpSession session)
			throws Exception {
		Object datas = Collections.emptyList();
		Object mode = null;
			
		if(param != null) {
			if(param.get("datas") != null) {
				datas = param.get("datas");
			}
			
			mode = param.get("mode");
		}
		
		model.addAttribute("datas", new ObjectMapper().writeValueAsString(datas));
		model.addAttribute("mode", mode);

		return "origindetermination/originDeterminationDetail_popup";
	}

	// "BOM 추적" 아이콘 클릭 시 뜨는 팝업. 그 협정(FTA_CODE) 판정 계산에 실제로 쓰인 최종 원재료(FCR_DTL)를 보여준다.
	@RequestMapping(value = "/origin/compliance/origindetermination/bomTraceList_popup")
	public String bomTraceList_popup(@RequestParam(value = "sales_no", required = false) String salesNo,
			@RequestParam(value = "sales_seq", required = false) String salesSeq,
			@RequestParam(value = "fta_code", required = false) String ftaCode,
			@RequestParam(value = "fta_name", required = false) String ftaName, Model model, HttpSession session) {
		model.addAttribute("sales_no", salesNo);
		model.addAttribute("sales_seq", salesSeq);
		model.addAttribute("fta_code", ftaCode);
		model.addAttribute("fta_name", ftaName);

		return "origindetermination/bomTraceList_popup";
	}

	// "역내전환전략" 아이콘 클릭 시 뜨는 팝업. 세번변경/부가가치기준 충족에 원산지확인서가 필요한 원재료를 보여준다.
	@RequestMapping(value = "/origin/compliance/origindetermination/conversionStrategy_popup")
	public String conversionStrategy_popup(@RequestParam(value = "sales_no", required = false) String salesNo,
			@RequestParam(value = "sales_seq", required = false) String salesSeq,
			@RequestParam(value = "fta_code", required = false) String ftaCode,
			@RequestParam(value = "fta_name", required = false) String ftaName, Model model, HttpSession session) {
		model.addAttribute("sales_no", salesNo);
		model.addAttribute("sales_seq", salesSeq);
		model.addAttribute("fta_code", ftaCode);
		model.addAttribute("fta_name", ftaName);

		return "origindetermination/conversionStrategy_popup";
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/conversionStrategyTargetList")
	@ResponseBody
	public Result conversionStrategyTargetList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = conversionStrategyService.retrieveConversionStrategyTargets(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetailList")
	@ResponseBody
	public Result originDeterminationDetailList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationDetailList(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	// 원산지 판정 상세 팝업(내수 전용)이 열릴 때/판정 실행 직후에 호출. (매출년월/플랜트/고객사/품번) 그룹
	// 기준으로 "지금 시점" sales_no/sales_seq를 다시 찾아 판정상태/상품상세와 함께 조회한다
	@RequestMapping(value = "/origin/compliance/origindetermination/retrieveDomesticOriginDeterminationDetailList")
	@ResponseBody
	public Result retrieveDomesticOriginDeterminationDetailList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveDomesticOriginDeterminationDetailList(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationDetailResultList")
	@ResponseBody
	public Result originDeterminationDetailResultList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationDetailResultList(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationFailList")
	@ResponseBody
	public Result originDeterminationFailList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationFailList(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	// BOM 추적 팝업 전용. param.fta_code로 그 협정 1건의 원재료(FCR_DTL)만 조회한다.
	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationMaterialList")
	@ResponseBody
	public Result originDeterminationMaterialList(@RequestBody Map param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationMaterialList(super.extendsMap(param));
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeDomesticOriginDetermination")
	@ResponseBody
	public Result executeDomesticOriginDetermination(
			@RequestBody DomesticOriginDeterminationExecuteRequestDto param) {
		try {
			param.setCompany_code((String) super.extendsMap(new HashMap<>()).get("company_code"));
			return originDeterminationService.executeDomesticOriginDetermination(param);
		} catch (Exception e) {
			logger.error("내수 원산지 판정 실행 실패", e);
			return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeExportOriginDetermination")
	@ResponseBody
	public Result executeExportOriginDetermination(
			@RequestBody ExportOriginDeterminationExecuteRequestDto param) {
		try {
			param.setCompany_code((String) super.extendsMap(new HashMap<>()).get("company_code"));
			return originDeterminationService.executeExportOriginDetermination(param);
		} catch (Exception e) {
			logger.error("수출 원산지 판정 실행 실패", e);
			return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
	}

	@RequestMapping(value = "/origin/compliance/origindetermination/executeMonthlyOriginDetermination")
	@ResponseBody
	public Result executeMonthlyOriginDetermination(
			@RequestBody MonthlyOriginDeterminationExecuteRequestDto param) {
		try {
			param.setCompany_code((String) super.extendsMap(new HashMap<>()).get("company_code"));
			return originDeterminationService.executeMonthlyOriginDetermination(param);
		} catch (Exception e) {
			logger.error("월판정 실행 실패", e);
			return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
	}
}
