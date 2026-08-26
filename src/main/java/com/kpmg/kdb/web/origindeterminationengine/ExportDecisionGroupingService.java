package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 벌크 판정 "1. 데이터 가공" 단계의 수출 버전. 수출은 대상 SALES_NO 가 이미 실제로 존재해 가상매출
 * 생성이 필요 없으므로, 고객사/사업부 그룹 발견 없이 회사+기간(+선택 필터) 조건만으로 대상을 직접
 * 뽑는다({@link ExportDecisionGroupingDao#selectPendingExportTargets} 참고).
 */
@Service
public class ExportDecisionGroupingService extends GeneralService {

	public List<ExportDecisionTarget> prepare(VirtualSalesGenerationParams filter) {
		ExportDecisionGroupingDao dao = sqlSession.getMapper(ExportDecisionGroupingDao.class);
		List<SalesTarget> targets = dao.selectPendingExportTargets(filter);

		List<ExportDecisionTarget> result = new ArrayList<>(targets.size());
		for (SalesTarget target : targets) {
			result.add(new ExportDecisionTarget(target.getCompanyCode(), target.getDivisionCode(),
					target.getSalesNo(), filter.getProductCodes()));
		}
		return result;
	}
}
