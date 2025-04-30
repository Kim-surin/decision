package com.kpmg.kdb.core.common.helper.excel;

import java.io.File;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.util.FileUtil;

public class ExcelConverter {

	private static Log log = LogFactory.getLog(ExcelConverter.class);

	private ExcelFileHelper loader;

	public ExcelConverter() {
	}

	public ExcelConverter(ExcelFileHelper loader) {
		this.loader = loader;
	}

	@SuppressWarnings("rawtypes")
	public List getContents(MultipartFile file, int srow) throws Exception {
		return this.getContents(file, srow, null);
	}
	
	@SuppressWarnings("rawtypes")
	public List getContents4PowerTech(MultipartFile file) throws Exception {

		if (loader == null) {

			String fileName = file.getOriginalFilename();

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (fileName.toLowerCase().lastIndexOf(".xlsx") > 0) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			}else if (fileName.toLowerCase().lastIndexOf(".xls") > 0) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			} else {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}
			

		}

		return loader.read4PowerTech(FileUtil.multipart2File(file), null);
	}

	@SuppressWarnings("rawtypes")
	public List getContentsBySheet(MultipartFile file, int srow, String sheet) throws Exception {
		return this.getContents(file, srow, sheet);
	}

	@SuppressWarnings("rawtypes")
	public List getContents(MultipartFile file, int srow, String sheet) throws Exception {
		ExcelFileHelper loader = null;

		if (loader == null) {

			String fileName = file.getOriginalFilename();

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (fileName.toLowerCase().lastIndexOf(".xls") > 0) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			}
			
			if (fileName.toLowerCase().lastIndexOf(".xlsx") > 0) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			} 
			
			if(loader == null) {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}

		}

		return loader.read(FileUtil.multipart2File(file), srow, sheet);
	}
	
	
	
	/**
	 * Excel File을 읽을 때 사용할 Loader를 선택합니다.
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public ExcelFileHelper getLoader (MultipartFile file) throws Exception{
		ExcelFileHelper loader = null;
		
		if (loader == null) {

			String fileName = file.getOriginalFilename();

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (fileName.toLowerCase().lastIndexOf(".xls") > 0) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			}
			if (fileName.toLowerCase().lastIndexOf(".xlsx") > 0) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			} else {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}

		}

		return loader;
	}

	@SuppressWarnings("rawtypes")
	public void write(List contents, String fname) throws Exception {
		this.write(contents, null, fname);
	}

	@SuppressWarnings("rawtypes")
	public void write(List contents, String fpath, String fname) throws Exception {
		if (loader == null) {

			if (fname.toLowerCase().lastIndexOf(".xls") > 0) {
				log.debug("File info : Excel(2003~2007)");
				loader = new ExcelTypeHLoader();
			}
			if (fname.toLowerCase().lastIndexOf(".xlsx") > 0) {
				log.debug("File info : Excel(2007 later).");

				loader = new ExcelTypeXLoader();
			} else {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}
		}

		loader.write(contents, FileUtil.getFile(fpath, fname));
	}
	
	@SuppressWarnings("rawtypes")
	public List getContents(MultipartFile file, int srow, int sheetNum) throws Exception {
		ExcelFileHelper loader = null;

		if (loader == null) {

			String fileName = file.getOriginalFilename();

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (fileName.toLowerCase().lastIndexOf(".xls") > 0) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			}
			
			if (fileName.toLowerCase().lastIndexOf(".xlsx") > 0) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			} 
			
			if(loader == null) {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}

		}

		log.debug("########### loader.read  진입 전");
		return loader.read(FileUtil.convertFile(file), srow, sheetNum);
	}

	@SuppressWarnings("rawtypes")
	public List getContents(File file, int srow, String sheet, String originalFilename) throws Exception {
		ExcelFileHelper loader = null;

		if (loader == null) {

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (originalFilename.toLowerCase().endsWith(".xls")) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			}
			
			if (originalFilename.toLowerCase().endsWith(".xlsx")) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			} 
			
			if(loader == null) {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}

		}

		return loader.read(file, srow, sheet);
	}

	@SuppressWarnings("rawtypes")
	public List getContents(File file, int srow, int sheet, String originalFilename) throws Exception {
		ExcelFileHelper loader = null;

		if (loader == null) {

			//File newFile = new File(fileName);
			//file.transferTo(newFile);

			if (originalFilename.toLowerCase().endsWith(".xls")) {

				log.debug("File type is Excel(2003~2007).");
				loader = new ExcelTypeHLoader();
			}
			
			if (originalFilename.toLowerCase().endsWith(".xlsx")) {

				log.debug("File type is Excel(2007~).");

				loader = new ExcelTypeXLoader();
			} 
			
			if(loader == null) {
				throw new Exception("Wrong request. Please request again after entering the correct file name.");
			}

		}

		return loader.read(file, srow, sheet);
	}
}
