package com.kpmg.kdb.schedule.quartz.job.vo;

import java.util.Map;

import com.kpmg.kdb.schedule.quartz.job.collection.TransferMap;
import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.util.StringUtil;

public class ParameterVo {

	private TransferMap paramMap = new TransferMap();

	// 전송ID
	public String getTransId() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_TRANS_ID));
	}

	public void setTransId(String transid) {
		this.paramMap.put(Consistent.IF_PARAMETER_TRANS_ID, transid);
	}

	public String getCompanyCode() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_COMPANY_CODE));
	}

	public void setCompanyCode(String ifParameterCompanyCode) {
		this.paramMap.put(Consistent.IF_PARAMETER_COMPANY_CODE, ifParameterCompanyCode);
	}

	public String getFromDate() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_FROM_DATE));
	}

	public void setFromDate(String ifParameterFromDate) {
		this.paramMap.put(Consistent.IF_PARAMETER_FROM_DATE, ifParameterFromDate);
	}

	public String getToDate() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_TO_DATE));
	}

	public void setToDate(String ifParameterToDate) {
		this.paramMap.put(Consistent.IF_PARAMETER_TO_DATE, ifParameterToDate);
	}

	public String getDivisionCode() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_DIVISION_CODE));
	}

	public void setDivisionCode(String ifParameterDivisionCode) {
		this.paramMap.put(Consistent.IF_PARAMETER_DIVISION_CODE, ifParameterDivisionCode);
	}

	public String getIfCode() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_IF_CODE));
	}

	public void setIfCode(String ifParameterIfCode) {
		this.paramMap.put(Consistent.IF_PARAMETER_IF_CODE, ifParameterIfCode);
	}

	public String getItemCode() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_ITEM_CODE));
	}

	public void setItemCode(String ifParameterItemCode) {
		this.paramMap.put(Consistent.IF_PARAMETER_ITEM_CODE, ifParameterItemCode);
	}

	public String getBatchFlag() {
		return StringUtil.null2String(paramMap.get(Consistent.IF_PARAMETER_BATCH_FLAG));
	}

	public void setBatchFlag(String ifParameterBatchFlag) {
		this.paramMap.put(Consistent.IF_PARAMETER_BATCH_FLAG, ifParameterBatchFlag);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setPutAll(Map map) {
		this.paramMap.putAll(map);
	}

	@SuppressWarnings("rawtypes")
	public Map getMap() {
		return ((TransferMap) this.paramMap).getMap();
	}

	public String toString() {
		StringBuilder buf = new StringBuilder();

		if (!StringUtil.isNull(this.getTransId()))
			buf.append(" Transaction Number=" + this.getTransId());
		if (!StringUtil.isNull(this.getIfCode()))
			buf.append(" Batch ID=" + this.getIfCode());
		if (!StringUtil.isNull(this.getCompanyCode()))
			buf.append(" Company Code=" + this.getCompanyCode());
		if (!StringUtil.isNull(this.getDivisionCode()))
			buf.append(" Division Code=" + this.getDivisionCode());
		if (!StringUtil.isNull(this.getItemCode()))
			buf.append(" Product Code=" + this.getItemCode());
		if (!StringUtil.isNull(this.getFromDate()))
			buf.append(" From Date=" + this.getFromDate());
		if (!StringUtil.isNull(this.getToDate()))
			buf.append(" To Date=" + this.getToDate());

		return buf.toString();
	}

	public void clear() {
		this.paramMap.clear();
	}
}
