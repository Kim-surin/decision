package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.web.origindeterminationexecution.dto.VirtualSalesGenerationParams;

/**
 * 개별판정 배치 처리 "1. 데이터 가공" 단계. 원본 (SALES_NO, PRODUCT_CODE) 입력 목록을
 * CUSTOMER_CODE+DIVISION_CODE+YYYYMM(INVOICE_DATE 앞 6자리)+COMPANY_CODE 로 그룹핑하고, 그룹 내
 * PRODUCT_CODE 중복은 먼저 들어온 SALES_NO 를 대표로 남기고 제거한다(같은 상품이 여러 SALES_NO 로
 * 중복 입력돼도 판정은 상품 단위로 1번만 수행). 그룹의 헤더 복사용 sourceSalesNo 는 그 그룹에서 가장
 * 먼저 나온 원본 행의 SALES_NO 를 그대로 쓴다(같은 그룹이면 CUSTOMER_CODE/DIVISION_CODE/COMPANY_CODE
 * 가 동일해 어떤 실제 SALES_NO 를 대표로 골라도 SALES_MST 헤더 값은 같다).
 *
 * <p>CUSTOMER_CODE+DIVISION_CODE+YYYYMM 조합 자체는 {@link IndividualVirtualSalesGenerator} 가
 * "1. 가상 매출 번호 채번" 단계에서 실제 가상 SALES_NO 로 다시 만드는 값과 동일하므로, 그룹핑 키도
 * 별도로 조합하지 않고 그 채번 로직({@link VirtualSalesNoGenerator})을 그대로 재사용한다 — 채번 규칙이
 * 바뀌어도 두 곳이 따로 어긋날 일이 없다.
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
