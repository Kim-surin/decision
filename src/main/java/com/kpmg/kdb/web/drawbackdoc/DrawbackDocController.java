package com.kpmg.kdb.web.drawbackdoc;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;


/*******************************************************************************************
 * 
 * DrawbackDocController Class
 * 
 * @since 2018.02.01
 * @author D.Cat
 *
 * Unipas 송/수신 문서 관련 Class
 * 
 ********************************************************************************************/
@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class DrawbackDocController extends GenericController {


	protected Logger logger = LoggerFactory.getLogger(DrawbackDocController.class);

	@Autowired
	protected DrawbackDocService service;
	
	


	/**
	 * Unipass 수신
	 * 
	 * @author  
	 * @param param
	 * @return data
	 */
	@RequestMapping(value="/common/unipassReceiveData", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public Result unipassReceiveData(
			HttpServletRequest req , @RequestHeader MultiValueMap<String, String> headerMap ) throws Exception {
		
		Result rs = new Result();
		Map<String, Object> param = new HashMap();
		try {
			logger.debug("유니패스 수신 프로세스 시작");
			
			Enumeration params = req.getParameterNames();
			while (params.hasMoreElements()){
			    String name = (String)params.nextElement();
			    if("COMPANY_CODE".equalsIgnoreCase(name) || "DIVISION_CODE".equalsIgnoreCase(name)){
			    	param.put(name, req.getParameter(name));
			    }
			}
			
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator("app_resource");
			
			String workPath = configurator.getString("file.xml.dir");
    		String sendPath = configurator.getString("file.sendxml.dir");
    		String receivePath = configurator.getString("file.xmlreceive.dir");
    		
    		String backupPath = configurator.getString("file.xmlbackup.dir");
    		
    		//String basePath = req.getSession().getServletContext().getRealPath(workPath);			
    		String basePath = configurator.getString("file.xml.dir");
    		
    		String outputFolder = basePath +  sendPath;
    		String receiveFolder = basePath + receivePath;
    		//String backupFolder = basePath +  receivePath + backupPath;
    		String backupFolder = backupPath;

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

    		/*
    		for(int inx = 0; inx < mfile.length; inx++) {
    			MultipartFile file = mfile[inx];
    			transferToPath(req.getSession().getServletContext(), receiveFolder, file);
    		}
    		*/
    		// request 에서 File만 꺼냄
    		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
    		Iterator<String> iterator = multipartRequest.getFileNames();
    		while (iterator.hasNext()) {
    			 String key = (String) iterator.next();
    			 for(MultipartFile files : multipartRequest.getFiles(key)){
    		            // files.getName();
    		            // files.getSize(); 등등...
    				 transferToPath(req.getSession().getServletContext(), receiveFolder, files);
    			 }
    		 }
			rs.setValue(service.unipassReceiveData(param));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		return rs;
	}
	
	
	/**
	 * 파일 저장 후 정보 리턴
	 * @param servletContext
	 * @param filePath
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> transferToPath(ServletContext servletContext, String filePath, MultipartFile file) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		String ORIGINAL_FILE_NAME = "ORIGINAL_FILE_NAME";
		String ORIGINAL_FILE_EXTENSION = "ORIGINAL_FILE_EXTENSION";
		String NEW_FILE_NAME = "NEW_FILE_NAME";
		String FILE_PATH = "FILE_PATH";
		String DOWNLOAD_URL = "DOWNLOAD_URL";
		
		logger.debug("FileUtils.transferToPath start");
		//String basePath = servletContext.getRealPath(filePath);
		String basePath = filePath;
		String originalFileFullName = file.getOriginalFilename();
		String originalFileName = originalFileFullName.substring(0, originalFileFullName.lastIndexOf("."));
		String originalExtension = originalFileFullName.substring(originalFileFullName.lastIndexOf("."));

		File newFile;
		String newFileFullName;
		String newFileFullPath;
		Integer dupCount = 0;
		String dupName;

		while (true) {
			dupName = (dupCount++ == 0) ? "" : "(" + dupCount.toString() + ")";
			newFileFullName = originalFileName + dupName + originalExtension;
			newFileFullPath = basePath + File.separator+ newFileFullName;
			newFile = new File(newFileFullPath);
			if (!newFile.exists()) {
				break;
			}
		}

		/*
		File dir = new File(basePath);

		// directory 없을경우
		if (!dir.exists()) {
			if (!dir.mkdirs()) {
				throw new Exception("Failed Make Dir ==> " + dir.getName());
			}
		}
		*/
		logger.debug("#####" + "newFileFullPath : " + newFileFullPath);
		File uploadFile = new File(newFileFullPath);
		newFileFullPath = uploadFile.getAbsolutePath();
		String downloadUrl = filePath;
		
		
		
		file.transferTo(uploadFile);
		
		rtnMap.put(ORIGINAL_FILE_NAME, originalFileFullName);
		rtnMap.put(NEW_FILE_NAME, newFileFullName);
		rtnMap.put(FILE_PATH, filePath);
		rtnMap.put(DOWNLOAD_URL, downloadUrl);
		rtnMap.put(ORIGINAL_FILE_EXTENSION, originalExtension);
		
		return rtnMap;
	}
	
	
	/**
	 * 환급신청 (관세청 연계)에 필요한 XML 파일 생성
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_Drwb", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_Drwb(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_Drwb(systemMap, paramList);

	}

	/**
	 * 송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateDrwbStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateDrwbStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateDrwbStatus(systemMap, paramList);
		return rs;

	}

	/**
	 * 기납증/분증에 필요한 XML 파일 생성
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_init_part", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_init_part(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_init_part(systemMap, paramList);

	}
	
	/**
	 * 분증/기납증 송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateInitPartStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateInitPartStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateInitPartStatus(systemMap, paramList);
		return rs;

	}
	
	/**
	 * 관세청 수신 상태 조회
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/drawbackDoc/unipassStatusPopup")
	public String refundBasis_002_view(@RequestParam Map param, Model model, HttpSession session) {
		
		String returnPageStr = "";
		model.addAttribute("reqParam", super.extendsMap(param));
		returnPageStr = "drawbackdoc/unipassStatus_R20_Popup";
		
		
		return returnPageStr;

	}
	
	/**
	 * BOM에 필요한 XML 파일 생성
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_DrwbBom", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_Bom(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_DrwbBom(systemMap, paramList);

	}
	
	/**
	 * BOM 제출 송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateBomSubmitStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateBomSubmitStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateBomSubmitStatus(systemMap, paramList);
		return rs;

	}
	
	
	/**
	 * BOM에 필요한 XML 파일 생성(기납증)
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_InitBom", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_InitBom(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_InitbBom(systemMap, paramList);

	}
	
	/**
	 * BOM 제출 송신 이후 상태 값 처리(기납증)
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateInitBomSubmitStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateInitBomSubmitStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateBomSubmitStatus(systemMap, paramList);
		return rs;

	}
	
	
	/**
	 * 과다환급자진신고에 필요한 XML 파일 생성
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_overDrwb", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_overDrwb(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_overDrwb(systemMap, paramList);

	}
	
	/**
	 * 과다환급자진신고 송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateOverDrwbStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateOverDrwbStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateOverDrwbStatus(systemMap, paramList);
		return rs;

	}
	
	/**
	 * 조견표 XML 파일 생성
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_quickRef", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_quickRef(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_quickRef(systemMap, paramList);
	}
	
	/**
	 * 조견표 송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateQuickRefStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateQuickRefStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateQuickRefStatus(systemMap, paramList);
		return rs;

	}
	
	
	/**
	 * BOM제출 데이터 생성 및 수정
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createMerge_BomSubmitData", method = RequestMethod.POST)
	@ResponseBody
	public Result createMerge_BomSubmitData(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		
		rs = service.createBomSubmitData(super.extendsMap(param));
		return rs;

	}
	
	
	/**
	 * BOM제출 데이터 생성 및 수정
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createMerge_InitBomSubmitData", method = RequestMethod.POST)
	@ResponseBody
	public Result createMerge_InitBomSubmitData(@RequestBody Map param) throws Exception {
		Result rs = new Result();
		
		rs = service.createInitBomSubmitData(super.extendsMap(param));
		return rs;

	}
	
	
	/**
	 * 가산금 지급 신청 XML 파일 생성
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/createXml_Adamt", method = RequestMethod.POST)
	@ResponseBody
	public Result createXml_Adamt(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());

		return service.createXml_Adamt(systemMap, paramList);

	}
	
	
	/**
	 * 가산금 지급 신청  송신 이후 상태 값 처리
	 * 
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/drawbackDoc/updateAdamtSubmitStatus", method = RequestMethod.POST)
	@ResponseBody
	public Result updateAdamtSubmitStatus(@RequestBody List<Map> paramList) throws Exception {
		Result rs = new Result();
		Map systemMap = super.extendsMap(new HashedMap());
		rs = service.updateAdamtSubmitStatus(systemMap, paramList);
		return rs;

	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/common/unipassRecvSync", method = RequestMethod.POST)
	@ResponseBody
	public Result uploadExportExcelProcess(@RequestParam Map param,  @RequestParam("file01") MultipartFile []  mfile, HttpServletRequest req, MultipartHttpServletRequest mReq) throws Exception {
		
		
		Result rs = new Result();
		try {
			logger.debug("유니패스 수동 수신 프로세스 시작");
			
			
			
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfigurator("app_resource");
			
			String workPath = configurator.getString("file.xml.dir");
    		String sendPath = configurator.getString("file.sendxml.dir");
    		String receivePath = configurator.getString("file.xmlreceive.dir");
    		
    		String backupPath = configurator.getString("file.xmlbackup.dir");
    		
    		//String basePath = req.getSession().getServletContext().getRealPath(workPath);			
    		String basePath = configurator.getString("file.xml.dir");
    		
    		String outputFolder = basePath +  sendPath;
    		String receiveFolder = basePath + receivePath;
    		//String backupFolder = basePath +  receivePath + backupPath;
    		String backupFolder = backupPath;

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

    		
    		for(int inx = 0; inx < mfile.length; inx++) {
    			MultipartFile file = mfile[inx];
    			transferToPath(req.getSession().getServletContext(), receiveFolder, file);
    		}
    		// request 에서 File만 꺼냄
    		/*
    		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
    		Iterator<String> iterator = multipartRequest.getFileNames();
    		
    		while (iterator.hasNext()) {
    			 String key = (String) iterator.next();
    			 for(MultipartFile files : multipartRequest.getFiles(key)){
    		            // files.getName();
    		            // files.getSize(); 등등...
    				 transferToPath(req.getSession().getServletContext(), receiveFolder, files);
    			 }
    		 }
    		*/
			rs.setValue(service.unipassReceiveData(super.extendsMap(param)));
			rs.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}
		
		return rs;
	}
	
}