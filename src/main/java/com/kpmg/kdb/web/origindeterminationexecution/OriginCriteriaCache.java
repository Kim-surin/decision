package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginCriteria;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginCriteriaBatchRequest;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginCriteriaBatchResult;
import com.kpmg.kdb.web.origindeterminationexecution.dto.OriginDeterminationTarget;

/**
 * {@link OriginDeterminationExecutionService#determineOrigin} 1회 호출 범위에서만 유효한 FTA_RULE 조회
 * 사전조회 결과. 전역 캐시(@Cacheable)가 아니라, FM_LIST 행 전체(제품 × FTA_CODE 후보)에 필요한
 * (hsCode,ftaCode,hsCodeSubCategory) 조합을 이 호출 시작 시점에 한 번의 배치 쿼리로 모두 가져온 뒤
 * 호출이 끝나면 버려지는 일회성 프리페치다 — FTA_RULE 데이터량이 커서 오래 유지되는 캐시에 담기엔
 * 부적합하다는 판단에 따른 절충이다.
 */
class OriginCriteriaCache {

	private final OriginDeterminationCursorDao dao;
	private final Map<String, List<OriginCriteria>> byKey;

	private OriginCriteriaCache(OriginDeterminationCursorDao dao, Map<String, List<OriginCriteria>> byKey) {
		this.dao = dao;
		this.byKey = byKey;
	}

	static OriginCriteriaCache prefetch(OriginDeterminationCursorDao dao, List<OriginDeterminationTarget> fmListRows,
			String newAptaPsrFlag) {
		List<OriginCriteriaBatchRequest> requests = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (OriginDeterminationTarget fm : fmListRows) {
			String key = key(fm.getHsCode(), fm.getFtaCode(), fm.getHsCodeSubCategory());
			if (seenKeys.add(key)) {
				requests.add(new OriginCriteriaBatchRequest(fm.getHsCode(), fm.getFtaCode(), fm.getHsCodeSubCategory(),
						newAptaPsrFlag));
			}
		}

		Map<String, List<OriginCriteria>> byKey = new HashMap<>();
		if (!requests.isEmpty()) {
			List<OriginCriteriaBatchResult> results = dao.selectApplicableOriginCriteriaBatch(requests);
			for (OriginCriteriaBatchResult r : results) {
				byKey.computeIfAbsent(key(r.getReqHsCode(), r.getReqFtaCode(), r.getReqHsCodeSubCategory()),
						k -> new ArrayList<>()).add(r.toCriteria());
			}
			// 요청했지만 매칭되는 룰이 0건인 조합도 "조회 완료, 결과 없음"으로 명시해둬야 get() 이
			// 불필요한 단건 폴백 조회를 다시 하지 않는다.
			for (OriginCriteriaBatchRequest req : requests) {
				byKey.putIfAbsent(key(req.getHsCode(), req.getFtaCode(), req.getHsCodeSubCategory()), List.of());
			}
		}
		return new OriginCriteriaCache(dao, byKey);
	}

	List<OriginCriteria> get(String hsCode, String ftaCode, String hsCodeSubCategory, String newAptaPsrFlag) {
		List<OriginCriteria> cached = byKey.get(key(hsCode, ftaCode, hsCodeSubCategory));
		if (cached != null) {
			return cached;
		}
		// 방어적 폴백: 프리페치 시점에 없었던 조합이면(있어서는 안 되지만) 단건 조회로 대체한다.
		return dao.selectApplicableOriginCriteria(hsCode, ftaCode, hsCodeSubCategory, newAptaPsrFlag);
	}

	private static String key(String hsCode, String ftaCode, String hsCodeSubCategory) {
		return String.join("|", nz(hsCode), nz(ftaCode), nz(hsCodeSubCategory));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}
}
