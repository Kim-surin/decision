package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

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

	/**
	 * "BOM 추적" 아이콘 클릭 시 뜨는 팝업. 그 협정(FTA_CODE) 판정 계산에 실제로 쓰인 최종 원재료(FCR_DTL)를
	 * 조회해 보여준다.
	 */
	@RequestMapping(value = "/origin/compliance/origindetermination/bomTraceList_popup")
	public String bomTraceList_popup(@RequestParam(value = "sales_no", required = false) String salesNo,
			@RequestParam(value = "sales_seq", required = false) String salesSeq,
			@RequestParam(value = "fta_code", required = false) String ftaCode, Model model, HttpSession session) {
		model.addAttribute("sales_no", salesNo);
		model.addAttribute("sales_seq", salesSeq);
		model.addAttribute("fta_code", ftaCode);

		return "origindetermination/bomTraceList_popup";
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

	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationFailList")
	@ResponseBody
	public Result originDeterminationFailList(@RequestBody OriginDeterminationDetailResultRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationFailList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	// BOM 추적 팝업 전용. param.fta_code로 그 협정 1건의 원재료(FCR_DTL)만 조회한다.
	@RequestMapping(value = "/origin/compliance/origindetermination/originDeterminationMaterialList")
	@ResponseBody
	public Result originDeterminationMaterialList(@RequestBody OriginDeterminationDetailResultRequestDto param)
			throws Exception {
		Result result;

		try {
			result = originDeterminationService.retrieveOriginDeterminationMaterialList(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/**
	 * 판정 실행 자체는 오래 걸릴 수 있어 {@link Callable}을 반환해 Spring MVC 비동기 요청 처리로 넘긴다.
	 * Tomcat 워커 스레드는 즉시 반납되고, 실제 판정은 {@code WebConfig}에 설정된 스레드풀에서 실행된 뒤
	 * 완료 시점에 지금과 동일한 {@link Result} 응답이 내려간다 — 응답 계약/화면 코드는 변경 없음.
	 */
	@RequestMapping(value = "/origin/compliance/origindetermination/executeDomesticOriginDetermination")
	@ResponseBody
	public Callable<Result> executeDomesticOriginDetermination(
			@RequestBody DomesticOriginDeterminationExecuteRequestDto param) {
		return () -> {
			try {
				return originDeterminationService.executeDomesticOriginDetermination(param);
			} catch (Exception e) {
				logger.error("내수 원산지 판정 실행 실패", e);
				return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
			}
		};
	}

	/** {@link #executeDomesticOriginDetermination} 과 동일한 이유로 {@link Callable}을 반환한다. */
	@RequestMapping(value = "/origin/compliance/origindetermination/executeExportOriginDetermination")
	@ResponseBody
	public Callable<Result> executeExportOriginDetermination(
			@RequestBody ExportOriginDeterminationExecuteRequestDto param) {
		return () -> {
			try {
				return originDeterminationService.executeExportOriginDetermination(param);
			} catch (Exception e) {
				logger.error("수출 원산지 판정 실행 실패", e);
				return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
			}
		};
	}

	/** {@link #executeDomesticOriginDetermination} 과 동일한 이유로 {@link Callable}을 반환한다. */
	@RequestMapping(value = "/origin/compliance/origindetermination/executeMonthlyOriginDetermination")
	@ResponseBody
	public Callable<Result> executeMonthlyOriginDetermination(
			@RequestBody MonthlyOriginDeterminationExecuteRequestDto param) {
		return () -> {
			try {
				return originDeterminationService.executeMonthlyOriginDetermination(param);
			} catch (Exception e) {
				logger.error("월판정 실행 실패", e);
				return super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
			}
		};
	}
}
