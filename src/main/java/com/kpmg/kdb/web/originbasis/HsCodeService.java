package com.kpmg.kdb.web.originbasis;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCandidateRow;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;

/**
 * 레거시 FS03_GET_HS_CODE(company, division, customer, item, nation, fta, yyyymmdd) 이관.
 */
@Service
public class HsCodeService extends GeneralService {

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
}
