package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

/**
 * "SALES_DTL STATUS 업데이트" 단계. SALES_MST/SALES_DTL/FCR_MST 를 판정완료로 갱신한다.
 * 내수(가상 SALES_NO)/수출(실제 SALES_NO) 구분 없이 동일하게 동작한다(SALES_MST 갱신이 VIRTUAL_YN
 * 값으로 그 둘을 구분해 처리한다). {@link OriginDecisionPipeline} 이 사용한다.
 */
@Service
public class SalesDecisionStatusUpdater extends GeneralService {

	public void updateStatus(String companyCode, String salesNo, List<String> productCodes) {
		SalesDecisionStatusDao dao = sqlSession.getMapper(SalesDecisionStatusDao.class);

		dao.updateSalesMstDecisionComplete(companyCode, salesNo, productCodes);
		dao.updateSalesDtlDecisionComplete(companyCode, salesNo, productCodes);
		dao.updateFcrMstDecisionComplete(companyCode, salesNo, productCodes);
	}

	/** 판정 파이프라인 단계 중 예외가 발생한 대상을 SALES_MST/SALES_DTL 판정실패('5')로 표시한다. */
	public void markDecisionFailed(String companyCode, String salesNo, List<String> productCodes) {
		SalesDecisionStatusDao dao = sqlSession.getMapper(SalesDecisionStatusDao.class);

		dao.markSalesMstDecisionFailed(companyCode, salesNo);
		dao.markSalesDtlDecisionFailed(companyCode, salesNo, productCodes);
	}
}
