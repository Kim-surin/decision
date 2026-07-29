package com.kpmg.kdb.web.originbasis.dto;

import java.math.BigDecimal;
import java.util.function.Function;

/**
 * FTA_INCOTERMS_INFO 한 행. 인코텀즈 조건별 환산율 컬럼을 그대로 보관하고,
 * 어떤 컬럼을 사용할지는 {@link IncotermsCode} 로 Java에서 선택한다.
 * (원본 SQL의 DECODE(P_FROM_INCOTERMS_CODE, 'EXW', ..., 'FOB', ...) 컬럼 피벗을 대체)
 */
public class IncotermsRateRow {

	public enum IncotermsCode {
		EXW(IncotermsRateRow::getExwRate),
		FCA(IncotermsRateRow::getFcaRate),
		FAS(IncotermsRateRow::getFasRate),
		FOB(IncotermsRateRow::getFobRate),
		CFR(IncotermsRateRow::getCfrRate),
		CIF(IncotermsRateRow::getCifRate),
		CPT(IncotermsRateRow::getCptRate),
		CIP(IncotermsRateRow::getCipRate),
		DAP(IncotermsRateRow::getDapRate),
		DAT(IncotermsRateRow::getDatRate),
		DDU(IncotermsRateRow::getDduRate),
		DDP(IncotermsRateRow::getDdpRate);

		private final Function<IncotermsRateRow, BigDecimal> extractor;

		IncotermsCode(Function<IncotermsRateRow, BigDecimal> extractor) {
			this.extractor = extractor;
		}

		/** 코드 문자열을 안전하게 enum 으로 변환. 알 수 없는 코드는 null 반환 */
		public static IncotermsCode fromCode(String code) {
			if (code == null) {
				return null;
			}
			try {
				return IncotermsCode.valueOf(code.trim().toUpperCase());
			} catch (IllegalArgumentException e) {
				return null;
			}
		}

		public BigDecimal extractRate(IncotermsRateRow row) {
			return row == null ? null : extractor.apply(row);
		}
	}

	private String stdYyyy;
	private BigDecimal exwRate;
	private BigDecimal fcaRate;
	private BigDecimal fasRate;
	private BigDecimal fobRate;
	private BigDecimal cfrRate;
	private BigDecimal cifRate;
	private BigDecimal cptRate;
	private BigDecimal cipRate;
	private BigDecimal dapRate;
	private BigDecimal datRate;
	private BigDecimal dduRate;
	private BigDecimal ddpRate;

	public String getStdYyyy() {
		return stdYyyy;
	}

	public void setStdYyyy(String stdYyyy) {
		this.stdYyyy = stdYyyy;
	}

	public BigDecimal getExwRate() {
		return exwRate;
	}

	public void setExwRate(BigDecimal exwRate) {
		this.exwRate = exwRate;
	}

	public BigDecimal getFcaRate() {
		return fcaRate;
	}

	public void setFcaRate(BigDecimal fcaRate) {
		this.fcaRate = fcaRate;
	}

	public BigDecimal getFasRate() {
		return fasRate;
	}

	public void setFasRate(BigDecimal fasRate) {
		this.fasRate = fasRate;
	}

	public BigDecimal getFobRate() {
		return fobRate;
	}

	public void setFobRate(BigDecimal fobRate) {
		this.fobRate = fobRate;
	}

	public BigDecimal getCfrRate() {
		return cfrRate;
	}

	public void setCfrRate(BigDecimal cfrRate) {
		this.cfrRate = cfrRate;
	}

	public BigDecimal getCifRate() {
		return cifRate;
	}

	public void setCifRate(BigDecimal cifRate) {
		this.cifRate = cifRate;
	}

	public BigDecimal getCptRate() {
		return cptRate;
	}

	public void setCptRate(BigDecimal cptRate) {
		this.cptRate = cptRate;
	}

	public BigDecimal getCipRate() {
		return cipRate;
	}

	public void setCipRate(BigDecimal cipRate) {
		this.cipRate = cipRate;
	}

	public BigDecimal getDapRate() {
		return dapRate;
	}

	public void setDapRate(BigDecimal dapRate) {
		this.dapRate = dapRate;
	}

	public BigDecimal getDatRate() {
		return datRate;
	}

	public void setDatRate(BigDecimal datRate) {
		this.datRate = datRate;
	}

	public BigDecimal getDduRate() {
		return dduRate;
	}

	public void setDduRate(BigDecimal dduRate) {
		this.dduRate = dduRate;
	}

	public BigDecimal getDdpRate() {
		return ddpRate;
	}

	public void setDdpRate(BigDecimal ddpRate) {
		this.ddpRate = ddpRate;
	}
}
