package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.ConversionStrategyRuleContextDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;

/**
 * 역내전환전략 팝업 전용 DAO.
 */
public interface ConversionStrategyDao {

	// 이 협정 판정 시 시도된 FTA_RULE 전체(0건 이상, 룰별 1행씩): cth_rule, bu_rule/bd_rule/nc_rule/mc_rule,
	// inkoterms_amount, net_cost_amount, inarea_amount, outarea_amount. 세번변경/부가가치기준이 서로
	// 다른 룰(대안)로 존재할 수 있어 "채택된 룰 1건"이 아니라 시도된 룰 전체를 반환한다.
	public List<ConversionStrategyRuleContextDto> selectConversionStrategyRuleContext(OriginDeterminationDetailResultRequestDto param);

	// 세번변경기준 충족을 위해 원산지확인서 수취가 필요한 대상(제품과 동일한 호이면서 역외인 원재료)
	public List<Map<String, Object>> selectCthCertifyTargetList(OriginDeterminationDetailResultRequestDto param);

	// 부가가치기준 충족 후보(역외 원재료를 재료비 비중 높은 순 정렬) - 실제 필요 건수는 Service에서 계산
	public List<Map<String, Object>> selectValueContentCertifyCandidateList(OriginDeterminationDetailResultRequestDto param);
}
