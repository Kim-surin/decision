package com.kpmg.kdb.schedule.quartz.job.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kpmg.kdb.schedule.quartz.job.collection.TransferMap;
import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.util.StringUtil;

public class TransferJobValueObject {
	private static Log log = LogFactory.getLog(TransferJobValueObject.class);

	private TransferMap transMap = new TransferMap();

	// 수행된 배치 항목을 가지는 List
	private List<BatchJobValueObject> batchList = new ArrayList<BatchJobValueObject>();

	private TransferBatchLogger batchLogger; // 배치내용을 파일로 기록하기 위한 로그 클래스

	public String getCompanyCode() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_COMPANY_CODE));
	}

	public void setCompanyCode(String ifJobCompanyCode) {
		this.transMap.put(Consistent.IF_JOB_COMPANY_CODE, ifJobCompanyCode);
	}

	public String getScheduleCode() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_SCHEDULE_CODE));
	}

	public void setScheduleCode(String ifJobScheduleCode) {
		this.transMap.put(Consistent.IF_JOB_SCHEDULE_CODE, ifJobScheduleCode);
	}

	public String getCreateBy() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_CREATE_BY));
	}

	public void setCreateBy(String ifJobCreateBy) {
		this.transMap.put(Consistent.IF_JOB_CREATE_BY, ifJobCreateBy);
	}

	public String getUpdateBy() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_UPDATE_BY));
	}

	public void setUpdateBy(String ifJobUpdateBy) {
		this.transMap.put(Consistent.IF_JOB_UPDATE_BY, ifJobUpdateBy);
	}

	public String getPyyyymm() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_YYYYMM));
	}

	public void setPyyyymm(String yyyymm) {
		this.transMap.put(Consistent.IF_JOB_YYYYMM, yyyymm);
	}

	public String getAliasScheduleCode() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_ALIAS_SCHEDULE_CODE));
	}

	public void setAliasScheduleCode(String ifJobAliasScheduleCode) {
		this.transMap.put(Consistent.IF_JOB_ALIAS_SCHEDULE_CODE, ifJobAliasScheduleCode);
	}

	public String getStatus() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_STATUS));
	}

	public void setStatus(String ifJobStatus) {
		this.transMap.put(Consistent.IF_JOB_STATUS, ifJobStatus);
	}

	public String getIfCode() {
		return StringUtil.null2String(transMap.get(Consistent.IF_PARAMETER_IF_CODE));
	}

	public void setIfCode(String ifCode) {
		this.transMap.put(Consistent.IF_PARAMETER_IF_CODE, ifCode);
	}

	public String getScheduleType() {
		return StringUtil.null2String(transMap.get(Consistent.IF_JOB_SCHEDULE_TYPE));
	}

	public void setScheduleType(String ScheduleType) {
		this.transMap.put(Consistent.IF_JOB_SCHEDULE_TYPE, ScheduleType);
	}

	public TransferBatchLogger getBatchLogger() {
		return batchLogger;
	}

	public void setBatchLogger(TransferBatchLogger batchLogger) {
		this.batchLogger = batchLogger;
	}

	@SuppressWarnings("rawtypes")
	public Map getMap() {
		return ((TransferMap) this.transMap).getMap();
	}

	public String toString() {
		return "Job Info [" + this.transMap.getMap() + "]";
	}

	public void setBatchList(int idx, BatchJobValueObject vo) {
		this.batchList.add(idx, vo);
		if (log.isDebugEnabled())
			log.debug("batch item count = " + this.batchList.size());
	}

	public List<BatchJobValueObject> getBatchList() {
		return this.batchList;
	}

	public int getBatchVoSize() {
		return this.batchList.size();
	}
}
