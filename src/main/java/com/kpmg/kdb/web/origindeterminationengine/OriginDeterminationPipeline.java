package com.kpmg.kdb.web.origindeterminationengine;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpmg.kdb.core.procedurelog.ProcedureLogService;
import com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationMode;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

// 원산지판정 흐름을 메서드 체이닝으로 실행하는 파이프라인. 내수는 generateVirtualSales > createFcr > determineOrigin >
// updateStatus, 수출은 createFcr부터 시작하며, 판정 대상 1건에서 예외가 나면 그 대상만 판정실패('5')로 표시하고 나머지는 계속 진행한다.
public class OriginDeterminationPipeline {

	private static final Logger logger = LoggerFactory.getLogger(OriginDeterminationPipeline.class);

	/** CREATE_FCR 의 P_BOM_TYPE. 원본 MONTHLY_DECISION_PROC 호출부와 동일하게 항상 "F"를 쓴다. */
	private static final String BOM_TYPE = "F";

	private final OriginDeterminationMode mode;
	private final List<String> productCodes;
	private final Set<SalesTarget> failedTargets = new HashSet<>();

	private final AggregatedVirtualSalesGenerator virtualSalesGenerator;
	private final CreateFcrService fcrCreator;
	private final OriginDeterminationExecutionService originDecider;
	private final SalesOriginDeterminationStatusUpdater statusUpdater;
	private final ProcedureLogService procedureLogService;
	/** AS-IS MONTHLY_DECISION_PROC 대응 로그(호출측이 만들어 넘겨준다). 대상별 진행상황/에러를 여기에 이어 붙인다. */
	private final Long logId;

	private List<SalesTarget> targets;

	public OriginDeterminationPipeline(List<SalesTarget> initialTargets, OriginDeterminationMode mode,
			List<String> productCodes, AggregatedVirtualSalesGenerator virtualSalesGenerator,
			CreateFcrService fcrCreator, OriginDeterminationExecutionService originDecider,
			SalesOriginDeterminationStatusUpdater statusUpdater, ProcedureLogService procedureLogService, Long logId) {
		this.targets = initialTargets;
		this.mode = mode;
		this.productCodes = productCodes;
		this.virtualSalesGenerator = virtualSalesGenerator;
		this.fcrCreator = fcrCreator;
		this.originDecider = originDecider;
		this.statusUpdater = statusUpdater;
		this.procedureLogService = procedureLogService;
		this.logId = logId;
	}

	// ==================== 단계 ====================

	/** "1. 가상매출 생성"(내수 전용). SALES_MST/SALES_DTL 가상매출을 만들고 판정 대상 목록을 갱신한다. */
	public OriginDeterminationPipeline generateVirtualSales(VirtualSalesGenerationParams params) {
		this.targets = virtualSalesGenerator.generate(params);
		this.failedTargets.clear();
		return this;
	}

	/** "3. CREATE_FCR". 현재 판정 대상 각각에 대해 FCR_MST/FCR_DTL 을 생성한다. */
	public OriginDeterminationPipeline createFcr() {
		return forEachTarget("CREATE_FCR",
				t -> fcrCreator.createFcr(t.getCompanyCode(), t.getDivisionCode(), t.getSalesNo(), BOM_TYPE,
						productCodes));
	}

	/** "4. PKG99_COO_DECISION.COO_DECISION". 현재 판정 대상 각각에 대해 원산지를 판정한다(제품+상품). */
	public OriginDeterminationPipeline determineOrigin() {
		return forEachTarget("COO_DECISION", t -> originDecider.determineOrigin(t.getCompanyCode(),
				t.getDivisionCode(), t.getSalesNo(), mode, productCodes));
	}

	/** "5. SALES_DTL STATUS 업데이트". 현재 판정 대상 각각의 상태값을 판정완료로 갱신한다. */
	public OriginDeterminationPipeline updateStatus() {
		return forEachTarget("STATUS 업데이트",
				t -> statusUpdater.updateStatus(t.getCompanyCode(), t.getDivisionCode(), t.getSalesNo(), productCodes));
	}

	/** 이번 파이프라인이 다루는 판정 대상 목록(가장 최근 단계 기준). */
	public List<SalesTarget> targets() {
		return targets;
	}

	/** 도중에 예외가 발생해 이후 단계에서 제외된 판정 대상 목록. */
	public Set<SalesTarget> failedTargets() {
		return failedTargets;
	}

	private OriginDeterminationPipeline forEachTarget(String stepName, Consumer<SalesTarget> step) {
		for (SalesTarget target : targets) {
			if (failedTargets.contains(target)) {
				continue;
			}
			// AS-IS MONTHLY_DECISION_PROC 루프의 "SALES_NO 건 FCR생성 중"/"판정 중" 대응
			procedureLogService.batchLogDtl(logId, target.getSalesNo() + " 건 " + stepName + " 중");
			try {
				step.accept(target);
			} catch (Exception e) {
				failedTargets.add(target);
				logger.error("{} 실패. companyCode={}, salesNo={}", stepName, target.getCompanyCode(),
						target.getSalesNo(), e);
				procedureLogService.batchLogDtl(logId, "DBMS 에러가 발생 했습니다 " + e
						+ "[PARAM {COMPANY_CODE : " + target.getCompanyCode() + "}{SALES_NO : " + target.getSalesNo() + "}]");
				try {
					statusUpdater.markDecisionFailed(target.getCompanyCode(), target.getDivisionCode(), target.getSalesNo(),
							productCodes);
				} catch (Exception markFailedException) {
					logger.error("판정실패 표시 실패. companyCode={}, salesNo={}", target.getCompanyCode(),
							target.getSalesNo(), markFailedException);
				}
			}
		}
		return this;
	}
}
