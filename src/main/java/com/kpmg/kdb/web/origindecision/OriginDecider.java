package com.kpmg.kdb.web.origindecision;

import java.util.List;

import com.kpmg.kdb.web.coodecision.OriginDeterminationMode;

/**
 * {@link OriginDecisionPipeline} "PKG99_COO_DECISION.COO_DECISION" 단계의 부품 인터페이스.
 * 기본 구현은 {@code OriginDeterminationService} 참고.
 */
public interface OriginDecider {

	void determineOrigin(String companyCode, String salesNo, OriginDeterminationMode mode, List<String> productCodes);
}
