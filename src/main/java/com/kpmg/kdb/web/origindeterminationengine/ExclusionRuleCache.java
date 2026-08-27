package com.kpmg.kdb.web.origindeterminationengine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kpmg.kdb.web.origindeterminationengine.dto.ExclusionRuleDetail;
import com.kpmg.kdb.web.origindeterminationengine.dto.ExclusionRuleHeader;

/** determineOrigin() 1회 호출 범위에서 유효한 예외판정 규칙(FTA_EXCLUSION_RULE 헤더/상세) 조회 캐시. */
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
