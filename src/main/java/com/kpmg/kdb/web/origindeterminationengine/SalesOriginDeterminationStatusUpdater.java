package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

// "SALES_DTL STATUS 업데이트" 단계. SALES_MST/SALES_DTL/FCR_MST를 판정완료로 갱신하며, 내수(가상 SALES_NO)/
// 수출(실제 SALES_NO) 구분 없이 동일하게 동작한다(SALES_MST 갱신이 VIRTUAL_YN 값으로 구분). OriginDeterminationPipeline이 사용한다.
@Service
public class SalesOriginDeterminationStatusUpdater extends GeneralService {

	public void updateStatus(String companyCode, String divisionCode, String salesNo, List<String> productCodes,
			String updateBy) {
		SalesOriginDeterminationStatusDao dao = sqlSession.getMapper(SalesOriginDeterminationStatusDao.class);

		dao.updateSalesMstDecisionComplete(companyCode, salesNo, divisionCode, productCodes);
		dao.updateSalesDtlDecisionComplete(companyCode, salesNo, divisionCode, productCodes, updateBy);
		dao.updateFcrMstDecisionComplete(companyCode, salesNo, divisionCode, productCodes);
	}

	/** 판정 파이프라인 단계 중 예외가 발생한 대상을 SALES_MST/SALES_DTL 판정실패('5')로 표시한다. */
	public void markDecisionFailed(String companyCode, String divisionCode, String salesNo, List<String> productCodes,
			String updateBy) {
		SalesOriginDeterminationStatusDao dao = sqlSession.getMapper(SalesOriginDeterminationStatusDao.class);

		dao.markSalesMstDecisionFailed(companyCode, salesNo, divisionCode);
		dao.markSalesDtlDecisionFailed(companyCode, salesNo, divisionCode, productCodes, updateBy);
	}
}
