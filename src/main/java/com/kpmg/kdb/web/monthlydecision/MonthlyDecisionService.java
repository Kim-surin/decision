package com.kpmg.kdb.web.monthlydecision;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.coodecision.OriginDeterminationService;
import com.kpmg.kdb.web.coodecision.OriginDeterminationMode;
import com.kpmg.kdb.web.createfcr.CreateFcrService;
import com.kpmg.kdb.web.monthlydecision.dto.CompanyDecisionFlags;
import com.kpmg.kdb.web.monthlydecision.dto.MonthlyDecisionParams;
import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;

/**
 * 레거시 MONTHLY_DECISION_PROC 이관.
 *
 * 1) 내수 포괄(가상) 매출 마스터/상세 생성, 2) 판정대상(SALES_NO) 커서 순회, 3) 매출건마다
 * {@link CreateFcrService}(CREATE_FCR)로 FCR_MST/FCR_DTL 을 만들고 {@link OriginDeterminationService}
 * (COO_DECISION)로 원산지를 판정한 뒤 상태값을 갱신한다.
 *
 * <p>대상 매출이 대량일 수 있는 배치 성격상, 판정대상 목록은 회사/기간 단위로 자연히 유한하게
 * 제한되는 조회 결과 하나만 메모리에 두고(SALES_NO 목록), 매출 1건에 대한 실제 무거운 데이터
 * (BOM 전개, FCR_INFO_TEMP 대체 리스트 등)는 {@link CreateFcrService}/{@link OriginDeterminationService}
 * 가 매출 1건 처리 후 즉시 버려지는 지역 변수로만 다뤄 누적되지 않는다(OOM 방지).
 *
 * <p><b>이관되지 않은 부분:</b> COMPANY.MATERIAL_USE_YN='Y' 인 회사에 대해 원본이 호출하는
 * PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC(원재료수불부 자동생성)은 원산지판정과는 별개의 하위
 * 시스템이고 이번 이관 대상 PL/SQL 소스 목록에도 포함되어 있지 않아 옮기지 못했다. 이 플래그가 'Y'인
 * 회사는 경고 로그만 남기고 이 단계를 건너뛴 채 계속 진행한다 — 별도 이관 필요.
 *
 * <p>CREATE_FCR/COO_DECISION 각각의 예외 처리 방식이 원본에서 서로 다르다는 점을 그대로 반영했다:
 * COO_DECISION 은 자체적으로 예외를 흡수하지만 CREATE_FCR 은 흡수하지 않으므로, 매출 1건 단위의
 * 예외 격리는 이 클래스({@link #decideOneSalesHeader} 호출부)가 담당한다(원본 커서 루프의
 * BEGIN/EXCEPTION 블록과 동일 위치).
 */
@Service
public class MonthlyDecisionService extends GeneralService {

	@Autowired
	private CreateFcrService createFcrService;
	@Autowired
	private OriginDeterminationService originDeterminationService;

	public void run(MonthlyDecisionParams params) {
		try {
			MonthlyDecisionDao dao = sqlSession.getMapper(MonthlyDecisionDao.class);

			CompanyDecisionFlags flags = dao.selectCompanyDecisionFlags(params.getCompanyCode());

			if ("Y".equals(flags.getMaterialUseYn())) {
				logger.warn(
						"PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC 미이관: 원재료수불부(자동생성) 로드 단계를 건너뜁니다. "
								+ "companyCode={}, yyyymm={}",
						params.getCompanyCode(), params.getYyyymm());
			}

			// 1. 내수 포괄(가상) 매출 마스터 생성
			dao.deleteAggregatedSalesDtl(params);
			dao.deleteAggregatedSalesMst(params);
			dao.mergeAggregatedSalesMst(params);

			// 2. 포괄 SALES_DTL 생성
			dao.mergeAggregatedSalesDtl(params);

			// 4. 판정대상 커서 LOOP
			OriginDeterminationMode mode = "Y".equals(flags.getCtcDecisionOnlyYn()) ? OriginDeterminationMode.CTC_ONLY
					: OriginDeterminationMode.RVC_CTC;
			List<SalesTarget> targets = dao.selectDecisionTargets(params);

			int count = 1;
			for (SalesTarget target : targets) {
				try {
					decideOneSalesHeader(dao, target, mode);
				} catch (Exception e) {
					logger.error("MONTHLY_DECISION_PROC 판정 실패. companyCode={}, salesNo={}",
							target.getCompanyCode(), target.getSalesNo(), e);
				}
				if (count % 100 == 0) {
					logger.info("{}건 판정 완료", count);
				}
				count++;
			}
		} catch (Exception e) {
			logger.error("MONTHLY_DECISION_PROC 실패. companyCode={}, yyyymmdd={}", params.getCompanyCode(),
					params.getYyyymmdd(), e);
		}
	}

	/**
	 * 레거시 C_SALES_MST 커서 루프 1회 반복(5. 원산지판정) 이관.
	 *
	 * <p>원본은 이 자리에서 SALES_DTL.DECISION_YN='Y' 를 먼저 세팅해 "이번에 판정할 제품 범위"를
	 * DB 컬럼에 마킹해두고, CREATE_FCR/COO_DECISION 이 그 값을 다시 조회해 스코프를 알아내는
	 * 2단계 과정을 거쳤다. 월 판정은 salesNo 의 전체 제품을 대상으로 하므로("전체판정"), 그 스코프를
	 * DB 마킹 대신 productCodes=null 파라미터로 직접 전달한다 — 마킹 UPDATE 자체가 필요 없어진다.
	 * DECISION_YN 컬럼은 다른 화면/리포트도 읽지 않는 것으로 확인되어 안전하다.
	 */
	private void decideOneSalesHeader(MonthlyDecisionDao dao, SalesTarget target, OriginDeterminationMode mode) {
		// FCR 생성 (V_RETURN_CODE 는 원본도 이 시점에는 검사하지 않고 COO_DECISION 으로 그대로 진행한다)
		createFcrService.createFcr(target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(), "F", null);

		// 원산지 판정
		originDeterminationService.determineOrigin(target.getCompanyCode(), target.getSalesNo(), mode, null);

		// 상태값 변경 4: 판정완료
		dao.updateSalesMstDecisionComplete(target.getCompanyCode(), target.getSalesNo());
		dao.updateSalesDtlDecisionComplete(target.getCompanyCode(), target.getSalesNo(), null);
		dao.updateFcrMstDecisionComplete(target.getCompanyCode(), target.getSalesNo(), null);
	}
}
