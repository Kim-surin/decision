package com.kpmg.kdb.web.coodecision.dto;

import java.math.BigDecimal;

/**
 * 레거시 PKG99_COO_DECISION 패키지 전역변수 VG_FRD_REC(FCR_RESULT%ROWTYPE) 대체 객체.
 *
 * 원본은 패키지 레벨 전역변수라 하나의 판정 룰(FTA_RULE 한 건) 처리 동안 여러 프로시저
 * (EXCLUTION_RULE_DECISION → COO_DECISION_FOR_CTC/RVC → GET_RCEP_* → INSERT_FRD_PROCESS)가
 * 이 값을 이어받아 채워나간다. Java 에서는 {@link com.kpmg.kdb.web.coodecision.OriginDeterminationContext}
 * 가 들고 있는 인스턴스 필드로 대체해 판정 1건(스레드) 단위로 격리시킨다(동시성 안전).
 */
public class OriginDeterminationResult {

	private Long seq;
	private String salesNo;
	private int salesSeq;
	private String ftaCode;
	private String divisionCode;
	private String companyCode;
	private String hsCode;
	private String productCode;
	private String standard;
	private String ruleSeq;
	private String ruleCode;
	private String ftaCooYn;
	private String companyCooYn;
	private String bufferOption;
	private BigDecimal deMinimisRate;
	private BigDecimal rvcRate;
	private String status;
	private String errorCode;
	private String errorMsg;
	private String deleteYn = "N";
	private String createDate;
	private String createBy;
	private String updateDate;
	private String updateBy;
	private String spCooYn;
	private String woCooYn;
	private String ctcYn;
	private String ftaDeMinimisYn;
	private String companyDeMinimisYn;
	private String ftaRvcYn;
	private String companyRvcYn;
	private String exclusionYn;
	private String exclusionCondition;
	private BigDecimal ctcResultRate;
	private BigDecimal ctcFtaResultRate;
	private BigDecimal ctcCompanyResultRate;
	private BigDecimal rvcResultRate;
	private BigDecimal rvcFtaResultRate;
	private BigDecimal rvcCompanyResultRate;
	private String rcepCooNation;

	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public int getSalesSeq() {
		return salesSeq;
	}

	public void setSalesSeq(int salesSeq) {
		this.salesSeq = salesSeq;
	}

	public String getFtaCode() {
		return ftaCode;
	}

	public void setFtaCode(String ftaCode) {
		this.ftaCode = ftaCode;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getHsCode() {
		return hsCode;
	}

	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getRuleSeq() {
		return ruleSeq;
	}

	public void setRuleSeq(String ruleSeq) {
		this.ruleSeq = ruleSeq;
	}

	public String getRuleCode() {
		return ruleCode;
	}

	public void setRuleCode(String ruleCode) {
		this.ruleCode = ruleCode;
	}

	public String getFtaCooYn() {
		return ftaCooYn;
	}

	public void setFtaCooYn(String ftaCooYn) {
		this.ftaCooYn = ftaCooYn;
	}

	public String getCompanyCooYn() {
		return companyCooYn;
	}

	public void setCompanyCooYn(String companyCooYn) {
		this.companyCooYn = companyCooYn;
	}

	public String getBufferOption() {
		return bufferOption;
	}

	public void setBufferOption(String bufferOption) {
		this.bufferOption = bufferOption;
	}

	public BigDecimal getDeMinimisRate() {
		return deMinimisRate;
	}

	public void setDeMinimisRate(BigDecimal deMinimisRate) {
		this.deMinimisRate = deMinimisRate;
	}

	public BigDecimal getRvcRate() {
		return rvcRate;
	}

	public void setRvcRate(BigDecimal rvcRate) {
		this.rvcRate = rvcRate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public String getSpCooYn() {
		return spCooYn;
	}

	public void setSpCooYn(String spCooYn) {
		this.spCooYn = spCooYn;
	}

	public String getWoCooYn() {
		return woCooYn;
	}

	public void setWoCooYn(String woCooYn) {
		this.woCooYn = woCooYn;
	}

	public String getCtcYn() {
		return ctcYn;
	}

	public void setCtcYn(String ctcYn) {
		this.ctcYn = ctcYn;
	}

	public String getFtaDeMinimisYn() {
		return ftaDeMinimisYn;
	}

	public void setFtaDeMinimisYn(String ftaDeMinimisYn) {
		this.ftaDeMinimisYn = ftaDeMinimisYn;
	}

	public String getCompanyDeMinimisYn() {
		return companyDeMinimisYn;
	}

	public void setCompanyDeMinimisYn(String companyDeMinimisYn) {
		this.companyDeMinimisYn = companyDeMinimisYn;
	}

	public String getFtaRvcYn() {
		return ftaRvcYn;
	}

	public void setFtaRvcYn(String ftaRvcYn) {
		this.ftaRvcYn = ftaRvcYn;
	}

	public String getCompanyRvcYn() {
		return companyRvcYn;
	}

	public void setCompanyRvcYn(String companyRvcYn) {
		this.companyRvcYn = companyRvcYn;
	}

	public String getExclusionYn() {
		return exclusionYn;
	}

	public void setExclusionYn(String exclusionYn) {
		this.exclusionYn = exclusionYn;
	}

	public String getExclusionCondition() {
		return exclusionCondition;
	}

	public void setExclusionCondition(String exclusionCondition) {
		this.exclusionCondition = exclusionCondition;
	}

	public BigDecimal getCtcResultRate() {
		return ctcResultRate;
	}

	public void setCtcResultRate(BigDecimal ctcResultRate) {
		this.ctcResultRate = ctcResultRate;
	}

	public BigDecimal getCtcFtaResultRate() {
		return ctcFtaResultRate;
	}

	public void setCtcFtaResultRate(BigDecimal ctcFtaResultRate) {
		this.ctcFtaResultRate = ctcFtaResultRate;
	}

	public BigDecimal getCtcCompanyResultRate() {
		return ctcCompanyResultRate;
	}

	public void setCtcCompanyResultRate(BigDecimal ctcCompanyResultRate) {
		this.ctcCompanyResultRate = ctcCompanyResultRate;
	}

	public BigDecimal getRvcResultRate() {
		return rvcResultRate;
	}

	public void setRvcResultRate(BigDecimal rvcResultRate) {
		this.rvcResultRate = rvcResultRate;
	}

	public BigDecimal getRvcFtaResultRate() {
		return rvcFtaResultRate;
	}

	public void setRvcFtaResultRate(BigDecimal rvcFtaResultRate) {
		this.rvcFtaResultRate = rvcFtaResultRate;
	}

	public BigDecimal getRvcCompanyResultRate() {
		return rvcCompanyResultRate;
	}

	public void setRvcCompanyResultRate(BigDecimal rvcCompanyResultRate) {
		this.rvcCompanyResultRate = rvcCompanyResultRate;
	}

	public String getRcepCooNation() {
		return rcepCooNation;
	}

	public void setRcepCooNation(String rcepCooNation) {
		this.rcepCooNation = rcepCooNation;
	}

	/**
	 * 레거시 INSERT_FRD_PROCESS 말미의 VG_FRD_REC 필드 초기화 블록을 그대로 이관.
	 * INSERT 직후 다음 룰 판정을 위해 상태값만 남기고 모두 초기화한다(STATUS='N').
	 */
	public void resetForNextRule() {
		this.seq = null;
		this.salesNo = null;
		this.salesSeq = 0; // 다음 룰 처리 직전에 FM_LIST.SALES_SEQ 로 재설정되므로 0은 실제로 읽히지 않는다
		this.ftaCode = null;
		this.ruleSeq = null;
		this.divisionCode = null;
		this.companyCode = null;
		this.ruleCode = null;
		this.spCooYn = null;
		this.woCooYn = null;
		this.ctcYn = null;
		this.ftaDeMinimisYn = null;
		this.companyDeMinimisYn = null;
		this.ftaRvcYn = null;
		this.companyRvcYn = null;
		this.exclusionYn = null;
		this.exclusionCondition = null;
		this.ctcResultRate = null;
		this.ctcFtaResultRate = null;
		this.ctcCompanyResultRate = null;
		this.rvcResultRate = null;
		this.rvcFtaResultRate = null;
		this.rvcCompanyResultRate = null;
		this.ftaCooYn = null;
		this.companyCooYn = null;
		this.status = "N";
		this.errorCode = null;
		this.errorMsg = null;
		this.createDate = null;
		this.createBy = null;
		this.updateDate = null;
		this.updateBy = null;
		this.rcepCooNation = null;
	}
}
