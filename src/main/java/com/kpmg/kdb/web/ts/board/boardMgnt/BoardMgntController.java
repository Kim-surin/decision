package com.kpmg.kdb.web.ts.board.boardMgnt;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/*******************************************************************************************
 *
 * BoardController.class
 *
 * @since 2026.07
 *
 *         게시판 > 게시판
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class BoardMgntController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(BoardMgntController.class);
	

	@Autowired
	protected BoardMgntService boardMgntService;

	/**
	 * 게시판 > 게시판
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/board/boardMgnt")
	public String boardMgnt_view(Model model, HttpSession session) {
		return "board/boardMgnt";
	}
	
	
	/**
	 *  게시판 > 게시판 > 리스트 조회
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/board/boardMgnt/retrieveBoardMgntList")
	@ResponseBody
	public Result retrieveBoardMgntList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = boardMgntService.retrieveBoardMgntList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 * 게시판 > 게시판 > 게시판 상세
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/board/boardMgnt/boardMgntDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardMgntDetail_view(Model model,HttpSession session, HttpServletRequest request, @RequestParam(required = false) Map<String, String> params) {
		model.addAttribute("params", params);
		return "board/boardMgntDetail";
	}
	
	/**
	 *  게시판 > 게시판 > 리스트 상세조회 
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/board/boardMgnt/retrieveBoardMgntDetail")
	@ResponseBody
	public Result retrieveBoardMgntDetail(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = boardMgntService.retrieveBoardMgntDetail(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  게시판 > 게시판 > 리스트 상세조회 저장
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/board/boardMgnt/saveBoardMgntDetail", method = RequestMethod.POST)
	@ResponseBody
	public Result saveBoardMgntDetail(@RequestPart("boardData") Map param, 
			@RequestPart(value = "files", required = false) MultipartFile[] files, 
			@RequestPart(value = "deletedFiles", required = false) List<Map<String, Object>> deletedFileList) {
		Result result = new Result();
		try {
		    result = boardMgntService.saveBoardMgntDetail(super.extendsMap(param),files,deletedFileList);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  게시판 > 게시판 > 리스트 상세조회 > 파일다운로드
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/board/boardMgnt/downloadBoardFile")
	public void downloadBoardFile(@RequestParam Map<String, Object> param, HttpServletResponse response) {

	    try {

	        Map<String, Object> fileInfo = boardMgntService.retrieveBoardFile( super.extendsMap(param));

	        if (fileInfo == null) {
	            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            return;
	        }

	        byte[] fileData = (byte[]) fileInfo.get("file_data");
	        String originFileName = String.valueOf(fileInfo.get("origin_file_name") );
	        String contentType = String.valueOf(fileInfo.get("content_type"));

	        if (contentType == null || "null".equals(contentType) ||  contentType.isEmpty()) {
	        	contentType = "application/octet-stream";
	        }

	        response.setContentType(contentType);
	        response.setContentLengthLong(fileData.length);

	        String encodedFileName =   URLEncoder.encode(originFileName, StandardCharsets.UTF_8.name()).replace("+", "%20");

	        response.setHeader( "Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

	        response.getOutputStream().write(fileData);
	        response.getOutputStream().flush();

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	}

	
}