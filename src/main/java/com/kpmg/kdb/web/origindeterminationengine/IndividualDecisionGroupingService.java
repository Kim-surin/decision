package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 개별판정 배치 처리 "1. 데이터 가공" 단계. 원본 (SALES_NO, PRODUCT_CODE) 입력 목록을 CUSTOMER_CODE+
 * DIVISION_CODE+YYYYMM+COMPANY_CODE 로 그룹핑하고, 그룹 내 PRODUCT_CODE 중복은 먼저 들어온 SALES_NO
 * 를 대표로 남기고 제거한다(같은 상품 판정은 1번만 수행). 그룹핑 키는 {@link IndividualVirtualSalesGenerator}
 * 가 가상 SALES_NO 채번에 쓰는 것과 동일한 {@link VirtualSalesNoGenerator} 를 재사용해 두 곳이
 * 어긋나지 않게 한다.
 *
 * <p>DB 조회 없이 순수 인메모리로 처리하는 단계라 {@link OriginDecisionPipeline#generateVirtualSales}
 * 호출 이전에 미리 실행해둔다.
 */
@Service
public class IndividualDecisionGroupingService {

	@Autowired
	private VirtualSalesNoGenerator salesNoGenerator;

	private record GroupKey(String companyCode, String virtualSalesNo) {
	}

	public List<VirtualSalesGenerationParams> prepare(List<IndividualDecisionRawLine> rawLines) {
		Map<GroupKey, VirtualSalesGenerationParams> paramsByGroup = new LinkedHashMap<>();
		Map<GroupKey, String> representativeSalesNoByGroup = new LinkedHashMap<>();
		Map<GroupKey, LinkedHashMap<String, String>> productFirstSalesNoByGroup = new LinkedHashMap<>();

		for (IndividualDecisionRawLine line : rawLines) {
			VirtualSalesGenerationParams lineParams = new VirtualSalesGenerationParams();
			lineParams.setCompanyCode(line.getCompanyCode());
			lineParams.setDivisionCode(line.getDivisionCode());
			lineParams.setCustomerCode(line.getCustomerCode());
			lineParams.setYyyymmdd(toYyyymm(line.getInvoiceDate()));

			GroupKey key = new GroupKey(line.getCompanyCode(), salesNoGenerator.generate(lineParams));
			paramsByGroup.putIfAbsent(key, lineParams);
			representativeSalesNoByGroup.putIfAbsent(key, line.getSalesNo());
			productFirstSalesNoByGroup.computeIfAbsent(key, k -> new LinkedHashMap<>())
					.putIfAbsent(line.getProductCode(), line.getSalesNo());
		}

		List<VirtualSalesGenerationParams> groups = new ArrayList<>();
		for (Map.Entry<GroupKey, LinkedHashMap<String, String>> entry : productFirstSalesNoByGroup.entrySet()) {
			GroupKey key = entry.getKey();

			VirtualSalesGenerationParams params = paramsByGroup.get(key);
			params.setSourceSalesNo(representativeSalesNoByGroup.get(key));
			params.setProductCodes(new ArrayList<>(entry.getValue().keySet()));
			groups.add(params);
		}
		return groups;
	}

	private String toYyyymm(String invoiceDate) {
		return invoiceDate == null || invoiceDate.length() < 6 ? invoiceDate : invoiceDate.substring(0, 6);
	}
}
