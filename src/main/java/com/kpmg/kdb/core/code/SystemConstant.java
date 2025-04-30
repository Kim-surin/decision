package com.kpmg.kdb.core.code;

import java.net.InetAddress;

import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.util.SystemHelper;

/**
 * ����� ���� Ŭ����
 * 
 * @author  Damned Cat
 * @since   2016-08-01
 */
public class SystemConstant {

    /**
     * 시스템 설정 변수
     */
    public static class session {
        /** 사용자 세션  */
        public static final String USER_SESSION_KEY = "_sessionUser";

        
        public static final String AUTH_LIST_SESSION_KEY = "_AUTH_LIST_";

        /* 세션 라이프 타임*/
        public static final int SESSION_TIMEOUT_SECOND = 30 * 60;
    }


    /**
     * ���Ͼ��ε� ���� �����
     */
    public static class upload {
        /** ���Ͼ��ε� ����Ʈ ���丮(�������� C: ����̺�) */
        public static final String UPLOAD_BASE_DIR = "/upload";
    }
    
    
    public static String SERVER_HOST_ADDRESS; // ��Ʈ��ũ ���� IP
	public static String SERVER_HOST_NAME; // ��Ʈ��ũ ������

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

	// ���� ������ ���� ����
	public static int EXCEL_MAX_ROWS = 10000;
	public static int EXCEL_SHEET_ROWS = 1000;

	// �����ͺ��̽� ��ġ ũ��
	public static int DB_BATCH_SIZE = 2000;

	// ���� ���ε� �ִ� ũ��
	public static long FILE_MAX_UPLOAD_SIZE = 5000000; //(5MB)
	// ���� �޸� �ִ� ����뷮
	public static int FILE_MAX_MEMORY_SIZE = 5000000; //(5MB)
	
	public static String EAI_ADDRESS_IP;
	

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

			EAI_ADDRESS_IP = StringUtil.null2String(configurator.getString("eai.call.address"));
			
			if (!APPLICATION_FILE_ENCODING.isEmpty())
				SystemHelper.setSystemProperty("file.encoding", APPLICATION_FILE_ENCODING);
		} catch (Exception exp) {
			// exp.printStackTrace();
		}
	}

    

}

