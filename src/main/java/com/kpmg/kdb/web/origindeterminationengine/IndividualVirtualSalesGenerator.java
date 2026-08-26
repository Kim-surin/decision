package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * {@link VirtualSalesGenerator} 개별 판정용 구현. 월 판정({@link AggregatedVirtualSalesGenerator})과
 * 달리 회사/기간 범위를 통째로 집계하지 않고, 이미 알고 있는 실제 매출건 1건({@code sourceSalesNo})의
 * 헤더를 복사하고 요청받은 제품(productCodes)만큼 가상 SALES_DTL 을 만든다. 그 결과 판정 대상은 언제나
 * 정확히 1건(방금 만든 가상 SALES_NO)이다.
 *
 * <p>"1. 가상 매출 번호 채번"은 {@link VirtualSalesNoGenerator} 에 위임한다(원본처럼 DB 조회는 필요
 * 없지만, 채번 규칙 자체가 나중에 바뀔 수 있어 부품으로 분리했다).
 */
@Service
public class IndividualVirtualSalesGenerator extends GeneralService implements VirtualSalesGenerator {

	@Autowired
	private VirtualSalesNoGenerator salesNoGenerator;

	@Override
	public List<SalesTarget> generate(VirtualSalesGenerationParams params) {
		if (params.getProductCodes() == null || params.getProductCodes().isEmpty()) {
			throw new IllegalArgumentException("개별 판정은 productCodes 가 1개 이상 필요합니다.");
		}

		// 1. 가상 매출 번호 채번
		String virtualSalesNo = salesNoGenerator.generate(params);

		IndividualVirtualSalesDao dao = sqlSession.getMapper(IndividualVirtualSalesDao.class);

		// 2. SALES_MST 가상 매출 생성
		dao.mergeIndividualSalesMst(virtualSalesNo, params);

		// 3. SALES_DTL 가상 매출 생성 (요청받은 PRODUCT_CODE 전체를 1회 배치 MERGE 로 처리)
		dao.mergeIndividualSalesDtl(virtualSalesNo, params, params.getProductCodes());

		SalesTarget target = new SalesTarget();
		target.setCompanyCode(params.getCompanyCode());
		target.setDivisionCode(params.getDivisionCode());
		target.setSalesNo(virtualSalesNo);
		return List.of(target);
	}
}
