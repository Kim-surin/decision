package com.kpmg.kdb.web.origindecision;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpmg.kdb.web.coodecision.OriginDeterminationMode;
import com.kpmg.kdb.web.monthlydecision.dto.SalesTarget;
import com.kpmg.kdb.web.monthlydecision.dto.VirtualSalesGenerationParams;

/**
 * 원산지판정 전체 흐름(레거시 MONTHLY_DECISION_PROC + CREATE_FCR + PKG99_COO_DECISION.COO_DECISION)을
 * 메서드 체이닝으로 호출하는 컨트롤 파이프라인. 내수/수출은 사용하는 단계가 다르다.
 *
 * <pre>
 * 내수) generateVirtualSales(params) -&gt; createFcr() -&gt; determineOrigin() -&gt; updateStatus()
 * 수출)                                  createFcr() -&gt; determineOrigin() -&gt; updateStatus()
 * </pre>
 *
 * 각 단계는 {@link VirtualSalesGenerator}/{@link FcrCreator}/{@link OriginDecider}/
 * {@link DecisionStatusUpdater} 부품으로 분리되어 있어 {@code with*} 메서드로 다른 구현체와
 * 갈아끼울 수 있다. 기본 부품(기존 CreateFcrService/OriginDeterminationService/
 * MonthlyDecisionDao 이관 코드)은 {@link OriginDecisionPipelineFactory} 가 채워준다.
 *
 * <p>내수는 {@link #generateVirtualSales} 호출 시점에 회사/기간 범위의 판정 대상(SALES_NO)이 여러
 * 건 채워질 수 있어, 그 뒤의 각 단계는 현재 판정 대상 전체에 대해 반복 수행된다. 수출은 파이프라인
 * 생성 시 이미 확정된 SALES_NO 1건만 대상으로 한다. 원본 C_SALES_MST 커서 루프와 동일하게, 판정
 * 대상 1건에서 예외가 발생하면 그 대상만 이후 단계에서 제외하고 나머지는 계속 진행한다(전체 파이프라인이
 * 중단되지 않는다).
 */
public class OriginDecisionPipeline {

	private static final Logger logger = LoggerFactory.getLogger(OriginDecisionPipeline.class);

	private final OriginDeterminationMode mode;
	private final List<String> productCodes;
	private final Set<SalesTarget> failedTargets = new HashSet<>();

	private VirtualSalesGenerator virtualSalesGenerator;
	private FcrCreator fcrCreator;
	private OriginDecider originDecider;
	private DecisionStatusUpdater statusUpdater;

	private String bomType = "F";
	private List<SalesTarget> targets;

	public OriginDecisionPipeline(List<SalesTarget> initialTargets, OriginDeterminationMode mode,
			List<String> productCodes, VirtualSalesGenerator virtualSalesGenerator, FcrCreator fcrCreator,
			OriginDecider originDecider, DecisionStatusUpdater statusUpdater) {
		this.targets = initialTargets;
		this.mode = mode;
		this.productCodes = productCodes;
		this.virtualSalesGenerator = virtualSalesGenerator;
		this.fcrCreator = fcrCreator;
		this.originDecider = originDecider;
		this.statusUpdater = statusUpdater;
	}

	// ==================== 부품 교체 ====================

	public OriginDecisionPipeline withVirtualSalesGenerator(VirtualSalesGenerator generator) {
		this.virtualSalesGenerator = generator;
		return this;
	}

	public OriginDecisionPipeline withFcrCreator(FcrCreator creator) {
		this.fcrCreator = creator;
		return this;
	}

	public OriginDecisionPipeline withOriginDecider(OriginDecider decider) {
		this.originDecider = decider;
		return this;
	}

	public OriginDecisionPipeline withStatusUpdater(DecisionStatusUpdater updater) {
		this.statusUpdater = updater;
		return this;
	}

	/** CREATE_FCR 의 P_BOM_TYPE. 기본값 "F"(원본 MONTHLY_DECISION_PROC 호출부와 동일). */
	public OriginDecisionPipeline withBomType(String bomType) {
		this.bomType = bomType;
		return this;
	}

	// ==================== 단계 ====================

	/**
	 * "1. 가상매출 생성"(내수 전용). 회사/기간 단위로 SALES_MST/SALES_DTL 가상매출을 만들고, 그 결과를
	 * 판정 대상 목록으로 갱신한다. 수출 파이프라인에서는 호출하지 않는다.
	 */
	public OriginDecisionPipeline generateVirtualSales(VirtualSalesGenerationParams params) {
		this.targets = virtualSalesGenerator.generate(params);
		this.failedTargets.clear();
		return this;
	}

	/** "3. CREATE_FCR". 현재 판정 대상 각각에 대해 FCR_MST/FCR_DTL 을 생성한다. */
	public OriginDecisionPipeline createFcr() {
		return forEachTarget("CREATE_FCR",
				t -> fcrCreator.createFcr(t.getCompanyCode(), t.getDivisionCode(), t.getSalesNo(), bomType,
						productCodes));
	}

	/** "4. PKG99_COO_DECISION.COO_DECISION". 현재 판정 대상 각각에 대해 원산지를 판정한다. */
	public OriginDecisionPipeline determineOrigin() {
		return forEachTarget("COO_DECISION",
				t -> originDecider.determineOrigin(t.getCompanyCode(), t.getSalesNo(), mode, productCodes));
	}

	/** "5. SALES_DTL STATUS 업데이트". 현재 판정 대상 각각의 상태값을 판정완료로 갱신한다. */
	public OriginDecisionPipeline updateStatus() {
		return forEachTarget("STATUS 업데이트",
				t -> statusUpdater.updateStatus(t.getCompanyCode(), t.getSalesNo(), productCodes));
	}

	/** 이번 파이프라인이 다루는 판정 대상 목록(가장 최근 단계 기준). */
	public List<SalesTarget> targets() {
		return targets;
	}

	/** 도중에 예외가 발생해 이후 단계에서 제외된 판정 대상 목록. */
	public Set<SalesTarget> failedTargets() {
		return failedTargets;
	}

	private OriginDecisionPipeline forEachTarget(String stepName, Consumer<SalesTarget> step) {
		for (SalesTarget target : targets) {
			if (failedTargets.contains(target)) {
				continue;
			}
			try {
				step.accept(target);
			} catch (Exception e) {
				failedTargets.add(target);
				logger.error("{} 실패. companyCode={}, salesNo={}", stepName, target.getCompanyCode(),
						target.getSalesNo(), e);
			}
		}
		return this;
	}
}
