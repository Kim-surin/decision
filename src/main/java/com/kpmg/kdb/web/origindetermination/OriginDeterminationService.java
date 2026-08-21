package com.kpmg.kdb.web.origindetermination;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindetermination.dto.DomesticOriginDeterminationExecuteRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultDetailResponseDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultRequestDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationResultResponseDto;
import com.kpmg.kdb.web.origindeterminationengine.BulkDecisionResult;
import com.kpmg.kdb.web.origindeterminationengine.DomesticBulkDecisionService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

@Service
public class OriginDeterminationService extends GeneralService {

	@Autowired
	private DomesticBulkDecisionService domesticBulkDecisionService;
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

	public Result retrieveDomesticOriginDeterminationDetailList(OriginDeterminationDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationDetailResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationDetailList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveDomesticOriginDeterminationResultList(OriginDeterminationResultRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResultResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationResultList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	public Result retrieveDomesticOriginDeterminationResultDetailList(OriginDeterminationResultDetailRequestDto param) throws Exception {
		Result result = new Result();

		try {
			List<OriginDeterminationResultDetailResponseDto> list = sqlSession.getMapper(OriginDeterminationDao.class).retrieveDomesticOriginDeterminationResultDetailList(param);

			result.setValue(list);
			result.setSuccess(true);
			result.setMessage(DEFAULT_MESSAGE_OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	/**
	 * 팝업(domesticOriginDetermination_popup)에서 선택한 (매출년월/고객사/플랜트/품번) 라인들을 대상으로 내수
	 * 원산지 판정을 실행한다. 같은 상품코드를 쓰는 다른 고객사/플랜트 조합까지 함께 처리되지 않도록,
	 * (invoice_month, customer_code, division_code) 조합별로 그룹을 나누고 그룹별 product_code 목록으로
	 * 정확히 좁혀서 {@link DomesticBulkDecisionService} 를 그룹 수만큼 호출한다.
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
				BulkDecisionResult groupResult = domesticBulkDecisionService.run(filter);

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
}
