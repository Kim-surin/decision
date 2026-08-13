package com.kpmg.kdb.web.originbasis;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.IncotermsRateRow;
import com.kpmg.kdb.web.originbasis.dto.IncotermsRateRow.IncotermsCode;

/**
 * 레거시 GET_INCOTERMS_CHANGE_RATE(stdYyyy, companyCode, divisionCode, exportFlag,
 * nationCode, fromIncotermsCode, toIncotermsCode) 이관.
 *
 * 원본: 1 - ((FROM_INCOTERMS_RATE - TO_INCOTERMS_RATE) / 100), 값이 없으면 1 반환.
 */
@Service
public class IncotermsRateService extends GeneralService {

	private static final BigDecimal ONE_HUNDRED = BigDecimal.valueOf(100);

	@Autowired
	private IncotermsReferenceDataService referenceDataService;

	public BigDecimal calculateChangeRate(IncotermsChangeRateCriteria criteria) {
		try {
			IncotermsRateRow row = referenceDataService.selectIncotermsInfo(criteria);
			if (row == null) {
				return BigDecimal.ONE;
			}

			IncotermsCode fromCode = IncotermsCode.fromCode(criteria.getFromIncotermsCode());
			IncotermsCode toCode = IncotermsCode.fromCode(criteria.getToIncotermsCode());

			BigDecimal fromRate = fromCode == null ? null : fromCode.extractRate(row);
			BigDecimal toRate = toCode == null ? null : toCode.extractRate(row);

			if (fromRate == null || toRate == null) {
				return BigDecimal.ONE;
			}

			return BigDecimal.ONE.subtract(fromRate.subtract(toRate).divide(ONE_HUNDRED, 10, java.math.RoundingMode.HALF_UP));
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN 1; 과 동일
			logger.error("인코텀즈 환산율 조회 실패. criteria={}", criteria, e);
			return BigDecimal.ONE;
		}
	}
}
