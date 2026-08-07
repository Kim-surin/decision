package com.kpmg.kdb.web.coodecision;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.kpmg.kdb.web.coodecision.dto.MaterialOriginRow;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationTarget;
import com.kpmg.kdb.web.coodecision.dto.OriginDeterminationResult;

/**
 * 레거시 PKG99_COO_DECISION / PKG99_COO_CTC_DECISION 패키지 전역변수(VG_*)를 대체하는 판정 작업 컨텍스트.
 *
 * Oracle PL/SQL 패키지 전역변수는 세션(커넥션) 단위로 존재해 COO_DECISION 이 처리하는 매출 1건마다
 * 값을 새로 채우는 방식으로 동작했다. Java 로 옮기면서 이를 Spring 싱글톤 서비스의 필드로 두면
 * 배치를 여러 스레드로 동시 처리할 때 서로 값을 덮어써 데이터가 섞이는 문제가 생긴다.
 * 따라서 이 클래스는 스프링 빈이 아닌 일반 POJO 로, 매출 1건(=FM_LIST 한 행)을 판정할 때마다
 * 새로 생성해서 사용한다(스레드 안전).
 *
 * FCR_INFO_TEMP(임시테이블)도 더 이상 DB 테이블로 두지 않고, 매출 1건당 한 번만 조회한 뒤
 * fcrInfoRows 리스트로 메모리에 올려 이후의 모든 판정 로직이 스트림으로 처리하도록 했다.
 */
public class OriginDeterminationContext {

	/** 현재 판정 대상 매출/FTA 라인 (원본 FM_LIST) */
	private OriginDeterminationTarget fmList;

	/** FCR_INFO_TEMP 대체: 현재 매출건의 BOM 자재별 원산지/수량/금액 정보 (매출 1건당 1회 조회 후 재사용) */
	private List<MaterialOriginRow> fcrInfoRows = new ArrayList<>();

	/** 현재 판정 룰 1건 처리 중 누적되는 판정결과 레코드 (원본 VG_FRD_REC) */
	private OriginDeterminationResult frdRec = new OriginDeterminationResult();

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
	/** 판정 처리결과 코드 (원본 VG_RETURN_CODE) */
	private int returnCode;
	private String errorCode;
	private String errorMsg;

	/** RCEP 한국산 재료비 BD20 달성 여부 (원본 VG_RCEP_KR_YN) */
	private String rcepKrYn;
	/** RCEP 원산지 재료비 최대 기여국 (원본 VG_RCEP_COO_NATION) */
	private String rcepCooNation;

	public OriginDeterminationTarget getFmList() {
		return fmList;
	}

	public void setFmList(OriginDeterminationTarget fmList) {
		this.fmList = fmList;
	}

	public List<MaterialOriginRow> getMaterialOriginRows() {
		return fcrInfoRows;
	}

	public void setMaterialOriginRows(List<MaterialOriginRow> fcrInfoRows) {
		this.fcrInfoRows = fcrInfoRows;
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

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
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
}
