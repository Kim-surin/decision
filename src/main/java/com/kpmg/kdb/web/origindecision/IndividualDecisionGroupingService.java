package com.kpmg.kdb.web.origindecision;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 개별판정 배치 처리 "1. 데이터 가공" 단계. 원본 (SALES_NO, PRODUCT_CODE) 입력 목록을
 * CUSTOMER_CODE+DIVISION_CODE+YYYYMM(INVOICE_DATE 앞 6자리)+COMPANY_CODE 로 그룹핑하고, 그룹 내
 * PRODUCT_CODE 중복은 먼저 들어온 SALES_NO 를 대표로 남기고 제거한다(같은 상품이 여러 SALES_NO 로
 * 중복 입력돼도 판정은 상품 단위로 1번만 수행). 그룹의 헤더 복사용 sourceSalesNo 는 그 그룹에서 가장
 * 먼저 나온 원본 행의 SALES_NO 를 그대로 쓴다(같은 그룹이면 CUSTOMER_CODE/DIVISION_CODE/COMPANY_CODE
 * 가 동일해 어떤 실제 SALES_NO 를 대표로 골라도 SALES_MST 헤더 값은 같다).
 *
 * <p>DB 조회 없이 순수 인메모리로 처리하는 단계라 {@link OriginDecisionPipeline#generateVirtualSales}
 * 호출 이전에 미리 실행해둔다.
 */
@Service
public class IndividualDecisionGroupingService {

	private record GroupKey(String companyCode, String divisionCode, String customerCode, String yyyymm) {
	}

	public List<VirtualSalesGenerationParams> prepare(List<IndividualDecisionRawLine> rawLines) {
		Map<GroupKey, String> representativeSalesNoByGroup = new LinkedHashMap<>();
		Map<GroupKey, LinkedHashMap<String, String>> productFirstSalesNoByGroup = new LinkedHashMap<>();

		for (IndividualDecisionRawLine line : rawLines) {
			GroupKey key = new GroupKey(line.getCompanyCode(), line.getDivisionCode(), line.getCustomerCode(),
					toYyyymm(line.getInvoiceDate()));
			representativeSalesNoByGroup.putIfAbsent(key, line.getSalesNo());
			productFirstSalesNoByGroup.computeIfAbsent(key, k -> new LinkedHashMap<>())
					.putIfAbsent(line.getProductCode(), line.getSalesNo());
		}

		List<VirtualSalesGenerationParams> groups = new ArrayList<>();
		for (Map.Entry<GroupKey, LinkedHashMap<String, String>> entry : productFirstSalesNoByGroup.entrySet()) {
			GroupKey key = entry.getKey();

			VirtualSalesGenerationParams params = new VirtualSalesGenerationParams();
			params.setCompanyCode(key.companyCode());
			params.setDivisionCode(key.divisionCode());
			params.setCustomerCode(key.customerCode());
			params.setYyyymmdd(key.yyyymm());
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
