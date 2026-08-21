package com.kpmg.kdb.web.origindeterminationexecution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeBatchResult;
import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.origindeterminationexecution.dto.HsCodeCriteria;

/**
 * 레거시 FS03_GET_HS_CODE(company, division, customer, item, nation, fta, yyyymmdd) 이관.
 */
@Service
public class HsCodeService extends GeneralService {

	/** {@link #prefetchHsCode} 배치 조회 1회당 최대 요청 건수(바인드 파라미터 상한 방지) */
	private static final int BATCH_CHUNK_SIZE = 500;

	public String resolveHsCode(HsCodeCriteria criteria) {
		try {
			HsCodeCandidateRow candidate = sqlSession.getMapper(HsCodeDao.class).selectHsCodeCandidates(criteria);
			if (candidate == null) {
				return "";
			}

			String hsCode = candidate.resolvePriorityHsCode();
			return hsCode == null ? "" : hsCode;
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN(''); 과 동일하게 조회 실패 시 빈 문자열 반환
			logger.error("HS코드 조회 실패. criteria={}", criteria, e);
			return "";
		}
	}

	/**
	 * {@link HsCodeDao#selectHsCodeCandidates} 가 (제품×FTA_CODE 후보) 조합마다 반복 호출되던 것을 배치
	 * 조회 1회로 대체하기 위한 사전조회. 반환된 맵은 {@link #hsCodeKey} 로 만든 키에 최종 우선순위
	 * HS코드(빈 문자열이면 "결과 없음", {@link #resolveHsCode} 와 동일 규칙)를 담는다 — 호출자가 만든
	 * hsCodeCache(Map)에 그대로 채워 넣으면 그 이후의 조회는 추가 DB 호출 없이 캐시만으로 처리된다.
	 */
	public Map<String, String> prefetchHsCode(List<HsCodeCriteria> criteriaList) {
		if (criteriaList == null || criteriaList.isEmpty()) {
			return Map.of();
		}

		List<HsCodeCriteria> distinctRequests = new ArrayList<>();
		Set<String> seenKeys = new HashSet<>();
		for (HsCodeCriteria criteria : criteriaList) {
			String key = hsCodeKey(criteria.getCompanyCode(), criteria.getDivisionCode(), criteria.getCustomerCode(),
					criteria.getItemCode(), criteria.getNationCode(), criteria.getFtaCode(), criteria.getBaseDate());
			if (seenKeys.add(key)) {
				distinctRequests.add(criteria);
			}
		}

		try {
			HsCodeDao dao = sqlSession.getMapper(HsCodeDao.class);
			Map<String, String> cache = new HashMap<>();
			for (int from = 0; from < distinctRequests.size(); from += BATCH_CHUNK_SIZE) {
				List<HsCodeCriteria> chunk = distinctRequests.subList(from,
						Math.min(from + BATCH_CHUNK_SIZE, distinctRequests.size()));
				List<HsCodeBatchResult> results = dao.selectHsCodeCandidatesBatch(chunk);
				for (HsCodeBatchResult r : results) {
					String key = hsCodeKey(r.getReqCompanyCode(), r.getReqDivisionCode(), r.getReqCustomerCode(),
							r.getReqItemCode(), r.getReqNationCode(), r.getReqFtaCode(), r.getReqBaseDate());
					String hsCode = r.toCandidateRow().resolvePriorityHsCode();
					cache.put(key, hsCode == null ? "" : hsCode);
				}
			}
			return cache;
		} catch (Exception e) {
			// 배치 사전조회는 최적화일 뿐이라 실패해도 전체 흐름을 막지 않는다 — 빈 캐시를 돌려주면
			// resolveHsCode 가 그 자리에서 단건 조회로 대체한다.
			logger.error("HS코드 배치조회 실패. requestCount={}", distinctRequests.size(), e);
			return Map.of();
		}
	}

	/** {@link #prefetchHsCode} 와 호출자(CreateFcrService 등)의 개별 캐시가 공유하는 키 규칙. */
	public static String hsCodeKey(String companyCode, String divisionCode, String customerCode, String itemCode,
			String nationCode, String ftaCode, String baseDate) {
		return String.join("|", nz(companyCode), nz(divisionCode), nz(customerCode), nz(itemCode), nz(nationCode),
				nz(ftaCode), nz(baseDate));
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}
}
