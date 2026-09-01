package com.kpmg.kdb.web.origindetermination;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.DomesticOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.ExportOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.MonthlyOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailMaterialResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationFailReasonResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;
import com.kpmg.kdb.web.origindeterminationengine.BulkDecisionResult;
import com.kpmg.kdb.web.origindeterminationengine.DomesticDecisionService;
import com.kpmg.kdb.web.origindeterminationengine.ExportDecisionService;
import com.kpmg.kdb.web.origindeterminationengine.ExportDecisionTarget;
import com.kpmg.kdb.web.origindeterminationengine.MonthlyDecisionService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

@Service
public class OriginDeterminationService extends GeneralService {

	@Autowired
	private DomesticDecisionService domesticDecisionService;

	@Autowired
	private ExportDecisionService exportDecisionService;

	@Autowired
	private MonthlyDecisionService monthlyDecisionService;

	public Result retrieveDomesticOriginDetermination(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDetermination(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	public Result retrieveExportOriginDetermination(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveExportOriginDetermination(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
	
	public Result retrieveOriginDeterminationResult(OriginDeterminationRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveOriginDeterminationResult(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveOriginDeterminationDetailList(OriginDeterminationDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationDetailResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveOriginDeterminationDetailList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	
	public Result retrieveOriginDeterminationDetailResultList(OriginDeterminationDetailResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			OriginDeterminationDao dao = sqlSession.getMapper(OriginDeterminationDao.class);
			List<OriginDeterminationDetailResultResponseDto> resultList = dao.retrieveOriginDeterminationDetailResultList(param);
			List<OriginDeterminationDetailResultDetailResponseDto> detailList = dao.retrieveOriginDeterminationDetailResultDetailList(param);

			Map<String, Object> value = new LinkedHashMap<>();
			value.put("resultList", resultList);
			value.put("detailList", detailList);

			result.setValue(value);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	// 판정실패(status=5) 건의 실패 사유(협정/룰별)와, 그 사유(FTA_CODE)별 상세내용(룰 전체 처리결과)/원재료
	// 목록(HS코드 누락·금액 0 사유일 때 화면에서 보여줌)을 한 번에 조회.
	// retrieveOriginDeterminationDetailResultList와 동일한 패턴 - 상세내용/원재료 목록은 fta_code마다
	// 별도 호출하지 않고 화면에서 매핑해 바로 보여준다.
	public Result retrieveOriginDeterminationFailList(OriginDeterminationDetailResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			OriginDeterminationDao dao = sqlSession.getMapper(OriginDeterminationDao.class);
			List<OriginDeterminationFailReasonResponseDto> reasonList = dao.retrieveOriginDeterminationFailReasonList(param);
			List<OriginDeterminationFailDetailResponseDto> detailList = dao.retrieveOriginDeterminationFailDetailList(param);
			List<OriginDeterminationFailMaterialResponseDto> materialList = dao.retrieveOriginDeterminationFailMaterialList(param);

			Map<String, Object> value = new LinkedHashMap<>();
			value.put("reasonList", reasonList);
			value.put("detailList", detailList);
			value.put("materialList", materialList);

			result.setValue(value);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/**
	 * 팝업(originDeterminationDetail_popup)에서 선택한 (매출년월/고객사/플랜트/품번) 라인들을 대상으로 내수
	 * 원산지 판정을 실행한다. 같은 상품코드를 쓰는 다른 고객사/플랜트 조합까지 함께 처리되지 않도록,
	 * (invoice_month, customer_code, division_code) 조합별로 그룹을 나누고 그룹별 product_code 목록으로
	 * 정확히 좁혀서 {@link DomesticDecisionService} 를 그룹 수만큼 호출한다.
	 */
	public Result executeDomesticOriginDetermination(DomesticOriginDeterminationExecuteRequestDto param) throws Exception {
		Result result = new Result();

		try {
			Map<String, VirtualSalesGenerationParams> groupsByKey = new LinkedHashMap<>();

			for (DomesticOriginDeterminationExecuteRequestDto.Line line : param.getDatas()) {
				String key = line.getInvoice_month() + "|" + line.getCustomer_code() + "|" + line.getDivision_code();

				VirtualSalesGenerationParams filter = groupsByKey.get(key);
				if (filter == null) {
					filter = new VirtualSalesGenerationParams();
					filter.setCompanyCode(param.getCompany_code());
					filter.setYyyymmdd(line.getInvoice_month());
					filter.setCustomerCode(line.getCustomer_code());
					filter.setDivisionCode(line.getDivision_code());
					filter.setProductCodes(new ArrayList<>());
					groupsByKey.put(key, filter);
				}

				if (!filter.getProductCodes().contains(line.getProduct_code())) {
					filter.getProductCodes().add(line.getProduct_code());
				}
			}

			int groupCount = 0;
			List<SalesTarget> targets = new ArrayList<>();
			List<SalesTarget> failedTargets = new ArrayList<>();

			for (VirtualSalesGenerationParams filter : groupsByKey.values()) {
				BulkDecisionResult groupResult = domesticDecisionService.run(filter);

				groupCount += groupResult.getGroupCount();
				targets.addAll(groupResult.getTargets());
				failedTargets.addAll(groupResult.getFailedTargets());
			}

			result.setValue(new BulkDecisionResult(groupCount, targets, failedTargets));
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/**
	 * 팝업(originDeterminationDetail_popup)에서 선택한 (SALES_NO, DIVISION_CODE) 라인들을 대상으로 수출
	 * 원산지 판정을 실행한다. 수출은 이미 존재하는 실제 SALES_NO를 그대로 판정 대상으로 삼아 내수처럼
	 * 매출년월/고객사/품번으로 그룹핑하거나 가상매출을 생성할 필요가 없어 {@link ExportDecisionService}에
	 * 대상 목록을 그대로 넘긴다.
	 */
	public Result executeExportOriginDetermination(ExportOriginDeterminationExecuteRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<ExportDecisionTarget> targets = new ArrayList<>();

			for (ExportOriginDeterminationExecuteRequestDto.Line line : param.getDatas()) {
				targets.add(new ExportDecisionTarget(param.getCompany_code(), line.getDivision_code(),
						line.getSales_no(), null));
			}

			BulkDecisionResult bulkResult = exportDecisionService.run(targets);

			result.setValue(bulkResult);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/**
	 * 검색 조건의 매출일자(from_date~to_date) 범위가 걸치는 매출년월마다 {@link MonthlyDecisionService}
	 * 를 호출해 월 판정을 진행한다. 
	 */
	public Result executeMonthlyOriginDetermination(MonthlyOriginDeterminationExecuteRequestDto param) throws Exception {
		Result result = new Result();

		try {
			int groupCount = 0;
			List<SalesTarget> targets = new ArrayList<>();
			List<SalesTarget> failedTargets = new ArrayList<>();

			for (String yyyymm : resolveYyyymmRange(param.getFrom_date(), param.getTo_date())) {
				VirtualSalesGenerationParams filter = new VirtualSalesGenerationParams();
				filter.setCompanyCode(param.getCompany_code());
				filter.setYyyymmdd(yyyymm);

				BulkDecisionResult monthResult = monthlyDecisionService.run(filter);

				groupCount += monthResult.getGroupCount();
				targets.addAll(monthResult.getTargets());
				failedTargets.addAll(monthResult.getFailedTargets());
			}

			result.setValue(new BulkDecisionResult(groupCount, targets, failedTargets));
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/** fromDate~toDate(YYYYMMDD)가 걸치는 매출년월(YYYYMM) 목록을 오름차순으로 만든다. */
	private List<String> resolveYyyymmRange(String fromDate, String toDate) {
		LocalDate from = LocalDate.parse(fromDate, DateTimeFormatter.BASIC_ISO_DATE);
		LocalDate to = LocalDate.parse(toDate, DateTimeFormatter.BASIC_ISO_DATE);

		List<String> yyyymmList = new ArrayList<>();
		YearMonth cursor = YearMonth.from(from);
		YearMonth last = YearMonth.from(to);
		while (!cursor.isAfter(last)) {
			yyyymmList.add(cursor.format(DateTimeFormatter.ofPattern("yyyyMM")));
			cursor = cursor.plusMonths(1);
		}
		return yyyymmList;
	}
}
