package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.List;

/**
 * {@link OriginDecisionPipeline} "CREATE_FCR" 단계의 부품 인터페이스.
 * 기본 구현은 {@code CreateFcrService} 참고.
 */
public interface FcrCreator {

	String createFcr(String companyCode, String divisionCode, String salesNo, String bomType,
			List<String> productCodes);
}
