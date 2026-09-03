package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;

/**
 * 역내전환전략 팝업 전용 DAO. RVC 컷오프 계산을 위해 Service에서 필드값을 직접 읽어야 해서,
 * (resultType="HashMap"이 실제로 그대로 반환되는) 이 코드베이스의 통상적인 "List<응답DTO> 선언" 관례
 * 대신 List&lt;Map&lt;String, Object&gt;&gt;로 선언한다 - 단건 조회를 구체 DTO 타입으로 선언하면 프록시가
 * HashMap을 그 타입으로 캐스팅하려다 ClassCastException이 발생하기 때문이다.
 */
public interface ConversionStrategyDao {

	// 이 협정 판정 시 시도된 FTA_RULE 전체(0건 이상, 룰별 1행씩): cth_rule, bu_rule/bd_rule/nc_rule/mc_rule,
	// inkoterms_amount, net_cost_amount, inarea_amount, outarea_amount. 세번변경/부가가치기준이 서로
	// 다른 룰(대안)로 존재할 수 있어 "채택된 룰 1건"이 아니라 시도된 룰 전체를 반환한다.
	public List<Map<String, Object>> selectConversionStrategyRuleContext(OriginDeterminationDetailResultRequestDto param);

	// 세번변경기준 충족을 위해 원산지확인서 수취가 필요한 대상(제품과 동일한 호이면서 역외인 원재료)
	public List<Map<String, Object>> selectCthCertifyTargetList(OriginDeterminationDetailResultRequestDto param);

	// 부가가치기준 충족 후보(역외 원재료를 재료비 비중 높은 순 정렬) - 실제 필요 건수는 Service에서 계산
	public List<Map<String, Object>> selectValueContentCertifyCandidateList(OriginDeterminationDetailResultRequestDto param);
}
