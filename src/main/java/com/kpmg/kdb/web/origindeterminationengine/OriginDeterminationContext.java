package com.kpmg.kdb.web.origindeterminationengine;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialOriginRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;

/**
 * 원산지 판정(COO_DECISION) 1건(FTA 후보 1행) 처리 중 쓰는 작업 컨텍스트. 스프링 빈이 아닌 일반
 * POJO로, 판정할 때마다 새로 생성해서 스레드 안전하게 쓴다. FCR_INFO_TEMP(자재원산지 정보)도
 * materialOriginRows에 한 번만 조회해 메모리에 올려두고 이후 판정 로직은 스트림으로 처리한다.
 */
public class OriginDeterminationContext {

	/** 현재 판정 대상 매출/FTA 라인 (원본 FM_LIST) */
	private OriginDeterminationTarget fmData;

	/** FCR_INFO_TEMP 대체: 현재 매출건의 BOM 자재별 원산지/수량/금액 정보 (매출 1건당 1회 조회 후 재사용) */
	private List<MaterialOriginRow> materialOriginRows = new ArrayList<>();

	/** 현재 판정 룰 1건 처리 중 누적되는 판정결과 레코드 (원본 VG_FRD_REC) */
	private OriginDeterminationResult frdRec = new OriginDeterminationResult();

	/** 룰별로 확정된 판정결과를 즉시 저장하지 않고 모아뒀다가 배치로 저장하기 위한 버퍼 */
	private final List<OriginDeterminationResult> pendingResults = new ArrayList<>();

	/** GET_BUFFER 결과: 버퍼 산정기준(COM/DIV/PRD/FTA) (원본 VG_OPTION_VALUE) */
	private String optionValue;
	/** GET_BUFFER 결과: RVC 버퍼율 (원본 VG_COMPANY_RVC_RATE) */
	private BigDecimal companyRvcRate;
	/** GET_BUFFER 결과: 미소기준 버퍼율 (원본 VG_COMPANY_CTC_RATE) */
	private BigDecimal companyCtcRate;

	/** 인코텀즈 환산 기준금액 (원본 VG_INKOTERMS_AMOUNT, 상위 오케스트레이션 단계에서 설정) */
	private BigDecimal inkotermsAmount;
	/** 미소기준 인코텀즈 금액 (원본 VG_DE_MINIMIS_INKOTERMS_AMOUNT) */
	private BigDecimal deMinimisInkotermsAmount;
	private BigDecimal netCostAmount;
	private BigDecimal netWeight;

	/** 해당 HS코드에 적용 가능한 룰 존재 여부 카운트 (원본 VG_RULE_COUNT) */
	private int ruleCount;
	private String errorCode;
	private String errorMsg;

	/** RCEP 한국산 재료비 BD20 달성 여부 (원본 VG_RCEP_KR_YN) */
	private String rcepKrYn;
	/** RCEP 원산지 재료비 최대 기여국 (원본 VG_RCEP_COO_NATION) */
	private String rcepCooNation;

	/** 최소공정 제외 품목 여부 캐시(이 컨텍스트 안의 모든 룰에서 조회 키가 동일해 룰마다 재조회할 필요 없음) */
	private String minimalProcessItemYn;
	private boolean minimalProcessItemYnLoaded;

	public OriginDeterminationTarget getFmData() {
		return fmData;
	}

	public void setFmData(OriginDeterminationTarget fmData) {
		this.fmData = fmData;
	}

	public List<MaterialOriginRow> getMaterialOriginRows() {
		return materialOriginRows;
	}

	public void setMaterialOriginRows(List<MaterialOriginRow> materialOriginRows) {
		this.materialOriginRows = materialOriginRows;
	}

	public OriginDeterminationResult getFrdRec() {
		return frdRec;
	}

	public void setFrdRec(OriginDeterminationResult frdRec) {
		this.frdRec = frdRec;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public BigDecimal getCompanyRvcRate() {
		return companyRvcRate;
	}

	public void setCompanyRvcRate(BigDecimal companyRvcRate) {
		this.companyRvcRate = companyRvcRate;
	}

	public BigDecimal getCompanyCtcRate() {
		return companyCtcRate;
	}

	public void setCompanyCtcRate(BigDecimal companyCtcRate) {
		this.companyCtcRate = companyCtcRate;
	}

	public BigDecimal getInkotermsAmount() {
		return inkotermsAmount;
	}

	public void setInkotermsAmount(BigDecimal inkotermsAmount) {
		this.inkotermsAmount = inkotermsAmount;
	}

	public BigDecimal getDeMinimisInkotermsAmount() {
		return deMinimisInkotermsAmount;
	}

	public void setDeMinimisInkotermsAmount(BigDecimal deMinimisInkotermsAmount) {
		this.deMinimisInkotermsAmount = deMinimisInkotermsAmount;
	}

	public BigDecimal getNetCostAmount() {
		return netCostAmount;
	}

	public void setNetCostAmount(BigDecimal netCostAmount) {
		this.netCostAmount = netCostAmount;
	}

	public BigDecimal getNetWeight() {
		return netWeight;
	}

	public void setNetWeight(BigDecimal netWeight) {
		this.netWeight = netWeight;
	}

	public int getRuleCount() {
		return ruleCount;
	}

	public void setRuleCount(int ruleCount) {
		this.ruleCount = ruleCount;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getRcepKrYn() {
		return rcepKrYn;
	}

	public void setRcepKrYn(String rcepKrYn) {
		this.rcepKrYn = rcepKrYn;
	}

	public String getRcepCooNation() {
		return rcepCooNation;
	}

	public void setRcepCooNation(String rcepCooNation) {
		this.rcepCooNation = rcepCooNation;
	}

	public void addPendingResult(OriginDeterminationResult snapshot) {
		pendingResults.add(snapshot);
	}

	public List<OriginDeterminationResult> getPendingResults() {
		return pendingResults;
	}

	public String getMinimalProcessItemYn() {
		return minimalProcessItemYn;
	}

	public void setMinimalProcessItemYn(String minimalProcessItemYn) {
		this.minimalProcessItemYn = minimalProcessItemYn;
		this.minimalProcessItemYnLoaded = true;
	}

	public boolean isMinimalProcessItemYnLoaded() {
		return minimalProcessItemYnLoaded;
	}
}
