package com.kpmg.kdb.schedule.quartz.job.vo;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kpmg.kdb.schedule.quartz.job.collection.TransferMap;
import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.util.StringUtil;

public class BatchJobValueObject {

	private static Log log = LogFactory.getLog(BatchJobValueObject.class);

	private TransferMap batchMap = new TransferMap();

	// 배치 시 하나의 파라메터를 포함할 수 있음.
	private ParameterVo parameterVo;

	// 인터페이스코드
	public String getInterfaceCode() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_INTERFACE_CODE));
	}

	public void setInterfaceCode(String interfacecode) {
		this.batchMap.put(Consistent.IF_BATCH_INTERFACE_CODE, interfacecode);
	}

	// 우선 실행해야 할 인터페이스 코드
	public String getParentCode() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_PARENT_CODE));
	}

	public void setParentCode(String parentcode) {
		this.batchMap.put(Consistent.IF_BATCH_PARENT_CODE, parentcode);
	}

	// 우선 실행해야 할 인터페이스 코드
	public String getItemType() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_ITEM_TYPE));
	}

	public void setItemType(String type) {
		this.batchMap.put(Consistent.IF_BATCH_ITEM_TYPE, type);
	}

	// 인터페이스 필수 실행여부
	public String getRequired() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_REQUIRED));
	}

	public void setRequired(String required) {
		this.batchMap.put(Consistent.IF_BATCH_REQUIRED, required);
	}

	// 인터페이스 방식
	public String getInterfaceMethod() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_INTERFACE_METHOD));
	}

	public void setInterfaceMethod(String interfacemethod) {
		this.batchMap.put(Consistent.IF_BATCH_INTERFACE_METHOD, interfacemethod);
	}

	// 컬럼 전송유형(I:Input , O:Output)
	public String getColumnTransType() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TRANS_TYPE));
	}

	public void setColumnTransType(String columntranstype) {
		this.batchMap.put(Consistent.IF_BATCH_TRANS_TYPE, columntranstype);
	}

	// XML - JCO ID
	public String getJcoId() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_JCO_ID));
	}

	public void setJcoId(String jcoid) {
		this.batchMap.put(Consistent.IF_BATCH_JCO_ID, jcoid);
	}

	// 수행할 function 명
	public String getFunctionName() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_FUNCTION_NAME));
	}

	public void setFunctionName(String functionName) {
		this.batchMap.put(Consistent.IF_BATCH_FUNCTION_NAME, functionName);
	}

	// 파라메터
	public String getInterfaceParam() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_INTERFACE_PARAM));
	}

	public void setInterfaceParam(String param) {
		this.batchMap.put(Consistent.IF_BATCH_INTERFACE_PARAM, param);
	}

	// 전송ID
	public String getTransId() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TRANS_ID));
	}

	public void setTransId(String transid) {
		this.batchMap.put(Consistent.IF_BATCH_TRANS_ID, transid);
	}

	// 그룹핑 ID
	public String getInterfaceId() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_INTERFACE_ID));
	}

	public void setInterfaceId(String interfaceId) {
		this.batchMap.put(Consistent.IF_BATCH_INTERFACE_ID, interfaceId);
	}

	// 배치상태
	public String getBatchStatus() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_BATCH_STATUS));
	}

	public void setBatchStatus(String batchStatus) {
		this.batchMap.put(Consistent.IF_BATCH_BATCH_STATUS, batchStatus);
	}

	// 데이터 수신상태
	public String getTransStatus() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TRANS_STATUS));
	}

	public void setTransStatus(String transStatus) {
		this.batchMap.put(Consistent.IF_BATCH_TRANS_STATUS, transStatus);
	}

	// row 수
	public String getTotalRows() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TOTAL_ROWS));
	}

	public void setTotalRows(String totalrows) {
		this.batchMap.put(Consistent.IF_BATCH_TOTAL_ROWS, totalrows);
	}

	// 에러메시지
	public String getErrorMessage() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_ERROR_MESSAGE));
	}

	public void setErrorMessage(String errormessage) {
		this.batchMap.put(Consistent.IF_BATCH_ERROR_MESSAGE, errormessage);
	}

	// row off set
	public String getOffset() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_OFFSET));
	}

	public void setOffset(String offset) {
		this.batchMap.put(Consistent.IF_BATCH_OFFSET, offset);
	}

	// 1회 조회할 최대 row 수
	public String getMaxRows() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_MAX_ROWS));
	}

	public void setMaxRows(String rows) {
		this.batchMap.put(Consistent.IF_BATCH_MAX_ROWS, rows);
	}

	// 소스 테이블명
	public String getSourceTable() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_SOURCE_TABLE));
	}

	public void setSourceTable(String sourceTable) {
		this.batchMap.put(Consistent.IF_BATCH_SOURCE_TABLE, sourceTable);
	}

	// 대상 테이블 명
	public String getTargetTable() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TARGET_TABLE));
	}

	public void setTargetTable(String targetTable) {
		this.batchMap.put(Consistent.IF_BATCH_TARGET_TABLE, targetTable);
	}

	// 임시 테이블 명 ex) INTG_INTERFACE_TRANS_DTL HISTORY_TABLE
	public String getHistoyTable() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_HISTORY_TABLE));
	}

	public void setHistoyTable(String historyTable) {
		this.batchMap.put(Consistent.IF_BATCH_HISTORY_TABLE, historyTable);
	}

	// 이관프로그램명
	public String getTransProgramName() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_TRANS_PROGRAM_NAME));
	}

	public void setTransProgramName(String transprogramname) {
		this.batchMap.put(Consistent.IF_BATCH_HISTORY_TABLE, transprogramname);
	}

	// 실행 Procedure 명 IF_BATCH_PROCEDURE_ID
	public String getProcedureId() {
		return StringUtil.null2String(batchMap.get(Consistent.IF_BATCH_PROCEDURE_ID));
	}

	public void setProcedureId(String procedureid) {
		this.batchMap.put(Consistent.IF_BATCH_PROCEDURE_ID, procedureid);
	}

	// 파라메터 map 정보
	public ParameterVo getParameter() {
		return this.parameterVo;
	}

	public void setParameter(ParameterVo paramVo) {
		this.parameterVo = paramVo;

		if (log.isDebugEnabled()) {
			log.debug("batch excute parameter : " + paramVo.toString());
		}

		this.setInterfaceParam(paramVo.toString());
	}

	@SuppressWarnings("rawtypes")
	public void setJobInfo(Map map) {
		this.batchMap.put(Consistent.IF_JOB_COMPANY_CODE, map.get(Consistent.IF_JOB_COMPANY_CODE));
		this.batchMap.put(Consistent.IF_JOB_SCHEDULE_CODE, map.get(Consistent.IF_JOB_SCHEDULE_CODE));
		this.batchMap.put(Consistent.IF_JOB_CREATE_BY, map.get(Consistent.IF_JOB_CREATE_BY));
		this.batchMap.put(Consistent.IF_JOB_UPDATE_BY, map.get(Consistent.IF_JOB_UPDATE_BY));
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void setPutAll(Map map) {
		this.batchMap.putAll(map);
	}

	@SuppressWarnings("rawtypes")
	public Map getMap() {
		return ((TransferMap) this.batchMap).getMap();
	}

	public String toString() {
		return "Batch Info [" + this.batchMap.getMap() + "]";
	}

	public void clear() {
		this.batchMap.clear();
	}

}
