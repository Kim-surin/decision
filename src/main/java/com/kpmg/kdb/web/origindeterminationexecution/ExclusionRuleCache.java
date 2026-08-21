package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindeterminationexecution.dto.ExclusionRuleDetail;
import com.kpmg.kdb.web.origindeterminationexecution.dto.ExclusionRuleHeader;

/**
 * {@link OriginDeterminationExecutionService#determineOrigin} 1회 호출 범위에서 유효한 예외판정 규칙
 * (FTA_EXCLUSION_RULE 헤더/상세) 조회 결과 캐시. FM_LIST(제품) 여러 건이 같은 (ftaCode, hsCode,
 * hsCodeSubCategory, ruleSeq[, exclusionType]) 조합을 공유하는 경우가 흔해(동일 HS코드를 쓰는 제품이
 * 여러 개인 매출) 조회 자체를 최소화한다.
 *
 * <p>FM_LIST 1건마다 새로 생성되는 {@link OriginDeterminationContext} 와 달리, 이 캐시는
 * determineOrigin() 최상위에서 한 번만 만들어 전체 FM_LIST 루프에 공유해야 한다.
 */
class ExclusionRuleCache {

	private final ExclusionRuleDao dao;
	private final Map<String, List<ExclusionRuleHeader>> headerCache = new HashMap<>();
	private final Map<String, List<ExclusionRuleDetail>> detailCache = new HashMap<>();

	ExclusionRuleCache(ExclusionRuleDao dao) {
		this.dao = dao;
	}

	List<ExclusionRuleHeader> headers(String ftaCode, String hsCode, String hsCodeSubCategory, String ruleSeq) {
		String key = String.join("|", nz(ftaCode), nz(hsCode), nz(hsCodeSubCategory), nz(ruleSeq));
		return headerCache.computeIfAbsent(key,
				k -> dao.selectExclusionRuleHeaders(ftaCode, hsCode, hsCodeSubCategory, ruleSeq));
	}

	List<ExclusionRuleDetail> details(String ftaCode, String hsCode, String hsCodeSubCategory, String ruleSeq,
			String exclusionType) {
		String key = String.join("|", nz(ftaCode), nz(hsCode), nz(hsCodeSubCategory), nz(ruleSeq), nz(exclusionType));
		return detailCache.computeIfAbsent(key,
				k -> dao.selectExclusionRuleDetails(ftaCode, hsCode, hsCodeSubCategory, ruleSeq, exclusionType));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}
}
