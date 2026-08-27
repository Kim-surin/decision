package com.kpmg.kdb.web.origindeterminationengine;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpmg.kdb.web.origindeterminationengine.OriginDeterminationMode;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.VirtualSalesGenerationParams;

/**
 * 원산지판정 흐름(가상매출생성 -&gt; CREATE_FCR -&gt; COO_DECISION -&gt; STATUS 업데이트)을 메서드 체이닝으로
 * 실행하는 파이프라인. 내수/수출은 사용 단계가 다르다.
 *
 * <pre>
 * 내수) generateVirtualSales(params) -&gt; createFcr() -&gt; determineOrigin() -&gt; updateStatus()
 * 수출)                                  createFcr() -&gt; determineOrigin() -&gt; updateStatus()
 * </pre>
 *
 * 각 단계는 {@link VirtualSalesGenerator}/{@link FcrCreator}/{@link OriginDecider}/
 * {@link DecisionStatusUpdater} 부품으로 분리되어 {@code with*} 로 교체 가능하며, 기본 부품은
 * {@link OriginDecisionPipelineFactory} 가 채워준다. 판정 대상 1건에서 예외가 발생하면 그 대상만
 * 이후 단계에서 제외하고 나머지는 계속 진행한다.
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

	/** "1. 가상매출 생성"(내수 전용). SALES_MST/SALES_DTL 가상매출을 만들고 판정 대상 목록을 갱신한다. */
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

	/** "4. PKG99_COO_DECISION.COO_DECISION". 현재 판정 대상 각각에 대해 원산지를 판정한다(제품+상품). */
	public OriginDecisionPipeline determineOrigin() {
		return forEachTarget("COO_DECISION", t -> originDecider.determineOrigin(t.getCompanyCode(),
				t.getDivisionCode(), t.getSalesNo(), mode, productCodes));
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
