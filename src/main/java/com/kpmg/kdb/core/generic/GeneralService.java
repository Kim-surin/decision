package com.kpmg.kdb.core.generic;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.util.StringUtil;

/**
 * 서비스의 상위 클래스. 일반적이거나 공통적이 변수, 함수
 */
@Service
public class GeneralService {
    protected final String PARAM_ROW_FLAG_INSERT = "+";
    protected final String PARAM_ROW_FLAG_UPDATE = "*";
    protected final String PARAM_ROW_FLAG_DELETE = "-";

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    public static final String DEFAULT_MESSAGE_OK = "정상적으로 처리하였습니다.";
    
    public static final String DEFAULT_MESSAGE_ERROR = "처리중 오류가 발생하였습니다!";

    @Autowired
    @Qualifier("sqlSessionTemplate")
    protected SqlSession sqlSession;
    
    @Autowired
    @Qualifier("batchSqlSessionTemplate")
    protected SqlSession sqlBatchSession;

    @Autowired
    private MessageSource messageSource;


    /**
     * 기본생성자
     */
    public GeneralService() {
    }

    /**
     * SQL세션객체 반환
     * @return  SQL세션객체
     */
    public SqlSession getSqlSession() {
        return this.sqlSession;
    }
    

    
    

    public SqlSession getSqlBatchSession() {
		return this.sqlBatchSession;
	}



	/**
     * 메시지 문자열을 완성하여 반환
     * @param   messageId 메시지ID
     * @param   args      메시지 문자열 생성시 필요한 매개변수배열
     * @return  메시지 문자열
     */
    protected String getMessage(String messageId,  Object[] args) {
        return messageSource.getMessage(messageId, args, Locale.getDefault());
    }

    /**
     * 결과객체를 완성하여 반환
     * @param   isSuccess 성공여부
     * @param   messageId 메시지ID
     * @param   args      메시지 문자열 생성시 필요한 매개변수배열
     * @return  결과객체
     */
    protected Result getResult(boolean isSuccess, String messageId,  Object[] args) {
        Result result = new Result();

        String mesg = this.getMessage(messageId, args);
        if ( StringUtils.isBlank(mesg) ) {
            mesg = isSuccess ? DEFAULT_MESSAGE_OK : DEFAULT_MESSAGE_ERROR; //default message!
        }

        result.setSuccess(isSuccess);
        result.setMessage(mesg);
        return result;
    }

    /**
     * 오류결과객체를 완성하여 반환
     * @param   errorMessage    오류메시지
     * @param   value   참조 갑객체
     * @param   t       던져진 오류
     * @return  오류결과객체
     */
    protected Result getErrorResult(String errorMessage, Object value, Throwable t) {
        Result errorResult = new Result();

        StringBuffer s = new StringBuffer();

        s.append("+-----------------------------------------------------------------------+\n");
        s.append("+ 다음은 오류관련 정보!\n");
        s.append("+-----------------------------------------------------------------------+\n");
        s.append("+ 오류　메시지 : ").append(errorMessage).append("\n");
        s.append("+ 오류관련정보 : ").append(value).append("\n");
        if (null!=t)
            s.append("+ 던져진메시지 : ").append(t.getMessage()).append("\n");
        s.append("+-----------------------------------------------------------------------+\n");

        errorResult.setMessage(errorMessage);
        errorResult.setSuccess(false);
        errorResult.setValue(value);

        logger.error("[오류결과정보] 오류정보\n{}", s);

        return errorResult;
    }


    /**
     * 업로드된 파일을 실제 디스크에 저장후 결과 파일 객체를 반환
     * 
     * @param     multipartFile    업로드된 파일 정보 객체
     * @param     workType        업무구분(10byte이하)
     * @return    저장된 파일 객체
     */
    protected File saveUploadFile(MultipartFile multipartFile, String workType) {
        if (null==multipartFile) {
            return null;
        }

        File savedFile = null;

        String originalFilename = multipartFile.getOriginalFilename();
        String saveFilename = originalFilename.replaceAll("[ ]", "");
        long fileSize = multipartFile.getSize();

        if (fileSize<1 || StringUtils.isBlank(originalFilename)) {
            return null;
        }

        String y = new SimpleDateFormat("yyyy").format(new Date());
        String ym = new SimpleDateFormat("yyyyMM").format(new Date());
        String ymd = new SimpleDateFormat("yyyyMMdd").format(new Date());
        StringBuffer uploadSubDir = new StringBuffer();
        uploadSubDir.append(workType).append(File.separator);
        uploadSubDir.append(y).append(File.separator);
        uploadSubDir.append(ym).append(File.separator);
        uploadSubDir.append(ymd).append(File.separator);

        File saveDir = new File(SystemConstant.upload.UPLOAD_BASE_DIR, uploadSubDir.toString());
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }

        savedFile = new File(saveDir, saveFilename);

        try {
            if (savedFile.exists()) {
                String fnm = saveFilename.substring(0, saveFilename.lastIndexOf("."));
                String ext = saveFilename.substring(saveFilename.lastIndexOf("."));

                //originalFilename = originalFilename + "" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                saveFilename = fnm + new SimpleDateFormat("_HHmmss").format(new Date()) + ext;
                savedFile = new File(saveDir, saveFilename);
            }

            OutputStream outputStream = new FileOutputStream(savedFile);
            FileCopyUtils.copy( multipartFile.getInputStream(), outputStream );
            outputStream.close();
        }
        catch (FileNotFoundException e) {
            savedFile = null;
            
        }
        catch (IOException e) {
            savedFile = null;
            
        }
        return savedFile;
    }
    
    protected GridOutputData gridProcessCommon(List<Map<String, Object>> p_list, Map<String, Object> p_map) {
    	
    	String pageParam = StringUtil.null2String(p_map.get("page"), "1");
		String rowsParam = StringUtil.null2String(p_map.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
		int page = Integer.parseInt(pageParam);
		int rows = Integer.parseInt(rowsParam);
		int total = 0;
		int listSize = null==p_list ? 0 : p_list.size();
		if(p_list != null && p_list.size() > 0 ){
			total = Integer.parseInt(p_list.get(0).get("TOTAL_RECORDS").toString());
		}
		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
		
		return new GridOutputData(p_list, page, rows, total);
    }
    
    /* EAI 통신시 List만 가져오는경우 사용되는 Method*/
    protected GridOutputData gridProcessEAICommon(List<Object> list, LinkedHashMap<String, Object> eaiResultMap, Map<String, Object> p_map) {
    	
    	String sPage = "".equalsIgnoreCase(stringValueOf(eaiResultMap.get("PAGE"))) ? stringValueOf(p_map.get("page")) : stringValueOf(eaiResultMap.get("PAGE"));
    	String sRows = "".equalsIgnoreCase(stringValueOf(eaiResultMap.get("PAGE"))) ? stringValueOf(p_map.get("rows")) : stringValueOf(eaiResultMap.get("ROWS"));
    	
 		int page = Integer.parseInt(sPage);
		int rows = Integer.parseInt(sRows);
		
		int total = StringUtil.null2zero(StringUtil.null2String(eaiResultMap.get("RECORDS"),"0"));
		if(total == 0) {
			total = list.size();	
		}
		
		logger.debug("<조회결과> total interface Count  = " + total);
		
		return new GridOutputData(list, page, rows, total);
    }
    
    
    /* EAI 통신시 해더정보를 같이 가져오는경우 사용되는 Method*/
    protected GridOutputData gridProcessEAICommon(List<Object> list, LinkedHashMap<String, Object> header,  LinkedHashMap<String, Object> eaiResultMap, Map<String, Object> p_map) {
    	
    	String sPage = "".equalsIgnoreCase(stringValueOf(eaiResultMap.get("PAGE"))) ? stringValueOf(p_map.get("page")) : stringValueOf(eaiResultMap.get("PAGE"));
    	String sRows = "".equalsIgnoreCase(stringValueOf(eaiResultMap.get("PAGE"))) ? stringValueOf(p_map.get("rows")) : stringValueOf(eaiResultMap.get("ROWS"));
    	
 		int page = Integer.parseInt(sPage);
		int rows = Integer.parseInt(sRows);
		int total = StringUtil.null2zero(eaiResultMap.get("RECORDS"));
		if(total == 0) {
			total = list.size();	
		}
		logger.debug("<조회결과> total interface Count  = " + total);
		
		return new GridOutputData(list, header, page, rows, total);
    }
	
    /**
     * EAI를 통해 전달받은 Holder Class를 List Collection 으로 변환
     * @author D.Cat
     * @param o
     * @return
     * @throws JsonParseException
     * @throws JsonMappingException
     * @throws JsonProcessingException
     * @throws IOException
     */
    protected List<Object> convertEai2List(Object o) throws JsonParseException, JsonMappingException, JsonProcessingException, IOException{
    
    	ObjectMapper mapper = new ObjectMapper();
    	mapper.setPropertyNamingStrategy(new JacksonUpperCaseStrategy());
    	List<Object> returnList = mapper.readValue(mapper.writeValueAsString(o), new TypeReference<List<Object>>(){});
    	
    	if(returnList == null) {
    		returnList = new ArrayList<Object>();
    		returnList.add(new LinkedHashMap<String, Object>());
    	}
    	return returnList;
    }
    /**
     * EAI를 통해 전달받은 Holder Class를 LinkedHashMap Collection으로 변환
     * @author D.Cat
     * @param o
     * @return
     * @throws JsonParseException
     * @throws JsonMappingException
     * @throws JsonProcessingException
     * @throws IOException
     */
    protected LinkedHashMap<String, Object> convertEai2Map(Object o) throws JsonParseException, JsonMappingException, JsonProcessingException, IOException{
        
    	if(o == null) {
    		return null;	
    	}else {
    		ObjectMapper mapper = new ObjectMapper();
        	mapper.setPropertyNamingStrategy(new JacksonUpperCaseStrategy());
        	
        	return mapper.readValue(mapper.writeValueAsString(o), new TypeReference<LinkedHashMap<String, Object>>(){});
    	}
    	
   	 
   }
   
	protected boolean isEAISuccess(LinkedHashMap<String, Object> o) {

		boolean rtn = false;
		
		if(o != null) {
			if("E".equalsIgnoreCase(this.stringValueOf(o.get("EAI"))) && "NO DATA".equalsIgnoreCase(this.stringValueOf(o.get("MESSAGE"))) ) {
				rtn = false;
			}else {
				rtn = true;
			}
		}else {
			rtn = true;
		}
	    return rtn;
	   	 
   }
     
    
    protected String stringValueOf(Object object) {
	   return object == null ? "" : String.valueOf(object).trim();
   }

    
    /**
     * @Desc
     * targetList을 대상으로 groupByColumnList에 포함된 컬럼들에 대해서 Group by count를 수행한다.
     * 리턴되는 KeyValue는 groupByColumnList의 각 값들이 되며 Value는 Count가 된다.
     * 
     * @author D.Cat
     * @param targetList
     * @param groupByColumnList
     * @return
     */
    protected Map<String, Long> listGroupBy_Count(List<Map> targetList, List<String> groupByColumnList) {

		List<String> items = new ArrayList<String>();
		for(int inx = 0; inx < targetList.size() ; inx++) {
			for(int jnx = 0; jnx < groupByColumnList.size(); jnx++) {
				items.add(String.valueOf((targetList.get(inx)).get(groupByColumnList.get(jnx)))) ;	
			}
		}
		Map<String, Long> result = items.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
        return result;
    }
    
    /**
     * row.company_code 없으면 param.company_code 넣음
       row.user_id 없으면 param.user_id 넣음
       이미 값 있으면 유지
     * @param row
     * @param param
     * @param keys
     * 
     * 예시
     * super.putCommonFieldsIfAbsent(row, param, "company_code", "user_id");
     * 
     */
    protected void putCommonFieldsIfAbsent(Map<String, Object> row, Map<String, Object> param, String... keys) {
        if (row == null || param == null || keys == null) {
            return;
        }

        for (String key : keys) {
            Object rowValue = row.get(key);
            Object paramValue = param.get(key);

            if ((!row.containsKey(key) || rowValue == null || "".equals(String.valueOf(rowValue).trim()))
                    && paramValue != null) {
                row.put(key, paramValue);
            }
        }
    }
}