package com.kpmg.kdb.web.ts.board.boardMgnt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;




@Service
@SuppressWarnings({ "rawtypes" })
public class BoardMgntService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(BoardMgntService.class);
    
    /**
     *  게시판 > 게시판 > 게시판 리스트 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveBoardMgntList(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    		
    		result.setValue(sqlSession.getMapper(BoardMgntDao.class).retrieveBoardMgntList(param));
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 게시판 > 게시판 > 게시판 상세 데이터 조회
     * @param param
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveBoardMgntDetail(Map<String, Object> param){
    	
    	Result result = new Result();
    	try {
    	   Map<String, Object> boardInfo =  sqlSession.getMapper(BoardMgntDao.class).retrieveBoardMgntDetail(param);
    	   List fileList = sqlSession.getMapper(BoardMgntDao.class).retrieveBoardMgntFileList(param);
    	    		
    	   Map<String, Object> returnMap = new HashMap<String,Object>();
    	   returnMap.put("boardInfo", boardInfo); 		
    	   returnMap.put("fileList", fileList);
    	    		
    	    result.setValue(returnMap);
    		result.setSuccess(true);
    		result.setMessage(DEFAULT_MESSAGE_OK);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
    	}
    	
    	return result;
    }
    
    /**
     * 게시판 > 게시판 > 게시판 상세 저장
     * @param param
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveBoardMgntDetail(Map<String, Object> param, MultipartFile[] files, List<Map<String, Object>> deleteFileList) throws Exception {
    	Result result = new Result();
    	
    	Long returnBoardNo = 0L;
    	
    	//1. BOARD 데이터 저장
    	if("I".equals(param.get("inputType"))) {  //신규 또는 답글 등록
    		returnBoardNo = sqlSession.getMapper(BoardMgntDao.class).retrieveNextBoardNo(param);
    		param.put("boardNo", returnBoardNo);
    		sqlSession.getMapper(BoardMgntDao.class).insertBoardMgntDetail(param);
    		
    	}else if("U".equals(param.get("inputType"))) {
    		Object boardNo = param.get("boardNo");

    	    if (boardNo != null) {
    	    	returnBoardNo = ((Number) boardNo).longValue();
    	    }
    			
    		sqlSession.getMapper(BoardMgntDao.class).updateBoardMgntDetail(param); 
    	}
    		
    	// 2. 기존 첨부파일 삭제
        if (deleteFileList != null && !deleteFileList.isEmpty()) {

        	for (Map<String, Object> deleteFileMap : deleteFileList) {

        		Map<String, Object> fileParam = new HashMap<String, Object>();

                fileParam.put("companyCode",   deleteFileMap.get("company_code"));
                fileParam.put("boardNo", deleteFileMap.get("board_no"));
                fileParam.put("fileSeq", deleteFileMap.get("file_seq"));
                   

                sqlSession.getMapper(BoardMgntDao.class).deleteBoardFile(fileParam);
            }
        }


        // 3. 신규 첨부파일 저장
        if (files != null && files.length > 0) {

        	for (MultipartFile file : files) {

        		if (file == null || file.isEmpty()) {
                	continue;
                }

                Map<String, Object> fileParam = new HashMap<String, Object>();

                fileParam.put("companyCode", param.get("company_code"));
                fileParam.put("boardNo", returnBoardNo);
                fileParam.put("originFileName", file.getOriginalFilename());
                fileParam.put("fileSize", file.getSize());
                fileParam.put("contentType", file.getContentType());
                fileParam.put("fileData", file.getBytes());

                fileParam.put("createBy", param.get("update_by"));

                sqlSession.getMapper(BoardMgntDao.class).insertBoardFile(fileParam);
            }
        }
    		
    		
        result.setValue(returnBoardNo);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        
    	return result;
    }
    
    /**
     * 게시판 > 게시판 > 게시판 상세 데이터 > 파일다운로드를 위한 파일조회
     * @param param
     * @return
     */
    public Map<String, Object> retrieveBoardFile( Map<String, Object> param) {

        return sqlSession .getMapper(BoardMgntDao.class).retrieveBoardFile(param);
    }
    
    
    
}