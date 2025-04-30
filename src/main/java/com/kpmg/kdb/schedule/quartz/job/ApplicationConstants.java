package com.kpmg.kdb.schedule.quartz.job;

import java.net.InetAddress;

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.util.SystemHelper;

public class ApplicationConstants {

	public static String SERVER_HOST_ADDRESS; // 네트워크 서버 IP
	public static String SERVER_HOST_NAME; // 네트워크 서버명

	public static final String PROPERTIES_PREFIX_NAME = "_resource";

	public static String SERVLET_CONTEXT_PATH;
	public static String APPLICATION_REAL_PATH;
	public static String APPLICATION_CONTEXT_CHARSET;
	public static String APPLICATION_FILE_ENCODING;
	public static String APPLICATION_LEVEL;
	public static String APPLICATION_TIME_NATION;

	public static float GARBAGE_COLLECTION_LIMIT_RATE = 99;
	public static final Integer NULL = 0;

	public static String DEFAULT_LANGUAGE = "ENG";

	public static final String DUMMY = "DUMMY";
	public static final String ERROR_YN = "ERROR_YN";
	public static final String ERROR_MESSAGE = "ERROR_MESSAGE";

	// 세션Key
	public static final String SESSION_KEY = "_MEMBER";

	// 세션정보(내부사용자)
	public static final String KEY_COMPANY_ID = "COMPANY_ID";
	public static final String KEY_COMPANY_CODE = "COMPANY_CODE";
	public static final String KEY_COMPANY_NAME = "COMPANY_NAME";
	public static final String KEY_DEFAULT_LANGUAGE = "DEFAULT_LANGUAGE";
	public static final String KEY_USER_ID = "USER_ID";
	public static final String KEY_USER_INFO_ID = "USER_INFO_ID";
	public static final String KEY_USER_NAME = "USER_NAME";
	public static final String KEY_DEPT_NAME = "DEPT_NAME";
	public static final String KEY_PU_NAME = "PU_NAME";
	public static final String KEY_PU_CODE = "PU_CODE";
	public static final String KEY_FAMILY_CODE = "FAMILY_CODE"; // LGD추가

	// 엑셀 사이즈 관련 변수
	public static int EXCEL_MAX_ROWS = 10000;
	public static int EXCEL_SHEET_ROWS = 1000;

	// 데이터베이스 배치 크기
	public static int DB_BATCH_SIZE = 2000;

	// 파일 업로드 최대 크기
	public static long FILE_MAX_UPLOAD_SIZE = 5000000; //(5MB)
	// 파일 메모리 최대 저장용량
	public static int FILE_MAX_MEMORY_SIZE = 5000000; //(5MB)

	static {
		configure();
	}

	public static void configure() {
		try {
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator();

			APPLICATION_REAL_PATH = configurator.getString("application.path");
			APPLICATION_CONTEXT_CHARSET = StringUtil.null2String(configurator.getString("application.context.charset"), "utf-8");
			DEFAULT_LANGUAGE = StringUtil.null2String(configurator.getString("application.context.language"), DEFAULT_LANGUAGE);
			APPLICATION_FILE_ENCODING = StringUtil.null2String(configurator.getString("application.file.encoding"));
			APPLICATION_LEVEL = StringUtil.null2String(configurator.getString("application.level"), "O");
			APPLICATION_TIME_NATION = StringUtil.null2String(configurator.getString("application.time.nation"), "KOR");

			String heapGcSize = StringUtil.null2String(configurator.getString("system.gc.rate"));
			String excelMaxRow = StringUtil.null2String(configurator.getString("biz.excel.max.rows"));
			String excelSheetRow = StringUtil.null2String(configurator.getString("biz.excel.sheet.rows"));
			String maxUploadSize = StringUtil.null2String(configurator.getString("file.max.upload.size"));
			String maxMemorySize = StringUtil.null2String(configurator.getString("file.max.memory.size"));

			if (!excelMaxRow.isEmpty())
				EXCEL_MAX_ROWS = Integer.parseInt(excelMaxRow);
			if (!excelSheetRow.isEmpty())
				EXCEL_SHEET_ROWS = Integer.parseInt(excelSheetRow);
			if (!maxUploadSize.isEmpty())
				FILE_MAX_UPLOAD_SIZE = Long.parseLong(maxUploadSize);
			if (!maxMemorySize.isEmpty())
				FILE_MAX_MEMORY_SIZE = Integer.parseInt(maxMemorySize);
			if (!heapGcSize.isEmpty())
				GARBAGE_COLLECTION_LIMIT_RATE = StringUtil.null2float(configurator.getString("system.gc.rate"));

			InetAddress inet = InetAddress.getLocalHost();

			SERVER_HOST_ADDRESS = inet.getHostAddress();
			SERVER_HOST_NAME = inet.getHostAddress();

			DB_BATCH_SIZE = StringUtil.null2zero(configurator.getString("db.batch.size"), DB_BATCH_SIZE);

			if (!APPLICATION_FILE_ENCODING.isEmpty())
				SystemHelper.setSystemProperty("file.encoding", APPLICATION_FILE_ENCODING);
		} catch (Exception exp) {
			// exp.printStackTrace();
		}
	}
}