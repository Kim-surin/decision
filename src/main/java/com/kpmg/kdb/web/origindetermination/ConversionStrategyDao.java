package com.kpmg.kdb.web.origindetermination;

import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindetermination.dto.ConversionStrategyRuleContextDto;
import com.kpmg.kdb.web.origindetermination.dto.OriginDeterminationDetailResultRequestDto;

/**
 * 역내전환전략 팝업 전용 DAO.
 *
 * selectCthCertifyTargetList/selectValueContentCertifyCandidateList는 Java에서 필드를 개별로 읽지 않고
 * 그대로 프론트로 내려주므로 매퍼 XML의 resultType="HashMap" 그대로 List&lt;Map&lt;String, Object&gt;&gt;로
 * 선언한다(실제 만들어지는 객체가 HashMap이라 사실대로 선언한 것 - DTO로 선언해도 리스트 반환은 제네릭
 * 타입 소거 때문에 당장 캐스팅 오류는 안 나지만, 원소를 꺼내 그 DTO 타입으로 쓰려는 순간 ClassCastException이
 * 난다).
 *
 * selectConversionStrategyRuleContext는 RVC 컷오프 재계산을 위해 Service가 필드값을 직접 읽어야 해서,
 * 매퍼 XML의 resultType 자체를 실제 DTO 클래스로 지정해 MyBatis가 진짜 그 클래스의 인스턴스를 만들게
 * 했다. 그래서 이 메서드만 getter로 안전하게 읽을 수 있는 진짜 DTO를 반환한다.
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
