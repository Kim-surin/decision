package com.kpmg.kdb.util;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.configuration.ConstantBox;
import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.schedule.quartz.job.ApplicationConstants;



public class FileUtil {
	
    
    private static final Log log = LogFactory.getLog(FileUtil.class);

    
    public final static String ORIGINAL_FILE_NAME = "ORIGINAL_FILE_NAME";
	public final static String ORIGINAL_FILE_EXTENSION = "ORIGINAL_FILE_EXTENSION";
	public final static String NEW_FILE_FULL_PATH = "NEW_FILE_FULL_PATH";
	public final static String NEW_FILE_NAME = "NEW_FILE_NAME";
	public final static String FILE_PATH = "FILE_PATH";
	public final static String DOWNLOAD_URL = "DOWNLOAD_URL";
	public final static String FILE_SIZE = "FILE_SIZE";
	
	
	private static String tmpFilePath = ConstantBox.tmpFilePath;
	

	
	
    private static class FileExtensionFilter implements FilenameFilter {
    	


        String acceptableExtensions[];

        FileExtensionFilter(String ext[]) {
            acceptableExtensions = ext;
        }

        public boolean accept(File dir, String fname) {
            if (acceptableExtensions == null) {
                return true;
            }

            // check if the extension of the file is in the ecceptable list.
            for (int i = 0; i < acceptableExtensions.length; i++) {
                if (fname.endsWith(acceptableExtensions[i])) {
                    return true;
                }
            }

            // if the file is a directory, then return true.
            File tempFile = new File(dir, fname);
            return tempFile.isDirectory();
        }
    }

    
    private static class FilenamePatternFilter implements FilenameFilter {

    	List<Pattern> patternList = new ArrayList<Pattern>();

    	FilenamePatternFilter(String patternStr) {
    		if (patternStr != null) {
    			patternList.add(Pattern.compile(patternStr));
    		}
    	}
    	
        FilenamePatternFilter(String[] patternStr) {
        	if (patternStr == null) {
        		return;
        	}
        	
            for(int i=0;i<patternStr.length;i++) {
            	patternList.add(Pattern.compile(patternStr[i]));
            }
        }

        public boolean accept(File dir, String fname) {

            // check if the extension of the file is in the ecceptable list.
            for (int i=0;i<patternList.size();i++) {
            	if (patternList.get(i).matcher(fname).matches()) {
            		return true;
            	}
            }

            // if the file is a directory, then return true.
            File tempFile = new File(dir, fname);
            return tempFile.isDirectory();
        }
    }
 
    
    public static void mergeFile(String targetName, String[] sourceNames, boolean deleteSource) throws IOException {
    	File targetFile = new File(targetName);
    	FileOutputStream fos = new FileOutputStream(targetFile);
    	
    	File sourceFile = null;
    	FileInputStream fis = null;
    	int len = 0;
    	byte[] buf = new byte[1024*1024];
    	
    	try {
	    	for(int i=0;i<sourceNames.length;i++) {
	    		sourceFile = new File(sourceNames[i]);
	    		fis = new FileInputStream(sourceFile);
	    		while((len=fis.read(buf))>0) {
	    			fos.write(buf,0,len);
	    		}
	    		fis.close();
	    		sourceFile.delete();
	    	}
    	} finally {
    		fos.close();
    	}
    }
    
    
    
    public static boolean deleteDirectory(File dir, boolean include) {
    	if (dir.exists()) {
    		File[] files = dir.listFiles();
    		if (files != null) {
    			for(int i=0;i<files.length;i++) {
	    			if (files[i].isDirectory()) {
	    				deleteDirectory(files[i],true);
	    			} else {
	    				files[i].delete();
	    			}
	    		}
    		}
    		if (include) {
        		return dir.delete();
        	} else {
        		return true;
        	}
    	} else {
    		return true;
    	}
    }
    
    
    public static String[] getFilenamesUnder(String rootDir, String ext[], boolean excludingRoot) {
        List<String> filenames = new ArrayList<String>();
        File rootFile = null;

        if (rootDir == null) {
            rootDir = ".";
        }
        rootFile = new File(rootDir);

        String rootPathString = rootFile.getPath();
        File tempFile = null;
        String tempString = null;

        for (Iterator<File> i = getAllFilesUnder(rootFile, new FileExtensionFilter(ext)).iterator();
             i.hasNext();) {
            tempFile = (File) i.next();
            tempString = tempFile.getPath();
            if (excludingRoot) {
                tempString = tempString.substring(rootPathString.length() + 1, tempString.length());
            }
            if (tempString.startsWith(File.separator)) {
                tempString = tempString.substring(1);
            }

            filenames.add(tempString);
        }

        return (String[]) filenames.toArray(new String[0]);
    }

    
    public static String[] getClassnamesUnder(String rootDir, String pkgPrefix, boolean excludingRoot) {

        List<String> classnames = new ArrayList<String>();
        File rootFile = null;

        if (rootDir == null) {
            rootDir = ".";
        }
        rootFile = new File(rootDir);

        String rootPathString = rootFile.getPath();
        File tempFile = null;
        String tempString = null;

        for (Iterator<File> i = getAllFilesUnder(rootFile, new FileExtensionFilter(new String[]{".class"})).iterator();
             i.hasNext();) {
            tempFile = (File) i.next();
            tempString = tempFile.getPath();
            if (excludingRoot) {
                tempString = tempString.substring(rootPathString.length(), tempString.length() - 6);
            } else {
                tempString = tempString.substring(0, tempString.length() - 6);
            }
            tempString = tempString.replace(File.separatorChar, '.');
            if (pkgPrefix != null) {
                tempString = pkgPrefix.concat(tempString);
            }
            if (tempString.startsWith(".")) {
                tempString = tempString.substring(1);
            }
            classnames.add(tempString);
        }

        return (String[]) classnames.toArray(new String[0]);
    }

    
    public static Set<File> getFilesWithExtension(File[] rootDir, String[] ext, boolean subDir) {
    	FilenameFilter filter = new FileExtensionFilter(ext);
        TreeSet<File> set = new TreeSet<File>();
        
        for(int i=0;i<rootDir.length;i++) {
        	set.addAll(getAllFilesUnder(rootDir[i],filter,subDir));
        }
       
        return set;
    }
    
    
    public static Set<File> getFilesWithExtension(File rootDir, String[] ext, boolean subDir) {
    	FilenameFilter filter = new FileExtensionFilter(ext);
    	
    	return getAllFilesUnder(rootDir,filter,subDir);
    }
    
    
    public static Set<File> getFilesOfPattern(File[] rootDir, String[] pattern, boolean subDir) {
    	FilenameFilter filter = new FilenamePatternFilter(pattern);
        TreeSet<File> set = new TreeSet<File>();
        
        for(int i=0;i<rootDir.length;i++) {
        	set.addAll(getAllFilesUnder(rootDir[i],filter,subDir));
        }
       
        return set;
    }
    
    
    public static List<File> getFilesOfPatternAsPatternOrder(File[] rootDir, String[] pattern, boolean subDir) {
    	List<File> list = new ArrayList<File>();
    	
    	for(int i=0;i<pattern.length;i++) {
    		FilenameFilter filter = new FilenamePatternFilter(pattern[i]);
    		for(int j=0;j<rootDir.length;j++) {
    			list.addAll(getAllFilesUnder(rootDir[j],filter,subDir));
    		}
    	}
    	
    	return list;
    }
    
    
    public static Set<File> getFilesOfPattern(File rootDir, String[] pattern, boolean subDir) {
    	FilenameFilter filter = new FilenamePatternFilter(pattern);
    	
    	return getAllFilesUnder(rootDir,filter,subDir);
    }
    
    
    public static Set<File> getAllFilesUnder(File rootDir, FilenameFilter filter) {
    	return getAllFilesUnder(rootDir,filter,true);
    }
    
    
    public static Set<File> getAllFilesUnder(File rootDir, FilenameFilter filter, boolean subDir) {
        TreeSet<File> set = new TreeSet<File>();
        
        if (rootDir.exists() && rootDir.isDirectory()) {
            getFilesIn(rootDir, filter, set, false, subDir);
        } else {
            if (log.isErrorEnabled()) {
                log.error("Directory does not exist. : " + rootDir.getPath());
            }
        }

        return set;
    }

    
    private static void getFilesIn(File rootFile, FilenameFilter filter, Set<File> set, boolean dirFlag, boolean recursiveFlag) {
        File fileList[] = rootFile.listFiles(filter);

        for (int i = 0; i < fileList.length; i++) {
            if (fileList[i].isDirectory()) {
                if (recursiveFlag) {
                    getFilesIn(fileList[i], filter, set, dirFlag, recursiveFlag);
                }
                if (dirFlag) {
                    set.add(fileList[i]);
                }
            } else {
                set.add(fileList[i]);
            }
        }
    }
    
    
    public static void makeDirectrory(String path) {
    	File file = new File(path);

		if (!file.exists()) {
			file.mkdir();
		}
    }
    
    
	public static Map<String, String> transferTo(String propName, MultipartFile file) throws Exception {
		if (file == null) {
			if(log.isDebugEnabled()) log.debug("MultipartFile is null");
			
			throw new Exception("This MultipartFile can't found.");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		
		String filePath =  getFullPath(propName);
		String workPath = getWorkPath(propName);
		
		String orgFileName = file.getOriginalFilename(); 	// 실제파일명
		String orgExtension = orgFileName.substring(orgFileName.lastIndexOf(".")); // 확장자

		File newFile = null;
		String newFileName = null;
		String newFilePath = null;
		Integer dupCount = 0;
		String dupName = null;
		
		File dir = new File(filePath);

		// directory 없을경우
		if (!dir.exists()) {
			if (!dir.mkdirs()) {
				throw new Exception("Failed make directory(" + dir.getName() + ")");
			}
		}
		
		// unique한 파일명을 생성
		while(true) {
			dupName = (dupCount++ == 0) ? "" : "(" + dupCount.toString() + ")";
			
			newFileName = UUID.randomUUID().toString() + dupName + orgExtension; 
			
			newFilePath = filePath + "/" +newFileName;
			newFile = new File(newFilePath);
			
			if (!newFile.exists()) {
				break;
			}
		}
		
		File uploadFile = new File(newFilePath);
		String downloadUrl = workPath + newFileName;
		
		// 파일 생성
		file.transferTo(uploadFile);
		
		//file.setFileName(newFileName);
		map.put(NEW_FILE_FULL_PATH, newFilePath);
		map.put(ORIGINAL_FILE_NAME, orgFileName);
		map.put(NEW_FILE_NAME, newFileName);
		map.put(FILE_PATH, workPath);
		map.put(DOWNLOAD_URL, downloadUrl);
		map.put(ORIGINAL_FILE_EXTENSION, orgExtension);
		map.put("FILE_SIZE", Integer.toString((int)file.getSize()));

		return map;
	}	
	
	
	public static Map<String, String> transferTo(MultipartFile file) throws Exception {
		return transferTo(null, file);
	}
	
	
	public static boolean deleteTo(String propName, String filename) throws Exception {
		String filePath = getFullPath(propName) + filename;

		File uploadedFile = new File(filePath);
		boolean deleted = uploadedFile.delete();
		
		if(log.isDebugEnabled()) log.debug("delete file = " + filePath + ", delete true/false = " + deleted);
		
		return deleted;
	}
	
	public static boolean deleteTo(ServletContext servletContext, String workType, String filename) throws Exception {
		if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "FileUtils.transferTo start");

		if (workType.trim().isEmpty()) {
			workType = "file.common.dir";
		} else {
			workType = workType.trim();
		}

		String workPath;

		try {
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfiguratorByName("appFileAndJasper");
			
			workPath = configurator.getString(workType);
		} catch (Exception e) {
			return false;
		}

		String basePath = servletContext.getRealPath(workPath);
		String newFileFullPath = basePath + "/"+filename;

		if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "newFileFullPath:" + newFileFullPath);

		File uploadedFile = new File(newFileFullPath);

		boolean deleted = uploadedFile.delete();

		if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "deleted:" + deleted);

		return deleted;
	}

	
	public static int deleteTempFile(int days) throws Exception {
		int ret = 0;
		String tempPath = getFullPath(null);
		File tempFile = new File(tempPath);
		
		File[] files = tempFile.listFiles();
		
		for(int i = 0; i < files.length; i++) {
			File file = files[i];
			
			String lastDay = getLastModify(file, "D");
			String currentDay = DateUtil.getToday("");
			int interval = DateUtil.getDays(lastDay, currentDay); // 두일자간의 일수를 구한다.
			
			if(interval >= days) {
				if(file.isFile()) {
					deleteTo(null, file.getName());
					
					if(log.isDebugEnabled()) log.debug("delete template file(name=" + tempPath + file.getName() + ", last modify=" + lastDay + ")");
				}
				
				ret++;
			}
		}
		
		return ret;
	}
	
	
	public static boolean deleteTo(String filename) throws Exception {
		return deleteTo(null, filename);
	}
	
	
	public static String getLastModify(File file, String type) throws Exception {
		Calendar cc = new GregorianCalendar();
        cc.setTimeInMillis(file.lastModified());
        
        String year = Integer.toString(cc.get(Calendar.YEAR));
        String month = ((cc.get(Calendar.MONTH)+1)<10) ? "0"+Integer.toString((cc.get(Calendar.MONTH)+1)) : Integer.toString((cc.get(Calendar.MONTH)+1));
        String day = (cc.get(Calendar.DAY_OF_MONTH)<10) ? "0"+Integer.toString(cc.get(Calendar.DAY_OF_MONTH)) : Integer.toString(cc.get(Calendar.DAY_OF_MONTH)); 
        String hour = (cc.get(Calendar.HOUR_OF_DAY)<10) ? "0"+Integer.toString(cc.get(Calendar.HOUR_OF_DAY)) : Integer.toString(cc.get(Calendar.HOUR_OF_DAY));
        String minute = (cc.get(Calendar.MINUTE)<10) ? "0"+Integer.toString(cc.get(Calendar.MINUTE)) : Integer.toString(cc.get(Calendar.MINUTE)); 
        String second = (cc.get(Calendar.SECOND)<10) ? "0"+Integer.toString(cc.get(Calendar.SECOND)) : Integer.toString(cc.get(Calendar.SECOND)); 
        
        if("Y".equals(type)) return year;
        else if("M".equals(type)) return year + month;
        else if("D".equals(type)) return year + month + day;
        else if("H".equals(type)) return year + month + day + hour;
        else if("MI".equals(type)) return year + month + day + hour + minute;
        else if("S".equals(type)) return year + month + day + hour + minute + second;
        else return year + month + day;
	}
	
	
	public static byte[] getBytesFromFile(File file) throws Exception {
		InputStream is = null;
		byte[] bytes = null;
		
		try{
			is = new FileInputStream(file);
	
			long length = file.length();
			bytes = new byte[(int) length];
	
			int offset = 0;
			int numRead = 0;
			while (offset < bytes.length && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
				offset += numRead;
			}
	
			if (offset < bytes.length) {
				throw new IOException("Could not completely read file" + file.getName());
			}
			is.close();
		}catch(Exception e){
			throw e;
		}finally{
			if(is != null) is.close();
		}
		return bytes;
	}
	
	
	public static String getFullPath() throws Exception {
		return getFullPath(null);
	}
	
	
	public static String getFullPath(String propName) throws Exception {
		return ApplicationConstants.APPLICATION_REAL_PATH + getWorkPath(propName);
	}
	
	
	public static String getWorkPath(String propName) throws Exception {
		String path = null;
		
		try {
			PropertiesConfigurator configurator = PropertiesConfiguratorFactory.getInstance().getConfiguratorByName("appFileAndJasper");
			
			if(!StringUtil.isNull(propName)) {
				path = configurator.getString(propName);
			} else {
				path = configurator.getString("file.upload.temp.dir");
			}
			
			if (log.isInfoEnabled()) log.info("work directory path = " + path);
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(propName + "'s file not found in the [.properties]");
	    }
		
		return path;
	}
	
	
	public static  List<File> getDirFileList(String dirPath) {
		// 디렉토리 파일 리스트
		List<File> dirFileList = null;
		// 파일 목록을 요청한 디렉토리를 가지고 파일 객체를 생성함
		File dir = new File(dirPath);
		// 디렉토리가 존재한다면
		if (dir.exists()) {
			// 파일 목록을 구함
			File[] files = dir.listFiles();
			// 파일 배열을 파일 리스트로 변화함
			dirFileList = Arrays.asList(files);
		}
		return dirFileList;
	}
	
	
 	public static File[] getDirFileList(String dirPath, String extension) {
 		final String rExtension = extension;
 		
 		// 파일 목록을 요청한 디렉토리를 가지고 파일 객체를 생성함
 		File dir = new File(dirPath);
 		
 		File[] files = null;

 		if (dir.exists()) {
 			FilenameFilter ff = new FilenameFilter(){
				public boolean accept(File dir, String name) {
					
					return name.toLowerCase().endsWith(rExtension);
				}
 			};
 			files = dir.listFiles(ff);
 		}

 		return files;
 	}
 	
 	public static void fileMove(String inFileName, String outFileName) {
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);

			int data = 0;
			while ((data = fis.read()) != -1) {
				fos.write(data);
			}
			fis.close();
			fos.close();
			// 복사한뒤 원본파일을 삭제함
			fileDelete(inFileName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
 	
	public static void fileDelete(String deleteFileName) {
		File I = new File(deleteFileName);
		I.delete();
	}
	
    
    
    
    public static boolean fileMove(String path, String fileName, String newPath) throws Exception{
    	boolean rst = true;
    	File file = new File(path + "/" + fileName);
    	
    	if(file.isFile()){
    		File dir = new File(newPath);
    		
    		if(!dir.isDirectory()) {
  			  dir.mkdirs();
  			}
    		
	    	rst = file.renameTo(new File(newPath + "/" + fileName));
	    	file.delete();
    	} else {
    		rst = false;
    	}
    	
    	return rst;
    }
    
    
    public static String fileMove(String path, String fileName, String newPath, String newFileName) throws Exception{
    	boolean rst = true;
    	String newFileFullName = "";
    	File file = new File(path + "/" + fileName);
    	
    	if(file.isFile()){
    		File dir = new File(newPath);
    		
    		if(!dir.isDirectory()) {
  			  dir.mkdirs();
  			}
    		
    		String orgFileName = newFileName.substring(0, newFileName.lastIndexOf("."));
    		String orgExtension = newFileName.substring(newFileName.lastIndexOf("."));
    		
    		
    		Integer dupCount = 0;
    		String dupName;

    		while (true) {
    			dupName = (dupCount++ == 0) ? "" : "(" + dupCount.toString() + ")";
    			newFileFullName = orgFileName + dupName + orgExtension;
    			String newFileFullPath = newPath + newFileFullName;
    			
    			File newFile = new File(newFileFullPath);
    			
    			if (!newFile.exists()) {
    				break;
    			}
    		}
    		
    		rst = file.renameTo(new File(newPath + "/" + newFileFullName));
	    	file.delete();
    	} else {
    		rst = false;
    	}
    	
    	if(!rst) newFileFullName = "Fialed";  
    	
    	return newFileFullName;
    }
    
	
    
    
    public static File getFile(String fpath, String fname) throws Exception {
    	String tpath = null;
    	
    	if(fpath == null) {
    		tpath = FileUtil.getFullPath(fpath);
    	} else {
	    	File file = new File(fpath);
			
	    	if(file.exists()) {
				tpath = fpath;
			} else {
				makeDirectrory(fpath);
				tpath = FileUtil.getFullPath(fpath);
			}
    	}
    	
		return new File(tpath + File.separator + fname);
    }
    
    public static String transferToImage(String fileSavePath, byte[] encodeBytes, String FileFullName) throws Exception {
    	if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "FileUtils.transferTo start");
    	
    	File file = new File(FileFullName);
		
    	if (!file.exists()) {
    		if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "FileUtils.transferTo file is null");
    		return null;
    	}

    	String filePath  = fileSavePath;// + fileFullName;
		String newFileFullPath;
		String newFileFullName;
		File newFile;
		
		String orgFileName = FileFullName.substring(0, FileFullName.lastIndexOf("."));
		String orgExtension = FileFullName.substring(FileFullName.lastIndexOf("."));
		
		Integer dupCount = 0;
		String dupName;

		while (true) {
			dupName = (dupCount++ == 0) ? "" : "(" + dupCount.toString() + ")";
			newFileFullName = orgFileName + dupName + orgExtension;
			newFileFullPath = filePath + newFileFullName;
			newFile = new File(newFileFullPath);
			if (!newFile.exists()) {
				break;
			}
		}

		//저장할 폴더가 있는지 확인
		//여기서 filePath는 디렉토리임
		File dir = new File(filePath);
		
		//directory 없을경우
		//맹그러
		if(!dir.exists()){
			if(!dir.mkdirs()){
				throw new Exception("Failed Make Dir ==> " + dir.getName());
			}
		}

		//디렉토리가 준비되면
		//경로+파일명으로
		//file 개체생성
		//생성해놓고 newFileFullPath 잡는 이유는
		//저장 경로가  c:\abc\..\abk\122.bmp 이렇게 되어있어도 유효한 주소지만
		//보기 않좋으니까
		//new File을 할 때는 위 주소가 먹힘
		//getAbsolutePath() 하면
		//   c:\abk\122.bmp 라
	
		
		File uploadFile = new File(newFileFullPath);
		newFileFullPath = uploadFile.getAbsolutePath();
		
		DataOutputStream dis;
		
		FileOutputStream fout = new FileOutputStream(newFileFullPath); 
		dis = new DataOutputStream(fout); 
		dis.write(encodeBytes);
		dis.flush();
		dis.close();
		fout.close();
		
		if(log.isDebugEnabled()) log.debug(StringUtils.repeat("#", 10) + "FileUtils.transferTo end");
    	
		return newFileFullName;
	}
    
      
    public static Map getFile(String propName, MultipartFile file) throws Exception {
    	Map map = new HashMap();
        String filePath = getFullPath(propName);
        String workPath = getWorkPath(propName);
        String orgFileName = file.getOriginalFilename();
        String orgExtension = orgFileName.substring(orgFileName.lastIndexOf(".")); // 확장자
        orgFileName = orgFileName.substring(0, orgFileName.lastIndexOf("."));
 
        map.put("ORIGIN_FILE_NAME", orgFileName+orgExtension);
        map.put("ORIGIN_FILE_PATH", workPath);
        map.put("ORIGINAL_FILE_EXTENSION", orgExtension);
        map.put("SAVED_FILE_NAME", orgFileName+orgExtension);
        map.put("FILE_SIZE", Integer.toString((int)file.getSize()));
        
        return map;
    }
    
    public static File multipart2File(MultipartFile mFile) throws IllegalStateException, IOException {
    	
    	File convFile = new File(tmpFilePath ,mFile.getOriginalFilename());
    	String fullFilePath = tmpFilePath + File.separator + mFile.getOriginalFilename();
    	Path path = Paths.get(tmpFilePath).toAbsolutePath();
    	
    	
    	mFile.transferTo(path.toFile());
        return convFile;
    }
    
    public static File convertFile(MultipartFile mFile) throws IllegalStateException, IOException {
    	
    	
    	File convFile = new File(mFile.getOriginalFilename());
        convFile.createNewFile(); 
        FileOutputStream fos = new FileOutputStream(convFile); 
        fos.write(mFile.getBytes());
        fos.flush();
        fos.close(); 
        return convFile;
    }
    
    
    
    public static void writeBytesToFileClassic(byte[] bFile, String fileDest) {

        FileOutputStream fileOuputStream = null;

        try {
            fileOuputStream = new FileOutputStream(fileDest);
            fileOuputStream.write(bFile);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileOuputStream != null) {
                try {
                    fileOuputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }
    
    
    /**
     * 바이너리 바이트 배열을 스트링으로 변환
     * 
     * @param b
     * @return
     */
    public static String byteArrayToBinaryString(byte[] b) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < b.length; ++i) {
            sb.append(byteToBinaryString(b[i]));
        }
        return sb.toString();
    }
 
    /**
     * 바이너리 바이트를 스트링으로 변환
     * 
     * @param n
     * @return
     */
    public static String byteToBinaryString(byte n) {
        StringBuilder sb = new StringBuilder("00000000");
        for (int bit = 0; bit < 8; bit++) {
            if (((n >> bit) & 1) > 0) {
                sb.setCharAt(7 - bit, '1');
            }
        }
        return sb.toString();
    }
 
    /**
     * 바이너리 스트링을 바이트배열로 변환
     * 
     * @param s
     * @return
     */
    public static byte[] binaryStringToByteArray(String s) {
        int count = s.length() / 8;
        byte[] b = new byte[count];
        for (int i = 1; i < count; ++i) {
            String t = s.substring((i - 1) * 8, i * 8);
            b[i - 1] = binaryStringToByte(t);
        }
        return b;
    }
 
    /**
     * 바이너리 스트링을 바이트로 변환
     * 
     * @param s
     * @return
     */
    public static byte binaryStringToByte(String s) {
        byte ret = 0, total = 0;
        for (int i = 0; i < 8; ++i) {
            ret = (s.charAt(7 - i) == '1') ? (byte) (1 << i) : 0;
            total = (byte) (ret | total);
        }
        return total;
    }
    
    /**
     * byte[] 를 java.lang.Byte[] 로 변환하여 리턴
     * @param bytes
     * @return
     */
    public static Byte[] convert_byteArray2ByteArray(byte[] bytes) {
    	Byte[] byteObjects = new Byte[bytes.length];
    	int i=0;    
		/** byte[] to Byte[] */
		for(byte b: bytes) {
			byteObjects[i++] = b;
		}
    	
    	
    	return byteObjects;
    }
    
    /**
     * java.lang.Byte[] 를  byte[]로 변환하여 리턴
     * @param bytes
     * @return
     */
    public static byte[] convert_ByteArray2byteArray(Byte[] p_Bytes) {
    	
    	byte[] byteArray = new byte[p_Bytes.length];
    	
    	int i=0;
    	// Unboxing Byte values. (Byte[] to byte[])
    	for(Byte b: p_Bytes) {
    		byteArray[i++] = b.byteValue();
    	}
    	
    	
    	return byteArray;
    }

    /**
     * 파일을 byte[] 로 리턴합니다. 
     * @param filePath
     * @return
     */
    private static byte[] readBytesFromFile(String filePath) {

		FileInputStream fileInputStream = null;
		byte[] bytesArray = null;

		try {

			File file = new File(filePath);
			bytesArray = new byte[(int) file.length()];

			// read file into bytes[]
			fileInputStream = new FileInputStream(file);
			fileInputStream.read(bytesArray);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fileInputStream != null) {
				try {
					fileInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

		return bytesArray;

	}

}