package com.kpmg.kdb.web.origindetermination;

import java.util.List;

import com.kpmg.kdb.web.origindetermination.OriginDeterminationMode;

/**
 * {@link OriginDecisionPipeline} "PKG99_COO_DECISION.COO_DECISION" 단계의 부품 인터페이스. 제품(P,H)
 * 판정뿐 아니라 상품(M,R,B) 판정도 이 안에서 함께 처리한다. 기본 구현은 {@code OriginDeterminationExecutionService}
 * 참고.
 */
public interface OriginDecider {

	void determineOrigin(String companyCode, String divisionCode, String salesNo, OriginDeterminationMode mode,
			List<String> productCodes);
}
