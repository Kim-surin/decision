package com.kpmg.kdb.core.common.helper;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;

import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.ui.ModelMap;

import com.kpmg.kdb.configuration.DatasourceConfiguration;
import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.ReportsPrintView;
import com.kpmg.kdb.util.StringUtil;


/**
 * iReport 출력을 위한 DB작업을 도와주는 클래스
 * 
 */
public class ReportPrintHelper {
	private static Log log = LogFactory.getLog(ReportPrintHelper.class);
	

	
	/**
	 * JasperPrint의 집합을 가지는 List객체를 반환한다.
	 * 
	 * @param reportNames jasper파일들
	 * @param parameter 파라에터
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<JasperPrint> getJasperPrintList(Map dataMap, ModelMap parameter) throws Exception {
		Connection conn = null;
		List jasperPrintList = null;
		int idx = 0;
		
		try {
			conn = this.getConnection();
			
			jasperPrintList = new ArrayList();
			
			String scope = StringUtil.null2String(dataMap.get("DECLARATION_SCOPE"));
			String reportNames = StringUtil.null2String(dataMap.get("FORM_FILE_NAME"));
			String version = StringUtil.null2String(dataMap.get("VERSION"));
			StringTokenizer st = new StringTokenizer(reportNames, "^");
			
			while(st.hasMoreTokens()) {
				String reportName = StringUtil.null2String(st.nextToken());
				if(!reportName.isEmpty() && "Y".equals(reportName)) {
					boolean cont = true;
					String fileName = version;
					
					// 제품목록은 선언범위가 제품인 경우에만 적용됨.
					if(fileName.startsWith("eicc_template_product_list")) {
						if(!scope.equals("D")) {
							cont = false;
						}
					}
					
					if(cont) {
						if(log.isDebugEnabled()) {log.debug("file name = " + fileName + ", parameter = " + parameter + ", connector = " + conn);}
						
						// DB Connection을 맺고 bind 파라메터를 넘겨 쿼리 수행 후 결과를 JasperPrint에 담는다. 
						JasperPrint jasper = this.getJasperPrint(fileName, parameter, conn);
						
						// 처리 결과를 담고 있는 JasperPrint객체를 리스트에 담는다.
						jasperPrintList.add(jasper);
					}
				}
				
				idx++;
			}
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			this.closeConnection(conn);
		}
		
		return jasperPrintList;
	}

	/**
	 * JasperPrint의 집합을 가지는 List객체를 반환한다.
	 * 
	 * @param reportNames jasper파일들
	 * @param parameter 파라에터
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<JasperPrint> getJasperPrintOfList(Map dataMap, ModelMap parameter) throws Exception {
		Connection conn = null;
		List jasperPrintList = null;
		
		try {
			conn = this.getConnection();
			
			jasperPrintList = new ArrayList();
			String reportName = StringUtil.null2String(dataMap.get("P_FILE_NAME"));
			if(log.isDebugEnabled()) {log.debug("file name = " + reportName + ", parameter = " + parameter + ", connector = " + conn);}
			
			// DB Connection을 맺고 bind 파라메터를 넘겨 쿼리 수행 후 결과를 JasperPrint에 담는다. 
			JasperPrint jasper = this.getJasperPrint(reportName, parameter, conn);
			
			// 처리 결과를 담고 있는 JasperPrint객체를 리스트에 담는다.
			jasperPrintList.add(jasper);

		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			this.closeConnection(conn);
		}
		
		return jasperPrintList;
	}
	
	/**
	 * Jasper가 실행한 결과를 가지는 JasperPrint 객체를 반환한다.
	 * 
	 * @param reportName jasper파일명
	 * @param parameter 파라에터
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	private JasperPrint getJasperPrint(String reportName, ModelMap parameter, Connection conn) {
		
		
		Properties p = new Properties();
		JasperPrint jasper = null;
		try {
	        InputStream is = getClass().getClassLoader().getResourceAsStream("config/appFileAndJasper.properties");

	        p.load(is);
	        is.close();
	        

			String jasperPath = p.getProperty("thirdparty.print.jasper.dir");
			
			
			
			log.debug("jasper file name : " + jasperPath + reportName);
			
			// jasper파일이 존재하는지 체크하고 존재하면 Report객체를 얻는다.
			//File compiledFile = new File(jasperPath + reportName + REPORT_PREFIX_NAME);
			File compiledFile = new File(jasperPath + reportName);
			
			if (!compiledFile.exists()) {
				throw new Exception("Jasper File not Found : " + jasperPath + reportName);
			} else {
				if(log.isDebugEnabled()) {log.debug("jasper file name : " + jasperPath + reportName);}
			}
			log.debug("#######compiledFile.getPath() : " + compiledFile.getPath());
			JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(compiledFile.getPath()); 
			log.debug("JasperReport jasperReport ok");
			// DB Connection을 맺고 bind 파라메터를 넘겨 쿼리 수행 후 결과를 JasperPrint에 담는다. 
			jasper = JasperFillManager.fillReport(jasperReport, parameter, conn);
			log.debug("jJasperPrint jasper ok ");
		}
		catch(java.io.IOException ie) {
			log.error("executeInternal not found isc.properties \n{}", ie);
			ie.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return jasper;
	}
	
	/**
	 * JasperPrint의 집합을 가지는 List객체를 반환한다.
	 * 
	 * @param reportNames jasper파일들
	 * @param parameter 파라에터
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getJasperPrintOfCooList(Map dataMap, ModelMap parameter) throws Exception {
		Connection conn = null;
		List jasperPrintList = null;
		int idx = 0;
		
		try {
			conn = this.getConnection();
			
			jasperPrintList = new ArrayList();
			
			String reportNames = StringUtil.null2String(dataMap.get("FORM_FILE_NAME"));
			StringTokenizer st = new StringTokenizer(reportNames, "^");
			
			while(st.hasMoreTokens()) {
				String reportName = st.nextToken();
				if(!"N".equals(reportName)) {

					if(log.isDebugEnabled()) {log.debug("file name = " + reportName + ", parameter = " + parameter + ", connector = " + conn);}
					
					// DB Connection을 맺고 bind 파라메터를 넘겨 쿼리 수행 후 결과를 JasperPrint에 담는다. 
					JasperPrint jasper = this.getJasperPrint(reportName, parameter, conn);
					
					// 처리 결과를 담고 있는 JasperPrint객체를 리스트에 담는다.
					jasperPrintList.add(jasper);

				}
				
				idx++;
			}
		}catch(Exception e){
			e.printStackTrace();
		} finally {
			this.closeConnection(conn);
		}
		
		return jasperPrintList;
	}	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<JasperPrint> getJasperPrintList(ModelMap parameter) throws Exception {
		Connection conn = null;
		List jasperPrintList = null;
		
		try {
			conn = this.getConnection();
			
			jasperPrintList = new ArrayList();
			String reportName = StringUtil.null2String(parameter.get("P_FILE_NAME"));
			if(log.isDebugEnabled()) {log.debug("file name = " + reportName + ", parameter = " + parameter + ", connector = " + conn);}
			
			// DB Connection을 맺고 bind 파라메터를 넘겨 쿼리 수행 후 결과를 JasperPrint에 담는다. 
			JasperPrint jasper = this.getJasperPrint(reportName, parameter, conn);
			
			// 처리 결과를 담고 있는 JasperPrint객체를 리스트에 담는다.
			jasperPrintList.add(jasper);

		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			this.closeConnection(conn);
		}
		
		return jasperPrintList;
	}	
	/**
	 * iReport 생성, OutputStream 생성 ==> BLOB 등록 시 사용
	 * 
	 * @param req
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ReportsPrintView getJasperPrintOutputStream(ModelMap parameter)  throws Exception { 

		ReportPrintHelper operator = new ReportPrintHelper();
		ByteArrayOutputStream bops = null;
		ReportsPrintView view = new ReportsPrintView();
			
		
		try {
			List jasList = operator.getJasperPrintList(parameter);
			
			// export설정
			Map exportParameter = new HashMap();
			
			bops = new ByteArrayOutputStream();
			
			exportParameter.put(JRExporterParameter.OUTPUT_STREAM, bops);
			exportParameter.put(JRExporterParameter.JASPER_PRINT_LIST, jasList);
			
			view.setExportParameter(exportParameter);
			view.setReportOutputType(StringUtil.null2String(parameter.get("REPORT_TYPE")));
			
			// export 생성
			view.createExporter();
			
		} catch(Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			if(bops != null) bops.close();
		}
		
		return view;
	}
	

	
	/**
	 * DB컨넥션 후 Connection객체를 반환한다.
	 * @return
	 * @throws SQLException
	 */
	private Connection getConnection() throws Exception{

		ApplicationContext ctx = ApplicationContextAwareExtends.getApplicationContext();
		DataSource dataSource =  ctx.getBean(DatasourceConfiguration.class).dataSource();
		
		return dataSource.getConnection();
	}
	
	/**
	 * DB컨넥션 연결을 종료시킨다.
	 * @throws SQLException
	 */
	private void closeConnection(Connection conn) throws SQLException {
		if(conn != null) {
			conn.close();
		}
	}
}
