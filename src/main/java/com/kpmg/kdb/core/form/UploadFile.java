package com.kpmg.kdb.core.form;

import java.util.Map;
import java.math.BigDecimal;

/**
 * 저장된 파일 정보
 * 
 * @author 	Damned Cat
 */
public class UploadFile {
/*
	FILE_SEQ	NUMBER
	WORK_TYPE	VARCHAR2(10 BYTE)
	WORK_KEY	NUMBER
	WORK_FILE_SEQ	NUMBER
	ORG_FILE_NAME	VARCHAR2(255 BYTE)
	FILE_NAME	VARCHAR2(255 BYTE)
	FILE_SIZE	NUMBER
	FILE_PATH	VARCHAR2(500 BYTE)
 */
	private int fileSeq;
	
	private String workType;
	
	private int workKey;
	
	private int workFileSeq;
	
	private String orgFileName;
	
	private String fileName;
	
	private int fileSize;
	
	private String filePath;

	private String insertId;

	/**
	 * 맵정보 저장된 파일 정보를 추출하여 값을 설정함
	 * 
	 * @param	param	파일정보 맵
	 */
	public void setValues(Map param) {
		//FILE_SEQ, WORK_TYPE, WORK_KEY, WORK_FILE_SEQ, ORG_FILE_NAME, FILE_NAME, FILE_SIZE, FILE_PATH
		this.fileSeq = _get_int(param, "FILE_SEQ", 0);
		this.workKey = _get_int(param, "WORK_KEY", 0);
		this.workFileSeq = _get_int(param, "WORK_FILE_SEQ", 0);
		this.fileSize = _get_int(param, "FILE_SIZE", 0);

		this.workType = (String)param.get("WORK_TYPE");
		this.orgFileName = (String)param.get("ORG_FILE_NAME");
		this.fileName = (String)param.get("FILE_NAME");
		this.filePath = (String)param.get("FILE_PATH");
	}
	
	
	public int getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public int getWorkKey() {
		return workKey;
	}

	public void setWorkKey(int workKey) {
		this.workKey = workKey;
	}

	public int getWorkFileSeq() {
		return workFileSeq;
	}

	public void setWorkFileSeq(int workFileSeq) {
		this.workFileSeq = workFileSeq;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	
	public String getInsertId() {
		return insertId;
	}
	public void setInsertId(String insertId) {
		this.insertId = insertId;
	}


	@Override
	public String toString() {
		return "UploadFile [fileSeq=" + fileSeq + ", workType=" + workType
				+ ", workKey=" + workKey + ", workFileSeq=" + workFileSeq
				+ ", orgFileName=" + orgFileName + ", fileName=" + fileName
				+ ", fileSize=" + fileSize + ", filePath=" + filePath
				+ ", insertId=" + insertId + "]";
	}

	/**
	 * 정수로 반환
	 * @param param
	 * @param key
	 * @param defaultVal
	 * @return
	 */
	public static int _get_int(Map param, String key, int defaultVal) {
		if (null==param || null==key) {
			return defaultVal;
		}
		Object val = param.get(key);
		if (null==val) {
			return defaultVal;
		}

		int intVal = 0;
		
		if ( val instanceof Integer ) {
			intVal = ((Integer)val).intValue();
		}
		else if ( val instanceof Long ) {
			intVal = ((Long)val).intValue();
		}
		else if ( val instanceof BigDecimal ) {
			intVal = ((BigDecimal)val).intValue();
		}
		else {
			intVal = defaultVal;
		}
		return intVal;
	}
}
