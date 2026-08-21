package com.kpmg.kdb.web.origindeterminationengine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.MonthlyDecisionDao;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 월판정(MONTHLY_DECISION_PROC 이관 확장) "1. 데이터 가공" 단계의 수출 버전. 레거시 판정대상 커서
 * (C_SALES_MST)는 EXPORT_FLAG='D'(가상매출 집계 후 판정)와 EXPORT_FLAG='E'(이미 TARGET_FTA_CODE 가
 * 세팅된 실제 매출 판정)를 한 커서에서 함께 순회했다. {@link DomesticDecisionGroupingService} 는
 * 고객사/사업부 그룹마다 가상매출을 새로 만들어야 하는 내수 전용 흐름이라 이 조회를 재사용할 수 없다 —
 * 수출은 가상매출 생성 자체가 필요 없어(대상 SALES_NO 가 이미 실제로 존재) 고객사/사업부 그룹 발견과
 * 무관하게 회사+기간(+선택 필터) 조건만으로 대상을 직접 뽑는다({@link MonthlyDecisionDao#selectPendingExportTargets}
 * 참고).
 */
@Service
public class ExportDecisionGroupingService extends GeneralService {

	public List<ExportDecisionTarget> prepare(VirtualSalesGenerationParams filter) {
		MonthlyDecisionDao dao = sqlSession.getMapper(MonthlyDecisionDao.class);
		List<SalesTarget> targets = dao.selectPendingExportTargets(filter);

		List<ExportDecisionTarget> result = new ArrayList<>(targets.size());
		for (SalesTarget target : targets) {
			result.add(new ExportDecisionTarget(target.getCompanyCode(), target.getDivisionCode(),
					target.getSalesNo(), filter.getProductCodes()));
		}
		return result;
	}
}
