package com.kpmg.kdb.web.originbasis;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;

/**
 * 레거시 FS03_GET_HS_CODE(company, division, customer, item, nation, fta, yyyymmdd) 이관.
 *
 * 원본 함수는 DETERMINISTIC 으로 선언되어 있어 동일 입력에 대해 Oracle 옵티마이저가 결과를 재사용할 수 있었다.
 * 대량의 매출/BOM 라인이 동일 품목·거래처 조합을 반복 참조하는 배치 특성상, 애플리케이션 레벨 캐시로
 * 동일한 효과(반복 DB 호출 제거)를 재현한다.
 */
@Service
public class HsCodeService extends GeneralService {

	@Cacheable(cacheNames = "hsCode", key = "#criteria.companyCode + ':' + #criteria.divisionCode + ':' "
			+ "+ #criteria.customerCode + ':' + #criteria.itemCode + ':' + #criteria.nationCode + ':' "
			+ "+ #criteria.ftaCode + ':' + #criteria.resolvedBaseDate")
	public String resolveHsCode(HsCodeCriteria criteria) {
		try {
			List<HsCodeCandidateRow> candidates = sqlSession.getMapper(HsCodeDao.class)
					.selectHsCodeCandidates(criteria);

			if (candidates.isEmpty()) {
				return "";
			}

			String hsCode = candidates.get(0).resolvePriorityHsCode();
			return hsCode == null ? "" : hsCode;
		} catch (Exception e) {
			// 원본 EXCEPTION WHEN OTHERS THEN RETURN(''); 과 동일하게 조회 실패 시 빈 문자열 반환
			logger.error("HS코드 조회 실패. criteria={}", criteria, e);
			return "";
		}
	}
}
