package com.kpmg.kdb.web.drawbackdoc;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.FileUtil;
import com.kpmg.kdb.util.StringUtil;



/**
 * Unipas 송/수신 문서 관련 Class
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class DrawbackDocService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(DrawbackDocService.class);
    
    /**
     * 유니패스 수신
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result unipassReceiveData(Map<String, Object> param) throws Exception {
    	Result rs = new Result();
    	List<File> dirList = null;
    	Map<String, Object> xmlMap = new HashMap();
    	try {
    		String formType = ""; // 제출문서 구분 값
    		
    		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator("app_resource");
			String workPath = configurator.getString("file.xml.dir");
    		String sendPath = configurator.getString("file.sendxml.dir");
    		String receivePath = configurator.getString("file.xmlreceive.dir");
    		String backupPath = configurator.getString("file.xmlbackup.dir");
    		String basePath = configurator.getString("file.xml.dir");
    		
    		String outputFolder = basePath +  sendPath;
    		String receiveFolder = basePath +  receivePath;
    		String backupFolder = backupPath;
    		
    		
    		File dir = new File(receiveFolder);
			if (dir.exists()) {// 디렉토리가 존재한다면
				File[] files = dir.listFiles();// 파일 목록을 구함
				dirList = Arrays.asList(files);// 파일 배열을 파일 리스트로 변화함
			}
			
			String fileName = "";
			// 폴더의 사이즈만큼 돌면서 파일을 처리한다.
			for (int inx = 0; inx < dirList.size(); inx++) {
				fileName = dirList.get(inx).getName();
				
				if(!fileName.endsWith(".xml")){ // xml 파일이 아니면 next
					continue;
				}
				SAXBuilder builder = new SAXBuilder();
				Document jdomdoc = builder.build(new File(receiveFolder + "/"+ fileName));
				
				// get root element 
				Element root = jdomdoc.getRootElement();
				
				// get children element
				List<Element> elements = root.getChildren();
				String target_Regist_rcept_no = "";
				 
				if(fileName.endsWith("GOVCBR5DV.xml")) {  // 	통보 - 분할 증명서
					logger.debug("양수자통보 - 분할 증명서");
					xmlMap = parsingXml_For_GOVCBR5DV(elements);
					xmlMap.putAll(param);
					
					String ctrmYn = sqlSession.getMapper(DrawbackDocDao.class).checkDuplicateCtrm(xmlMap);
					
					if("Y".equalsIgnoreCase(ctrmYn)) {
						//기납증 / 분증 - <갑> 정보 저장
						sqlSession.getMapper(DrawbackDocDao.class).merge_An_Ctrm_Cmmn(xmlMap);
						target_Regist_rcept_no = StringUtil.null2String(xmlMap.get("REGIST_RCEPT_NO"));
						//Detail Table insert
						List<Map<String,String>> an_an_ctrm_thing_rawmtrl = (List)xmlMap.get("GOODS_SHIPMENT");
						for(int iinx = 0; iinx < an_an_ctrm_thing_rawmtrl.size(); iinx++) {
							Map rowMap = an_an_ctrm_thing_rawmtrl.get(iinx);
							Map workMap = new HashMap<String, Object>();
							workMap.putAll(xmlMap);
							workMap.putAll(rowMap);
							workMap.remove("GOODS_SHIPMENT");
							//기존  데이터가 있다면 기존 오류 상세 목록 제거 
							sqlSession.getMapper(DrawbackDocDao.class).delete_An_Ctrm_Thing_Rawmtrl(workMap);
						}
						
						for(int iinx = 0; iinx < an_an_ctrm_thing_rawmtrl.size(); iinx++) {
							Map rowMap = an_an_ctrm_thing_rawmtrl.get(iinx);
							// 상세 목록 생성
							Map workMap = new HashMap<String, Object>();
							workMap.putAll(xmlMap);
							workMap.putAll(rowMap);
							workMap.remove("GOODS_SHIPMENT");
							
							sqlSession.getMapper(DrawbackDocDao.class).insert_An_Ctrm_Thing_Rawmtrl(workMap);
						}
						param.put("REGIST_RCEPT_NO", target_Regist_rcept_no);
						/* 잔량테이블 이관 */
						// 원본 양수자 항목 MERGET
						param.put("ISSUE_TYPE", "04"); // 분증
						param.put("IF_YN", "N"); // 인터페이스 수행 안된 것
						param.put("RECV_DOC_TYPE", "'09'"); // 원본 대상
						sqlSession.getMapper(DrawbackDocDao.class).merge_IncmeLocalBntSm_for_04_09(param);

						//양수자 통보 잔량생성된 분증정보 상태값 update 
						sqlSession.getMapper(DrawbackDocDao.class).update_An_CtrmCmmn(param);
						
						//양수자 통보 양수자 통보 잔량생성 01-취하 / 35-정정
						sqlSession.getMapper(DrawbackDocDao.class).merge_IncmeLocalBntSm_for_04_01_35(param);
						
						//양수자 통보 잔량생성된 분증정보 상태값 update
						param.put("RECV_DOC_TYPE", "'01', '35'"); // 원본 대상
						sqlSession.getMapper(DrawbackDocDao.class).update_An_CtrmCmmn(param);
					}else {
						logger.debug("##############################################");
						logger.debug("###### 양수자통보 - 분할증명서 : 기등록된 분할증명서 입니다.");
						logger.debug("###### 접수번호 : " + xmlMap.get("REGIST_RCEPT_NO"));
						logger.debug("###### 제출번호 : " + xmlMap.get("SUBMIT_NO"));
						logger.debug("##############################################");
					}
					
				
					
				}else if(fileName.endsWith("GOVCBR5DU.xml")) { // 양수자통보 - 기초납입 증명서
					logger.debug("양수자통보 -기초납입 증명서");
					xmlMap = parsingXml_For_GOVCBR5DU(elements);
					xmlMap.putAll(param);
					
					String ctrmYn = sqlSession.getMapper(DrawbackDocDao.class).checkDuplicateCtrm(xmlMap);
					
					if("Y".equalsIgnoreCase(ctrmYn)) {
						//기납증 / 분증 - <갑> 정보 저장
						sqlSession.getMapper(DrawbackDocDao.class).merge_An_Ctrm_Cmmn(xmlMap);
						target_Regist_rcept_no = StringUtil.null2String(xmlMap.get("REGIST_RCEPT_NO"));
						
						//Detail Table insert
						List<Map<String,String>> an_ctrm_trget_thng = (List)xmlMap.get("GOODS_SHIPMENT");
						for(int iinx = 0; iinx < an_ctrm_trget_thng.size(); iinx++) {
							Map rowMap = an_ctrm_trget_thng.get(iinx);
							Map workMap = new HashMap<String, Object>();
							workMap.putAll(xmlMap);
							workMap.putAll(rowMap);
							workMap.remove("GOODS_SHIPMENT");
							//기존에 받은 데이터에 중복데이터가 있다면 삭제 후 
							sqlSession.getMapper(DrawbackDocDao.class).delete_An_Ctrm_Trget_Thng(workMap);
						}
						
						for(int iinx = 0; iinx < an_ctrm_trget_thng.size(); iinx++) {
							Map rowMap = an_ctrm_trget_thng.get(iinx);
							//상세 목록 생성
							Map workMap = new HashMap<String, Object>();
							workMap.putAll(xmlMap);
							workMap.putAll(rowMap);
							workMap.remove("GOODS_SHIPMENT");
							
							sqlSession.getMapper(DrawbackDocDao.class).insert_An_Ctrm_Trget_Thng(workMap);

						}
						param.put("REGIST_RCEPT_NO", target_Regist_rcept_no);
						/* 잔량테이블 이관 */
						// 원본 양수자 항목 MERGET
						param.put("ISSUE_TYPE", "02"); // 분증
						param.put("IF_YN", "N"); // 인터페이스 수행 안된 것
						param.put("RECV_DOC_TYPE", "'09'"); // 원본 대상
						sqlSession.getMapper(DrawbackDocDao.class).merge_IncmeLocalBntSm_for_02_09(param);

						//양수자 통보 잔량생성된 분증정보 상태값 update 
						sqlSession.getMapper(DrawbackDocDao.class).update_An_CtrmCmmn(param);
						
						
						//양수자 통보 양수자 통보 잔량생성 01-취하 / 35-정정
						sqlSession.getMapper(DrawbackDocDao.class).merge_IncmeLocalBntSm_for_02_01_35(param);
						
						//양수자 통보 잔량생성된 분증정보 상태값 update
						param.put("RECV_DOC_TYPE", "'01', '35'"); // 원본 대상
						sqlSession.getMapper(DrawbackDocDao.class).update_An_CtrmCmmn(param);
					}else {
						logger.debug("######################################################");
						logger.debug("###### 양수자통보 - 기초납입증명서 : 기등록된 기초납입증명서 입니다.");
						logger.debug("###### 접수번호 : " + xmlMap.get("REGIST_RCEPT_NO"));
						logger.debug("###### 제출번호 : " + xmlMap.get("SUBMIT_NO"));
						logger.debug("######################################################");
					}
					
					
				}else if(fileName.endsWith("GOVCBRR54.xml")) { // 환급신청서 - 접수통보
					logger.debug("접수통보");
					xmlMap = parsingXml_For_GOVCBRR54(elements);
					xmlMap.putAll(param);
					
					//xml 데이터 저장
					sqlSession.getMapper(DrawbackDocDao.class).merge_R54_Data(xmlMap);
					xmlMap.put("EXECUT_STATUS", "10");
					
					// 통보 후 제출문서 상태값 변경
					formType = StringUtil.null2String(xmlMap.get("FORM_TYPE"));
					this.setSubmitDocStatus(formType, xmlMap);
					
					
				}else if(fileName.endsWith("GOVCBR5DF.xml")) {// 환급 - 완료통보 50
					logger.debug("완료통보");
					xmlMap = parsingXml_For_GOVCBR5DF(elements);
					xmlMap.putAll(param);
					//xml 데이터 저장
					xmlMap.put("EXECUT_STATUS", "50");
					
					//xml 데이터 저장
					sqlSession.getMapper(DrawbackDocDao.class).merge_5DF_Data(xmlMap);
					formType = StringUtil.null2String(xmlMap.get("FORM_TYPE"));
					this.setSubmitDocStatus(formType, xmlMap);
					
					//각 문서에 맞게 상태값 수정
					
				}else if(fileName.endsWith("GOVCBR381.xml")) {// 환급 - 지급통보 60
					logger.debug("지급통보");
					xmlMap = parsingXml_For_GOVCBR381(elements);
					xmlMap.putAll(param);
					//xml 데이터 저장
					xmlMap.put("EXECUT_STATUS", "60");
					
					//지급 통보 데이터 생성
					sqlSession.getMapper(DrawbackDocDao.class).merge_381_Data(xmlMap);
					String payOrderNo = StringUtil.null2String(xmlMap.get("PAY_ORDER_NO"));
					
					if(payOrderNo.indexOf("K") > -1) {
						//가산금 지급 신청서 
						formType = "18"; 
								
					}else if(payOrderNo.indexOf("H") > -1) {
						//환급신청서
						formType = "10";
					}else {
						
					}
					this.setSubmitDocStatus(formType, xmlMap);
					
					
					//각 문서에 맞게 상태값 수정
					
				}else if(fileName.endsWith("GOVCBRR58.xml")) {// 환급 - 보완통보서 30
					logger.debug("보완통보서");
					xmlMap = parsingXml_For_GOVCBRR58(elements);
					//xml 데이터 저장
					xmlMap.put("EXECUT_STATUS", "30");
					xmlMap.putAll(param);
					// 보안통보서 테이블 만들고 저장하는 로직 만들어야함
					sqlSession.getMapper(DrawbackDocDao.class).merge_R58_Data(xmlMap);
					
					// 통보 후 제출문서 상태값 변경
					formType = StringUtil.null2String(xmlMap.get("FORM_TYPE"));
					this.setSubmitDocStatus(formType, xmlMap);
					
					
				}else if(fileName.endsWith("GOVCBRR57.xml")) {// 환급 - 환급 자료제출요구서 40
					logger.debug("자료제출요구서");
					xmlMap = parsingXml_For_GOVCBRR57(elements);
					xmlMap.putAll(param);
					
					//xml 데이터 저장
					xmlMap.put("EXECUT_STATUS", "40");
					
					//Master Table Merge
					sqlSession.getMapper(DrawbackDocDao.class).merge_R57_Data(xmlMap);
					
					//Detail Table insert
					List<Map<String,String>> docReqList = (List)xmlMap.get("GOODS_SHIPMENT");
					if(docReqList.size() > 0 ) {
						//기존  데이터가 있다면 기존 오류 상세 목록 제거 
						sqlSession.getMapper(DrawbackDocDao.class).delete_R57_DetailData(xmlMap);
					}
					for(int iinx = 0; iinx < docReqList.size(); iinx++) {
						Map rowMap = docReqList.get(iinx);
						//Error 상세 목록 생성
						rowMap.putAll(param);
						rowMap.remove("GOODS_SHIPMENT");
						rowMap.put("DRWB_REVIEW_DOC_NO", xmlMap.get("DRWB_REVIEW_DOC_NO"));
						
						sqlSession.getMapper(DrawbackDocDao.class).insert_R57_DetailData(rowMap);
						
						/* 자료 제출요구는 상세에 접수번호와 문서구분(환급/기납/분증) 값이 있어 상세 데이터 별로 각 업무테이블에 상태값을 업데이트 한다. */
						formType = rowMap.get("DRWB_DOC_TYPE")+"";
						this.setSubmitDocStatus(formType, rowMap);
						
					}
					
					
					//각 문서에 맞게 상태값 수정
					
				}else if(fileName.endsWith("GOVCBRR20.xml")) { // 오류통보 20
					logger.debug("오류통보");
					xmlMap = parsingXml_For_GOVCBRR20(elements);
					xmlMap.put("EXECUT_STATUS", "20");
					List<Map<String,String>> errorList = (List)xmlMap.get("ERROR_LIST");
					
					xmlMap.putAll(param);
					// Error 마스터 Merge
					sqlSession.getMapper(DrawbackDocDao.class).merge_R20_Data(xmlMap);
					
					if(errorList.size() > 0 ) {
						//Error  데이터가 있다면 기존 오류 상세 목록 제거 
						sqlSession.getMapper(DrawbackDocDao.class).delete_R20_DetailData(xmlMap);
					}
					// 상세 데이터 저장
					for(int iinx = 0; iinx < errorList.size(); iinx++) {
						Map rowMap = errorList.get(iinx);
						//Error 상세 목록 생성
						rowMap.putAll(xmlMap);
						rowMap.remove("ERROR_LIST");
						sqlSession.getMapper(DrawbackDocDao.class).insert_R20_DetailData(rowMap);
					}
					
					
					String targetDocCode = xmlMap.get("SUBMIT_STTEMNT_DOC_STLE")+"";
					if("GOVCBR5DA".equals(targetDocCode)) {
						// 환급신청서 오류 통보 처리 
						formType = "10";
						
					}else if("GOVCBR5DE".equals(targetDocCode) || "GOVCBR5DB".equals(targetDocCode)) {
						// 기납증 분증 오류 통보 처리
						formType = "20";
						
					}else if("GOVCBRDCC".equals(targetDocCode)) {
						//과다 환급금 자진 신고서
						formType = "82";
						// TO Do 
						
					}else if("GOVCBRDEX".equals(targetDocCode)) {
						//조견표 
						formType = "90";
					}else if("GOVCBRD93".equals(targetDocCode)) {
						//BOM
						formType = "91";
					}
					
					// 통보 후 제출문서 상태값 변경
					this.setSubmitDocStatus(formType, xmlMap);
				}
			}
			
			
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		
    		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator("app_resource");
    		
    		String receivePath = configurator.getString("file.xmlreceive.dir");
    		String backupPath = configurator.getString("file.xmlbackup.dir");
    		String basePath = configurator.getString("file.xml.dir");
    		
    		String receiveFolder = basePath +  receivePath;
    		String backupFolder = backupPath;
    		
			//수신파일 backup경로로 이동
    		List<File> preFiles = FileUtil.getDirFileList(receiveFolder);
    		
    		String fileName = "";
    		for (int inx = 0; inx < preFiles.size(); inx++) {
    			fileName = preFiles.get(inx).getName();
    			if (!fileName.endsWith(".xml")) {
    				continue;
    			}
    			//파일을 백업폴더로 이동 시킴
    			FileUtil.fileMove(receiveFolder+"/"+fileName, backupFolder+"/"+fileName);
    		}
		}
    	
    	return rs;
    }
    

    
    /**
     * 송신 : 환급신청서
     * @param param
     * @param presentnNo
     * @return
     * @throws Exception
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<String, Object> createXmlDocForDrawbackDoc(Map param, String presentnNo) throws Exception {
    	Map returnMap = new HashMap<String, Object>();
    	Map paramMap = new HashMap<String, Object>();
    	paramMap.putAll(param);
    	paramMap.put("PRESENTN_NO", presentnNo);
    	
    	returnMap.put("PRESENTN_NO", presentnNo);
    	//XML 생성 시작 
    	Map xmlMap = new HashMap();
		
	    //Tax 종류
	    String[] taxArray = {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
		
		//Name 스페이스 정의
  		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DASchemaModule:1:0");
  		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DASchemaModule:1:0");
  		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");	
  		
  		//root element 만들기
  		Element Declaration = new Element("Declaration", wco);
  		
  		//Name 스페이스 설정
		Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DASchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_5DASchemaModule_1.0_standard.xsd", xsi);
		Declaration.addNamespaceDeclaration(kcs);
		Declaration.addNamespaceDeclaration(xsi);
    	
    	/**
    	 * ******  XML 생성용 <갑> 데이터 조회
    	 * ******  @param param
    	 * ******  @return
    	 */
		logger.debug(" Xml Content Parsing Start : " + presentnNo);

		String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_drwb(paramMap);

		if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
			/* 제출번호 생성을 위해 기존 번호 + 1  수행*/
			sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
			/* 제출번호 xml 생성할때마다 재생성 */
			sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_drwb(paramMap);	
		}
		
    	Map<String, Object> cmmnMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Drwbak_Cmmn(paramMap);
    	
    	returnMap.put("SUBMIT_NO", StringUtil.null2String(cmmnMap.get("SUBMIT_NO")));
    	returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(cmmnMap.get("STTEMNT_DOC_STLE")));
    	
    	logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);
			//  CSMHSE_CODE 신청세관부호 Declaration/DeclarationOfficeID	
			Declaration.addContent( new Element("DeclarationOfficeID", wco).setText(StringUtil.null2String(cmmnMap.get("CSMHSE_CODE"))));
			//  PRESENTN_NO 제출번호 Declaration/ID	
			Declaration.addContent(new Element("ID", wco).setText(StringUtil.null2String(cmmnMap.get("SUBMIT_NO"))));
			//  STTEMNT_DOC_STLE 문서형태구분(GOVCBR5DA) Declaration/TypeCode
			Declaration.addContent(new Element("TypeCode", wco).setText(StringUtil.null2String(cmmnMap.get("STTEMNT_DOC_STLE"),"GOVCBR5DA")));	// 환급신청서 : GOVCBR5DA		
			//  DRWBAK_SE_CODE 환급구분 Declaration/TransactionNatureCode	
			Declaration.addContent(new Element("TransactionNatureCode", wco).setText(StringUtil.null2String(cmmnMap.get("DRWBAK_SE_CODE"))));		
			//  XPORT_TYPE 수출형태 Declaration/SubTypeCode	
			Declaration.addContent(new Element("SubTypeCode", kcs).setText(StringUtil.null2String(cmmnMap.get("XPORT_TYPE"))));		
	
			
			//  환급신청서_수입신고필증유효기간단축배제사유서 - 해당사유 Declaration/Reason	
			Declaration.addContent(new Element("Reason", kcs).setText(""));

    		
    		/** 
    		 * Declaration/AdditionalCode
    		 * 환급신청서_수입신고필증유효기간단축배제사유서 에 해당하지 않으면 노드 자체가 없어야 함
    		 * 
    		 */
			/*
    		Element DeclareAC = new Element("AdditionalCode", wco);
    			//  동질원재료전체사용여부 Declaration/AdditionalCode/TotalUseCode	
    			DeclareAC.addContent(new Element("TotalUseCode", kcs).setText(""));	
    			//  생산공정투입지연여부 Declaration/AdditionalCode/PutDelayCode	
    			DeclareAC.addContent(new Element("PutDelayCode", kcs).setText(""));	
    			//  생산공정3월이상소요여부 Declaration/AdditionalCode/RequirementCode	
    			DeclareAC.addContent(new Element("RequirementCode", kcs).setText(""));	
    			//  기타사유수입원재료사용여부 Declaration/AdditionalCode/RawMaterialUseCode	
    			DeclareAC.addContent(new Element("RawMaterialUseCode", kcs).setText(""));	
    		Declaration.addContent(DeclareAC);
    		*/
    		
    		/** 
    		 * Declaration/AdditionalDocument
    		 */
    		Element DeclareAD = new Element("AdditionalDocument", wco);
    			//  추징고지 충당 환급건 여부 -  충당여부 Declaration/AdditionalDocument/TypeCode	
    			DeclareAD.addContent(new Element("TypeCode", wco).setText("N"));
    			//  추가환급접수번호 Declaration/AdditionalDocument/ID- 추가환급이 발생할 경우 기존 환급의 접수번호(세관부호(3)+연도(2)+일련번호(7))를 기재
    			DeclareAD.addContent(new Element("ID", wco).setText(""));
    			//  증빙자료명 Declaration/AdditionalDocument/Name	
    			DeclareAD.addContent(new Element("Name", wco).setText(""));
    		Declaration.addContent(DeclareAD);
    	
    		/** 
    		 * Declaration/AdditionalInformation
    		 * 환급신청서_수입신고필증유효기간단축배제사유서에 관련된 항목으로 해당되지 않으면 빈값으로 표시해야함
    		 */
    		Element DeclareAI = new Element("AdditionalInformation", wco);
    			// 원재료개별법적용여부 Declaration/AdditionalInformation/StatementCode	
    			DeclareAI.addContent(new Element("StatementCode", wco).setText(""));
    			//  원재료선입선출법적용여부 Declaration/AdditionalInformation/StatementTypeCode	
    			DeclareAI.addContent(new Element("StatementTypeCode", wco).setText(""));
    		Declaration.addContent(DeclareAI);

    		/** 
    		 * Declaration/Agent
    		 */
    		Element DeclareAgent = new Element("Agent", wco);		
    			// CSTBRKR 신고대행관세사번호 Declaration/Agent/ID	
    			DeclareAgent.addContent(new Element("ID", wco).setText(""));
    		Declaration.addContent(DeclareAgent);

    		/** 
    		 * 환급신청서_세율별 환급사용물량 조정 및 제한배제 사유서
    		 * Declaration/AttachedDocument
    		 */
    		Element DeclareAttachedDoc = new Element("AttachedDocument", wco);	
    			// 해당세율수입원재료전체사용여부 Declaration/AttachedDocument/RawMaterialAllUseCode	
    			DeclareAttachedDoc.addContent(new Element("RawMaterialAllUseCode", kcs).setText(""));
    			// 생산구분사용여부 Declaration/AttachedDocument/ProductionDivisionUseCode 	
    			DeclareAttachedDoc.addContent(new Element("ProductionDivisionUseCode", kcs).setText(""));
    			// 단일세율수입여부 Declaration/AttachedDocument/ShortdayTaxrateImportCode	
    			DeclareAttachedDoc.addContent(new Element("ShortdayTaxrateImportCode", kcs).setText(""));
    			// 원재료개별법적용여부 Declaration/AttachedDocument/RawMaterialIndividualLawUseCode	
    			DeclareAttachedDoc.addContent(new Element("RawMaterialIndividualLawUseCode", kcs).setText(""));
    			// 원재료선입선출법적용여부 Declaration/AttachedDocument/RawMaterialFifoUseCode	
    			DeclareAttachedDoc.addContent(new Element("RawMaterialFifoUseCode", kcs).setText(""));
    			// 중소기업자여부 Declaration/AttachedDocument/SmallEnterpriseCode	
    			DeclareAttachedDoc.addContent(new Element("SmallEnterpriseCode", kcs).setText(""));
    			// 기타실제사용원재료신청여부 Declaration/AttachedDocument/OtherActualUseApplicationCode  	
    			DeclareAttachedDoc.addContent(new Element("OtherActualUseApplicationCode", kcs).setText(""));
    			// 증빙자료명 Declaration/AttachedDocument/EvidenceMaterialDescriptionText	
    			DeclareAttachedDoc.addContent(new Element("EvidenceMaterialDescriptionText", kcs).setText(""));
    		Declaration.addContent(DeclareAttachedDoc);


    		/** 
    		 * Declaration/BankAccount
    		 */
    		Element DeclareBankAccount = new Element("BankAccount", wco);	
    			// ACNUTNO 온라인구좌번호 Declaration/BankAccount/ID	
    			DeclareBankAccount.addContent(new Element("ID", wco).setText(StringUtil.null2String(cmmnMap.get("ACNUTNO"))));
    			// BANK_CODE 금융기관코드 Declaration/BankAccount/ReferenceID	
    			DeclareBankAccount.addContent(new Element("ReferenceID", wco).setText(StringUtil.null2String(cmmnMap.get("BANK_CODE"))));
    		Declaration.addContent(DeclareBankAccount);

    		/** 
    		 * Declaration/Consignment
    		 */
    		Element DeclareConsign = new Element("Consignment", wco);	
    			// ACCMLT_ORDER_QY(BASS_UNIT) 총수출물량(단위) Declaration/Consignment/GrossVolumeMeasure	
    			DeclareConsign.addContent(new Element("GrossVolumeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(cmmnMap.get("BASS_UNIT")))
    																			.setText(StringUtil.null2String(cmmnMap.get("ACCMLT_ORDER_QY"))));
    			// STTEMNT_PC_KRW 총수출금액 Declaration/Consignment/ValueAmount	
    			DeclareConsign.addContent(new Element("ValueAmount", wco).setText(StringUtil.null2String(cmmnMap.get("STTEMNT_PC_KRW"))));
    			// REQREQY_CALC_MTH 환급부호 Declaration/Consignment/BOMTypeCode	
    			DeclareConsign.addContent(new Element("BOMTypeCode", kcs).setText(StringUtil.null2String(cmmnMap.get("REQREQY_CALC_MTH"))));

    			
    			/**
    			 * 환급신청서_세율별 환급사용물량 제한배제내역 
    			 * Declaration/Consignment/AdditionalInformation
    			 * */
    			/*
    			Element ConsignAI = new Element("AdditionalInformation", wco);	
    				// 비고 Declaration/Consignment/AdditionalInformation/Content	
    				ConsignAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 수입 관세율 Declaration/Consignment/AdditionalInformation/StatementCode	
    				ConsignAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 배제제한내역행번호 Declaration/Consignment/AdditionalInformation/StatementDescription	
    				ConsignAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 원재료식별번호 Declaration/Consignment/AdditionalInformation/AdjustmentDescription	
    				ConsignAI.addContent(new Element("AdjustmentDescription", kcs).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// HS부호 Declaration/Consignment/AdditionalInformation/StoragePlace	
    				ConsignAI.addContent(new Element("StoragePlace", kcs).setText(StringUtil.null2String(cmmnMap.get(""))));
    			DeclareConsign.addContent(ConsignAI);
				*/
    			/**
    			 * 환급신청서_세율별 환급사용물량 조정내역 
    			 * Declaration/Consignment/BorderTransportMeans
    			 * */
    			/*
    			Element ConsignBTM = new Element("BorderTransportMeans", wco);			
    				// 부족세율 Declaration/Consignment/BorderTransportMeans/BunkerFuelValueAmount	
    				ConsignBTM.addContent(new Element("BunkerFuelValueAmount", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// HS부호 Declaration/Consignment/BorderTransportMeans/CrewQuantity	
    				ConsignBTM.addContent(new Element("CrewQuantity", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 조정내역행번호 Declaration/Consignment/BorderTransportMeans/ID	
    				ConsignBTM.addContent(new Element("ID", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 원재료식별번호 Declaration/Consignment/BorderTransportMeans/JourneyID 	
    				ConsignBTM.addContent(new Element("JourneyID", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 부족환급물량 Declaration/Consignment/BorderTransportMeans/LengthMeasure	
    				ConsignBTM.addContent(new Element("LengthMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(cmmnMap.get("kcsUnitCode")))
    																	   .setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 비고 Declaration/Consignment/BorderTransportMeans/Name	
    				ConsignBTM.addContent(new Element("Name", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 환급적용물량 Declaration/Consignment/BorderTransportMeans/NetWeightMeasure	
    				ConsignBTM.addContent(new Element("NetWeightMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(cmmnMap.get("kcsUnitCode")))
    																	      .setText(StringUtil.null2String(cmmnMap.get(""))));
    				// 환급사용세율 Declaration/Consignment/BorderTransportMeans/SecurityLevelCode 	
    				ConsignBTM.addContent(new Element("SecurityLevelCode", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
    			DeclareConsign.addContent(ConsignBTM);		
    			*/
    			
    	
    	logger.debug("<갑> - xml 데이터 종료 : " + presentnNo);
    	
    	
    	/**
    	 * ******  XML 생성용 <병> 데이터 조회
    	 * ******  @param param
    	 * ******  @return
    	 */
    	List<Map<String, Object>> rawmtrlList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Drwbak_Rawmtrl(paramMap);
    	
    	logger.debug("<병> - xml 데이터 생성 : " + presentnNo);
    	
    	/**
		 * Declaration/Consignment/ConsignmentItem
		 * */
		Element CosignItem = new Element("ConsignmentItem", wco);		

			/**
			 * Declaration/Consignment/ConsignmentItem/Commodity
			 * */
			Element ConsignItemComm = new Element("Commodity", wco);			
				// 대표수출품명규격 Declaration/Consignment/ConsignmentItem/Commodity/CargoDescription	
				ConsignItemComm.addContent(new Element("CargoDescription", wco).setText(StringUtil.null2String(cmmnMap.get("STD_ITEM_NM"))));

				/**
				 * Declaration/Consignment/ConsignmentItem/Commodity/Classification
				 * */			
				Element ConsignItemCommCF = new Element("Classification", wco);				
					// HS_CODE HS부호 Declaration/Consignment/ConsignmentItem/Commodity/Classification/ID	
					ConsignItemCommCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(cmmnMap.get("HS_CODE"))));
				ConsignItemComm.addContent(ConsignItemCommCF);
			
				//====================================================
				// <!--0..99999 환급신청서_수입원재료--> 시작
				//====================================================
					
			
				for(int i =0;  i < rawmtrlList.size(); i++){
					Map ConsignItemCommDtlMap = (Map) rawmtrlList.get(i);
					
					/**
					 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity
					 **/		
					Element ConsignItemCD = new Element("DetailedCommodity", wco);				
						// M : POUCH_NO 수입원재료행번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/SequenceNumeric	
						ConsignItemCD.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("LINE_NUMBER"))));
						// M : RAWMTRL_SE 원재료구분 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/CharacteristicCode	
						ConsignItemCD.addContent(new Element("CharacteristicCode", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE"))));
						// M : RAWMTRL_CODE 원재료식별번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/ID	
						ConsignItemCD.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_CODE"))));
						// M : ITEM_CODE 제품식별번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/LotNumberID	
						ConsignItemCD.addContent(new Element("LotNumberID", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("ITEM_CODE"))));
						// M : USGQTY(BASS_UNIT) 사용물량(단위) Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/SizeMeasure	
						ConsignItemCD.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(ConsignItemCommDtlMap.get("BASS_UNIT")))
																				.setText(StringUtil.null2String(ConsignItemCommDtlMap.get("USGQTY"))));
						// C : 원재료단가 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/ValueAmount	
						ConsignItemCD.addContent(new Element("ValueAmount", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("UNIT_PRICE"))));
						
						/**
						 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument
						 **/		
						Element ConsignItemCDAD = new Element("AdditionalDocument", wco);				
							// 신고(증명)번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/ID	
							ConsignItemCDAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("IMPDEC_NO"))));	//기납분증인 경우 수입신고필드가 접수번호로 쓰임
							// 수입(매입)일자 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/IssueDateTime	
							ConsignItemCDAD.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("ACPT_DATE")))); //기납분증인 경우 수리일자가 증명일자로 쓰임
				
						if("02".equalsIgnoreCase(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE")))
								|| "03".equalsIgnoreCase(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE")))
								|| "04".equalsIgnoreCase(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE")))
								|| "05".equalsIgnoreCase(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE")))
								) {
							/*원재료 구분이 기납, 평세, 분증, 부산물인 경우에만 수행
							 *  "02" : 기납증
							 *  "03" : 평세증
							 *  "04" : 분증
							 *  "05" : 부산물
							*/

								if("05".equalsIgnoreCase(StringUtil.null2String(ConsignItemCommDtlMap.get("RAWMTRL_SE")))) {
									/*
									 * 계산근거상의 신고(증명) 번호의 란번호를 기재
									 * 제증명(기납증, 분증, 평세증)인 경우, 제품:'001', 부산물은‘003’기재
									 */
									// 신고(증명)번호_란번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/SequenceNumeric	
									ConsignItemCDAD.addContent(new Element("SequenceNumeric", wco).setText("003"));
									
								} else {
									// 신고(증명)번호_란번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/SequenceNumeric	
									ConsignItemCDAD.addContent(new Element("SequenceNumeric", wco).setText("001"));
									
								}
							ConsignItemCD.addContent(ConsignItemCDAD);

							
						} else { // 원재료 구분이 "01(수입신고필증)" 인경우 란번호를 입력
							ConsignItemCDAD.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("LNE_NO"))));
						}
						ConsignItemCD.addContent(ConsignItemCDAD);
						

							
						/**
						 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation
						 **/
						Element ConsignItemCDAI = new Element("AdditionalInformation", wco);				
							// 신고(증명)번호_규격번호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/Content	
							ConsignItemCDAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("POUCH_NO"))));
							// 조사란구분 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/StatementCode
							//A	지급제한 / B	/ 부산물 ( 내역 있음 ) / C	부산물 ( 내역 없음 ) / D	기본값
							ConsignItemCDAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get(""))));
							// 조사란비율 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/StatementDescription	
							ConsignItemCDAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get(""))));
						ConsignItemCD.addContent(ConsignItemCDAI);
								
						/**
						 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/Classification
						 **/
						Element ConsignItemCDCF = new Element("Classification", wco);				
							// HS_CODE HS부호 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/Classification/ID
							ConsignItemCDCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get("HS_CODE"))));
						ConsignItemCD.addContent(ConsignItemCDCF);
								
						//======================================================
						// <!--1..7 반복--> 시작
						// taxArray => {"CUD","IND"   ,"5AA"        ,"ACT","5AB","CAP" ,"5CZ"};
						//             {관세  ,개별소비세액,교통에너지환경세액,주세액,교육세액,농특세액,세액 합계}
						//======================================================*/


						for(int j = 0; j < taxArray.length ; j++){
						
						/**
						 *  Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee
						 **/
						Element ConsignItemCDTaxFee = new Element("DutyTaxFee", wco);		
							// 세액구분 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee/TypeCode	
							ConsignItemCDTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[j]));
							
							/**
							 *  Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee/Payment
							 **/
							Element ConsignItemCDTaxFeePay = new Element("Payment", wco);		
								// 세액 Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee/Payment/TaxAssessedAmount	
								ConsignItemCDTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(ConsignItemCommDtlMap.get(""+taxArray[j]))));
							ConsignItemCDTaxFee.addContent(ConsignItemCDTaxFeePay);
						ConsignItemCD.addContent(ConsignItemCDTaxFee);
						
						} 
						
						//======================================================
						//<!--1..7 반복--> 종료
						//======================================================
						
					ConsignItemComm.addContent(ConsignItemCD);
					
				} 
				
				//====================================================
				// <!--0..99999 환급신청서_수입원재료--> 종료
				//====================================================
			CosignItem.addContent(ConsignItemComm);
		DeclareConsign.addContent(CosignItem);
    	
    	/**
    	 * ******  XML 생성용 <을> 데이터 조회
    	 * ******  @param param
    	 * ******  @return
    	 */
    	List<Map<String, Object>> thnglList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Drwbak_Thng(paramMap);
    	
    	logger.debug("<을> - xml 데이터 생성 : " + presentnNo);

			//====================================================
			//<!--0..9999 환급신청서_환급대상물품--> 시작
			//====================================================
			
		for(int i=0; i < thnglList.size(); i++){
			Map prevDocMap = (Map) thnglList.get(i);
			
		    /**
			* Declaration/Consignment/PreviousDocument
			* */	
			Element PrevDoc = new Element("PreviousDocument", wco);		
				// PRESENTN_NO 수출신고번호 Declaration/Consignment/PreviousDocument/ID	
				PrevDoc.addContent(new Element("ID", wco).setText(StringUtil.null2String(prevDocMap.get("XPORT_STTEMNT_NO"))));
				// DSPTH_DATE 수리일자 Declaration/Consignment/PreviousDocument/IssueDateTime	
				PrevDoc.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(prevDocMap.get("DSPTH_DATE"))));
				// POUCH_NO 물품행번호 Declaration/Consignment/PreviousDocument/LineNumeric	
				PrevDoc.addContent(new Element("LineNumeric", wco).setText(StringUtil.null2String(prevDocMap.get("LINE_NUMBER"))));
				// LNE_NO 수출신고번호 란번호 Declaration/Consignment/PreviousDocument/SequenceNumeric	
				PrevDoc.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(prevDocMap.get("LNE_NO"))));
				// STTEMNT_PC_KRW 수출금액 Declaration/Consignment/PreviousDocument/AmountAmount	
				PrevDoc.addContent(new Element("AmountAmount", wco).setText(StringUtil.null2String(prevDocMap.get("STTEMNT_PC_KRW"))));
				
			    /**
				* Declaration/Consignment/PreviousDocument/Packaging
				* */	
				Element Packaging = new Element("Packaging", wco);		
					// ACCMLT_ORDER_QY(BASS_UNIT) 수출수량(단위) Declaration/Consignment/PreviousDocument/Packaging/VolumeMeasure	
					Packaging.addContent(new Element("VolumeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(prevDocMap.get("BASS_UNIT")))
																		  .setText(StringUtil.null2String(prevDocMap.get("ACCMLT_ORDER_QY"))));
				PrevDoc.addContent(Packaging);
				
			    /**
				* Declaration/Consignment/PreviousDocument/AdditionalInformation
				* */
				Element PrevDocAI = new Element("AdditionalInformation", wco);		
					// XPORT_STTEMNT_NO 수출신고번호 규격번호 Declaration/Consignment/PreviousDocument/AdditionalInformation/Content	
					PrevDocAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(prevDocMap.get("POUCH_NO"))));
					// THNG_SE 대상물품구분 Declaration/Consignment/PreviousDocument/AdditionalInformation/StatementCode	
					PrevDocAI.addContent(new Element("StatementCode", wco).setText("01"));  // 01 수출신고서 / 02 수출 갈음 / 99 기타
					// ITEM_CODE 제품식별번호 Declaration/Consignment/PreviousDocument/AdditionalInformation/StatementDescription	
					PrevDocAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(prevDocMap.get("ITEM_CODE"))));
				PrevDoc.addContent(PrevDocAI);
			DeclareConsign.addContent(PrevDoc);		
		} 
		
		//====================================================
		//<!--0..9999 환급신청서_환급대상물품--> 종료
		//====================================================
		Declaration.addContent(DeclareConsign);		
	
	    //======================================================
		// <!--1..7 반복--> 시작
		// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
		// ======================================================
		
		for(int i = 0; i < taxArray.length ; i++){
		
		/**
		 * <갑> 총 세금 Loop
		* Declaration/DutyTaxFee
		**/
		Element DeclareTaxFee = new Element("DutyTaxFee", wco);
			// 관세종류 Declaration/DutyTaxFree/TypeCode
			DeclareTaxFee.addContent(new Element("TypeCode",wco).setText(taxArray[i]));
		    
			/**
			* Declaration/DutyTaxFee/Payment
			**/
			Element DeclareTaxFeePay = new Element("Payment", wco);		
				// 총관세액 Declaration/DutyTaxFee/Payment/TaxAssessedAmount	
				DeclareTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(cmmnMap.get(""+taxArray[i]))));
			DeclareTaxFee.addContent(DeclareTaxFeePay);
		Declaration.addContent(DeclareTaxFee);		
		}
		
		//======================================================
		// <!--1..7 반복--> 종료
		// ======================================================
			
    	logger.debug("<을> - xml 데이터 종료 : " + presentnNo);

    	
		
		/**
		* Declaration/Manufacturer
		*/
		Element DeclareMF = new Element("Manufacturer", wco);		
			// ECTMRK 제조자(통관고유부호(380)/사업자등록번호(KTX)) Declaration/Manufacturer/ID	
			DeclareMF.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380")
													   .setText(StringUtil.null2String(cmmnMap.get("MANUFAC_ECTMRK"))));
			// BIZRNO 제조자(통관고유부호(380)/사업자등록번호(KTX)) Declaration/Manufacturer/ID	
			DeclareMF.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX")
													   .setText(StringUtil.null2String(cmmnMap.get("MANUFAC_BIZRNO"))));
		Declaration.addContent(DeclareMF);	
		
		/**
		* Declaration/Origin
		*/
		Element DeclareOrigin = new Element("Origin", wco);		
			// NATION_CODE 수출국가코드 Declaration/Origin/CountryCode	
			// ZZ 입력시 오류 발생으로 인하여 필수값이 아니므로 제외
			//DeclareOrigin.addContent(new Element("CountryCode", wco).setText(StringUtil.null2String(cmmnMap.get("NATION_CODE"))));
		DeclareOrigin.addContent(new Element("CountryCode", wco).setText(""));
		Declaration.addContent(DeclareOrigin);	

		/**
		* Declaration/Submitter
		*/
		Element DeclareSubmitter = new Element("Submitter", wco);		
			// 환급신청인 부호(통관고유부호(380)/사업자 등록번호(KTX)) Declaration/Submitter/ID	
			DeclareSubmitter.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380")
															  .setText(StringUtil.null2String(cmmnMap.get("ECTMRK"))));
			// 환급신청인 부호(통관고유부호(380)/사업자 등록번호(KTX)) Declaration/Submitter/ID	
			DeclareSubmitter.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX")
															  .setText(StringUtil.null2String(cmmnMap.get("BIZRNO"))));
		
			/**
			* Declaration/Submitter/Communication
			*/
			Element SubmitterCommu = new Element("Communication", wco);		
				// TELNO_1 환급신청인 연락처 Declaration/Submitter/Communication/ID	
				SubmitterCommu.addContent(new Element("ID", wco).setText(StringUtil.null2String(cmmnMap.get(""))));
			DeclareSubmitter.addContent(SubmitterCommu);
		Declaration.addContent(DeclareSubmitter);
    	
    	logger.debug("<병> - xml 데이터 종료 : " + presentnNo);
    	
    	logger.debug("FILE 생성 시작 : " + presentnNo);
    	
    	FileOutputStream fos = null;
		OutputStreamWriter writer = null;
    	
    	try {
    		Document myDoc = new Document(Declaration);
    		
    		XMLOutputter outputter = new XMLOutputter();
    		Format format = outputter.getFormat();
    		outputter.setFormat(Format.getPrettyFormat());
    		
    		PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator("app_resource");
    		
    		// XML 파일 명
    		String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";
    		
    		
    		String workPath = configurator.getString("file.xml.dir");
    		String sendPath = configurator.getString("file.sendxml.dir");
    		String receivePath = configurator.getString("file.xmlreceive.dir");
    		
    		String backupPath = configurator.getString("file.xmlbackup.dir");
    		
    		//String basePath = req.getSession().getServletContext().getRealPath(workPath);			
    		String basePath = configurator.getString("file.xml.dir");
    		
    		String outputFolder = basePath + sendPath;
    		String receiveFolder = basePath + receivePath;
    		//String backupFolder = basePath + receivePath + "/" + backupPath;
    		String backupFolder =  backupPath;

    		File senddir = new File(outputFolder);		// 송신 DIR
    		File receivedir = new File(receiveFolder);	// 수신 DIR
    		File backupdir = new File(backupFolder);	// 수신 Backup DIR

    		// 송신폴더 생성
    		if (!senddir.isDirectory()) {
    			senddir.mkdirs();
    		}
    		
    		// 수신폴더 생성
    		if (!receivedir.isDirectory()) {
    			receivedir.mkdirs();
    		}
    		
    		// 백업폴더 생성
    		if (!backupdir.isDirectory()) {
    			backupdir.mkdirs();
    		}		
    		
    		fos = new FileOutputStream(outputFolder + "/"+ crateXmlFileName);
    		writer = new OutputStreamWriter(fos, "utf-8");
    		outputter.output(myDoc, writer);
    		
		} catch (Exception e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		}finally {
			writer.close();
		}
    	
    	
    	logger.debug("createXmlDocForDrawbackDoc () -Create Xml Parsing End");
    	
    	return returnMap;
    }
	
	
	
	
	/**
	 * ********************************************************************************************************************************************* 
	 * 여기서 부터 수신
	 * *********************************************************************************************************************************************
	*/

	/*
	 * 환급 자료제출요구서
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBRR57(List<Element> elements) {
		Map returnMap = new HashMap();
		List<Map> goodsShipmentList = new ArrayList<Map>();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			}else if (element.getName().equals("Authenticator")) { 
				List<Element> authenticator = element.getChildren();
				for (Element lv2Node : authenticator) {
					if (lv2Node.getName().equals("Name")) {  //처리담당자
						returnMap.put("CSMHSE_PRSN", lv2Node.getText());	
					}else if (lv2Node.getName().equals("Contact")) {
						List<Element> contact = lv2Node.getChildren();
						for (Element lv3Node : contact) {
							if (lv3Node.getName().equals("DepartmentName")) {  //과명
								returnMap.put("CSMHSE_KWA_NAME", lv3Node.getText());	
							}else if (lv3Node.getName().equals("PrimaryOfficial")) {  //담당과장명
								returnMap.put("CSMHSE_KWAJANG_NAME", lv3Node.getText());
							}
						}
						
					}else if (lv2Node.getName().equals("Communication")) {
						List<Element> communication = lv2Node.getChildren();
						for (Element lv3Node : communication) {
							if (lv3Node.getName().equals("ID")) {  //담당자전화번호
								returnMap.put("CSMHSE_PRSN_TEL", lv3Node.getText());
							}
						}
					}
				}
			} // Authenticator loop end
			else if (element.getName().equals("Declaration")) { 
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("ExpirationDateTime")) {  //제출기한(CCYYMMDD)
						returnMap.put("SUBMIT_DUE_DATE", dec.getText());
					}else if (dec.getName().equals("FunctionalReferenceID")) {  //대표접수번호
						returnMap.put("MAIN_REGIST_RCEPT_NO", dec.getText());
					}else if (dec.getName().equals("ID")) {  //환급심사요구자료문서번호
						returnMap.put("DRWB_REVIEW_DOC_NO", dec.getText());
					}else if (dec.getName().equals("IssueDateTime")) {  //신청일자(CCYYMMDD)
						returnMap.put("APPLICANT_DATE", dec.getText());
					}else if (dec.getName().equals("Reason")) {  //자료제출요구사유
						returnMap.put("REQ_RESN", dec.getText());
					}else if (dec.getName().equals("DeclarationOffice")) {  //세관명
						returnMap.put("CSMHSE_NAME", dec.getText());
					}else if (dec.getName().equals("GoodsShipment")) {  // 정산신청서_상세내역 (1...999)
						List<Element> goodsShipment = dec.getChildren();
						Map<String, Object> goodsShipmenMap = new HashMap();
						for(Element lv2Node : goodsShipment){
							
							if (lv2Node.getName().equals("SequenceNumeric")) {  //요구자료_행번호
								goodsShipmenMap.put("SEQ", lv2Node.getText());
							}else if (lv2Node.getName().equals("TransactionNatureCode")) {  //문서구분(10:환급신청서, 20:기납증, 40:분증)
								goodsShipmenMap.put("DRWB_DOC_TYPE", lv2Node.getText());
							}else if (lv2Node.getName().equals("AdditionalDocument")) {  
								List<Element> additionalDocument = lv2Node.getChildren();
								for (Element lv3Node : additionalDocument) {
									if (lv3Node.getName().equals("ID")) { //접수번호
										goodsShipmenMap.put("REGIST_RCEPT_NO", lv3Node.getText());
									}
								}
								
							}else if (lv2Node.getName().equals("GovernmentAgencyGoodsItem")) {  //처리담당자
								List<Element> governmentAgencyGoodsItem = lv2Node.getChildren();
								for (Element lv3Node : governmentAgencyGoodsItem) {
									if (lv3Node.getName().equals("SequenceNumeric")) { //수출신고란번호
										goodsShipmenMap.put("XPORT_LNE_NO", lv3Node.getText());
									}else if (lv3Node.getName().equals("AdditionalDocument")) { 
										List<Element> additionalDocument = lv3Node.getChildren();
										for (Element lv4Node : additionalDocument) {
											if (lv4Node.getName().equals("Name")) { //제출요구자료명
												goodsShipmenMap.put("REQ_DOC_NAME", lv4Node.getText());
											}
										}
									}else if (lv3Node.getName().equals("Commodity")) {
										List<Element> commodity = lv3Node.getChildren();
										for (Element lv4Node : commodity) {
											if (lv4Node.getName().equals("SequenceNumeric")) { //수출신고규격번호
												goodsShipmenMap.put("XPORT_POUCH_NO", lv4Node.getText());
											}else if (lv4Node.getName().equals("ID")) { //제품식별번호
												goodsShipmenMap.put("ITEM_CODE", lv4Node.getText());
											}
										}
									}else if (lv3Node.getName().equals("PreviousDocument")) {
										List<Element> previousDocument = lv3Node.getChildren();
										for (Element lv4Node : previousDocument) {
											if (lv4Node.getName().equals("ID")) { //수출신고번호
												goodsShipmenMap.put("XPORT_STTEMNT_NO", lv4Node.getText());
											}
										}
									}
								}
							} // GovernmentAgencyGoodsItem loop end
							
						}
						goodsShipmentList.add(goodsShipmenMap);
					} // GoodsShipment loop end
					else if (dec.getName().equals("Submitter")) { 
						List<Element> submitter = dec.getChildren();
						for(Element lv2Node : submitter){
							if (lv2Node.getName().equals("Name")) {  // 수신인상호
								returnMap.put("RECV_CMPNY_NAME",lv2Node.getText());  
							}else if (lv2Node.getName().equals("TypeOfBusiness")) {  // 수신처구분(1:관세사,2:업체)
								returnMap.put("RECV_TYPE_CODE",lv2Node.getText());  
							}else if (lv2Node.getName().equals("Contact")) {  
								List<Element> contact = lv2Node.getChildren();
								returnMap.put("RECV_NAME", contact.get(0).getText()); // 수신인성명
							}
						}
					}
				}
			}
		}
		returnMap.put("GOODS_SHIPMENT", goodsShipmentList);
		return returnMap;
	}
	
	
	/*
	 * 환급 보완통보서
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBRR58(List<Element> elements) {
		Map returnMap = new HashMap();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			}else if (element.getName().equals("Authenticator")) { 
				List<Element> authenticator = element.getChildren();
				for (Element lv2Node : authenticator) {
					if (lv2Node.getName().equals("Name")) {  //처리담당자
						returnMap.put("CSMHSE_PRSN", lv2Node.getText());	
					}else if (lv2Node.getName().equals("Contact")) {
						List<Element> contact = lv2Node.getChildren();
						returnMap.put("CSMHSE_KWAJANG_NAME", contact.get(0).getText());  //과장명
					}else if (lv2Node.getName().equals("Communication")) {
						List<Element> communication = lv2Node.getChildren();
						returnMap.put("CSMHSE_PRSN_TEL", communication.get(0).getText());  //연락처
					}
				}
			} // Authenticator loop end
			else if (element.getName().equals("Declaration")) { 
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("DeclarationOfficeID")) {  
						returnMap.put("CSMHSE_CODE",dec.getText().substring(0,3));  // 통보 세관
						returnMap.put("CSMHSE_KWA_CODE",dec.getText().substring(3,5));  //과
					}else if (dec.getName().equals("FunctionalReferenceID")) { //접수번호
						returnMap.put("REGIST_RCEPT_NO",dec.getText());  
					}else if (dec.getName().equals("ID")) {// 제출번호
						returnMap.put("SUBMIT_NO",dec.getText());  
					}else if (dec.getName().equals("TransactionNatureCode")) { // 신청서종류
						returnMap.put("FORM_TYPE",dec.getText());  
					}else if (dec.getName().equals("Reason")) { // 보완요구내역
						returnMap.put("SPLMT_TEXT",dec.getText());  
					}else if (dec.getName().equals("AdditionalDocument")) { // 보완요구서번호
						List<Element> additionalDocument = dec.getChildren();
						returnMap.put("SPLMT_NO", additionalDocument.get(0).getText());  //보완요구서번호
					}else if (dec.getName().equals("AdditionalInformation")) { 
						List<Element> additionalInformation = dec.getChildren();
						for(Element lv2Node : additionalInformation){
							if (lv2Node.getName().equals("Content")) {  // 비고
								returnMap.put("REMARK",lv2Node.getText());  
							}else if (lv2Node.getName().equals("LimitDateTime")) {  //제출기한(CCYYMMDD)-->
								returnMap.put("SUBMIT_DUE_DATE",lv2Node.getText());  
							}
						}
					}else if (dec.getName().equals("Submitter")) { 
						List<Element> submitter = dec.getChildren();
						for(Element lv2Node : submitter){
							if (lv2Node.getName().equals("Name")) {  // 수신인상호
								returnMap.put("RECV_CMPNY_NAME",lv2Node.getText());  
							}else if (lv2Node.getName().equals("Contact")) {  
								List<Element> contact = lv2Node.getChildren();
								for(Element lv3Node : contact){
									if (lv3Node.getName().equals("Name")) {  // 수신인성명
										returnMap.put("RECV_NAME", lv3Node.getText()); 
									}
								}
								
							}
						}
						
					}
				}
			}// Declaration loop End
		}
		return returnMap;
	}
	
	
	/*
	 * (공통)환급 지급 통보
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBR381(List<Element> elements) {
		Map returnMap = new HashMap();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("RECV_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			}else if (element.getName().equals("Authenticator")) { //처리담당자
				List<Element> authenticator = element.getChildren();
				returnMap.put("CSMHSE_PRSN", authenticator.get(0).getText());
			} else if(element.getName().equals("Declaration")){	//<wco:Declaration>
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("ID")) { // 지급 지시 번호(환급신청시 세관에서 부여한 접수번호와 동일)
						returnMap.put("PAY_ORDER_NO",dec.getText());
					}else if (dec.getName().equals("AuthenticationDateTime")) { // 결정일자
						returnMap.put("AUTHEN_DATE",dec.getText());
					}else if (dec.getName().equals("BankAccount")) {  //
						List<Element> bankAccount = dec.getChildren();
						for(Element lv2Node : bankAccount){
							if(lv2Node.getName().equals("ID")) { // 지급계좌
								returnMap.put("ACNUTNO", lv2Node.getText());
							}else if(lv2Node.getName().equals("ReferenceID")) { // 지급은행코드
								returnMap.put("PAY_BANK_CODE", lv2Node.getText());
							}else if(lv2Node.getName().equals("Name")) { // 지급은행명
								returnMap.put("PAY_BANK_NAME", lv2Node.getText());
							}
						}
					}else if(dec.getName().equals("DutyTaxFee")){
						List<Element> dutyTaxFee = dec.getChildren();
						for(Element lv3Node : dutyTaxFee){
							if(lv3Node.getName().equals("Payment")){
								List<Element> payment = lv3Node.getChildren();
								
								for(Element lv4Node : payment){
									if(lv4Node.getName().equals("PaymentAmount")) { // 지급금액
										returnMap.put("PAY_AMOUNT", lv4Node.getText());
									}
								}
							}
						}
					}else if(dec.getName().equals("Submitter")){
						List<Element> submitter = dec.getChildren();
						for(Element lv3Node : submitter){
							if(lv3Node.getName().equals("Name")){  // 신청인 상호
								returnMap.put("SUBMITTER_COMP_NAME", lv3Node.getText());
							}else if(lv3Node.getName().equals("Contact")){ 
								List<Element> contact = lv3Node.getChildren();
								for(Element lv4Node : contact){
									if(lv4Node.getName().equals("Name")) { // 신청인 성명
										returnMap.put("SUBMITTER_PRSN_NAME", lv4Node.getText());
									}
								}
							}
						}
					} // end Submitter
				}
			} // end <wco:Declaration>
		}

		return returnMap;
	}
	
	
	/*
	 * (공통)환급 완료통보
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBR5DF(List<Element> elements) {
		Map returnMap = new HashMap();
		List<Map> goodsShipmentList = new ArrayList<Map>();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			}else if (element.getName().equals("Authenticator")) { //처리담당자
				List<Element> authenticator = element.getChildren();
				returnMap.put("CSMHSE_PRSN", authenticator.get(0).getText());
			}else if (element.getName().equals("Control")) {
				List<Element> control = element.getChildren();
				for(Element lv2Node : control){
					if (lv2Node.getName().equals("InspectionEndDateTime")) { // 심사완료일자
						returnMap.put("INSPECTIONENDDATE",lv2Node.getText());
					}
					
				}
			} else if(element.getName().equals("Declaration")){	//<wco:Declaration>
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("DeclarationOfficeID")) { // 통보세관
						returnMap.put("CSMHSE_CODE",dec.getText());
					}else if (dec.getName().equals("FunctionalReferenceID")) { // 접수번호
						returnMap.put("REGIST_RCEPT_NO",dec.getText());
					}else if (dec.getName().equals("TransactionNatureCode")) { // 서식구분 - 문서구분(10:환급신청서, 20:기납증, 40:분증)
						returnMap.put("FORM_TYPE",dec.getText());
					}else if (dec.getName().equals("ID")) { // 제출번호
						returnMap.put("SUBMIT_NO",dec.getText());  
					}else if (dec.getName().equals("TransactionNatureCode")) {  // 서식구분
						returnMap.put("DOC_FORMAT_TYPE",dec.getText());  
					}else if (dec.getName().equals("GoodsShipment")) {  // 정산신청서_상세내역 (1...999)
						List<Element> goodsShipment = dec.getChildren();
						Map<String, Object> goodsShipmenMap = new HashMap();
						for(Element lv2Node : goodsShipment){
							if(lv2Node.getName().equals("AdditionalDocument")) {
								List<Element> additionalDocument = lv2Node.getChildren();
								for(Element lv3Node : additionalDocument){
									if(lv3Node.getName().equals("ID")) {  // 정산상세신고번호
										goodsShipmenMap.put("SETTLE_NO", lv3Node.getText());		
									}else if(lv3Node.getName().equals("IssueDateTime")) {  // 결정일자
										goodsShipmenMap.put("DECISION_DATE", lv3Node.getText());
									}
								}
							}else if(lv2Node.getName().equals("AdditionalInformation")) {
								List<Element> additionalInformation = lv2Node.getChildren();
								goodsShipmenMap.put("SETTLE_TYPE", additionalInformation.get(0).getText());
							}else if(lv2Node.getName().equals("DutyTaxFee")){	//<wco:DutyTaxFee> 세액 (1 .. 7)
								List<Element> dutyTaxFee = lv2Node.getChildren();
								String taxType = "";
								String targetKeyName = "";
								for(Element lv3Node : dutyTaxFee){
									if(lv3Node.getName().equals("TypeCode")){
										taxType = lv3Node.getText();
										//세액구분(관세액(CUD)/개별소비세액(IND)/교통에너지환경세액(5AA)/주세(ACT)/교육세(5AB)/농특세(CAP)/세액합계(5CZ))
										if("CUD".equalsIgnoreCase(taxType)) {
											targetKeyName = "CSTMS";
										}else if("IND".equalsIgnoreCase(taxType)) {
											targetKeyName = "INTTAX";
										}else if("5AA".equalsIgnoreCase(taxType)) {
											targetKeyName = "TRANTAX";
										}else if("ACT".equalsIgnoreCase(taxType)) {
											targetKeyName = "LQTX_AMOUNT";
										}else if("5AB".equalsIgnoreCase(taxType)) {
											targetKeyName = "ECX_AMOUNT";
										}else if("CAP".equalsIgnoreCase(taxType)) {
											targetKeyName = "AGSPT";
										}else if("5CZ".equalsIgnoreCase(taxType)) {
											targetKeyName = "TOT_TAX";
										}
									}else if(lv3Node.getName().equals("Payment")){
										List<Element> payment = lv3Node.getChildren();
										String taxAssessedAmountValue = "";
										for(Element lv5Node : payment) {
											if(lv5Node.getName().equals("TaxAssessedAmount")) {
												taxAssessedAmountValue = lv5Node.getText();
											}
										}
										goodsShipmenMap.put(targetKeyName, taxAssessedAmountValue);
									}
								}
							}
							
						}
						
						goodsShipmentList.add(goodsShipmenMap);
					} // GoodsShipment Loop End
					else if (dec.getName().equals("Submitter")) {  
						List<Element> submitter = dec.getChildren();
						for (Element lv2Node : submitter) {
							if (lv2Node.getName().equals("ID")) {
								if("380".equals(lv2Node.getAttributeValue("schemeAgencyID"))) {  // 신청인통관고유번호
									returnMap.put("APPLICANT_ECTMRK",lv2Node.getText());
								}else if("KTX".equals(lv2Node.getAttributeValue("schemeAgencyID"))) { //KTX:신청인사업자등록번호
									returnMap.put("APPLICANT_BIZNO",lv2Node.getText());	
								}
							}else if (lv2Node.getName().equals("Name")) { // 신청인상호
								returnMap.put("APPLICANT_CMPNY_NAME",lv2Node.getText());	
							}else if (lv2Node.getName().equals("Contact")) { // 신청인명
								List<Element> contact = lv2Node.getChildren();
								for (Element lv3Node : contact) {
									if (lv3Node.getName().equals("Name")) { //
										returnMap.put("APPLICANT_NAME",lv3Node.getText());
									}
								}
									
							}
						}
					}
				}
			} // Declaration loop end
			else if(element.getName().equals("Status")){	//<wco:Status>
				List<Element> status = element.getChildren();
				for(Element sta : status){
					if (sta.getName().equals("NameCode")) { // 결과코드
						returnMap.put("REVIEW_RESULT_CODE",sta.getText());	
					}else if (sta.getName().equals("Description")) { // 결과내역
						returnMap.put("REVIEW_RESULT_TEXT",sta.getText());	
					}
				}
			} // Status loop end
		}
		returnMap.put("GOODS_SHIPMENT", goodsShipmentList);
		return returnMap;
	}
	
	/*
	 * (환급 공통)환급접수통보
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBRR54(List<Element> elements) {
		Map returnMap = new HashMap();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			} else if (element.getName().equals("Authenticator")) {
				List<Element> authenticator = element.getChildren();
				for(Element lv2Node : authenticator){
					if (lv2Node.getName().equals("Name")) {  // 처리담당자
						returnMap.put("CSMHSE_PRSN", lv2Node.getText());	
					}
				}
			} else if(element.getName().equals("Declaration")){	//<wco:Declaration>
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("AcceptanceDateTime")) { // 접수일시
						returnMap.put("REGIST_RCEP_DATE",dec.getText());  
					}else if (dec.getName().equals("DeclarationOfficeID")) { // 통보세관
						returnMap.put("CSMHSE_CODE",dec.getText());
					}else if (dec.getName().equals("FunctionalReferenceID")) { // 접수번호
						returnMap.put("REGIST_RCEPT_NO",dec.getText());
					}else if (dec.getName().equals("ID")) { // 제출번호
						returnMap.put("SUBMIT_NO",dec.getText());  
					}else if (dec.getName().equals("TypeCode")) {  // 신청서 종류
						returnMap.put("FORM_TYPE",dec.getText());  
					}else if (dec.getName().equals("SubTypeCode")) {  // PL구분( 1 : PL, 2 : 서류제출)
						returnMap.put("PL_TYPE",dec.getText());  
					}else if (dec.getName().equals("Reason")) {  // 서류제출사유
						returnMap.put("REQ_RESN",dec.getText());  
					}
				}
			}
		}

		return returnMap;
	}
	
	
	/**
	 * 사전검증 오류통보
	 * 송신 후 시스템의 Vailidation을 통과하지 못한경우 수신됨.
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBRR20(List<Element> elements) {
		Map returnMap = new HashMap();
		List<Map<String,String>> errorDataList = new ArrayList<Map<String,String>>();
		List<Map> goodsShipmentList = new ArrayList<Map>();
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //수신일시
				returnMap.put("RECV_DATE",element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			}else if (element.getName().equals("Declaration")) { 
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("AcceptanceDateTime")) {  //신청문서 수신일시(CCYYMMDDHHMMSS)
						returnMap.put("SUBMIT_DATE", dec.getText());
					}else if (dec.getName().equals("DeclarationOfficeID")) {  //통보 세관/과 
						returnMap.put("CSMHSE", dec.getText());
					}else if (dec.getName().equals("ID")) {  //오류발생 문서번호(제출번호)
						returnMap.put("SUBMIT_NO", dec.getText());
					}else if (dec.getName().equals("TypeCode")) {  //오류발생문서구분 
						returnMap.put("SUBMIT_STTEMNT_DOC_STLE", dec.getText());
					}
				}
			}else if (element.getName().equals("Error")) { 
				List<Element> errorList = element.getChildren();
				for(Element error : errorList){
					if (error.getName().equals("Description")) { 
						Map errorMap = new HashMap();
						errorMap.put("ERROR_MESSAGE", error.getText());
						errorDataList.add(errorMap);	
					}
				}
			}
		}
		returnMap.put("ERROR_LIST", errorDataList);
		return returnMap;
	}
	
	
	/* 
	 * 양수자통보 - 기초납입 증명서
	 */
	public static Map<String, Object> parsingXml_For_GOVCBR5DU(List<Element> elements) {
		Map returnMap = new HashMap();
	
		List<Map> goodsShipmentList = new ArrayList<Map>();
		returnMap.put("ISSUE_TYPE", "02"); // 기납증/분증구분(02:기납증, 04:분증)
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("FunctionCode")) { // 통보구분
				returnMap.put("RECV_DOC_TYPE", element.getText());
			}else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			} else if(element.getName().equals("Declaration")){	//<wco:Declaration>
				// get Declaration children element  
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("AcceptanceDateTime")) { // 접수일자
						returnMap.put("REGIST_RCEPT_DATE",dec.getText());  
					} else if (dec.getName().equals("FunctionalReferenceID")) { // 접수번호
						returnMap.put("REGIST_RCEPT_NO",dec.getText());  
					} else if (dec.getName().equals("ID")) { // 제출번호
						returnMap.put("SUBMIT_NO",dec.getText());  
					} else if (dec.getName().equals("SubTypeCode")) { // 발급방법(1:세관, 2:관세사, 3:자율)
						returnMap.put("ISSUE_MATHOD",dec.getText());  
					} else if(dec.getName().equals("AdditionalInformation")){	//<wco:AdditionalInformation>
						List<Element> additionalInformation = dec.getChildren();
						for(Element lv2Node : additionalInformation){
							if (lv2Node.getName().equals("AlienationDateTime")) { // 양도일자
								returnMap.put("CHIT_FRMTRM_DATE",lv2Node.getText());  
							}	
						}
						 
					} else if (dec.getName().equals("AdditionalDocument")) {	// 수출이행기준일자
						List<Element> additionalDocument = dec.getChildren();
						for(Element lv2Node : additionalDocument){
							if (lv2Node.getName().equals("IssueDateTime")) { // 양도일자
								returnMap.put("EXP_REF_DATE",lv2Node.getText());  
							}	
						}
					} else if (dec.getName().equals("TransactionNatureCode")) {	// 발급구분
						returnMap.put("CNVN_TYPE_CODE",dec.getText());
					} else if(dec.getName().equals("Consignment")){	//<wco:Consignment>
						List<Element> consignment = dec.getChildren();
						for(Element lv2Node : consignment){
							if (lv2Node.getName().equals("GrossVolumeMeasure")) { // 총양도물량(단위) 
								returnMap.put("ACCMLT_ORDER_QY",lv2Node.getText());
								returnMap.put("BASS_UNIT",lv2Node.getAttributeValue("kcsUnitCode"));
							} else if (lv2Node.getName().equals("ValueAmount")) { // 총공급가격
								returnMap.put("STTEMNT_PC_KRW",lv2Node.getText());
							} else if(lv2Node.getName().equals("BOMTypeCode")){	// 소요량산정방법부호
								returnMap.put("REQ_QTY_CODE",lv2Node.getText());
							} else if(lv2Node.getName().equals("Consignee")){	//<wco:Consignee>  양수자 
								List<Element> consignee = lv2Node.getChildren();
								for(Element lv3Node : consignee){
									if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("KTX")) { // 양수자 사업자등록번호
										returnMap.put("TO_BIZRNO",lv3Node.getText());
									} else if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("380")) { // 양수자 통관고유부호
										returnMap.put("TO_ECTMRK",lv3Node.getText());
									} else if (lv3Node.getName().equals("Name")) { // 양수자_상호
										returnMap.put("TO_COMPANY_NAME",lv3Node.getText());
									} else if (lv3Node.getName().equals("Address")) { // 양수자_주소
										List<Element> address = lv3Node.getChildren();
										for(Element lv4Node : address){
											if (lv4Node.getName().equals("Line")) { // 양수자_주소
												returnMap.put("TO_ADDRESS",lv4Node.getText());  
											}	
										}
									} else if (lv3Node.getName().equals("Contact")) { // 양수자_주소
										List<Element> contact = lv3Node.getChildren();
										for(Element lv4Node : contact){
											if (lv4Node.getName().equals("Name")) { // 양수자_성명
												returnMap.put("TO_RPRSNTV_NAME",lv4Node.getText());  
											}	
										}
									}
								}
							} else if(lv2Node.getName().equals("Consignor")){	//<wco:Consignor>  양도자 
								List<Element> consignor = lv2Node.getChildren();
								for(Element lv3Node : consignor){
									if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("KTX")) { // 양수자 사업자등록번호
										returnMap.put("FROM_BIZRNO",lv3Node.getText());
									} else if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("380")) { // 양수자 통관고유부호
										returnMap.put("FROM_ECTMRK",lv3Node.getText());
									} else if (lv3Node.getName().equals("Name")) { // 양수자_상호
										returnMap.put("FROM_COMPANY_NAME",lv3Node.getText());
									} else if (lv3Node.getName().equals("Address")) { // 양수자_주소
										List<Element> address = lv3Node.getChildren();
										for(Element lv4Node : address){
											if (lv4Node.getName().equals("Line")) { // 양수자_주소
												returnMap.put("FROM_ADDRESS",lv4Node.getText());  
											}	
										}
									} else if (lv3Node.getName().equals("Contact")) { // 양수자_주소
										List<Element> contact = lv3Node.getChildren();
										for(Element lv4Node : contact){
											if (lv4Node.getName().equals("Name")) { // 양수자_성명
												returnMap.put("FROM_RPRSNTV_NAME",lv4Node.getText());  
											}	
										}
									}
								}
							} else if(lv2Node.getName().equals("ConsignmentItem")){	//<wco:ConsignmentItem> HS Code
								List<Element> consignmentItem = lv2Node.getChildren();
								for(Element lv3Node : consignmentItem){
									if (lv3Node.getName().equals("Commodity")) { 
										List<Element> commodity = lv3Node.getChildren();
										for(Element lv4Node : commodity){
											if (lv4Node.getName().equals("Classification")) { 
												List<Element> classification = lv4Node.getChildren();
												for(Element lv5Node : classification){
													if (lv5Node.getName().equals("ID")) {
														returnMap.put("HS_CODE",lv5Node.getText());
													}
												}
											}
										}
									}
								} // End ConsignmentItem for
							} // End ConsignmentItem if
						} // End  Consignment for
					} // End Consignment if
					else if(dec.getName().equals("DutyTaxFee")){	//<wco:DutyTaxFee> 세액 (1 .. 7)
						List<Element> dutyTaxFee = dec.getChildren();
						String taxType = "";
						String targetKeyName = "";
						for(Element lv2Node : dutyTaxFee){
							if(lv2Node.getName().equals("TypeCode")){
								taxType = lv2Node.getText();
								//세액구분(관세액(CUD)/개별소비세액(IND)/교통에너지환경세액(5AA)/주세(ACT)/교육세(5AB)/농특세(CAP)/세액합계(5CZ))
								if("CUD".equalsIgnoreCase(taxType)) {
									targetKeyName = "CSTMS";
								}else if("IND".equalsIgnoreCase(taxType)) {
									targetKeyName = "INTTAX";
								}else if("5AA".equalsIgnoreCase(taxType)) {
									targetKeyName = "TRANTAX";
								}else if("ACT".equalsIgnoreCase(taxType)) {
									targetKeyName = "LQTX_AMOUNT";
								}else if("5AB".equalsIgnoreCase(taxType)) {
									targetKeyName = "ECX_AMOUNT";
								}else if("CAP".equalsIgnoreCase(taxType)) {
									targetKeyName = "AGSPT";
								}else if("5CZ".equalsIgnoreCase(taxType)) {
									targetKeyName = "TOT_TAX";
								}
							}else if(lv2Node.getName().equals("Payment")){
								List<Element> payment = lv2Node.getChildren();
								String taxAssessedAmountValue = "";
								for(Element lv3Node : payment) {
									if(lv3Node.getName().equals("TaxAssessedAmount")) {
										taxAssessedAmountValue = lv3Node.getText();
									}
								}
								returnMap.put(targetKeyName, taxAssessedAmountValue);

							}
						}
					} // End DutyTaxFee if
					else if(dec.getName().equals("GoodsShipment")){	//1..999 (기초원재료납세증명서_양도대상물품)
						List<Element> goodsShipment = dec.getChildren();
						Map<String, Object> goodsShipmenMap = new HashMap();
						for(Element lv2Node : goodsShipment){
							if(lv2Node.getName().equals("SequenceNumeric")) {  // 양도물품행번호 
								goodsShipmenMap.put("SEQ", lv2Node.getText());
							}else if(lv2Node.getName().equals("AdditionalDocument")) {  // 근거서류번호
								List<Element> additionalDocument = lv2Node.getChildren();
								Element id = additionalDocument.get(0);
								goodsShipmenMap.put("BASIS_DOC_NO", id.getText()); 
							}else if(lv2Node.getName().equals("Consignment")) {  
								List<Element> consignment = lv2Node.getChildren();
								for(Element lv3Node : consignment){
									if(lv3Node.getName().equals("Commodity")) {  // 근거서류번호
										List<Element> commodity = lv3Node.getChildren();
										for(Element lv4Node : commodity){
											if(lv4Node.getName().equals("CargoDescription")) {  // 품명및규격
												goodsShipmenMap.put("ITEM_NM", lv4Node.getText()); 
											}else if(lv4Node.getName().equals("ID")) {  // 제품식별번호
												goodsShipmenMap.put("ITEM_CODE", lv4Node.getText()); 
											}else if(lv4Node.getName().equals("SizeMeasure")) {  // 물량(단위)
												goodsShipmenMap.put("USGQTY", lv4Node.getText()); 
												goodsShipmenMap.put("BASS_UNIT", lv4Node.getAttributeValue("kcsUnitCode"));
											}else if(lv4Node.getName().equals("ValueAmount")) {  // 금액(통화단위)
												goodsShipmenMap.put("STTEMNT_PC_KRW", lv4Node.getText()); 
												goodsShipmenMap.put("ACPLC_CRNCY", lv4Node.getAttributeValue("currencyID"));
											}
										}
									}else if(lv3Node.getName().equals("DutyTaxFee")) { // 세액
										List<Element> dutyTaxFee = lv3Node.getChildren();
										String taxType = "";
										String targetKeyName = "";
										for(Element lv4Node : dutyTaxFee){
											if(lv4Node.getName().equals("TypeCode")) {
												taxType = lv4Node.getText();
												//세액구분(관세액(CUD)/개별소비세액(IND)/교통에너지환경세액(5AA)/주세(ACT)/교육세(5AB)/농특세(CAP)/세액합계(5CZ))
												if("CUD".equalsIgnoreCase(taxType)) {
													targetKeyName = "CSTMS";
												}else if("IND".equalsIgnoreCase(taxType)) {
													targetKeyName = "INTTAX";
												}else if("5AA".equalsIgnoreCase(taxType)) {
													targetKeyName = "TRANTAX";
												}else if("ACT".equalsIgnoreCase(taxType)) {
													targetKeyName = "LQTX_AMOUNT";
												}else if("5AB".equalsIgnoreCase(taxType)) {
													targetKeyName = "ECX_AMOUNT";
												}else if("CAP".equalsIgnoreCase(taxType)) {
													targetKeyName = "AGSPT";
												}else if("5CZ".equalsIgnoreCase(taxType)) {
													targetKeyName = "TOT_TAX";
												}
											}else if(lv4Node.getName().equals("Payment")) {
												List<Element> payment = lv4Node.getChildren();
												String taxAssessedAmountValue = "";
												for(Element lv5Node : payment) {
													if(lv5Node.getName().equals("TaxAssessedAmount")) {
														taxAssessedAmountValue = lv5Node.getText();
													}
												}
												goodsShipmenMap.put(targetKeyName, taxAssessedAmountValue);
											}
										}
									}
								}
							}
							
						}	// goodsShipment Loop End
						goodsShipmentList.add(goodsShipmenMap);
					}else if(dec.getName().equals("Submitter")){	//<wco:Submitter>  신고대행관세사번호
						List<Element> submitter = dec.getChildren();
						Element taxAssessedAmount = submitter.get(0);
						returnMap.put("CSTBRKR", taxAssessedAmount.getText());
					}
				}
			} // end for(Element dec : decl)
		}
		returnMap.put("GOODS_SHIPMENT", goodsShipmentList);
		return returnMap;
	}
	
	/* 
	 * 양수자통보 - 분할증명서
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map<String, Object> parsingXml_For_GOVCBR5DV(List<Element> elements) {
		Map returnMap = new HashMap();
		returnMap.put("ISSUE_TYPE", "04"); // 기납증/분증구분(02:기납증, 04:분증)
		List<Map> goodsShipmentList = new ArrayList<Map>();
		
		for (Element element : elements) {
			if (element.getName().equals("IssueDateTime")) { //통보일시
				returnMap.put("COMPLETE_DATE",element.getText());
			} else if (element.getName().equals("FunctionCode")) { // 통보구분
				returnMap.put("RECV_DOC_TYPE", element.getText());
			} else if (element.getName().equals("TypeCode")) { //문서형태구분
				returnMap.put("STTEMNT_DOC_STLE", element.getText());
			} else if(element.getName().equals("Declaration")){	//<wco:Declaration>
				// get Declaration children element  
				List<Element> decl = element.getChildren();
				for(Element dec : decl){
					if (dec.getName().equals("AcceptanceDateTime")) { // 접수일자
						returnMap.put("REGIST_RCEPT_DATE",dec.getText());  
					} else if (dec.getName().equals("FunctionalReferenceID")) { // 접수번호
						returnMap.put("REGIST_RCEPT_NO",dec.getText());  
					} else if (dec.getName().equals("ID")) { // 제출번호
						returnMap.put("SUBMIT_NO",dec.getText());  
					} else if (dec.getName().equals("SubTypeCode")) { // 발급방법(1:세관, 2:관세사, 3:자율)
						returnMap.put("ISSUE_MATHOD",dec.getText());  
					} else if(dec.getName().equals("AdditionalInformation")){	//<wco:AdditionalInformation>
						List<Element> additionalInformation = dec.getChildren();
						for(Element lv2Node : additionalInformation){
							if (lv2Node.getName().equals("AlienationDateTime")) { // 양도일자
								returnMap.put("CHIT_FRMTRM_DATE",lv2Node.getText());  
							}	
						}
						 
					} else if(dec.getName().equals("Consignment")){	//<wco:Consignment>
						List<Element> consignment = dec.getChildren();
						for(Element lv2Node : consignment){
							if (lv2Node.getName().equals("GrossVolumeMeasure")) { // 총양도물량(단위) 
								returnMap.put("ACCMLT_ORDER_QY",lv2Node.getText());
								returnMap.put("BASS_UNIT",lv2Node.getAttributeValue("kcsUnitCode"));
							} else if (lv2Node.getName().equals("ValueAmount")) { // 총공급가격
								returnMap.put("STTEMNT_PC_KRW",lv2Node.getText());
							} else if(lv2Node.getName().equals("Consignee")){	//<wco:Consignee>  양수자 
								List<Element> consignee = lv2Node.getChildren();
								for(Element lv3Node : consignee){
									if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("KTX")) { // 양수자 사업자등록번호
										returnMap.put("TO_BIZRNO",lv3Node.getText());
									} else if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("380")) { // 양수자 통관고유부호
										returnMap.put("TO_ECTMRK",lv3Node.getText());
									} else if (lv3Node.getName().equals("Name")) { // 양수자_상호
										returnMap.put("TO_COMPANY_NAME",lv3Node.getText());
									} else if (lv3Node.getName().equals("Address")) { // 양수자_주소
										List<Element> address = lv3Node.getChildren();
										for(Element lv4Node : address){
											if (lv4Node.getName().equals("Line")) { // 양수자_주소
												returnMap.put("TO_ADDRESS",lv4Node.getText());  
											}	
										}
									} else if (lv3Node.getName().equals("Contact")) { // 양수자_주소
										List<Element> contact = lv3Node.getChildren();
										for(Element lv4Node : contact){
											if (lv4Node.getName().equals("Name")) { // 양수자_성명
												returnMap.put("TO_RPRSNTV_NAME",lv4Node.getText());  
											}	
										}
									}
								}
							} else if(lv2Node.getName().equals("Consignor")){	//<wco:Consignor>  양도자 
								List<Element> consignor = lv2Node.getChildren();
								for(Element lv3Node : consignor){
									if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("KTX")) { // 양수자 사업자등록번호
										returnMap.put("FROM_BIZRNO",lv3Node.getText());
									} else if (lv3Node.getName().equals("ID") && lv3Node.getAttributeValue("schemeAgencyID").equals("380")) { // 양수자 통관고유부호
										returnMap.put("FROM_ECTMRK",lv3Node.getText());
									} else if (lv3Node.getName().equals("Name")) { // 양수자_상호
										returnMap.put("FROM_COMPANY_NAME",lv3Node.getText());
									} else if (lv3Node.getName().equals("Address")) { // 양수자_주소
										List<Element> address = lv3Node.getChildren();
										for(Element lv4Node : address){
											if (lv4Node.getName().equals("Line")) { // 양수자_주소
												returnMap.put("FROM_ADDRESS",lv4Node.getText());  
											}	
										}
									} else if (lv3Node.getName().equals("Contact")) { // 양수자_주소
										List<Element> contact = lv3Node.getChildren();
										for(Element lv4Node : contact){
											if (lv4Node.getName().equals("Name")) { // 양수자_성명
												returnMap.put("FROM_RPRSNTV_NAME",lv4Node.getText());  
											}	
										}
									}
								}
							} else if(lv2Node.getName().equals("ConsignmentItem")){	//<wco:ConsignmentItem> HS Code
								List<Element> consignmentItem = lv2Node.getChildren();
								for(Element lv3Node : consignmentItem){
									if (lv3Node.getName().equals("Commodity")) { 
										List<Element> commodity = lv3Node.getChildren();
										for(Element lv4Node : commodity){
											if (lv4Node.getName().equals("Classification")) { 
												List<Element> classification = lv4Node.getChildren();
												for(Element lv5Node : classification){
													if (lv5Node.getName().equals("ID")) {
														returnMap.put("HS_CODE",lv5Node.getText());
													}
												}
											}
										}
									}
								} // End ConsignmentItem for
							} // End ConsignmentItem if
						} // End  Consignment for
					} // End Consignment if
					else if(dec.getName().equals("DutyTaxFee")){	//<wco:DutyTaxFee> 세액 (1 .. 7)
						List<Element> dutyTaxFee = dec.getChildren();
						String taxType = "";
						String targetKeyName = "";
						for(Element lv2Node : dutyTaxFee){
							if(lv2Node.getName().equals("TypeCode")){
								taxType = lv2Node.getText();
								//세액구분(관세액(CUD)/개별소비세액(IND)/교통에너지환경세액(5AA)/주세(ACT)/교육세(5AB)/농특세(CAP)/세액합계(5CZ))
								if("CUD".equalsIgnoreCase(taxType)) {
									targetKeyName = "CSTMS";
								}else if("IND".equalsIgnoreCase(taxType)) {
									targetKeyName = "INTTAX";
								}else if("5AA".equalsIgnoreCase(taxType)) {
									targetKeyName = "TRANTAX";
								}else if("ACT".equalsIgnoreCase(taxType)) {
									targetKeyName = "LQTX_AMOUNT";
								}else if("5AB".equalsIgnoreCase(taxType)) {
									targetKeyName = "ECX_AMOUNT";
								}else if("CAP".equalsIgnoreCase(taxType)) {
									targetKeyName = "AGSPT";
								}else if("5CZ".equalsIgnoreCase(taxType)) {
									targetKeyName = "TOT_TAX";
								}
							}else if(lv2Node.getName().equals("Payment")){
								List<Element> payment = lv2Node.getChildren();
								String taxAssessedAmountValue = "";
								for(Element lv5Node : payment) {
									if(lv5Node.getName().equals("TaxAssessedAmount")) {
										taxAssessedAmountValue = lv5Node.getText();
									}
								}
								returnMap.put(targetKeyName, taxAssessedAmountValue);
							}
						}
					} // End DutyTaxFee if
					else if(dec.getName().equals("GoodsShipment")){	//<wco:GoodsShipment>  양도물품 시작 (1 .. 999)
						List<Element> goodsShipment = dec.getChildren();
						Map<String, Object> goodsShipmenMap = new HashMap();
						for(Element lv2Node : goodsShipment){
							if(lv2Node.getName().equals("SequenceNumeric")) {  // 양도물품행번호 
								goodsShipmenMap.put("SEQ", lv2Node.getText());
							}else if(lv2Node.getName().equals("AdditionalDocument")) {
								List<Element> additionalDocument = lv2Node.getChildren();
								Element id = additionalDocument.get(0);
								goodsShipmenMap.put("BASIS_DOC_NO", id.getText()); // 근거서류번호
							}else if(lv2Node.getName().equals("GovernmentAgencyGoodsItem")) {
								List<Element> governmentAgencyGoodsItem = lv2Node.getChildren();
								for(Element lv3Node : governmentAgencyGoodsItem){
									if(lv3Node.getName().equals("AdditionalDocument")) {
										List<Element> additionalDocument = lv3Node.getChildren();
										for(Element lv4Node : additionalDocument){
											if(lv4Node.getName().equals("ID")) {
												goodsShipmenMap.put("IMPDEC_NO", lv4Node.getText()); // 신고(증명)번호
											}else if(lv4Node.getName().equals("SequenceNumeric")) {
												goodsShipmenMap.put("LNE_NO", lv4Node.getText()); // 신고(증명)번호_란번호
											}
										}
									} else if(lv3Node.getName().equals("AdditionalInformation")) {
										List<Element> additionalInformation = lv3Node.getChildren();
										goodsShipmenMap.put("POUCH_NO", additionalInformation.get(0).getText()); // 신고(증명)번호_규격번호
									}else if(lv3Node.getName().equals("Commodity")) {
										List<Element> commodity = lv3Node.getChildren();
										for(Element lv4Node : commodity){
											if(lv4Node.getName().equals("CargoDescription")) { // 품명및규격
												goodsShipmenMap.put("ITEM_NM", lv4Node.getText());
											}else if(lv4Node.getName().equals("CharacteristicCode")) { // 원재료구분코드
												goodsShipmenMap.put("RAWMTRL_SE", lv4Node.getText());
											}else if(lv4Node.getName().equals("ID")) { // 부품식별번호
												goodsShipmenMap.put("RAWMTRL_CODE", lv4Node.getText());
											}else if(lv4Node.getName().equals("Name")) { // 상표
												goodsShipmenMap.put("GOODS_BRAND", lv4Node.getText());
											}else if(lv4Node.getName().equals("SizeMeasure")) { // 물량(단위)
												//물량
												goodsShipmenMap.put("USGQTY", lv4Node.getText());
												//단위
												goodsShipmenMap.put("BASS_UNIT", lv4Node.getAttributeValue("kcsUnitCode"));
											}else if(lv4Node.getName().equals("ValueAmount")) { // 공급가격(단위)
												//공급가격
												goodsShipmenMap.put("STTEMNT_PC_KRW", lv4Node.getText());
												//단위
												goodsShipmenMap.put("ACPLC_CRNCY", lv4Node.getAttributeValue("currencyID"));
												
												
											}else if(lv4Node.getName().equals("DutyTaxFee")) { // 세액
												List<Element> dutyTaxFee = lv4Node.getChildren();
												String taxType = "";
												String targetKeyName = "";
												for(Element lv5Node : dutyTaxFee){
													if(lv5Node.getName().equals("TypeCode")) {
														taxType = lv5Node.getText();
														//세액구분(관세액(CUD)/개별소비세액(IND)/교통에너지환경세액(5AA)/주세(ACT)/교육세(5AB)/농특세(CAP)/세액합계(5CZ))
														if("CUD".equalsIgnoreCase(taxType)) {
															targetKeyName = "CSTMS";
														}else if("IND".equalsIgnoreCase(taxType)) {
															targetKeyName = "INTTAX";
														}else if("5AA".equalsIgnoreCase(taxType)) {
															targetKeyName = "TRANTAX";
														}else if("ACT".equalsIgnoreCase(taxType)) {
															targetKeyName = "LQTX_AMOUNT";
														}else if("5AB".equalsIgnoreCase(taxType)) {
															targetKeyName = "ECX_AMOUNT";
														}else if("CAP".equalsIgnoreCase(taxType)) {
															targetKeyName = "AGSPT";
														}else if("5CZ".equalsIgnoreCase(taxType)) {
															targetKeyName = "TOT_TAX";
														}
													}else if(lv5Node.getName().equals("Payment")) {
														List<Element> payment = lv5Node.getChildren();
														String taxAssessedAmountValue = "";
														for(Element lv6Node : payment) {
															if(lv6Node.getName().equals("TaxAssessedAmount")) {
																taxAssessedAmountValue = lv6Node.getText();
															}
														}
														goodsShipmenMap.put(targetKeyName, taxAssessedAmountValue);
													}
												}
											}
										}
										
									}else if(lv3Node.getName().equals("Origin")) { // 원산지
										List<Element> origin = lv3Node.getChildren();
										goodsShipmenMap.put("ORGIN_NATION_CODE", origin.get(0).getText());
									
									}else if(lv3Node.getName().equals("PreviousDocument")) { // 수출이행기준일자
										List<Element> previousDocument = lv3Node.getChildren();
										goodsShipmenMap.put("EXP_REF_DATE", previousDocument.get(0).getText());
										
									}
								}
							}
						}  /// goodsShipment Loop End
						goodsShipmentList.add(goodsShipmenMap);
					} else if(dec.getName().equals("Submitter")){	//<wco:Submitter>  신고대행관세사번호
						List<Element> submitter = dec.getChildren();
						Element taxAssessedAmount = submitter.get(0);
						returnMap.put("CSTBRKR", taxAssessedAmount.getText());
					}
				} // End Declaration for
			} // End Declaration if
		}
		returnMap.put("GOODS_SHIPMENT", goodsShipmentList);
		return returnMap;
	}
	
	
	
	
	
	/**
	 * Xml 생성
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result createXml_Drwb(Map<String, Object> param, List<Map> workList) throws Exception {
	    	Result rs = new Result();
	    	String presentn_no = "";
	    	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
	    	for(int inx = 0; inx < workList.size(); inx++) {
	    		Map rowMap = workList.get(inx);
	    		presentn_no = StringUtil.null2String(rowMap.get("PRESENTN_NO"));
	    		Map returnMap = createXmlDocForDrawbackDoc(param, presentn_no);
	    		rowMap.putAll(returnMap);
	    		returnList.add(rowMap);
	    	}
	    	rs.setSuccess(true);
	    	rs.setValue(returnList);
	    	return rs;
	    	
	 }
	
	/**
	 * 환급 신청서 송신 이후 상태 값 처리 
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateDrwbStatus(Map<String, Object> param, List<Map> workList) throws Exception {
		return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateDrwbStatus(row));
	}
	
	/**
	 * 기납증/분증 Xml 생성
	 * 
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result createXml_init_part(Map<String, Object> param, List<Map> workList) throws Exception {
		Result rs = new Result();
		String presentn_no = "";
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();

		for (int inx = 0; inx < workList.size(); inx++) {
			Map rowMap = workList.get(inx);
			param.putAll(rowMap);
			presentn_no = StringUtil.null2String(rowMap.get("PRESENTN_NO"));

			Map returnMap = null;

			switch (rowMap.get("ISSUE_TYPE") + "") {
			case "02": // 기납증
				returnMap = createXmlDocForInit(param, presentn_no);
				break;
			case "04": // 분증
				returnMap = createXmlDocForPartial(param, presentn_no);
				break;
			default:
				continue;
			}

			rowMap.putAll(returnMap);
			returnList.add(rowMap);
		}

		rs.setSuccess(true);
		rs.setValue(returnList);
		return rs;

	}

	/**
	 * 송신 : 분증
	 * 
	 * @param param
	 * @param presentnNo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> createXmlDocForPartial(Map param, String presentnNo) throws Exception {

		Map returnMap = new HashMap<String, Object>();
		Map paramMap = new HashMap<String, Object>();
		paramMap.putAll(param);
		paramMap.put("PRESENTN_NO", presentnNo);

		returnMap.put("PRESENTN_NO", presentnNo);

		// Tax 종류
		String[] taxArray = { "CUD", "IND", "5AA", "ACT", "5AB", "CAP", "5CZ" };

		// Name 스페이스 정의
		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DESchemaModule:1:0");
		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DESchemaModule:1:0");
		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");

		// root element 만들기
		Element Declaration = new Element("Declaration", wco);

		// Name 스페이스 설정
		Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DESchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_5DESchemaModule_1.0_standard.xsd",xsi);
		Declaration.addNamespaceDeclaration(kcs);
		Declaration.addNamespaceDeclaration(xsi);

		/**
		 * ****** XML 생성용 <갑> 데이터 조회 ****** @param param ****** @return
		 */
		logger.debug(" Xml Content Parsing Start : " + presentnNo);

		
		String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_cmmn(paramMap);

		if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
			/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
			sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
			/* 제출번호 xml 생성할때마다 재생성 */
			sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_init_part(paramMap);
		}
		
		


		Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_partial(paramMap);

		returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
		returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
		returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
		returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

		logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);
		// 신청세관부호 Declaration/DeclarationOfficeID
		Declaration.addContent(new Element("DeclarationOfficeID", wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
		// 제출번호 Declaration/ID
		Declaration.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
		// 문서형태구분 Declaration/TypeCode
		Declaration.addContent(new Element("TypeCode", wco).setText(StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE"))));
		// 해당사유 Declaration/Reason
		Declaration.addContent(new Element("Reason", kcs).setText(StringUtil.null2String(retrieveMap.get("DECLARATION_REASON"))));

		/**
		 * Declaration/AdditionalCode
		 */
		 /*
		Element DeclareAC = new Element("AdditionalCode", wco);
			// 동질원재료전체사용여부 Declaration/AdditionalCode/TotalUseCode
			DeclareAC.addContent(new Element("TotalUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get("ADD_CODE_TOTALUSE"))));
			// 생산공정투입지연여부 Declaration/AdditionalCode/PutDelayCode
			DeclareAC.addContent(new Element("PutDelayCode", kcs).setText(StringUtil.null2String(retrieveMap.get("ADD_CODE_PUTDELAY"))));
			// 생산공정3월이상소요여부 Declaration/AdditionalCode/RequirementCode
			DeclareAC.addContent(new Element("RequirementCode", kcs).setText(StringUtil.null2String(retrieveMap.get("ADD_CODE_REQUIRE"))));
			// 기타사유수입원재료사용여부 Declaration/AdditionalCode/RawMaterialUseCode
			DeclareAC.addContent(new Element("RawMaterialUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get("ADD_CODE_RAWMATERIAL"))));
		Declaration.addContent(DeclareAC);
		*/

		/**
		 * Declaration/AdditionalDocument
		 */
		Element DeclareAD = new Element("AdditionalDocument", wco);
			// 증빙자료명 Declaration/AdditionalDocument/Name
			DeclareAD.addContent(new Element("Name", wco).setText(StringUtil.null2String(retrieveMap.get("ADD_DOC_NAME"))));
		Declaration.addContent(DeclareAD);

		/**
		 * Declaration/AdditionalInformation
		 */
		Element DeclareAI = new Element("AdditionalInformation", wco);
			// 원재료개별법적용여부 Declaration/AdditionalInformation/StatementCode
			DeclareAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(retrieveMap.get("ADD_INFO_CODE"))));
			// 원재료선입선출법적용여부 Declaration/AdditionalInformation/StatementTypeCode
			DeclareAI.addContent(new Element("StatementTypeCode", wco).setText(StringUtil.null2String(retrieveMap.get("ADD_INFO_TYPE_CODE"))));
			// 양도(매입)일자 Declaration/AdditionalInformation/AlienationDateTime
			DeclareAI.addContent(new Element("AlienationDateTime", kcs).setText(StringUtil.null2String(retrieveMap.get("CHIT_FRMTRM_DATE"))));
		Declaration.addContent(DeclareAI);

		/**
		 * Declaration/Agent
		 */
		Element DeclareAgent = new Element("Agent", wco);
			// 신고대행관세사번호 Declaration/Agent/ID
			DeclareAgent.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("AGENT_ID"))));
		Declaration.addContent(DeclareAgent);

		/**
		 * Declaration/AttachedDocument
		 * ********************************************************제한규정관련 나중에 수정
		 */
		Element DeclareAttachedDoc = new Element("AttachedDocument", wco);
//		// 해당세율수입원재료전체사용여부 Declaration/AttachedDocument/RawMaterialAllUseCode
//		DeclareAttachedDoc.addContent(
//				new Element("RawMaterialAllUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 생산구분사용여부 Declaration/AttachedDocument/ProductionDivisionUseCode
//		DeclareAttachedDoc.addContent(
//				new Element("ProductionDivisionUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 단일세율수입여부 Declaration/AttachedDocument/ShortdayTaxrateImportCode
//		DeclareAttachedDoc.addContent(
//				new Element("ShortdayTaxrateImportCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 원재료개별법적용여부 Declaration/AttachedDocument/RawMaterialIndividualLawUseCode
//		DeclareAttachedDoc.addContent(new Element("RawMaterialIndividualLawUseCode", kcs)
//				.setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 원재료선입선출법적용여부 Declaration/AttachedDocument/RawMaterialFifoUseCode
//		DeclareAttachedDoc.addContent(
//				new Element("RawMaterialFifoUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 중소기업자여부 Declaration/AttachedDocument/SmallEnterpriseCode
//		DeclareAttachedDoc.addContent(
//				new Element("SmallEnterpriseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 기타실제사용원재료신청여부 Declaration/AttachedDocument/OtherActualUseApplicationCode
//		DeclareAttachedDoc.addContent(
//				new Element("OtherActualUseApplicationCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 증빙자료명 Declaration/AttachedDocument/EvidenceMaterialDescriptionText
//		DeclareAttachedDoc.addContent(new Element("EvidenceMaterialDescriptionText", kcs)
//				.setText(StringUtil.null2String(retrieveMap.get(""))));
		Declaration.addContent(DeclareAttachedDoc);

		/**
		 * Declaration/Consignment
		 */
		Element DeclareConsign = new Element("Consignment", wco);
		/**
		 * 세율별 환급사용물량 제한배제내역
		 * Declaration/Consignment/AdditionalInformation
		 */
		 /*
		Element ConsignAI = new Element("AdditionalInformation", wco);
			// 비고 Declaration/Consignment/AdditionalInformation/Content
			ConsignAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 수입 관세율 Declaration/Consignment/AdditionalInformation/StatementCode
			ConsignAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 배제제한내역행번호 Declaration/Consignment/AdditionalInformation/StatementDescription
			ConsignAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료식별번호 Declaration/Consignment/AdditionalInformation/AdjustmentDescription
			ConsignAI.addContent(new Element("AdjustmentDescription", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// HS부호 Declaration/Consignment/AdditionalInformation/StoragePlace
			ConsignAI.addContent(new Element("StoragePlace", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
		DeclareConsign.addContent(ConsignAI);
		*/
		/**
		 * 세율별 환급사용물량 조정내역 
		 * Declaration/Consignment/BorderTransportMeans
		 */
		/*
		Element ConsignBTM = new Element("BorderTransportMeans", wco);
			// 부족세율 Declaration/Consignment/BorderTransportMeans/BunkerFuelValueAmount
			ConsignBTM.addContent(new Element("BunkerFuelValueAmount", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// HS부호 Declaration/Consignment/BorderTransportMeans/CrewQuantity
			ConsignBTM.addContent(new Element("CrewQuantity", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 조정내역행번호 Declaration/Consignment/BorderTransportMeans/ID
			ConsignBTM.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료식별번호 Declaration/Consignment/BorderTransportMeans/JourneyID
			ConsignBTM.addContent(new Element("JourneyID", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 부족환급물량(부족물량단위) Declaration/Consignment/BorderTransportMeans/LengthMeasure
			ConsignBTM.addContent(new Element("LengthMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("kcsUnitCode"))).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 비고 Declaration/Consignment/BorderTransportMeans/Name
			ConsignBTM.addContent(new Element("Name", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 환급적용물량(적용물량단위) Declaration/Consignment/BorderTransportMeans/NetWeightMeasure
			ConsignBTM.addContent(new Element("NetWeightMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("kcsUnitCode"))).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 환급사용세율 Declaration/Consignment/BorderTransportMeans/SecurityLevelCode
			ConsignBTM.addContent(new Element("SecurityLevelCode", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		DeclareConsign.addContent(ConsignBTM);
		*/
		/**
		 * Declaration/Consignment/Consignee
		 */
		Element Cosignee = new Element("Consignee", wco);
			// 양수자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignee/ID
			Cosignee.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380").setText(StringUtil.null2String(retrieveMap.get("CSTMR_ECTMRK"))));
			// 양수자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignee/ID
			Cosignee.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX").setText(StringUtil.null2String(retrieveMap.get("CSTMR_BIZRNO"))));
		DeclareConsign.addContent(Cosignee);

		/**
		 * Declaration/Consignment/ConsignmentItem
		 */
		Element ConsignItem = new Element("ConsignmentItem", wco);

		/**
		 * Declaration/Consignment/ConsignmentItem/Commodity
		 */
		Element ConsignItemCM = new Element("Commodity", wco);
			// 총양도물량(단위) Declaration/Consignment/ConsignmentItem/Commodity/SizeMeasure
			ConsignItemCM.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("BASS_UNIT"))).setText(StringUtil.null2String(retrieveMap.get("ACCMLT_ORDER_QY"))));
			// 총공급가격(단위) Declaration/Consignment/ConsignmentItem/Commodity/ValueAmount
			ConsignItemCM.addContent(new Element("ValueAmount", wco).setAttribute("currencyID", StringUtil.null2String(retrieveMap.get("ACPLC_CRNCY"))).setText(StringUtil.null2String(retrieveMap.get("STTEMNT_PC_KRW"))));
		
		/**
		 * Declaration/Consignment/ConsignmentItem/Commodity/Classification
		 */
		Element ConsignItemCF = new Element("Classification", wco);
			// HS부호 Declaration/Consignment/ConsignmentItem/Commodity/Classification/ID
			ConsignItemCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("HS_CODE"))));
		ConsignItemCM.addContent(ConsignItemCF);
		ConsignItem.addContent(ConsignItemCM);
		DeclareConsign.addContent(ConsignItem);

		/**
		 * Declaration/Consignment/Consignor
		 **/
		Element Consignor = new Element("Consignor", wco);
			// 양도자_통관고유부호 Declaration/Consignment/Consignor/ID
			Consignor.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380").setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
			// 양도자_통관고유부호 Declaration/Consignment/Consignor/ID
			Consignor.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX").setText(StringUtil.null2String(retrieveMap.get("BIZRNO"))));

		/**
		 * Declaration/Consignment/Consignor/Communication
		 **/
		Element ConsignorCommu = new Element("Communication", wco);
			// 앙도자_연락처 Declaration/Consignment/Consignor/Communication/ID
			ConsignorCommu.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("TELNO_1"))));
		Consignor.addContent(ConsignorCommu);
		DeclareConsign.addContent(Consignor);
		Declaration.addContent(DeclareConsign);

		// ======================================================
		// <!--1..7 반복--> 시작
		// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
		// ======================================================*/
		for (int i = 0; i < taxArray.length; i++) {
			Element DeclareTaxFee = new Element("DutyTaxFee", wco);
			DeclareTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[i]));
			Element DeclareTaxFeePay = new Element("Payment", wco);
			DeclareTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(retrieveMap.get(taxArray[i]))));
			DeclareTaxFee.addContent(DeclareTaxFeePay);
			Declaration.addContent(DeclareTaxFee);
		}

		logger.debug("<갑> - xml 데이터 종료 : " + presentnNo);
		// ======================================================
		// <!--1..7 반복--> 종료
		// ======================================================*/

		/**
		 * ****** XML 생성용 <을> 데이터 조회 ****** @param param ****** @return
		 */
		List<Map<String, Object>> thnglList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_partial_thng(paramMap);

		logger.debug("<을> - xml 데이터 생성 : " + presentnNo);

		for (int i = 0; i < thnglList.size(); i++) {
			Map<String, Object> thngl = (Map) thnglList.get(i);

			/**
			 * Declaration/GoodsShipment
			 **/
			Element DeclareGS = new Element("GoodsShipment", wco);
				// 물품행번호 Declaration/GoodsShipment/SequenceNumeric
				DeclareGS.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(thngl.get("LINE_NUMBER"))));

			/**
			 * Declaration/GoodsShipment/AdditionalDocument
			 **/
			Element GSAD = new Element("AdditionalDocument", wco);
				// 근거서류번호 Declaration/GoodsShipment/AdditionalDocument/ID
				GSAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(thngl.get("BASIS_DOC_NO"))));
			DeclareGS.addContent(GSAD);

			/**
			 * Declaration/GoodsShipment/Consignee
			 **/
			Element GSConsignee = new Element("Consignee", wco);
				// 양수자용식별번호 Declaration/GoodsShipment/Consignee/ID
				GSConsignee.addContent(new Element("ID", wco).setText(StringUtil.null2String(thngl.get("RAWMTRL_CODE"))));
			DeclareGS.addContent(GSConsignee);

			/**
			 * Declaration/GoodsShipment/Consignment
			 **/
			Element GSConsignment = new Element("Consignment", wco);
				// 공급가격 Declaration/GoodsShipment/Consignment/ValueAmount
				GSConsignment.addContent(new Element("ValueAmount", wco).setAttribute("currencyID", StringUtil.null2String(thngl.get("ACPLC_CRNCY"))).setText(StringUtil.null2String(thngl.get("STTEMNT_PC_KRW"))));
			DeclareGS.addContent(GSConsignment);

			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem
			 **/
			Element GSGAgItem = new Element("GovernmentAgencyGoodsItem", wco);
			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument
			 **/
			Element GSGAgItemAD = new Element("AdditionalDocument", wco);
				// 신고(증명)번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/ID
				GSGAgItemAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(thngl.get("IMPDEC_NO"))));
				// 양도(매입)일자(CCYYMMDD)
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/IssueDateTime
				GSGAgItemAD.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(thngl.get("ACPT_DATE"))));
				// 신고(증명)번호_란번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/SequenceNumeric
				GSGAgItemAD.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(thngl.get("LNE_NO"))));
			GSGAgItem.addContent(GSGAgItemAD);

			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation
			 **/
			Element GSGAgItemAI = new Element("AdditionalInformation", wco);
				// 신고(증명)번호_규격번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/Content
				GSGAgItemAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(thngl.get("POUCH_NO"))));
			GSGAgItem.addContent(GSGAgItemAI);

			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
			 **/
			Element GSGAgItemCOMM = new Element("Commodity", wco);
				// 품명 및 규격-
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/CargoDescription
				GSGAgItemCOMM.addContent(new Element("CargoDescription", wco).setText(StringUtil.null2String(thngl.get("ITEM_NM"))));
				// 원재료구분
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/CharacteristicCode
				GSGAgItemCOMM.addContent(new Element("CharacteristicCode", wco).setText(StringUtil.null2String(thngl.get("RAWMTRL_SE"))));
				// 부품식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/ID
				GSGAgItemCOMM.addContent(new Element("ID", wco).setText(StringUtil.null2String(thngl.get("RAWMTRL_CODE"))));
				// 상표 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Name
				GSGAgItemCOMM.addContent(new Element("Name", wco).setText(StringUtil.null2String(thngl.get("GOODS_BRAND"))));
				// 물량(단위)
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/SizeMeasure
				GSGAgItemCOMM.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(thngl.get("BASS_UNIT"))).setText(StringUtil.null2String(thngl.get("USGQTY"))));

			// ======================================================
			// <!--1..7 반복-->
			// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
			// ======================================================*/

			for (int j = 0; j < taxArray.length; j++) {

				String tax = taxArray[j];

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee
				 **/
				Element GSGAgItemTaxFree = new Element("DutyTaxFee", wco);
				GSGAgItemTaxFree.addContent(new Element("TypeCode", wco).setText(tax));

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/DutyTaxFee/Commodity/Payment
				 */
				Element GSGAgItemTaxFreePay = new Element("Payment", wco);
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/DutyTaxFee/Payment/TaxAssessedAmount
					GSGAgItemTaxFreePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(thngl.get(tax))));
				GSGAgItemTaxFree.addContent(GSGAgItemTaxFreePay);
				GSGAgItemCOMM.addContent(GSGAgItemTaxFree);
			}

			// ======================================================
			// <!--1..7 반복--> 종료
			// ======================================================

			GSGAgItem.addContent(GSGAgItemCOMM);

			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Origin
			 **/
			Element GSGAgItemOrigin = new Element("Origin", wco);
			// 원산지 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Origin/CountryCode
			GSGAgItemOrigin.addContent(new Element("CountryCode", wco).setText(StringUtil.null2String(thngl.get("ORGIN_NATION_CODE"))));
			GSGAgItem.addContent(GSGAgItemOrigin);

			/**
			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/PreviousDocument
			 **/
			Element GSGAgItemPDoc = new Element("PreviousDocument", wco);
			// 수출이행기준일자
			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/PreviousDocument/IssueDateTime
			GSGAgItemPDoc.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(thngl.get("DATE_EX"))));
			GSGAgItem.addContent(GSGAgItemPDoc);
			DeclareGS.addContent(GSGAgItem);
			Declaration.addContent(DeclareGS);
		}

		logger.debug("<을> - xml 데이터 종료 : " + presentnNo);

		// ===========================================================
		// <!--0..99999--> 분할증명서_수입신고필증 유효기간 단축배제 내역 시작
		// ============================================================

		ArrayList prevDocList = new ArrayList();

		for (int i = 0; i < prevDocList.size(); i++) {
			Map DeclarePrevDocMap = (Map) prevDocList.get(i);

			/**
			 * Declaration/PreviousDocument
			 **/
			Element PrevDoc = new Element("PreviousDocument", wco);
				// 수입신고번호 Declaration/PreviousDocument/ID
				PrevDoc.addContent(new Element("ID", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
				// 수리일자(CCYYMMDD) Declaration/PreviousDocument/IssueDateTime
				PrevDoc.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
				// 배제내역행번호 Declaration/PreviousDocument/LineNumeric
				PrevDoc.addContent(new Element("LineNumeric", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
				// 수입신고란번호 Declaration/PreviousDocument/SequenceNumeric
				PrevDoc.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
				// 수입신고규격번호 Declaration/PreviousDocument/ID
				PrevDoc.addContent(new Element("DescriptionNumber", kcs).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));

			/**
			 * Declaration/PreviousDocument/Commodity
			 **/
			Element PrevDocComm = new Element("PreviousDocument", wco);
				// 품명및규격 Declaration/PreviousDocument/Commodity/Description
				PrevDocComm.addContent(new Element("Description", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
				// 사용량 Declaration/PreviousDocument/Commodity/SizeMeasure
				PrevDocComm.addContent(new Element("SizeMeasure", wco).setText(StringUtil.null2String(DeclarePrevDocMap.get(""))));
			PrevDoc.addContent(PrevDocComm);
			Declaration.addContent(PrevDoc);
		}

		// ===========================================================
		// <!--0..99999--> 분할증명서_수입신고필증 유효기간 단축배제 내역 종료
		// ============================================================

		logger.debug("Xml Parsing End");

		logger.debug("FILE 생성 시작 : " + presentnNo);

		FileOutputStream fos = null;
		OutputStreamWriter writer = null;

		try {
			Document myDoc = new Document(Declaration);

			XMLOutputter outputter = new XMLOutputter();
			Format format = outputter.getFormat();
			outputter.setFormat(Format.getPrettyFormat());

			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
					.getConfigurator("app_resource");

			// XML 파일 명
			String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

			String workPath = configurator.getString("file.xml.dir");
			String sendPath = configurator.getString("file.sendxml.dir");
			String receivePath = configurator.getString("file.xmlreceive.dir");

			String backupPath = configurator.getString("file.xmlbackup.dir");

			// String basePath = req.getSession().getServletContext().getRealPath(workPath);
			String basePath = configurator.getString("file.xml.dir");

			String outputFolder = basePath + sendPath;
			String receiveFolder = basePath + receivePath;
			//String backupFolder = basePath + receivePath + "/" + backupPath;
			String backupFolder =  backupPath;

			File senddir = new File(outputFolder); // 송신 DIR
			File receivedir = new File(receiveFolder); // 수신 DIR
			File backupdir = new File(backupFolder); // 수신 Backup DIR

			// 송신폴더 생성
			if (!senddir.isDirectory()) {
				senddir.mkdirs();
			}

			// 수신폴더 생성
			if (!receivedir.isDirectory()) {
				receivedir.mkdirs();
			}

			// 백업폴더 생성
			if (!backupdir.isDirectory()) {
				backupdir.mkdirs();
			}

			fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
			writer = new OutputStreamWriter(fos, "utf-8");
			outputter.output(myDoc, writer);

		} catch (Exception e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		} finally {
			writer.close();
		}

		logger.debug("Create Xml Parsing End");

		return returnMap;
	}
	//-----------------------
	/**
	 * 송신 : 기납증
	 * 
	 * @param param
	 * @param presentnNo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> createXmlDocForInit(Map param, String presentnNo) throws Exception {

		Map returnMap = new HashMap<String, Object>();
		Map paramMap = new HashMap<String, Object>();
		paramMap.putAll(param);
		paramMap.put("PRESENTN_NO", presentnNo);

		returnMap.put("PRESENTN_NO", presentnNo);

		// XML 생성 시작
		Map xmlMap = new HashMap();

		// Tax 종류
		String[] taxArray = { "CUD", "IND", "5AA", "ACT", "5AB", "CAP", "5CZ" };

		// Name 스페이스 정의
		Namespace kcs = Namespace.getNamespace("kcs","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DBSchemaModule:1:0");
		Namespace wco = Namespace.getNamespace("wco","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DBSchemaModule:1:0");
		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");

		// root element 만들기
		Element Declaration = new Element("Declaration", wco);

		// Name 스페이스 설정
		Declaration.setAttribute("schemaLocation","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_5DBSchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_5DBSchemaModule_1.0_standard.xsd",xsi);
		Declaration.addNamespaceDeclaration(kcs);
		Declaration.addNamespaceDeclaration(xsi);

		/**
		 * ****** XML 생성용 <갑> 데이터 조회 ****** @param param ****** @return
		 */
		logger.debug(" Xml Content Parsing Start : " + presentnNo);

		String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_cmmn(paramMap);

		if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
			/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
			sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
			/* 제출번호 xml 생성할때마다 재생성 */
			sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_init_part(paramMap);
		}
		


		Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_init(paramMap);

		returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
		returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
		returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
		returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

		logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);
		// 신청세관부호 Declaration/DeclarationOfficeID
		Declaration.addContent(new Element("DeclarationOfficeID", wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
		// 제출번호 Declaration/ID
		Declaration.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
		// 문서형태구분(GOVCBR5DB) Declaration/TypeCode
		Declaration.addContent(new Element("TypeCode", wco).setText(StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE"))));
		// 환급구분 Declaration/TransactionNatureCode
		Declaration.addContent(new Element("TransactionNatureCode", wco).setText(StringUtil.null2String(retrieveMap.get("DRWBAK_SE_CODE"))));
		// 해당사유 Declaration/Reason
		Declaration.addContent(new Element("Reason", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));

		/**
		 * Declaration/AdditionalCode
		 */
//		Element DeclareAC = new Element("AdditionalCode", wco);
//		// 동질원재료전체사용여부 Declaration/AdditionalCode/TotalUseCode
//		DeclareAC.addContent(new Element("TotalUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 생산공정투입지연여부 Declaration/AdditionalCode/PutDelayCode
//		DeclareAC.addContent(new Element("PutDelayCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 생산공정3월이상소요여부 Declaration/AdditionalCode/RequirementCode
//		DeclareAC.addContent(new Element("RequirementCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		// 기타사유수입원재료사용여부 Declaration/AdditionalCode/RawMaterialUseCode
//		DeclareAC.addContent(
//				new Element("RawMaterialUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
//		Declaration.addContent(DeclareAC);

		/**
		 * Declaration/AdditionalDocument
		 */
		Element DeclareAD = new Element("AdditionalDocument", wco);
			// 수출이행기준일자 Declaration/AdditionalDocument/IssueDateTime
			DeclareAD.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(retrieveMap.get("DATE_EX"))));
			// 증빙자료명 Declaration/AdditionalDocument/Name
			DeclareAD.addContent(new Element("Name", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		Declaration.addContent(DeclareAD);

		/**
		 * Declaration/AdditionalInformation
		 */
		Element DeclareAI = new Element("AdditionalInformation", wco);
			// 원재료개별법적용여부 Declaration/AdditionalInformation/StatementCode
			DeclareAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료선입선출법적용여부 Declaration/AdditionalInformation/StatementTypeCode
			DeclareAI.addContent(new Element("StatementTypeCode", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 양도(매입)일자 Declaration/AdditionalInformation/AlienationDateTime
			DeclareAI.addContent(new Element("AlienationDateTime", kcs).setText(StringUtil.null2String(retrieveMap.get("CHIT_FRMTRM_DATE"))));
		Declaration.addContent(DeclareAI);

		/**
		 * Declaration/Agent
		 */
		Element DeclareAgent = new Element("Agent", wco);
			// 신고대행관세사번호 Declaration/Agent/ID
			DeclareAgent.addContent(new Element("ID", wco).setText(StringUtil.null2String(null)));
		Declaration.addContent(DeclareAgent);

		/**
		 * Declaration/AttachedDocument
		 */
		Element DeclareAttachedDoc = new Element("AttachedDocument", wco);
			// 해당세율수입원재료전체사용여부 Declaration/AttachedDocument/RawMaterialAllUseCode
			DeclareAttachedDoc.addContent(new Element("RawMaterialAllUseCode", kcs).setText(StringUtil.null2String(null)));
			// 생산구분사용여부 Declaration/AttachedDocument/ProductionDivisionUseCode
			DeclareAttachedDoc.addContent(new Element("ProductionDivisionUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 단일세율수입여부 Declaration/AttachedDocument/ShortdayTaxrateImportCode
			DeclareAttachedDoc.addContent(new Element("ShortdayTaxrateImportCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료개별법적용여부 Declaration/AttachedDocument/RawMaterialIndividualLawUseCode
			DeclareAttachedDoc.addContent(new Element("RawMaterialIndividualLawUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료선입선출법적용여부 Declaration/AttachedDocument/RawMaterialFifoUseCode
			DeclareAttachedDoc.addContent(new Element("RawMaterialFifoUseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 중소기업자여부 Declaration/AttachedDocument/SmallEnterpriseCode
			DeclareAttachedDoc.addContent(new Element("SmallEnterpriseCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 기타실제사용원재료신청여부 Declaration/AttachedDocument/OtherActualUseApplicationCode
			DeclareAttachedDoc.addContent(new Element("OtherActualUseApplicationCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 증빙자료명 Declaration/AttachedDocument/EvidenceMaterialDescriptionText
			DeclareAttachedDoc.addContent(new Element("EvidenceMaterialDescriptionText", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
		Declaration.addContent(DeclareAttachedDoc);

		/**
		 * Declaration/Consignment
		 */
		Element DeclareConsign = new Element("Consignment", wco);

		// 환급부호 Declaration/Consignment/BOMTypeCode
		// 세율별 환급사용물량 사유서 제한배제 공통항목이 없습니다. 에 대한 처리
		DeclareConsign.addContent(new Element("BOMTypeCode", kcs).setText(StringUtil.null2String(retrieveMap.get("REQREQY_CALC_MTH"))));
		//DeclareConsign.addContent(new Element("BOMTypeCode", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));

		/**
		 * Declaration/Consignment/AdditionalInformation
		 */
		/*
		Element ConsignAI = new Element("AdditionalInformation", wco);
			// 비고 Declaration/Consignment/AdditionalInformation/Content
			ConsignAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 수입 관세율 Declaration/Consignment/AdditionalInformation/StatementCode
			// ConsignAI.addContent(new Element("StatementCode",
			// wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 배제제한내역행번호 Declaration/Consignment/AdditionalInformation/StatementDescription
			ConsignAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
			// 원재료식별번호 Declaration/Consignment/AdditionalInformation/AdjustmentDescription
			ConsignAI.addContent(new Element("AdjustmentDescription", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
			// HS부호 Declaration/Consignment/AdditionalInformation/StoragePlace
			ConsignAI.addContent(new Element("StoragePlace", kcs).setText(StringUtil.null2String(retrieveMap.get(""))));
		DeclareConsign.addContent(ConsignAI);

*/
		/**
		 * Declaration/Consignment/BorderTransportMeans
		 */
		/*
		Element ConsignBTM = new Element("BorderTransportMeans", wco);
		// 부족세율 Declaration/Consignment/BorderTransportMeans/BunkerFuelValueAmount
//		ConsignBTM.addContent(
//				new Element("BunkerFuelValueAmount", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		// HS부호 Declaration/Consignment/BorderTransportMeans/CrewQuantity
		ConsignBTM.addContent(new Element("CrewQuantity", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		// 조정내역행번호 Declaration/Consignment/BorderTransportMeans/ID
		ConsignBTM.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		// 원재료식별번호 Declaration/Consignment/BorderTransportMeans/JourneyID
		ConsignBTM.addContent(new Element("JourneyID", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		// 부족환급물량(부족물량단위) Declaration/Consignment/BorderTransportMeans/LengthMeasure
//		ConsignBTM.addContent(new Element("LengthMeasure", wco)
//				.setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("kcsUnitCode")))
//				.setText(StringUtil.null2String(retrieveMap.get(""))));
		// 비고 Declaration/Consignment/BorderTransportMeans/Name
		ConsignBTM.addContent(new Element("Name", wco).setText(StringUtil.null2String(retrieveMap.get(""))));

		// 환급적용물량(적용물량단위) Declaration/Consignment/BorderTransportMeans/NetWeightMeasure
//		ConsignBTM.addContent(new Element("NetWeightMeasure", wco)
//				.setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("kcsUnitCode")))
//				.setText(StringUtil.null2String(retrieveMap.get(""))));
		// 환급사용세율 Declaration/Consignment/BorderTransportMeans/SecurityLevelCode
//		ConsignBTM
//				.addContent(new Element("SecurityLevelCode", wco).setText(StringUtil.null2String(retrieveMap.get(""))));
//		DeclareConsign.addContent(ConsignBTM);
*/
		/**
		 * Declaration/Consignment/Consignee
		 */
		Element Cosignee = new Element("Consignee", wco);
			// 양수자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignee/ID
			Cosignee.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380").setText(StringUtil.null2String(retrieveMap.get("CSTMR_ECTMRK"))));
			// 양수자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignee/ID
			Cosignee.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX").setText(StringUtil.null2String(retrieveMap.get("CSTMR_BIZRNO"))));
		DeclareConsign.addContent(Cosignee);

		/**
		 * Declaration/Consignment/ConsignmentItem
		 */
		Element ConsignItem = new Element("ConsignmentItem", wco);

		/**
		 * Declaration/Consignment/ConsignmentItem/Commodity
		 */
		Element ConsignItemCM = new Element("Commodity", wco);
			// 총양도물량(단위) Declaration/Consignment/ConsignmentItem/Commodity/SizeMeasure
			ConsignItemCM.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(retrieveMap.get("BASS_UNIT"))).setText(StringUtil.null2String(retrieveMap.get("ACCMLT_ORDER_QY"))));
	
			// 공급가격 Declaration/Consignment/ConsignmentItem/Commodity/ValueAmount
			ConsignItemCM.addContent(new Element("ValueAmount", wco).setText(StringUtil.null2String(retrieveMap.get("STTEMNT_PC_KRW"))));

		/**
		 * Declaration/Consignment/ConsignmentItem/Commodity/Classification
		 */
		Element ConsignItemCF = new Element("Classification", wco);
			// HS부호 Declaration/Consignment/ConsignmentItem/Commodity/Classification/ID
			ConsignItemCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("HS_CODE"))));
		ConsignItemCM.addContent(ConsignItemCF);

		// ===========================================================
		// <!--0..99999 수입원재료--> 시작
		// ===========================================================
		/**
		 * ****** XML 생성용 <병> 데이터 조회 ****** @param param ****** @return
		 */
		List<Map<String, Object>> ConsignItemDCList = sqlSession.getMapper(DrawbackDocDao.class)
				.retrieve_init_incme(paramMap);

		for (int i = 0; i < ConsignItemDCList.size(); i++) {
			Map ConsignItemDCMap = (Map) ConsignItemDCList.get(i);

			/**
			 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity
			 **/
			Element ConsignItemDC = new Element("DetailedCommodity", wco);
				// 수입원재료행번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/SequenceNumeric
				ConsignItemDC.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("LINE_NUMBER"))));
				// 원재료구분
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/CharacteristicCode
				ConsignItemDC.addContent(new Element("CharacteristicCode", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("RAWMTRL_SE"))));
				// 원재료식별번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/ID
				ConsignItemDC.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("RAWMTRL_CODE"))));
				// 제품식별번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/LotNumberID
				ConsignItemDC.addContent(new Element("LotNumberID", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("ITEM_CODE"))));
				// 사용물량
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/SizeMeasure
				ConsignItemDC.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(ConsignItemDCMap.get("BASS_UNIT"))).setText(StringUtil.null2String(ConsignItemDCMap.get("USGQTY"))));
				// 원재료단가
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/ValueAmount
	//			ConsignItemDC.addContent(new Element("ValueAmount", wco).setText(StringUtil.null2String(ConsignItemDCMap.get(""))));

			/**
			 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument
			 **/
			Element ConsignItemDCAD = new Element("AdditionalDocument", wco);
				// 신고(증명)번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/ID
				ConsignItemDCAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("IMPDEC_NO"))));
				// 수입(매입)일자(CCYYMMDD)
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/IssueDateTime
				ConsignItemDCAD.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("ACPT_DATE"))));
				// 신고(증명)번호_란번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalDocument/SequenceNumeric
				ConsignItemDCAD.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("LNE_NO"))));
			ConsignItemDC.addContent(ConsignItemDCAD);

			/**
			 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation
			 **/
			Element ConsignItemDCAI = new Element("AdditionalInformation", wco);
				// 신고(증명)번호_규격번호
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/Content
				ConsignItemDCAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("POUCH_NO"))));
				// 조사란구분
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/StatementCode
				ConsignItemDCAI.addContent(new Element("StatementCode", wco).setText(StringUtil.null2String(ConsignItemDCMap.get(""))));
				// 조사란비율
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/AdditionalInformation/StatementDescription
	//			ConsignItemDCAI.addContent(new Element("StatementDescription", wco).setText(StringUtil.null2String(ConsignItemDCMap.get(""))));
			ConsignItemDC.addContent(ConsignItemDCAI);

			/**
			 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/Classification
			 **/
			Element ConsignItemDCCF = new Element("Classification", wco);
			// HS부호
			// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/Classification/ID
			ConsignItemDCCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignItemDCMap.get("HS_CODE"))));
			ConsignItemDC.addContent(ConsignItemDCCF);

			// ================================================================
			// <!--1..7 반복--> 시작
			// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
			// ================================================================
			for (int j = 0; j < taxArray.length; j++) {

				/**
				 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee
				 **/
				Element ConsignItemDcTaxFee = new Element("DutyTaxFee", wco);
				ConsignItemDcTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[j]));

				/**
				 * Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee/Payment
				 **/
				Element ConsignItemDcTaxFeePay = new Element("Payment", wco);
				// 금액
				// Declaration/Consignment/ConsignmentItem/Commodity/DetailedCommodity/DutyTaxFee/Payment/TaxAssessedAmount
				ConsignItemDcTaxFeePay.addContent(new Element("TaxAssessedAmount", wco)
						.setText(StringUtil.null2String(ConsignItemDCMap.get(taxArray[j]))));
				ConsignItemDcTaxFee.addContent(ConsignItemDcTaxFeePay);
				ConsignItemDC.addContent(ConsignItemDcTaxFee);

			}

			// ================================================================
			// <!--1..7 반복--> 종료
			// ================================================================

			ConsignItemCM.addContent(ConsignItemDC);
		}

		// ================================================================
		// <!--0..99999 수입원재료--> 종료
		// ================================================================

		ConsignItem.addContent(ConsignItemCM);
		DeclareConsign.addContent(ConsignItem);

		/**
		 * Declaration/Consignment/Consignor
		 **/
		Element Consignor = new Element("Consignor", wco);
		// 양도자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignor/ID
		Consignor.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380").setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
		// 양도자_통관고유부호(380)/사업자등록번호(KTX) Declaration/Consignment/Consignor/ID
		Consignor.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX").setText(StringUtil.null2String(retrieveMap.get("BIZRNO"))));

		/**
		 * Declaration/Consignment/Consignor/Communication
		 **/
		Element ConsignorCommu = new Element("Communication", wco);
		// 앙도자_연락처 Declaration/Consignment/Consignor/Communication/ID
		ConsignorCommu.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("CSTMR_TELNO"))));
		Consignor.addContent(ConsignorCommu);
		DeclareConsign.addContent(Consignor);

		// =================================================
		// <!--0..999 양도대상물품--> 시작
		// =================================================
		/**
		 * ****** XML 생성용 <을> 데이터 조회 ****** @param param ****** @return
		 */
		List<Map<String, Object>> ConsignCMList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_init_thng(paramMap);

		for (int i = 0; i < ConsignCMList.size(); i++) {
			Map ConsignCMMap = (Map) ConsignCMList.get(i);

			/**
			 * Declaration/Consignment/Commodity
			 */
			Element ConsignCM = new Element("Commodity", wco);
			// 양도물품행번호 Declaration/Consignment/Commodity/SequenceNumeric
			ConsignCM.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(ConsignCMMap.get("LINE_NUMBER"))));
			// 품명및규격 Declaration/Consignment/Commodity/CargoDescription
			ConsignCM.addContent(new Element("CargoDescription", wco).setText(StringUtil.null2String(ConsignCMMap.get("ITEM_NM"))));
			// 제품식별번호 Declaration/Consignment/Commodity/ID
			ConsignCM.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignCMMap.get("ITEM_CODE"))));
			// 물량(단위) Declaration/Consignment/Commodity/SizeMeasure
			ConsignCM.addContent(new Element("SizeMeasure", wco).setAttribute("kcsUnitCode", StringUtil.null2String(ConsignCMMap.get("BASS_UNIT"))).setText(StringUtil.null2String(ConsignCMMap.get("ACCMLT_ORDER_QY"))));
			// 금액(통화단위) Declaration/Consignment/Commodity/ValueAmount
			ConsignCM.addContent(new Element("ValueAmount", wco).setAttribute("currencyID", StringUtil.null2String(ConsignCMMap.get("KRW_CRNCY"))).setText(StringUtil.null2String(ConsignCMMap.get("STTEMNT_PC_KRW"))));

			/**
			 * Declaration/Consignment/Commodity/AdditionalDocument
			 */
			Element ConsignCMAD = new Element("AdditionalDocument", wco);
			// 근거서류번호 Declaration/Consignment/Commodity/AdditionalDocument/ID
			ConsignCMAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(ConsignCMMap.get("BASIS_DOC_NO"))));
			ConsignCM.addContent(ConsignCMAD);

			/**
			 * Declaration/Consignment/Commodity/AdditionalInformation
			 */
			Element ConsignCMAI = new Element("AdditionalInformation", wco);
			// 양수자용제품식별번호 Declaration/Consignment/Commodity/AdditionalInformation/Content
			ConsignCMAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(ConsignCMMap.get("ITEM_CODE"))));
			ConsignCM.addContent(ConsignCMAI);

			// ======================================================
			// <!--1..7 반복--> 시작
			// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
			// ======================================================

			for (int t = 0; t < taxArray.length; t++) {

				/**
				 * Declaration/Consignment/Commodity/DutyTaxFee
				 */
				Element ConsignCmTaxFee = new Element("DutyTaxFee", wco);
				// 세액유형 Declaration/Consignment/Commodity/DutyTaxFee/TypeCode
				ConsignCmTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[t]));

				/**
				 * Declaration/Consignment/Commodity/DutyTaxFee/Payment
				 */
				Element ConsignCmTaxFeeTaxFeePay = new Element("Payment", wco);
				// 세액 Declaration/Consignment/Commodity/DutyTaxFee/Payment/TaxAssessedAmount
				ConsignCmTaxFeeTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(ConsignCMMap.get(taxArray[t]))));
				ConsignCmTaxFee.addContent(ConsignCmTaxFeeTaxFeePay);
				ConsignCM.addContent(ConsignCmTaxFee);
			}

			// ======================================================
			// <!--1..7 반복--> 종료
			// ======================================================

			DeclareConsign.addContent(ConsignCM);
		}

		// =================================================
		// <!--0..999 양도대상물품--> 종료
		// =================================================

		Declaration.addContent(DeclareConsign);

		// ======================================================
		// <!--1..7 반복--> 시작
		// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
		// ======================================================

		for (int i = 0; i < taxArray.length; i++) {

			/**
			 * Declaration/DutyTaxFee
			 */
			Element DeclareTaxFee = new Element("DutyTaxFee", wco);
			// 세액유형 DDeclaration/DutyTaxFee/DutyTaxFee/TypeCode
			DeclareTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[i]));

			/**
			 * Declaration/DutyTaxFee/Payment
			 */
			Element DeclareTaxFeePay = new Element("Payment", wco);
			// 세액유형 DDeclaration/DutyTaxFee/DutyTaxFee/Payment/TaxAssessedAmount
			DeclareTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(retrieveMap.get(taxArray[i]))));
			DeclareTaxFee.addContent(DeclareTaxFeePay);
			Declaration.addContent(DeclareTaxFee);
		}

		// ======================================================
		// <!--1..7 반복--> 종료
		// ======================================================

		/**
		 * Declaration/GoodsShipment
		 */
		Element DeclareGS = new Element("GoodsShipment", wco);

		// ======================================================
		// <!--0..999 부산물--> 시작
		// ======================================================
//		ArrayList GSConsignList = new ArrayList();
//
//		for (int i = 0; i < GSConsignList.size(); i++) {
//			Map GSConsignMap = (Map) GSConsignList.get(i);
//
//			/**
//			 * Declaration/GoodsShipment/Consignment
//			 **/
//			Element GSConsign = new Element("Consignment", wco);
//			// 부산물행번호 Declaration/GoodsShipment/SequenceNumeric
//			GSConsign.addContent(
//					new Element("SequenceNumeric", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//
//			/**
//			 * Declaration/GoodsShipment/Consignment/Commodity
//			 **/
//			Element GSCommodity = new Element("Commodity", wco);
//			// 품명및규격 Declaration/GoodsShipment/Consignment/Commodity/CargoDescription
//			GSCommodity.addContent(
//					new Element("CargoDescription", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//			// 부산물식별번호 Declaration/GoodsShipment/Consignment/Commodity/ID
//			GSCommodity.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//			// 물량(단위) Declaration/GoodsShipment/Consignment/Commodity/SizeMeasure
//			GSCommodity.addContent(new Element("SizeMeasure", wco)
//					.setAttribute("kcsUnitCode", StringUtil.null2String(GSConsignMap.get("kcsUnitCode")))
//					.setText(StringUtil.null2String(GSConsignMap.get(""))));
//			// 가격(원) Declaration/GoodsShipment/Consignment/Commodity/ValueAmount
//			GSCommodity
//					.addContent(new Element("ValueAmount", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//
//			/**
//			 * Declaration/GoodsShipment/Consignment/Commodity/Classification
//			 **/
//			Element GSCommodityCF = new Element("Classification", wco);
//			// HS부호 Declaration/GoodsShipment/Consignment/Commodity/Classification/ID
//			GSCommodityCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//			GSCommodity.addContent(GSCommodityCF);
//			GSConsign.addContent(GSCommodity);
//
//			// ======================================================
//			// <!--1..7 반복--> 시작
//			// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
//			// ======================================================
//
//			for (int j = 0; j < taxArray.length; j++) {
//
//				/**
//				 * Declaration/GoodsShipment/Consignment/DutyTaxFee
//				 **/
//				Element GSTaxFee = new Element("DutyTaxFee", wco);
//				// 세액구분 Declaration/GoodsShipment/Consignment/DutyTaxFee/TypeCode
//				GSTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[j]));
//
//				/**
//				 * Declaration/GoodsShipment/Consignment/DutyTaxFee/Payment
//				 **/
//				Element DGSTaxFeePay = new Element("Payment", wco);
//				// 세액구분
//				// Declaration/GoodsShipment/Consignment/DutyTaxFee/Payment/TaxAssessedAmount
//				DGSTaxFeePay.addContent(
//						new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(GSConsignMap.get(""))));
//				GSTaxFee.addContent(DGSTaxFeePay);
//				GSConsign.addContent(GSTaxFee);
//			}
//
//			// ======================================================
//			// <!--1..7 반복--> 종료
//			// ======================================================
//
//			DeclareGS.addContent(GSConsign);
//		}

		// ======================================================
		// <!--0..999 부산물--> 종료
		// ======================================================

		// ======================================================
		// <!--0..9999 부산물용수입원재료--> 시작
		// ======================================================*/
//		ArrayList GSItemList = new ArrayList();
//
//		for (int i = 0; i < GSItemList.size(); i++) {
//			Map GSItemMap = (Map) GSItemList.get(i);
//
//			/**
//			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem
//			 **/
//			Element GSItem = new Element("GovernmentAgencyGoodsItem", wco);
//			// 부산물수입원재료행번호
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/SequenceNumeric
//			GSItem.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//
//			/**
//			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument
//			 **/
//			Element GSItemAD = new Element("AdditionalDocument", wco);
//			// 신고(증명)번호
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/ID
//			GSItemAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			// 수입일자[매입(양도)일자]
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/IssueDateTime
//			GSItemAD.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			// 신고(증명)번호_란번호
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/SequenceNumeric
//			GSItemAD.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			GSItem.addContent(GSItemAD);
//
//			/**
//			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation
//			 **/
//			Element GSItemAI = new Element("AdditionalInformation", wco);
//			// 신고(증명)번호_규격번호
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/Content
//			GSItemAI.addContent(new Element("Content", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			GSItem.addContent(GSItemAI);
//
//			/**
//			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
//			 **/
//			Element GSItemComm = new Element("Commodity", wco);
//			// 원재료구분
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/CharacteristicCode
//			GSItemComm.addContent(
//					new Element("CharacteristicCode", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			// 부품번호
//			// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/LotNumberID
//			GSItemComm.addContent(new Element("LotNumberID", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			// 부산물식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/ID
//			GSItemComm.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//
//			/**
//			 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification
//			 **/
//			Element GSItemCommCF = new Element("Classification", wco);
//			// HS부호
//			// eclaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification/ID
//			GSItemCommCF.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//			GSItemComm.addContent(GSItemCommCF);
//
//			// ======================================================
//			// <!--1..7 반복--> 시작
//			// taxArray => {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
//			// ======================================================
//			for (int j = 0; j < taxArray.length; j++) {
//
//				/**
//				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee
//				 **/
//				Element GSItemCommTaxFee = new Element("DutyTaxFee", wco);
//				// 세액구분
//				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/TypeCode
//				GSItemCommTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[j]));
//
//				/**
//				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment
//				 **/
//				Element GSItemCommTaxFeePay = new Element("Payment", wco);
//				GSItemCommTaxFeePay.addContent(
//						new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(GSItemMap.get(""))));
//				GSItemCommTaxFee.addContent(GSItemCommTaxFeePay);
//				GSItemComm.addContent(GSItemCommTaxFee);
//			}
//
//			// ======================================================
//			// <!--1..7 반복--> 종료
//			// ======================================================
//			GSItem.addContent(GSItemComm);
//			DeclareGS.addContent(GSItem);
//		}

		// ======================================================
		// <!--0..9999 부산물용수입원재료--> 종료
		// ======================================================*/

		Declaration.addContent(DeclareGS);

		// ======================================================
		// <!--0..9999 수입신고필증유효기간단축배제내역--> 시작
		// ======================================================
//		ArrayList PrevDocList = new ArrayList();
//
//		for (int i = 0; i < PrevDocList.size(); i++) {
//			Map prevDocMap = (Map) PrevDocList.get(i);
//
//			/**
//			 * Declaration/PreviousDocument
//			 **/
//			Element DeclarePrevDoc = new Element("PreviousDocument", wco);
//			// 수입신고번호 Declaration/PreviousDocument/ID
//			DeclarePrevDoc.addContent(new Element("ID", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			// 수리일자(CCYYMMDD) Declaration/PreviousDocument/IssueDateTime
//			DeclarePrevDoc
//					.addContent(new Element("IssueDateTime", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			// 배제내역행번호 Declaration/PreviousDocument/LineNumeric
//			DeclarePrevDoc
//					.addContent(new Element("LineNumeric", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			// 수입신고란번호 Declaration/PreviousDocument/SequenceNumeric
//			DeclarePrevDoc.addContent(
//					new Element("SequenceNumeric", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			// 수입신고규격번호 Declaration/PreviousDocument/DescriptionNumber
//			DeclarePrevDoc.addContent(
//					new Element("DescriptionNumber", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//
//			/**
//			 * Declaration/PreviousDocument/Commodity
//			 **/
//			Element DeclarePrevDocComm = new Element("Commodity", wco);
//			// 품명및규격 Declaration/PreviousDocument/Commodity/Description
//			DeclarePrevDocComm
//					.addContent(new Element("Description", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			// 사용량 Declaration/PreviousDocument/Commodity/SizeMeasure
//			DeclarePrevDocComm
//					.addContent(new Element("SizeMeasure", wco).setText(StringUtil.null2String(prevDocMap.get(""))));
//			DeclarePrevDoc.addContent(DeclarePrevDocComm);
//			Declaration.addContent(DeclarePrevDoc);
//		}

		// ======================================================
		// <!--0..9999 수입신고필증유효기간단축배제내역--> 종료
		// ======================================================

		logger.debug("<병> - xml 데이터 종료 : " + presentnNo);

		logger.debug("FILE 생성 시작 : " + presentnNo);

		FileOutputStream fos = null;
		OutputStreamWriter writer = null;

		try {
			Document myDoc = new Document(Declaration);

			XMLOutputter outputter = new XMLOutputter();
			Format format = outputter.getFormat();
			outputter.setFormat(Format.getPrettyFormat());

			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
					.getConfigurator("app_resource");

			// XML 파일 명
			String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

			String workPath = configurator.getString("file.xml.dir");
			String sendPath = configurator.getString("file.sendxml.dir");
			String receivePath = configurator.getString("file.xmlreceive.dir");

			String backupPath = configurator.getString("file.xmlbackup.dir");

			// String basePath = req.getSession().getServletContext().getRealPath(workPath);
			String basePath = configurator.getString("file.xml.dir");

			String outputFolder = basePath + sendPath;
			String receiveFolder = basePath + receivePath;
			//String backupFolder = basePath + receivePath + "/" + backupPath;
			String backupFolder =  backupPath;

			File senddir = new File(outputFolder); // 송신 DIR
			File receivedir = new File(receiveFolder); // 수신 DIR
			File backupdir = new File(backupFolder); // 수신 Backup DIR

			// 송신폴더 생성
			if (!senddir.isDirectory()) {
				senddir.mkdirs();
			}

			// 수신폴더 생성
			if (!receivedir.isDirectory()) {
				receivedir.mkdirs();
			}

			// 백업폴더 생성
			if (!backupdir.isDirectory()) {
				backupdir.mkdirs();
			}

			fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
			writer = new OutputStreamWriter(fos, "utf-8");
			outputter.output(myDoc, writer);

		} catch (Exception e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		} finally {
			writer.close();
		}

		logger.debug("Create Xml Parsing End");

		return returnMap;
	}
	//-----------------------
	
	/**
	 * BOM 제출 송신 이후 상태 값 처리 
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateBomSubmitStatus(Map<String, Object> param, List<Map> workList) throws Exception {
		return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateBomSubmitStatus(row));
    	
	}
		
	
	/**
	 * 기납증/분증 송신 이후 상태 값 처리 
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Result updateInitPartStatus(Map<String, Object> param, List<Map> workList) throws Exception {
		return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateInitPartStatus(row));
    	
	}
	
	
	/**
	 * 송신 이후 상태 값 처리 
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	private Result updateExecuteStatus(Map<String, Object> param, List<Map> workList, Consumer<Map> consumer) throws Exception {	
		Result rs = new Result();
    	String rtnCode = "";
    	String rtnMessage = "";
    	StringBuffer rtn_sb = new StringBuffer();
    	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
    	for(int inx = 0; inx < workList.size(); inx++) {
    		Map rowMap = workList.get(inx);
    		rtnCode = StringUtil.null2String(rowMap.get("RTN_CODE"));
    		rtnMessage = StringUtil.null2String(rowMap.get("RTN_MESSAGE")); 
    		
    		if("C200".equalsIgnoreCase(rtnCode)) { // 전송 성공
    			rowMap.putAll(param);
    			
    			consumer.accept(rowMap);
    		}else {
    			rtn_sb.append("[" +rtnCode+ "] - "+ StringUtil.null2String(rowMap.get("PRESENTN_NO")) + " - " + rtnMessage + "\n\n");
    		}

    		// 오류내역이 있는경우
    		if(rtn_sb.length() > 0) {
    			rs.setSuccess(false);
    			rs.setMessage(rtn_sb.toString());
    		}else {
    			rs.setSuccess(true);
    			rs.setMessage("모든 데이터가 정상적으로 송신되었습니다.");
    		}
    		
    	}
    	
    	return rs;
	}
	
    /**
     * 통보 후 제출문서 상태값 변경
     * @throws Exception
     */
    public void setSubmitDocStatus(String formType, Map<String, Object> xmlMap) throws Exception {

    	/* FORM_TYPE 구분 코드
		10:환급,18:가산금지급신청서,19:정산,20:기납증,30:평세증,40:분증,50:제증명서정정취하승인신청서,80:자율발급업체지정신청서,81:간이정액환급신청서 적용비적용
		,82:과다 환급금 자진 신고서,83:소요량 산정방법등 신고서,84:단위신청서,86:환급신청기관변경신청서,87:환급금 계좌 통보서,88:평균세액증명서 발급대상 물품지정신청관리
		,90:조견표,91:BOM,94:소요량 계산서
		*/
		if("10".equalsIgnoreCase(formType)) {
			//환급신청서
			if("60".equalsIgnoreCase(xmlMap.get("EXECUT_STATUS")+"")) {	// 지급통보 인경우에만 
				sqlSession.getMapper(DrawbackDocDao.class).update_Drwb_ExecutStatus60(xmlMap);

			}else if("40".equalsIgnoreCase(xmlMap.get("EXECUT_STATUS")+"")) {	// 자료재출요구
				sqlSession.getMapper(DrawbackDocDao.class).update_Drwb_ExecutStatus40(xmlMap);

			}else if("10".equalsIgnoreCase(xmlMap.get("EXECUT_STATUS")+"")) {	// 접수통보
				sqlSession.getMapper(DrawbackDocDao.class).update_Drwb_ExecutStatus10(xmlMap);

			} else {
				sqlSession.getMapper(DrawbackDocDao.class).update_Drwb_ExecutStatus(xmlMap);	
			}
			
		}else if("18".equalsIgnoreCase(formType)) {
			// 가산금지급신청서
			sqlSession.getMapper(DrawbackDocDao.class).update_Adamt_ExecutStatus(xmlMap);
			
			
		}else if("20".equalsIgnoreCase(formType) || "40".equalsIgnoreCase(formType)) {
			//기납 분증
			if("40".equalsIgnoreCase(xmlMap.get("EXECUT_STATUS")+"")) {	// 자료재출요구
				sqlSession.getMapper(DrawbackDocDao.class).update_Cmmn_ExecutStatus40(xmlMap);

			}else {
				sqlSession.getMapper(DrawbackDocDao.class).update_Ctrm_ExecutStatus(xmlMap);	

			}
			
			
		}else if("82".equalsIgnoreCase(formType)) {
			//과다 환급금 자진 신고서
			sqlSession.getMapper(DrawbackDocDao.class).update_Over_ExecutStatus(xmlMap);
			
		}else if("90".equalsIgnoreCase(formType)) {
			//조견표
			sqlSession.getMapper(DrawbackDocDao.class).update_QuickRef_ExecutStatus(xmlMap);
			
		}else if("91".equalsIgnoreCase(formType)) {
			//BOM
			sqlSession.getMapper(DrawbackDocDao.class).update_BomSubmit_ExecutStatus(xmlMap);
			
		}
    	
    }
    
    
    /**
   	 * BOM Xml 생성
   	 * @param param
   	 * @param workList
   	 * @return
   	 * @throws Exception
   	 */
   	@SuppressWarnings({ "rawtypes", "unchecked" })
       public Result createXml_InitbBom(Map<String, Object> param, List<Map> workList) throws Exception {
       	Result rs = new Result();
       	String bom_Presentn_No = "";
       	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
       	for(int inx = 0; inx < workList.size(); inx++) {
       		Map rowMap = workList.get(inx);
       		rowMap.putAll(param);
       		
       		
       		bom_Presentn_No = StringUtil.null2String(rowMap.get("BOM_PRESENTN_NO"));
       		Map returnMap = createXmlDocForInitBom(rowMap, bom_Presentn_No);
       		rowMap.putAll(returnMap);
       		returnList.add(rowMap);
       	}
       	
       	rs.setSuccess(true);
       	rs.setValue(returnList);
       	return rs;
   	}
   	
    
    /**
	 * BOM Xml 생성
	 * @param param
	 * @param workList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Result createXml_DrwbBom(Map<String, Object> param, List<Map> workList) throws Exception {
    	Result rs = new Result();
    	String bom_Presentn_No = "";
    	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
    	for(int inx = 0; inx < workList.size(); inx++) {
    		Map rowMap = workList.get(inx);
    		rowMap.putAll(param);
    		
    		
    		bom_Presentn_No = StringUtil.null2String(rowMap.get("BOM_PRESENTN_NO"));
    		Map returnMap = createXmlDocForDrwbBom(rowMap, bom_Presentn_No);
    		rowMap.putAll(returnMap);
    		returnList.add(rowMap);
    	}
    	
    	rs.setSuccess(true);
    	rs.setValue(returnList);
    	return rs;
	}
	
	
	/**
	* 송신 : BOM제출 (기납증)
	* @param param
	* @param presentnNo
	* @return
	* @throws Exception
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> createXmlDocForInitBom(Map param, String presentnNo) throws Exception {
		
		Map paramMap = new HashMap<String, Object>();
		paramMap.putAll(param);
		paramMap.put("PRESENTN_NO", presentnNo);
		
		Map returnMap = new HashMap<String, Object>();
		returnMap.put("PRESENTN_NO", presentnNo);  // ex : BOM-11001100-20241009-0001
		
		// XML 생성 시작
		Map xmlMap = new HashMap();
		
		//Name 스페이스 정의
  		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0");
  		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0");
  		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");	
  		
  		//root element 만들기
  		Element Declaration = new Element("Declaration", wco);
  		
  		//Name 스페이스 설정
		Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_D93SchemaModule_1.0_standard.xsd", xsi);
		Declaration.addNamespaceDeclaration(kcs);
		Declaration.addNamespaceDeclaration(xsi);
		
		/**
		 * ****** XML 생성용 <갑> 데이터 조회 ****** @param param ****** @return
		 */
		logger.debug(" Xml Content Parsing Start : " + presentnNo);

		
		String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_bom(paramMap);

		if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
			/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
			sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
			
			/* 제출번호 xml 생성할때마다 재생성 */
			sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_bom(paramMap);
		}
		

    	
		//Map 생성 
		Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Initbom(paramMap);
		
		returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
		returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
		returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
		returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

		logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);

		// 제출세관부호 Declaration/DeclarationOfficeID  
		Declaration.addContent(new Element("DeclarationOfficeID" , wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
		// 환급제증명접수번호 Declaration/FunctionalReferenceID  
		Declaration.addContent(new Element("FunctionalReferenceID" , wco).setText(StringUtil.null2String(retrieveMap.get("CTRM_REGIST_RCEPT_NO"))));
		// 제출번호 Declaration/ID  
		Declaration.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
		// 제출일자 Declaration/IssueDateTime  
		Declaration.addContent(new Element("IssueDateTime" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_DATE"))));
		// 문서형태구분 Declaration/TypeCode  
		Declaration.addContent(new Element("TypeCode" , wco).setText("GOVCBRD93"));
		// 서식구분 Declaration/TransactionNatureCode  
		Declaration.addContent(new Element("TransactionNatureCode" , wco).setText(StringUtil.null2String(retrieveMap.get("FORM_TYPE"))));

		/** 
		 * Declaration/AdditionalDocument
		 */
		Element DeclareAD = new Element("AdditionalDocument", wco);  
			// 환급심사요구자료문서번호 Declaration/AdditionalDocument/ID  
			DeclareAD.addContent(new Element("ID" , kcs).setText(StringUtil.null2String(retrieveMap.get("REQ_DOC_NO"))));
			// 요구자료문서_행번호 Declaration/AdditionalDocument/SequenceNumeric  
			DeclareAD.addContent(new Element("SequenceNumeric" , kcs).setText(StringUtil.null2String(retrieveMap.get("REQ_DOC_LINE_NO"))));
		Declaration.addContent(DeclareAD);    

		/** 
		 * Declaration/Agent
		 */
		Element DeclareAgent = new Element("Agent", wco);  
			// 신고대행관세사번호 Declaration/Agent/ID  
			DeclareAgent.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		Declaration.addContent(DeclareAgent);    

		/** 
		 * Declaration/GoodsShipment
		 */
		Element DeclareGS = new Element("GoodsShipment", wco);  
		
			/** 
			* Declaration/GoodsShipment/GovernmentAgencyGoodsItem
			*/
			Element GSagItem = new Element("GovernmentAgencyGoodsItem", wco); 
			
				/** 
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation
				 */
				Element GSagItemAI = new Element("AdditionalInformation", wco); 
					// 사용기간시작일자 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/BeginningDateTime 
					GSagItemAI.addContent(new Element("BeginningDateTime" , kcs).setText(StringUtil.null2String(retrieveMap.get("START_DATE"))));
					// 사용기간종료일자 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/EndingDateTime 
					GSagItemAI.addContent(new Element("EndingDateTime" , kcs).setText(StringUtil.null2String(retrieveMap.get("END_DATE"))));
				GSagItem.addContent(GSagItemAI);  
				
				/** 
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				 */
				Element GSagItemComm = new Element("Commodity", wco); 
					// 제품명 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/CargoDescription 
					GSagItemComm.addContent(new Element("CargoDescription" , wco).setText(StringUtil.null2String(retrieveMap.get("ITEM_NM"))));
					// 제품규격 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Description 
					GSagItemComm.addContent(new Element("Description" , wco).setText(StringUtil.null2String(retrieveMap.get("SPEC"))));
					// 제품식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/ID 
					GSagItemComm.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("ITEM_CODE"))));
			
					/** 
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification
					 */
					Element GSagItemCommCF = new Element("Classification", wco); 
						// 제품HS부호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification/ID 
						GSagItemCommCF.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("HS_CODE"))));
					GSagItemComm.addContent(GSagItemCommCF);
					
					/**
					 * ****** XML 생성용 <병> 데이터 조회 ****** @param param ****** @return
					 */
					List<Map<String, Object>>  thnglList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Initbom_detail(paramMap);
					
					for(int i = 0; i < thnglList.size(); i++) {
						Map<String, Object> thngl = (Map) thnglList.get(i);
						/** 
						 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity
						 */
						Element GSagItemCommDtl = new Element("DetailedCommodity", wco); 
							// 일련번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SequenceNumeric 
							GSagItemCommDtl.addContent(new Element("SequenceNumeric" , wco).setText(StringUtil.null2String(thngl.get("BOM_SEQ"))));
							// 부품명및규격 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/CargoDescription
							GSagItemCommDtl.addContent(new Element("CargoDescription" , wco).setText(StringUtil.null2String(thngl.get("ITEM_NM"))));
							// 부품식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/ID 
							GSagItemCommDtl.addContent(new Element("ID" , wco).setText(StringUtil.null2String(thngl.get("ITEM_CODE"))));
							// 상위부품번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/LotNumberID
							GSagItemCommDtl.addContent(new Element("LotNumberID" , wco).setText(StringUtil.null2String(thngl.get("PARENT_ITEM_CODE"))));
							// 소요량(단위) Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SizeMeasure 
							GSagItemCommDtl.addContent(new Element("SizeMeasure" , wco).setAttribute("kcsUnitCode", StringUtil.null2String(thngl.get("INPUT_BASS_UNIT")))
									                                                   .setText(StringUtil.null2String(thngl.get("INPUT_QTY"))));
					
							/** 
							 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation
							 */
							Element GSagItemCommDtlAI = new Element("AdditionalInformation", wco); 
								// 기타 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation/Content 
								GSagItemCommDtlAI.addContent(new Element("Content" , wco).setText(StringUtil.null2String("")));
							GSagItemCommDtl.addContent(GSagItemCommDtlAI);
							
						GSagItemComm.addContent(GSagItemCommDtl);	
						
					}
					
					GSagItem.addContent(GSagItemComm);
					DeclareGS.addContent(GSagItem);  
				Declaration.addContent(DeclareGS); 
				
				logger.debug("<을> - xml 데이터 종료 : " + presentnNo);
				   
			
		/** 
		 * Declaration/Submitter
		 */
		Element Submitter = new Element("Submitter", wco);  
			// 신청인통관고유부호 Declaration/Submitter/ID
			Submitter.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
		Declaration.addContent(Submitter);    

		logger.debug("FILE 생성 시작 : " + presentnNo);

		FileOutputStream fos = null;
		OutputStreamWriter writer = null;

		try {
			Document myDoc = new Document(Declaration);

			XMLOutputter outputter = new XMLOutputter();
			Format format = outputter.getFormat();
			outputter.setFormat(Format.getPrettyFormat());

			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
					.getConfigurator("app_resource");

			// XML 파일 명
			String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

			String workPath = configurator.getString("file.xml.dir");
			String sendPath = configurator.getString("file.sendxml.dir");
			String receivePath = configurator.getString("file.xmlreceive.dir");

			String backupPath = configurator.getString("file.xmlbackup.dir");

			// String basePath = req.getSession().getServletContext().getRealPath(workPath);
			String basePath = configurator.getString("file.xml.dir");

			String outputFolder = basePath + sendPath;
			String receiveFolder = basePath + receivePath;
			//String backupFolder = basePath + receivePath + "/" + backupPath;
			String backupFolder =  backupPath;

			File senddir = new File(outputFolder); // 송신 DIR
			File receivedir = new File(receiveFolder); // 수신 DIR
			File backupdir = new File(backupFolder); // 수신 Backup DIR

			// 송신폴더 생성
			if (!senddir.isDirectory()) {
				senddir.mkdirs();
			}

			// 수신폴더 생성
			if (!receivedir.isDirectory()) {
				receivedir.mkdirs();
			}

			// 백업폴더 생성
			if (!backupdir.isDirectory()) {
				backupdir.mkdirs();
			}

			fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
			writer = new OutputStreamWriter(fos, "utf-8");
			outputter.output(myDoc, writer);

		} catch (Exception e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		} finally {
			writer.close();
		}

		logger.debug("Create Xml Parsing End");

		return returnMap;
	}
	
	/**
	* 송신 : BOM
	* @param param
	* @param presentnNo
	* @return
	* @throws Exception
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> createXmlDocForDrwbBom(Map param, String presentnNo) throws Exception {
		
		Map paramMap = new HashMap<String, Object>();
		paramMap.putAll(param);
		paramMap.put("PRESENTN_NO", presentnNo);
		
		Map returnMap = new HashMap<String, Object>();
		returnMap.put("PRESENTN_NO", presentnNo);  // ex : BOM-11001100-20241009-0001
		
		// XML 생성 시작
		Map xmlMap = new HashMap();
		
		//Name 스페이스 정의
  		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0");
  		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0");
  		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");	
  		
  		//root element 만들기
  		Element Declaration = new Element("Declaration", wco);
  		
  		//Name 스페이스 설정
		Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_D93SchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_D93SchemaModule_1.0_standard.xsd", xsi);
		Declaration.addNamespaceDeclaration(kcs);
		Declaration.addNamespaceDeclaration(xsi);
		
		/**
		 * ****** XML 생성용 <갑> 데이터 조회 ****** @param param ****** @return
		 */
		logger.debug(" Xml Content Parsing Start : " + presentnNo);

		String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_bom(paramMap);

		if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
			/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
			sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
			
			/* 제출번호 xml 생성할때마다 재생성 */
			sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_bom(paramMap);
		}
    	
		//Map 생성 
		Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_bom(paramMap);
		
		returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
		returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
		returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
		returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

		logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);

		// 제출세관부호 Declaration/DeclarationOfficeID  
		Declaration.addContent(new Element("DeclarationOfficeID" , wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
		// 환급제증명접수번호 Declaration/FunctionalReferenceID  
		Declaration.addContent(new Element("FunctionalReferenceID" , wco).setText(StringUtil.null2String(retrieveMap.get("DRWB_REGIST_RCEPT_NO"))));
		// 제출번호 Declaration/ID  
		Declaration.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
		// 제출일자 Declaration/IssueDateTime  
		Declaration.addContent(new Element("IssueDateTime" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_DATE"))));
		// 문서형태구분 Declaration/TypeCode  
		Declaration.addContent(new Element("TypeCode" , wco).setText("GOVCBRD93"));
		// 서식구분 Declaration/TransactionNatureCode  
		Declaration.addContent(new Element("TransactionNatureCode" , wco).setText(StringUtil.null2String(retrieveMap.get("FORM_TYPE"))));

		/** 
		 * Declaration/AdditionalDocument
		 */
		Element DeclareAD = new Element("AdditionalDocument", wco);  
			// 환급심사요구자료문서번호 Declaration/AdditionalDocument/ID  
			DeclareAD.addContent(new Element("ID" , kcs).setText(StringUtil.null2String(retrieveMap.get("REQ_DOC_NO"))));
			// 요구자료문서_행번호 Declaration/AdditionalDocument/SequenceNumeric  
			DeclareAD.addContent(new Element("SequenceNumeric" , kcs).setText(StringUtil.null2String(retrieveMap.get("REQ_DOC_LINE_NO"))));
		Declaration.addContent(DeclareAD);    

		/** 
		 * Declaration/Agent
		 */
		Element DeclareAgent = new Element("Agent", wco);  
			// 신고대행관세사번호 Declaration/Agent/ID  
			DeclareAgent.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get(""))));
		Declaration.addContent(DeclareAgent);    

		/** 
		 * Declaration/GoodsShipment
		 */
		Element DeclareGS = new Element("GoodsShipment", wco);  
		
			/** 
			* Declaration/GoodsShipment/GovernmentAgencyGoodsItem
			*/
			Element GSagItem = new Element("GovernmentAgencyGoodsItem", wco); 
			
				/** 
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation
				 */
				Element GSagItemAI = new Element("AdditionalInformation", wco); 
					// 사용기간시작일자 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/BeginningDateTime 
					GSagItemAI.addContent(new Element("BeginningDateTime" , kcs).setText(StringUtil.null2String(retrieveMap.get("START_DATE"))));
					// 사용기간종료일자 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/EndingDateTime 
					GSagItemAI.addContent(new Element("EndingDateTime" , kcs).setText(StringUtil.null2String(retrieveMap.get("END_DATE"))));
				GSagItem.addContent(GSagItemAI);  
				
				/** 
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				 */
				Element GSagItemComm = new Element("Commodity", wco); 
					// 제품명 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/CargoDescription 
					GSagItemComm.addContent(new Element("CargoDescription" , wco).setText(StringUtil.null2String(retrieveMap.get("ITEM_NM"))));
					// 제품규격 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Description 
					GSagItemComm.addContent(new Element("Description" , wco).setText(StringUtil.null2String(retrieveMap.get("SPEC"))));
					// 제품식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/ID 
					GSagItemComm.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("ITEM_CODE"))));
			
					/** 
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification
					 */
					Element GSagItemCommCF = new Element("Classification", wco); 
						// 제품HS부호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/Classification/ID 
						GSagItemCommCF.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("HS_CODE"))));
					GSagItemComm.addContent(GSagItemCommCF);
					
					/**
					 * ****** XML 생성용 <병> 데이터 조회 ****** @param param ****** @return
					 */
					List<Map<String, Object>>  thnglList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_bom_detail(paramMap);
					
					for(int i = 0; i < thnglList.size(); i++) {
						Map<String, Object> thngl = (Map) thnglList.get(i);
						/** 
						 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity
						 */
						Element GSagItemCommDtl = new Element("DetailedCommodity", wco); 
							// 일련번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SequenceNumeric 
							GSagItemCommDtl.addContent(new Element("SequenceNumeric" , wco).setText(StringUtil.null2String(thngl.get("BOM_SEQ"))));
							// 부품명및규격 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/CargoDescription
							GSagItemCommDtl.addContent(new Element("CargoDescription" , wco).setText(StringUtil.null2String(thngl.get("ITEM_NM"))));
							// 부품식별번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/ID 
							GSagItemCommDtl.addContent(new Element("ID" , wco).setText(StringUtil.null2String(thngl.get("ITEM_CODE"))));
							// 상위부품번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/LotNumberID
							GSagItemCommDtl.addContent(new Element("LotNumberID" , wco).setText(StringUtil.null2String(thngl.get("PARENT_ITEM_CODE"))));
							// 소요량(단위) Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SizeMeasure 
							GSagItemCommDtl.addContent(new Element("SizeMeasure" , wco).setAttribute("kcsUnitCode", StringUtil.null2String(thngl.get("INPUT_BASS_UNIT")))
									                                                   .setText(StringUtil.null2String(thngl.get("INPUT_QTY"))));
					
							/** 
							 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation
							 */
							Element GSagItemCommDtlAI = new Element("AdditionalInformation", wco); 
								// 기타 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation/Content 
								GSagItemCommDtlAI.addContent(new Element("Content" , wco).setText(StringUtil.null2String("")));
							GSagItemCommDtl.addContent(GSagItemCommDtlAI);
							
						GSagItemComm.addContent(GSagItemCommDtl);	
						
					}
					
					GSagItem.addContent(GSagItemComm);
					DeclareGS.addContent(GSagItem);  
				Declaration.addContent(DeclareGS); 
				
				logger.debug("<을> - xml 데이터 종료 : " + presentnNo);
				   
			
		/** 
		 * Declaration/Submitter
		 */
		Element Submitter = new Element("Submitter", wco);  
			// 신청인통관고유부호 Declaration/Submitter/ID
			Submitter.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
		Declaration.addContent(Submitter);    

		logger.debug("FILE 생성 시작 : " + presentnNo);

		FileOutputStream fos = null;
		OutputStreamWriter writer = null;

		try {
			Document myDoc = new Document(Declaration);

			XMLOutputter outputter = new XMLOutputter();
			Format format = outputter.getFormat();
			outputter.setFormat(Format.getPrettyFormat());

			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
					.getConfigurator("app_resource");

			// XML 파일 명
			String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

			String workPath = configurator.getString("file.xml.dir");
			String sendPath = configurator.getString("file.sendxml.dir");
			String receivePath = configurator.getString("file.xmlreceive.dir");

			String backupPath = configurator.getString("file.xmlbackup.dir");

			// String basePath = req.getSession().getServletContext().getRealPath(workPath);
			String basePath = configurator.getString("file.xml.dir");

			String outputFolder = basePath + sendPath;
			String receiveFolder = basePath + receivePath;
			//String backupFolder = basePath + receivePath + "/" + backupPath;
			String backupFolder =  backupPath;

			File senddir = new File(outputFolder); // 송신 DIR
			File receivedir = new File(receiveFolder); // 수신 DIR
			File backupdir = new File(backupFolder); // 수신 Backup DIR

			// 송신폴더 생성
			if (!senddir.isDirectory()) {
				senddir.mkdirs();
			}

			// 수신폴더 생성
			if (!receivedir.isDirectory()) {
				receivedir.mkdirs();
			}

			// 백업폴더 생성
			if (!backupdir.isDirectory()) {
				backupdir.mkdirs();
			}

			fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
			writer = new OutputStreamWriter(fos, "utf-8");
			outputter.output(myDoc, writer);

		} catch (Exception e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		} finally {
			writer.close();
		}

		logger.debug("Create Xml Parsing End");

		return returnMap;
	}
	
	 /**
		 * 과다환급자진신고 Xml 생성
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result createXml_overDrwb(Map<String, Object> param, List<Map> workList) throws Exception {
	    	Result rs = new Result();
	    	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
	    	
	    	for(int inx = 0; inx < workList.size(); inx++) {
	    		Map rowMap = workList.get(inx);
	    		Map returnMap = createXmlDocForOverDrwb(param, StringUtil.null2String(rowMap.get("PRESENTN_NO")), StringUtil.null2String(rowMap.get("OVER_DRWBAK_PRESENTN_NO")));
	    		rowMap.putAll(returnMap);
	    		returnList.add(rowMap);
	    	}
	    	
	    	rs.setSuccess(true);
	    	rs.setValue(returnList);
	    	return rs;
		 }
		
		/**
		* 송신 : 과다환급자진신고
		* @param param
		* @param presentnNo
		* @param overDrwbakPresentnNo
		* @return
		* @throws Exception
		*/
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Map<String, Object> createXmlDocForOverDrwb(Map param, String presentnNo,  String overDrwbakPresentnNo) throws Exception {
			Map paramMap = new HashMap<String, Object>();
			paramMap.putAll(param);
			paramMap.put("PRESENTN_NO", presentnNo);
			paramMap.put("OVER_DRWBAK_PRESENTN_NO", overDrwbakPresentnNo);

			Map returnMap = new HashMap<String, Object>();
			returnMap.put("PRESENTN_NO", presentnNo);
			returnMap.put("OVER_DRWBAK_PRESENTN_NO", overDrwbakPresentnNo);
	    	
			//XML 생성 시작 
	    	Map xmlMap = new HashMap();
		    
			//Name 스페이스 정의
	  		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCCSchemaModule:1:0");
	  		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCCSchemaModule:1:0");
	  		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");	
	  		
	  		//root element 만들기
	  		Element Declaration = new Element("Declaration", wco);
	  		
	  		//Name 스페이스 설정
			Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCCSchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_DCCSchemaModule_1.0_standard.xsd", xsi);
			Declaration.addNamespaceDeclaration(kcs);
			Declaration.addNamespaceDeclaration(xsi);
			
			/**
			 * ****** XML 생성용 <갑> 데이터 조회 ****** @param param ****** @return
			 */
			logger.debug(" Xml Content Parsing Start : " + overDrwbakPresentnNo);

			String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_overDrwb(paramMap);

			if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
				/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
				sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
				/* 제출번호 xml 생성할때마다 재생성 */
				sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_overDrwb(paramMap);
			}
			Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_overDrwb(paramMap);
			
			returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
			returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
			returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
			returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

			logger.debug("<갑> - xml 데이터 생성 : " + overDrwbakPresentnNo);
			// 제출세관 Declaration/DeclarationOfficeID  
			Declaration.addContent(new Element("DeclarationOfficeID" , wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
			// 제출번호 Declaration/ID  
			Declaration.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
			// 문서형태구분 Declaration/TypeCode  
			Declaration.addContent(new Element("TypeCode" , wco).setText("GOVCBRDCC"));
			// 과다환급사유내용 Declaration/Reason  
			Declaration.addContent(new Element("Reason" , kcs).setText(StringUtil.null2String(retrieveMap.get("OVER_DRWBAK_REASON"))));
			
			/** 
			 * Declaration/AdditionalDocument
			 */
			Element DeclareAD = new Element("AdditionalDocument", wco);  
				// 충당여부 Declaration/AdditionalDocument/TypeCode
				DeclareAD.addContent(new Element("TypeCode" , wco).setText("N"));
			Declaration.addContent(DeclareAD);    

			/** 
			 * Declaration/GoodsShipment
			 */
			Element DeclareGS = new Element("GoodsShipment", wco);  
				// 서식구분 Declaration/GoodsShipment/TransactionNatureCode  
				DeclareGS.addContent(new Element("TransactionNatureCode" , wco).setText("10"));
				
				/** 
				 * Declaration/GoodsShipment/AdditionalDocument
				 */
				Element GSAD = new Element("AdditionalDocument", wco);  
					// 환급결정액 Declaration/GoodsShipment/AdditionalDocument/AmountAmount
					GSAD.addContent(new Element("AmountAmount" , wco).setText(StringUtil.null2String(retrieveMap.get("DRWBAK_AMOUNT"))));
					// 관련접수번호 Declaration/GoodsShipment/AdditionalDocument/ID
					GSAD.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("REGIST_RCEPT_NO"))));
					// 결정일자(CCYYMMDD) Declaration/GoodsShipment/AdditionalDocument/IssueDateTime  
					GSAD.addContent(new Element("IssueDateTime" , wco).setText(StringUtil.null2String(retrieveMap.get("DRWBAK_COMP_YYYYMMDD"))));
				DeclareGS.addContent(GSAD);    

				/** 
				 * Declaration/GoodsShipment/AdditionalInformation
				 */
				Element GSAI = new Element("AdditionalInformation", wco);  
					// 비고 Declaration/GoodsShipment/AdditionalInformation/Content
					GSAI.addContent(new Element("Content" , wco).setText(StringUtil.null2String(retrieveMap.get("OVER_DRWBAK_REASON"))));
				DeclareGS.addContent(GSAI);    
				
				/** 
				 * Declaration/GoodsShipment/DutyTaxFee
				 */
				Element GSProperDrwbakDutyFee = new Element("DutyTaxFee", wco);  
					// 1:정당환급액/2:과다환급액 Declaration/GoodsShipment/DutyTaxFee/TypeCode
				GSProperDrwbakDutyFee.addContent(new Element("TypeCode" , wco).setText("1"));
					
					/** 
					 * Declaration/GoodsShipment/DutyTaxFee/Payment
					 */
					Element GSProperDrwbakDutyFeePay = new Element("Payment", wco);  
						// 환급액 Declaration/GoodsShipment/DutyTaxFee/Payment/TaxAssessedAmount
					GSProperDrwbakDutyFeePay.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(retrieveMap.get("PROPER_DRWBAK_AMOUNT"))));
					GSProperDrwbakDutyFee.addContent(GSProperDrwbakDutyFeePay);    
				DeclareGS.addContent(GSProperDrwbakDutyFee);  
				
				Element GSBalanceDutyFee = new Element("DutyTaxFee", wco);  
				// 1:정당환급액/2:과다환급액 Declaration/GoodsShipment/DutyTaxFee/TypeCode
				GSBalanceDutyFee.addContent(new Element("TypeCode" , wco).setText("2"));
				
				/** 
				 * Declaration/GoodsShipment/DutyTaxFee/Payment
				 */
				Element GSBalanceDutyFeePay = new Element("Payment", wco);  
					// 환급액 Declaration/GoodsShipment/DutyTaxFee/Payment/TaxAssessedAmount
				GSBalanceDutyFeePay.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(retrieveMap.get("BALANCE_AMOUNT"))));
					GSBalanceDutyFee.addContent(GSBalanceDutyFeePay);    
			DeclareGS.addContent(GSBalanceDutyFee);  			
			Declaration.addContent(DeclareGS);    


			/**
			* Declaration/Submitter
			*/
			Element Submitter = new Element("Submitter", wco);  
				// 사업자번호/신청인통관고유부호(SchemaAgencyID로 구분(KTX:사업자번호, 380:통관고유부호)) Declaration/Submitter/ID
				Submitter.addContent(new Element("ID" , wco).setAttribute("schemeAgencyID", "380")
															.setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
				// 사업자번호/신청인통관고유부호(SchemaAgencyID로 구분(KTX:사업자번호, 380:통관고유부호)) Declaration/Submitter/ID
				Submitter.addContent(new Element("ID" , wco).setAttribute("schemeAgencyID", "KTX")
															.setText(StringUtil.null2String(retrieveMap.get("BIZRNO"))));
		
				/**
				* Declaration/Submitter/Contact
				*/
				Element Contact = new Element("Contact", wco);  
					// 신청인명 Declaration/Submitter/Contact/Name
					Contact.addContent(new Element("Name" , wco).setText(StringUtil.null2String(retrieveMap.get("RCEPT_RPRSNTV_NM"))));
				Submitter.addContent(Contact);    
					
			Declaration.addContent(Submitter);    
			
			
			logger.debug("<갑> - xml 데이터 종료 : " + overDrwbakPresentnNo);

			logger.debug("FILE 생성 시작 : " + overDrwbakPresentnNo);

			FileOutputStream fos = null;
			OutputStreamWriter writer = null;

			try {
				Document myDoc = new Document(Declaration);

				XMLOutputter outputter = new XMLOutputter();
				Format format = outputter.getFormat();
				outputter.setFormat(Format.getPrettyFormat());

				PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
						.getConfigurator("app_resource");

				// XML 파일 명
				String crateXmlFileName = StringUtil.null2String(overDrwbakPresentnNo) + ".xml";

				String workPath = configurator.getString("file.xml.dir");
				String sendPath = configurator.getString("file.sendxml.dir");
				String receivePath = configurator.getString("file.xmlreceive.dir");

				String backupPath = configurator.getString("file.xmlbackup.dir");

				// String basePath = req.getSession().getServletContext().getRealPath(workPath);
				String basePath = configurator.getString("file.xml.dir");

				String outputFolder = basePath + sendPath;
				String receiveFolder = basePath + receivePath;
				//String backupFolder = basePath + receivePath + "/" + backupPath;
				String backupFolder =  backupPath;

				File senddir = new File(outputFolder); // 송신 DIR
				File receivedir = new File(receiveFolder); // 수신 DIR
				File backupdir = new File(backupFolder); // 수신 Backup DIR

				// 송신폴더 생성
				if (!senddir.isDirectory()) {
					senddir.mkdirs();
				}

				// 수신폴더 생성
				if (!receivedir.isDirectory()) {
					receivedir.mkdirs();
				}

				// 백업폴더 생성
				if (!backupdir.isDirectory()) {
					backupdir.mkdirs();
				}

				fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
				writer = new OutputStreamWriter(fos, "utf-8");
				outputter.output(myDoc, writer);

			} catch (Exception e) {
				// TODO: handle exception
				logger.debug(e.getMessage());
			} finally {
				writer.close();
			}

			logger.debug("Create Xml Parsing End");

			return returnMap; 	
		}
		
		/**
		 * 과다환급자진신고 송신 이후 상태 값 처리 
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result updateOverDrwbStatus(Map<String, Object> param, List<Map> workList) throws Exception {
			return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateOverDrwbStatus(row));
	    	
		}
		
		/**
		 * 조견표 Xml 생성
		 * 
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Result createXml_quickRef(Map<String, Object> param, List<Map> workList) throws Exception {
			Result rs = new Result();
			List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();

			for (int inx = 0; inx < workList.size(); inx++) {
				Map rowMap = workList.get(inx);
				param.putAll(rowMap);

				Map returnMap = createXmlDocForQuickRef(param, StringUtil.null2String(rowMap.get("PRESENTN_NO")), StringUtil.null2String(rowMap.get("REL_REGIST_RCEPT_NO")));
				
				rowMap.putAll(returnMap);
				returnList.add(rowMap);
			}

			rs.setSuccess(true);
			rs.setValue(returnList);
			return rs;

		}
		
		/**
		 * 송신 : 조견표
		 * 
		 * @param param
		 * @param presentnNo
		 * @param registRceptNo
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Map<String, Object> createXmlDocForQuickRef(Map param, String presentnNo, String registRceptNo) throws Exception {
			Map paramMap = new HashMap<String, Object>();
			paramMap.putAll(param);
			paramMap.put("PRESENTN_NO", presentnNo);
			paramMap.put("REGIST_RCEPT_NO", registRceptNo);
			
			Map returnMap = new HashMap<String, Object>();
			returnMap.put("PRESENTN_NO", presentnNo);
			returnMap.put("REGIST_RCEPT_NO", registRceptNo);


			// XML 생성 시작
			Map xmlMap = new HashMap();

			// Name 스페이스 정의
			Namespace kcs = Namespace.getNamespace("kcs","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DEXSchemaModule:1:0");
			Namespace wco = Namespace.getNamespace("wco","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DEXSchemaModule:1:0");
			Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");

			// root element 만들기
			Element Declaration = new Element("Declaration", wco);

			// Name 스페이스 설정
			Declaration.setAttribute("schemaLocation","urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DEXSchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_DEXSchemaModule_1.0_standard.xsd",xsi);
			Declaration.addNamespaceDeclaration(kcs);
			Declaration.addNamespaceDeclaration(xsi);
			
			/**
			 * ****** XML 생성용 <갑/을> 데이터 조회 ****** @param param ****** @return
			 */
			logger.debug(" Xml Content Parsing Start : " + presentnNo);
			
			String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_quickRef(paramMap);

			if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
				/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
				sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
				/* 제출번호 xml 생성할때마다 재생성 */
				sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_quickRef(paramMap);
			}



			// Map 생성
			List<Map<String, Object>> GSList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_quickRef(paramMap);
			Map<String, Object> retrieveMap = GSList.isEmpty() ? new HashMap<String, Object>() : GSList.get(0);
			
			returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
			returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
			returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
			returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));
			

			// 신청세관부호 Declaration/DeclarationOfficeID
			Declaration.addContent(new Element("DeclarationOfficeID", wco)
					.setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
			// 관련접수번호 Declaration/FunctionalReferenceID
			Declaration.addContent(new Element("FunctionalReferenceID", wco)
					.setText(StringUtil.null2String(retrieveMap.get("REL_REGIST_RCEPT_NO"))));
			// 제출번호 Declaration/ID
			Declaration.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
			
			// 제출일자 Declaration/IssueDateTime
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		    String dateTime = dateFormat.format(new Date());
		        
			Declaration.addContent(new Element("IssueDateTime", wco).setText(dateTime));
			// 문서형태구분 Declaration/TypeCode
			Declaration.addContent(new Element("TypeCode", wco).setText("GOVCBRDEX"));
			// 서식구분(10:환급,20:기납) Declaration/TransactionNatureCode
			Declaration.addContent(new Element("TransactionNatureCode", wco).setText("10"));

			/**
			 * Declaration/AdditionalDocument
			 */
			Element DeclareAD = new Element("AdditionalDocument", wco);
			// 환급심사요구자료문서번호 Declaration/AdditionalDocument/ID
			DeclareAD.addContent(
					new Element("ID", kcs).setText(StringUtil.null2String(retrieveMap.get("JUDGE_REQ_DOC_NO"))));
			// 요구자료문서_행번호 Declaration/AdditionalDocument/SequenceNumeric
			DeclareAD.addContent(new Element("SequenceNumeric", kcs)
					.setText(StringUtil.null2String(retrieveMap.get("JUDGE_REQ_DOC_SEQ"))));
			Declaration.addContent(DeclareAD);

			/**
			 * Declaration/Agent
			 */
			Element DeclareAgent = new Element("Agent", wco);
			// 신고대행관세사번호 Declaration/Agent/ID
			DeclareAgent.addContent(new Element("ID", wco).setText(""));
			Declaration.addContent(DeclareAgent);

			/**
			 * Declaration/GoodsShipment
			 */
			Element DeclareGS = new Element("GoodsShipment", wco);

			// =========================================================
			// 1..9999 조견표_제품증명내역 시작
			// =========================================================
			for (int i = 0; i < GSList.size(); i++) {
				Map GSMap = (Map) GSList.get(i);

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem
				 */
				Element GSagItem = new Element("GovernmentAgencyGoodsItem", wco);
				// 제품일련번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/SequenceNumeric
				GSagItem.addContent(new Element("SequenceNumeric", wco).setText(StringUtil.null2String(GSMap.get("SEQ"))));

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument
				 */
				Element GSagItemAD = new Element("AdditionalDocument", wco);
				// 신고(증명)번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/ID
				GSagItemAD.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSMap.get("REF_NO"))));
				// 신고(증명)번호 란번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalDocument/SequenceNumeric
				GSagItemAD.addContent(
						new Element("SequenceNumeric", wco).setText(StringUtil.null2String(GSMap.get("REF_LNE_NO"))));

				GSagItem.addContent(GSagItemAD);

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation
				 */
				Element GSagItemAI = new Element("AdditionalInformation", wco);
				// 신고(증명)번호 규격번호
				// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/AdditionalInformation/Content
				GSagItemAI
						.addContent(new Element("Content", wco).setText(StringUtil.null2String(GSMap.get("REF_POUCH_NO"))));
				GSagItem.addContent(GSagItemAI);

				/**
				 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				 */
				Element GSagItemComm = new Element("Commodity", wco);
				// 생산수량(단위) Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				GSagItemComm.addContent(new Element("CountQuantity", wco)
						.setAttribute("kcsUnitCode", StringUtil.null2String(GSMap.get("BASS_UNIT")))
						.setText(StringUtil.null2String(GSMap.get("ACCMLT_ORDER_QY"))));
				// 모델규격명 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				GSagItemComm.addContent(
						new Element("Description", wco).setText(StringUtil.null2String(GSMap.get("PRODUCT_NAME"))));
				// 제품번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				GSagItemComm.addContent(
						new Element("LotNumberID", wco).setText(StringUtil.null2String(GSMap.get("PRODUCT_CODE"))));
				// 상세제품번호 Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
				GSagItemComm.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSMap.get("PRODUCT_CODE"))));

				// ==================================================================
				// <!--1..99999 조견표_제품증명내역 상세--> 시작
				// ==================================================================
				
				/* todo 수린 - 병 데이터 한 번에 조회 */
				var detailParamMap = new HashMap<String, Object>(paramMap);
				detailParamMap.put("THNG_SEQ", GSMap.get("THNG_SEQ"));
				
				/**
				 * ****** XML 생성용 <병> 데이터 조회 ****** @param param ****** @return
				 */
				List<Map<String, Object>> GSAgItemCommDtlList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_quickRef_detail(detailParamMap);
				
				for (int t = 0; t < GSAgItemCommDtlList.size(); t++) {
					Map GSAgItemCommDtlMap = (Map) GSAgItemCommDtlList.get(t);

					/**
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity
					 */
					Element GSagItemCommDtl = new Element("DetailedCommodity", wco);
					// 부품행번호
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SequenceNumeric
					GSagItemCommDtl.addContent(new Element("SequenceNumeric", wco)
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("SEQ"))));
					// 원재료구분
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/CharacteristicCode
					GSagItemCommDtl.addContent(new Element("CharacteristicCode", wco)
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("RAWMTRL_SE"))));
					// 부품번호
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/ID
					GSagItemCommDtl.addContent(new Element("ID", wco).setText(StringUtil.null2String(GSAgItemCommDtlMap.get("RAWMTRL_CODE"))));
					// 소요물량(단위)
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/SizeMeasure
					GSagItemCommDtl.addContent(new Element("SizeMeasure", wco)
							.setAttribute("kcsUnitCode", StringUtil.null2String(GSAgItemCommDtlMap.get("BASS_UNIT")))
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("USGQTY"))));
					// 공제비율
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/ConsumptionRateNumeric
					GSagItemCommDtl
							.addContent(new Element("ConsumptionRateNumeric", kcs).setText(StringUtil.null2String("")));

					/**
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalDocument
					 */
					Element GSagItemCommDtlAD = new Element("AdditionalDocument", wco);
					// 신고(증명)번호 란번호
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalDocument/SequenceNumeric
					GSagItemCommDtlAD.addContent(new Element("SequenceNumeric", wco)
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("LNE_NO"))));
					// 신고(증명)번호
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalDocument/ID
					GSagItemCommDtlAD.addContent(
							new Element("ID", wco).setText(StringUtil.null2String(GSAgItemCommDtlMap.get("IMPDEC_NO"))));
					// 수입(증명)일자
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalDocument/IssueDateTime
					GSagItemCommDtlAD.addContent(new Element("IssueDateTime", wco)
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("ACPT_DATE"))));
					GSagItemCommDtl.addContent(GSagItemCommDtlAD);

					/**
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation
					 */
					Element GSagItemCommDtlAI = new Element("AdditionalInformation", wco);
					// 신고(증명)번호 규격번호
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalInformation/Content
					GSagItemCommDtlAI.addContent(new Element("Content", wco)
							.setText(StringUtil.null2String(GSAgItemCommDtlMap.get("POUCH_NO"))));
					// 공제구분(A:지급제한,B:부산물(내역있음),C:부산물(내역없음))
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/AdditionalDocument/StatementCode
					GSagItemCommDtlAI.addContent(new Element("StatementCode", wco).setText("C"));
					GSagItemCommDtl.addContent(GSagItemCommDtlAI);

					/**
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/DutyTaxFee
					 */
					Element GSagItemCommDtlTaxFee = new Element("DutyTaxFee", wco);
					/**
					 * Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/DutyTaxFee/Payment
					 */
					Element GSagItemCommDtlTaxFeePay = new Element("Payment", wco);
					// 세액합계
					// Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DetailedCommodity/DutyTaxFee/TaxAssessedAmount
					GSagItemCommDtlTaxFeePay.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(GSAgItemCommDtlMap.get("DRWBAK_AMOUNT"))));
					GSagItemCommDtlTaxFee.addContent(GSagItemCommDtlTaxFeePay);
					GSagItemCommDtl.addContent(GSagItemCommDtlTaxFee);
					GSagItemComm.addContent(GSagItemCommDtl);
				}

				// ==================================================================
				// <!--1..99999 조견표_제품증명내역 상세--> 종료
				// ==================================================================

				GSagItem.addContent(GSagItemComm);
				DeclareGS.addContent(GSagItem);
			}

			// =========================================================
			// 1..9999 조견표_제품증명내역 종료
			// =========================================================
			Declaration.addContent(DeclareGS);

			/**
			 * Declaration/Submitter
			 */
			Element Submitter = new Element("Submitter", wco);
			// 신청인통관고유부호 Declaration/Submitter/ID
			Submitter.addContent(new Element("ID", wco).setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
			Declaration.addContent(Submitter);

			logger.debug("<병> - xml 데이터 종료 : " + presentnNo);

			logger.debug("FILE 생성 시작 : " + presentnNo);

			FileOutputStream fos = null;
			OutputStreamWriter writer = null;

			try {
				Document myDoc = new Document(Declaration);

				XMLOutputter outputter = new XMLOutputter();
				Format format = outputter.getFormat();
				outputter.setFormat(Format.getPrettyFormat());

				PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
						.getConfigurator("app_resource");

				// XML 파일 명
				String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

				String workPath = configurator.getString("file.xml.dir");
				String sendPath = configurator.getString("file.sendxml.dir");
				String receivePath = configurator.getString("file.xmlreceive.dir");

				String backupPath = configurator.getString("file.xmlbackup.dir");

				// String basePath = req.getSession().getServletContext().getRealPath(workPath);
				String basePath = configurator.getString("file.xml.dir");

				String outputFolder = basePath + sendPath;
				String receiveFolder = basePath + receivePath;
				//String backupFolder = basePath + receivePath + "/" + backupPath;
				String backupFolder =  backupPath;

				File senddir = new File(outputFolder); // 송신 DIR
				File receivedir = new File(receiveFolder); // 수신 DIR
				File backupdir = new File(backupFolder); // 수신 Backup DIR

				// 송신폴더 생성
				if (!senddir.isDirectory()) {
					senddir.mkdirs();
				}

				// 수신폴더 생성
				if (!receivedir.isDirectory()) {
					receivedir.mkdirs();
				}

				// 백업폴더 생성
				if (!backupdir.isDirectory()) {
					backupdir.mkdirs();
				}

				fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
				writer = new OutputStreamWriter(fos, "utf-8");
				outputter.output(myDoc, writer);

			} catch (Exception e) {
				// TODO: handle exception
				logger.debug(e.getMessage());
			} finally {
				writer.close();
			}

			logger.debug("Create Xml Parsing End");

			return returnMap;
		}
		
		/**
		 * 조견표 송신 이후 상태 값 처리 
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result updateQuickRefStatus(Map<String, Object> param, List<Map> workList) throws Exception {
			return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateQuickRefStatus(row));
	    	
		}
		
		
		/**
		 * BOM 제출 데이터 생성
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result createBomSubmitData(Map<String, Object> param) throws Exception {
			Result rs = new Result();
			String bomPresentnNo = StringUtil.null2String(param.get("BOM_PRESENTN_NO"));
			
			int ii = 0;
			if("".equalsIgnoreCase(bomPresentnNo)) {
				//마스터 데이터 저장
				ii = sqlSession.getMapper(DrawbackDocDao.class).insertBomSubmit_MasterData(param);
				// 저장한 마스터 데이터 조회
				Map bomMstMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_BomMasterData(param);
				// 저장한 마스터 데이터를 이용하여 상세데이터 생성
				ii = ii + sqlSession.getMapper(DrawbackDocDao.class).insertBomSubmit_ItemData(bomMstMap);
			}else {
				ii = sqlSession.getMapper(DrawbackDocDao.class).updateBomSubmit_MasterData(param);
			}
			
			if(ii > 0) {
				rs.setSuccess(true);
			}else {
				rs.setSuccess(false);
			}
				
			return rs;
	    	
		}
		
		/**
		 * BOM 제출 데이터 생성(기납증)
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Result createInitBomSubmitData(Map<String, Object> param) throws Exception {
			Result rs = new Result();
			String bomPresentnNo = StringUtil.null2String(param.get("BOM_PRESENTN_NO"));
			
			int ii = 0;
			if("".equalsIgnoreCase(bomPresentnNo)) {
				//마스터 데이터 저장
				ii = sqlSession.getMapper(DrawbackDocDao.class).insertInitBomSubmit_MasterData(param);
				// 저장한 마스터 데이터 조회
				Map bomMstMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_BomMasterData(param);
				// 저장한 마스터 데이터를 이용하여 상세데이터 생성
				ii = ii + sqlSession.getMapper(DrawbackDocDao.class).insertInitBomSubmit_ItemData(bomMstMap);
			}else {
				ii = sqlSession.getMapper(DrawbackDocDao.class).updateInitBomSubmit_MasterData(param);
			}
			
			if(ii > 0) {
				rs.setSuccess(true);
			}else {
				rs.setSuccess(false);
			}
			
			return rs;
			
		}
		
		
		
	    /**
		 * 가산금 지급 신청 XML 파일 생성
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result createXml_Adamt(Map<String, Object> param, List<Map> workList) throws Exception {
	    	Result rs = new Result();
	    	String presentn_No = "";
	    	List<Map<String, Object>> returnList = new ArrayList<Map<String,Object>>();
	    	for(int inx = 0; inx < workList.size(); inx++) {
	    		Map rowMap = workList.get(inx);
	    		rowMap.putAll(param);
	    		
	    		
	    		presentn_No = StringUtil.null2String(rowMap.get("ADAMT_PRESENTN_NO"));
	    		Map returnMap = createXmlDocForAdamt(rowMap, presentn_No);
	    		rowMap.putAll(returnMap);
	    		returnList.add(rowMap);
	    	}
	    	
	    	rs.setSuccess(true);
	    	rs.setValue(returnList);
	    	return rs;
		}
		
		
		
		/**
		* 송신 : 가산금 지급 신청
		* @param param
		* @param presentnNo
		* @return
		* @throws Exception
		*/
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Map<String, Object> createXmlDocForAdamt(Map param, String presentnNo) throws Exception {
			
			Map paramMap = new HashMap<String, Object>();
			//Tax 종류
		    String[] taxArray = {"CUD","IND","5AA","ACT","5AB","CAP","5CZ"};
			
			paramMap.putAll(param);
			paramMap.put("PRESENTN_NO", presentnNo);
			
			Map returnMap = new HashMap<String, Object>();
			returnMap.put("PRESENTN_NO", presentnNo);  // ex : ADAMT-11001100-20241009-0001
			
			// XML 생성 시작
			Map xmlMap = new HashMap();
			
			//Name 스페이스 정의
	  		Namespace kcs = Namespace.getNamespace("kcs", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCKSchemaModule:1:0");
	  		Namespace wco = Namespace.getNamespace("wco", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCKSchemaModule:1:0");
	  		Namespace xsi = Namespace.getNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");	
	  		
	  		//root element 만들기
	  		Element Declaration = new Element("Declaration", wco);
	  		
	  		//Name 스페이스 설정
			Declaration.setAttribute("schemaLocation", "urn:kr:gov:kcs:data:standard:KCS_DeclarationOfDRB_DCKSchemaModule:1:0 ../../schema4G/kcs/data/standard/KCS_DeclarationOfDRB_DCKSchemaModule_1.0_standard.xsd", xsi);
			Declaration.addNamespaceDeclaration(kcs);
			Declaration.addNamespaceDeclaration(xsi);
			
			/**
			 * ****** XML 생성용 <갑> 데이터 조회 ****** 
			 */
			logger.debug(" Xml Content Parsing Start : " + presentnNo);
			
			String checkNewYn = sqlSession.getMapper(DrawbackDocDao.class).checkNewSubmitNo_Adamt(paramMap);

			if("Y".equalsIgnoreCase(checkNewYn)) {	// 오류통보등 기존에 생성된 번호가 있으면 재사용함
				/* 제출번호 생성을 위해 기존 번호 + 1 수행 */
				sqlSession.getMapper(DrawbackDocDao.class).createNewSubmitNo(paramMap);
				
				/* 제출번호 xml 생성할때마다 재생성 */
				sqlSession.getMapper(DrawbackDocDao.class).updateSubmitNo_Adamt(paramMap);
			}
			

	    	
			//Map 생성 
			Map<String, Object> retrieveMap = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Adamt(paramMap);
			
			returnMap.put("SUBMIT_NO", StringUtil.null2String(retrieveMap.get("SUBMIT_NO")));
			returnMap.put("UNIPASS_ID", StringUtil.null2String(retrieveMap.get("UNIPASS_ID")));
			returnMap.put("UNIPASS_DOC_BOX_CODE", StringUtil.null2String(retrieveMap.get("UNIPASS_DOC_BOX_CODE")));
			returnMap.put("STTEMNT_DOC_STLE", StringUtil.null2String(retrieveMap.get("STTEMNT_DOC_STLE")));

			logger.debug("<갑> - xml 데이터 생성 : " + presentnNo);

			// 제출세관부호 Declaration/DeclarationOfficeID  
			Declaration.addContent(new Element("DeclarationOfficeID" , wco).setText(StringUtil.null2String(retrieveMap.get("CSMHSE_CODE"))));
			// 제출번호 Declaration/ID  
			Declaration.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("SUBMIT_NO"))));
			// 문서형태구분 Declaration/TypeCode  
			Declaration.addContent(new Element("TypeCode" , wco).setText("GOVCBRD93"));

			/** 
			 * Declaration/Agent
			 * 가산금지급신청서는 신고대행관세사번호가 필수입력항목!!
			 */
			Element DeclareAgent = new Element("Agent", wco);  
				// 신고대행관세사번호 Declaration/Agent/ID  
				DeclareAgent.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("CSTBRKR"))));
			Declaration.addContent(DeclareAgent);    
			
			
			/**
			 * Declaration/BankAccount
			 */
			Element bankAccount = new Element("BankAccount", wco);
				// 온라인구좌번호  Declaration/BankAccount/ID  
				bankAccount.addContent(new Element("ID" , wco).setText(StringUtil.null2String(retrieveMap.get("ACNUTNO"))));
				//지급금융기관코드  Declaration/BankAccount/ReferenceID  
				bankAccount.addContent(new Element("ReferenceID" , wco).setText(StringUtil.null2String(retrieveMap.get("BANK_CODE"))));
			Declaration.addContent(bankAccount);
				
				//======================================================
				// <!--1..7 반복--> 시작
				// taxArray => {"CUD","IND"   ,"5AA"        ,"ACT","5AB","CAP" ,"5CZ"};
				//             {관세  ,개별소비세액,교통에너지환경세액,주세액,교육세액,농특세액,세액 합계}
				//======================================================*/
				for(int j = 0; j < taxArray.length ; j++){
				
				/**
				 *  세액 정보
				 *  Declaration/DutyTaxFee
				 **/
				Element dutyTaxFee = new Element("DutyTaxFee", wco);		
					// 세액구분 Declaration/DutyTaxFee/TypeCode	
				dutyTaxFee.addContent(new Element("TypeCode", wco).setText(taxArray[j]));
					
					/**
					 *  Declaration/DutyTaxFee/Payment
					 **/
					Element payment = new Element("Payment", wco);		
						// 세액 Declaration/DutyTaxFee/Payment/TaxAssessedAmount	
					payment.addContent(new Element("TaxAssessedAmount", wco).setText(StringUtil.null2String(retrieveMap.get(""+taxArray[j]))));
					dutyTaxFee.addContent(payment);
				Declaration.addContent(dutyTaxFee);
				
				} 
			
			List<Map<String, Object>> retrieveItemList = sqlSession.getMapper(DrawbackDocDao.class).retrieve_Adamt_detail(paramMap);
			
			for(int inx = 0; inx < retrieveItemList.size(); inx++) {
				Map itemMap = retrieveItemList.get(inx);
				/** 
				 * Declaration/GoodsShipment
				 */
				Element declareGS = new Element("GoodsShipment", wco);  
					/** 
					* Declaration/GoodsShipment/SequenceNumeric
					*/
					declareGS.addContent(new Element("SequenceNumeric" , wco).setText(StringUtil.null2String(itemMap.get("SEQ"))));
					
					/** 
					* Declaration/GoodsShipment/AdditionalDocument
					*/
					Element additionalDocument = new Element("AdditionalDocument", wco);
						//추가환급접수번호 Declaration/GoodsShipment/AdditionalDocument/ID
						additionalDocument.addContent(new Element("ID" , wco).setText(StringUtil.null2String(itemMap.get("PROPER_REGIST_RCEPT_NO"))));
					declareGS.addContent(additionalDocument);
					
					/** 
					* Declaration/GoodsShipment/DutyTaxFee
					*/
					Element dutyTaxFee = new Element("DutyTaxFee", wco);
						//세목세분류코드 Declaration/GoodsShipment/DutyTaxFee/TypeCode
						dutyTaxFee.addContent(new Element("TypeCode" , wco).setText(StringUtil.null2String(itemMap.get("TAX_TYPE"))));
						/** 
						* Declaration/GoodsShipment/DutyTaxFee/Payment
						*/
						Element payment = new Element("Payment", wco);
							// 개별납부고지서번호 Declaration/GoodsShipment/DutyTaxFee/Payment/ReferenceID
							payment.addContent(new Element("ReferenceID" , wco).setText(StringUtil.null2String(itemMap.get("IDV_PAMT_NO"))));
							// 개별납부고지일자 Declaration/GoodsShipment/DutyTaxFee/Payment/PaymentDateTime
							payment.addContent(new Element("PaymentDateTime" , wco).setText(StringUtil.null2String(itemMap.get("IDV_PAMT_DATE"))));
						dutyTaxFee.addContent(payment);
					declareGS.addContent(dutyTaxFee);
					/** 
					* Declaration/GoodsShipment/GovernmentAgencyGoodsItem
					*/
					Element governmentAgencyGoodsItem = new Element("GovernmentAgencyGoodsItem", wco);
						/** 
						* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity
						*/
						Element commodity = new Element("Commodity", wco);
						
						
							/** 
							* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee - (5BB:과다환급금)
							*/
							Element commodityDutyTaxFee_5BB = new Element("DutyTaxFee", wco);
								// 환급금 구분   Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/TypeCode - (5BB:과다환급금)
								commodityDutyTaxFee_5BB.addContent(new Element("TypeCode" , wco).setText("5BB"));
								/** 
								* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5BB:과다환급금)
								*/
								Element commodityDutyTaxFeePayment_5BB = new Element("Payment", wco);
									//과다환급금 금액 : Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5BB:과다환급금)
									commodityDutyTaxFeePayment_5BB.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(itemMap.get("PRE_DRWBAK_AMOUNT"))));
								commodityDutyTaxFee_5BB.addContent(commodityDutyTaxFeePayment_5BB);
							commodity.addContent(commodityDutyTaxFee_5BB);

							
							/** 
							* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee - (5AK:가산금)
							*/
							Element commodityDutyTaxFee_5AK = new Element("DutyTaxFee", wco);
								// 환급금 구분   Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/TypeCode - (5AK:가산금)
								commodityDutyTaxFee_5AK.addContent(new Element("TypeCode" , wco).setText("5AK"));
								/** 
								* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5AK:가산금)
								*/
								Element commodityDutyTaxFeePayment_5AK = new Element("Payment", wco);
									//가산금 금액 : Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5AK:가산금)
									commodityDutyTaxFeePayment_5AK.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(itemMap.get("ADAMT"))));
								commodityDutyTaxFee_5AK.addContent(commodityDutyTaxFeePayment_5AK);
							commodity.addContent(commodityDutyTaxFee_5AK);
							
							/** 
							* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee - (5CN:추가환급금)
							*/
							Element commodityDutyTaxFee_5CN = new Element("DutyTaxFee", wco);
								// 환급금 구분   Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/TypeCode - (5CN:추가환급금)
								commodityDutyTaxFee_5CN.addContent(new Element("TypeCode" , wco).setText("5CN"));
								/** 
								* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5CN:추가환급금)
								*/
								Element commodityDutyTaxFeePayment_5CN = new Element("Payment", wco);
									//추가환급금 금액 : Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5CN:추가환급금)
									commodityDutyTaxFeePayment_5CN.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(itemMap.get("PROPER_DRWBAK_AMOUNT"))));
								commodityDutyTaxFee_5CN.addContent(commodityDutyTaxFeePayment_5CN);
							commodity.addContent(commodityDutyTaxFee_5CN);
							
							/** 
							* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee - (5CP:지급신청가산금액)
							*/
							Element commodityDutyTaxFee_5CP = new Element("DutyTaxFee", wco);
								// 환급금 구분   Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/TypeCode - (5CP:지급신청가산금액)
								commodityDutyTaxFee_5CP.addContent(new Element("TypeCode" , wco).setText("5CP"));
								/** 
								* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5CP:지급신청가산금액)
								*/
								Element commodityDutyTaxFeePayment_5CP = new Element("Payment", wco);
									//지급신청가산금액 금액 : Declaration/GoodsShipment/GovernmentAgencyGoodsItem/Commodity/DutyTaxFee/Payment - (5CP:지급신청가산금액)
									commodityDutyTaxFeePayment_5CP.addContent(new Element("TaxAssessedAmount" , wco).setText(StringUtil.null2String(itemMap.get("PAMT_REQ_ADAMT"))));
								commodityDutyTaxFee_5CP.addContent(commodityDutyTaxFeePayment_5CP);
							commodity.addContent(commodityDutyTaxFee_5CP);
						governmentAgencyGoodsItem.addContent(commodity);
						/** 
						* Declaration/GoodsShipment/GovernmentAgencyGoodsItem/PreviousDocument
						*/
						Element previousDocument = new Element("PreviousDocument", wco);			
							// 최초환급접수번호 : Declaration/GoodsShipment/GovernmentAgencyGoodsItem/PreviousDocument/ID
							previousDocument.addContent(new Element("ID" , wco).setText(StringUtil.null2String(itemMap.get("PRE_REGIST_RCEPT_NO"))));
							
						governmentAgencyGoodsItem.addContent(previousDocument);
					declareGS.addContent(governmentAgencyGoodsItem);
					
				Declaration.addContent(declareGS);
			}  // retrieveItemList for End
			
			/**
			* Declaration/Submitter
			*/
			Element declareSubmitter = new Element("Submitter", wco);		
				// 환급신청인 부호(통관고유부호(380)/사업자 등록번호(KTX)) Declaration/Submitter/ID	
				declareSubmitter.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "380").setText(StringUtil.null2String(retrieveMap.get("ECTMRK"))));
				// 환급신청인 부호(통관고유부호(380)/사업자 등록번호(KTX)) Declaration/Submitter/ID	
				declareSubmitter.addContent(new Element("ID", wco).setAttribute("schemeAgencyID", "KTX").setText(StringUtil.null2String(retrieveMap.get("BIZRNO"))));
			Declaration.addContent(declareSubmitter);
			
				 
			logger.debug("FILE 생성 시작 : " + presentnNo);

			FileOutputStream fos = null;
			OutputStreamWriter writer = null;

			try {
				Document myDoc = new Document(Declaration);

				XMLOutputter outputter = new XMLOutputter();
				Format format = outputter.getFormat();
				outputter.setFormat(Format.getPrettyFormat());

				PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance()
						.getConfigurator("app_resource");

				// XML 파일 명
				String crateXmlFileName = StringUtil.null2String(presentnNo) + ".xml";

				String workPath = configurator.getString("file.xml.dir");
				String sendPath = configurator.getString("file.sendxml.dir");
				String receivePath = configurator.getString("file.xmlreceive.dir");

				String backupPath = configurator.getString("file.xmlbackup.dir");

				// String basePath = req.getSession().getServletContext().getRealPath(workPath);
				String basePath = configurator.getString("file.xml.dir");

				String outputFolder = basePath + sendPath;
				String receiveFolder = basePath + receivePath;
				//String backupFolder = basePath + receivePath + "/" + backupPath;
				String backupFolder =  backupPath;

				File senddir = new File(outputFolder); // 송신 DIR
				File receivedir = new File(receiveFolder); // 수신 DIR
				File backupdir = new File(backupFolder); // 수신 Backup DIR

				// 송신폴더 생성
				if (!senddir.isDirectory()) {
					senddir.mkdirs();
				}

				// 수신폴더 생성
				if (!receivedir.isDirectory()) {
					receivedir.mkdirs();
				}

				// 백업폴더 생성
				if (!backupdir.isDirectory()) {
					backupdir.mkdirs();
				}

				fos = new FileOutputStream(outputFolder + "/" + crateXmlFileName);
				writer = new OutputStreamWriter(fos, "utf-8");
				outputter.output(myDoc, writer);

			} catch (Exception e) {
				// TODO: handle exception
				logger.debug(e.getMessage());
			} finally {
				writer.close();
			}

			logger.debug("Create Xml Parsing End");

			return returnMap;
		}
		
		
		/**
		 * 가산금 지급 신청  송신 이후 상태 값 처리 
		 * @param param
		 * @param workList
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public Result updateAdamtSubmitStatus(Map<String, Object> param, List<Map> workList) throws Exception {
			return this.updateExecuteStatus(param, workList, row -> sqlSession.getMapper(DrawbackDocDao.class).updateAdamtSubmitStatus(row));
	    	
		}
}