package com.kpmg.kdb.web.origindecision;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;
import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesGenerator} 개별 판정용 구현. 월 판정({@link AggregatedVirtualSalesGenerator})과
 * 달리 회사/기간 범위를 통째로 집계하지 않고, 이미 알고 있는 실제 매출건 1건({@code sourceSalesNo})의
 * 헤더를 복사하고 요청받은 제품(productCodes)만큼 가상 SALES_DTL 을 만든다. 그 결과 판정 대상은 언제나
 * 정확히 1건(방금 만든 가상 SALES_NO)이다.
 *
 * <p>"1. 가상 매출 번호 채번"은 원본처럼 DB 조회가 필요 없다 — CUSTOMER_CODE+DIVISION_CODE+YYYYMM
 * 단순 문자열 조합이라 이 자리에서 바로 계산한다.
 */
@Service
public class IndividualVirtualSalesGenerator extends GeneralService implements VirtualSalesGenerator {

	@Override
	public List<SalesTarget> generate(VirtualSalesGenerationParams params) {
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			throw new IllegalArgumentException("개별 판정은 productCodes 가 1개 이상 필요합니다.");
		}

		// 1. 가상 매출 번호 채번
		String virtualSalesNo = params.getCustomerCode() + params.getDivisionCode() + params.getYyyymm();

		IndividualVirtualSalesDao dao = sqlSession.getMapper(IndividualVirtualSalesDao.class);

		// 2. SALES_MST 가상 매출 생성
		dao.mergeIndividualSalesMst(virtualSalesNo, params);

		// 3. SALES_DTL 가상 매출 생성 (PRODUCT_CODE 만큼 반복)
		for (String productCode : params.getProductCodes()) {
			dao.mergeIndividualSalesDtl(virtualSalesNo, params, productCode);
		}

		SalesTarget target = new SalesTarget();
		target.setCompanyCode(params.getCompanyCode());
		target.setDivisionCode(params.getDivisionCode());
		target.setSalesNo(virtualSalesNo);
		return List.of(target);
	}
}
