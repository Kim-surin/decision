package com.kpmg.kdb.web.drawback;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpmg.kdb.core.code.PropertiesConfigurator;
import com.kpmg.kdb.core.code.PropertiesConfiguratorFactory;
import com.kpmg.kdb.core.code.SystemConstant;
import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.HttpUtils;
import com.kpmg.kdb.util.StringUtil;
import com.kpmg.kdb.web.drawbackdoc.DrawbackDocDao;
import com.kpmg.kdb.web.refundbasis.RefundBasisDao;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class DrawbackService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(DrawbackService.class);

    /**
     * 환급모니터링 tab1 List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectTab1List(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(DrawbackDao.class).selectTab1List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
        	String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
        	int page = Integer.parseInt(pageParam);
        	int rows = Integer.parseInt(rowsParam);
        	int total = 0;
        	int listSize = null==list ? 0 : list.size();
        	
        	if(list != null && list.size() > 0 ){
        		total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
        	}
        	logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
        	
        	gridData = new GridOutputData(list, page, rows, total);
		} catch (RuntimeException e) {
			//e.printStackTrace();
		}
    	
    	return gridData;
    }
        
    /**
     * 관세청관리 - 환급 - 환급/기납증 발급
     * 
     * @author 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieveDrawbackCtrmList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieveDrawbackCtrmList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
    
    /**
     * 환급모니터링 bom List Data 
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> selectTab1BomList(Map<String, Object> param) throws Exception {
    	
		GridOutputData gridData = null;
    	try {
    		List<Map> list = sqlSession.getMapper(DrawbackDao.class).selectTab1BomList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
        	String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
        	int page = Integer.parseInt(pageParam);
        	int rows = Integer.parseInt(rowsParam);
        	int total = 0;
        	int listSize = null==list ? 0 : list.size();
        	
        	if(list != null && list.size() > 0 ){
        		total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
        	}
        	logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
        	
        	gridData = new GridOutputData(list, page, rows, total);
		} catch (RuntimeException e) {
			//e.printStackTrace();
		}
    	
    	return gridData;
    }
	
	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB005List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB005List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
	 * 환급신청서(갑)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_DB00501_header(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00501_header(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	
	/**
	 * 환급신청서 수출물품 (을)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00501_trget(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00501_trget(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 환급신청서 수입원재료 (병)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00501_rawmtrl(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00501_rawmtrl(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
	 * 환급신청서 수입원재료 (병) - 제한규정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00501_RestrictRawmtrl(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00501_RestrictRawmtrl(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
     * 환급신청서 수출 품목 삭제
     * @param paramList
     * @return
     * @throws Exception
     */
	@Transactional
    public Result cancel_DB00501_ConfirmProcess(Map param, List paramList){
        /*
         *  common.msg.en.saveok = 저장되었습니다.
            common.msg.en.savefail = 데이터를 저장할 수 없습니다.
         */
        Result rs = new Result();
        try {
            
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"), "N");
            
            int returnDataSuccess = 0;
            for(int inx = 0; inx < paramList.size(); inx++) {   // 을 Loop
                Map rowMap = (Map)paramList.get(inx);
                rowMap.put("COMPANY_CODE", StringUtil.null2String(param.get("COMPANY_CODE")));
                
                List<Map<String, Object>> rawmtrlItem = sqlSession.getMapper(DrawbackDao.class).retrieve_DrawBackRawmtrlList(rowMap);
                
                for(int jnx = 0; jnx < rawmtrlItem.size(); jnx++) {   // 병 Loop
                    Map rawmtrlMap = (Map)rawmtrlItem.get(jnx);
                    //환급신청서 사용잔량 반환
                    returnDataSuccess = sqlSession.getMapper(DrawbackDao.class).return_DrawBackRawmtrl(rawmtrlMap);
                    
                    if(returnDataSuccess == 0) {
                        rs = super.getResult(false, "잔량데이터에 오류가 있습니다. (반환받을 데이터가 없습니다.)", new Object[] {});
                        throw new RuntimeException();
                    }
                    
                    if("Y".equalsIgnoreCase(logEnable_Flag)) {
                        logger.debug("##### [drwbak.rawmtrl.return.log] 잔량 사용 로그 이력 저장 시작.");
                        // 잔량 사용이력 저장
                        Map<String, Object> historyMap = new HashMap<>();
                        
                        historyMap.put("COMPANY_CODE"  ,StringUtil.null2String(rawmtrlMap.get("COMPANY_CODE")));
                        historyMap.put("DIVISION_CODE" ,StringUtil.null2String(rawmtrlMap.get("DIVISION_CODE")));
                        historyMap.put("IMPDEC_NO"     ,StringUtil.null2String(rawmtrlMap.get("IMPDEC_NO")));
                        historyMap.put("LNE_NO"        ,StringUtil.null2String(rawmtrlMap.get("LNE_NO")));
                        historyMap.put("POUCH_NO"      ,StringUtil.null2String(rawmtrlMap.get("POUCH_NO")));
                        historyMap.put("ITEM_CODE"     ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_CODE")));
                        historyMap.put("USGQTY"        ,StringUtil.null2zero(rawmtrlMap.get("USGQTY")) * -1); // 반환이므로 음수처리
                        //잔량사용이력 저장 - USE_TYPE :: 사용형태(01:환급신청서, 02 기납증, 03 분증)
                        historyMap.put("USE_TYPE"      ,"01");
                        historyMap.put("PRESENTN_NO"   ,StringUtil.null2String(rawmtrlMap.get("PRESENTN_NO")));
                        historyMap.put("THNG_SEQ"      ,StringUtil.null2String(rawmtrlMap.get("THNG_SEQ")));
                        historyMap.put("RAWMTRL_SEQ"   ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_SEQ")));
                        historyMap.put("CREATE_BY"     ,StringUtil.null2String(param.get("CREATE_BY")));
                        
                        sqlSession.getMapper(DrawbackDao.class).createIncme_LocalBnt_History(historyMap);
                    }else {
                        logger.debug("##### [drwbak.rawmtrl.return.log] 잔량 사용 로그 이력 사용 안함.");
                    }
                }
                
                sqlSession.getMapper(DrawbackDao.class).delete_DrawBackRawmtrl(rowMap);
                
                Map<String, Object> cancelXportMap = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00501_cancelXport_List(rowMap);
                
                /* 을지 삭제전 수출데이터 환급 가능수량 복원*/
                sqlSession.getMapper(DrawbackDao.class).update_CancelXportItemQty(cancelXportMap);
                sqlSession.getMapper(DrawbackDao.class).delete_DrawBackTrgetThng(rowMap);
                param.put("DIVISION_CODE", rowMap.get("DIVISION_CODE"));
                param.put("PRESENTN_NO", rowMap.get("PRESENTN_NO"));
            }
            
            
                    
            Map countMap =  sqlSession.getMapper(DrawbackDao.class).retrieve_TrgetThngCount(param);
            
            if(0 == StringUtil.null2zero(countMap.get("CNT"))) {    // 모든행이 삭제된경우 갑/병 정보까지 모두 삭제하여 초기화합니다.
                sqlSession.getMapper(DrawbackDao.class).init_DrawBackRawmtrl(param);
                sqlSession.getMapper(DrawbackDao.class).init_DrawBackCmmn(param);
            }else {
                sqlSession.getMapper(DrawbackDao.class).refresh_DrawBackCmmn(param);    
                sqlSession.getMapper(DrawbackDao.class).refresh_Trget_DrawBackCmmn(param);    
            }
            
            rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
            
        } catch (Exception e) {
            //e.printStackTrace();
            rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
            throw new RuntimeException();
        }finally {

            
        }
        
        return rs;
        
    }
	
	
	
	
	/**
	 * 수출확정 정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB006List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB006List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
	 * 수출확정 상세 해더 정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_DB00601_header(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00601_header(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	
	/**
	 * 수출확정 상세 수출신고 정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00601_exportList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00601_exportList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }	
	
	
	/**
	 * 수출확정 취소 버튼 클릭
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public Result cencel_DB006_xportList(Map param, List paramList){
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	
    	try {
    		for(int inx = 0; inx < paramList.size(); inx++) {
    			Map loop_rows = (Map)paramList.get(inx);
    			loop_rows.putAll(param);
    			/** # 001 - 작성된 환급신청서에서 수출신고서 단위로 확정취소를 수행함 */
    			List<Map<String, Object>> cancelTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_cancelDrawbackTarget_List(loop_rows);
    			int workCount = 0;
    			for(int ii = 0; ii < cancelTargetList.size(); ii++) {
    	    		Map rows = cancelTargetList.get(ii);
    	    		rows.putAll(param);
    	    		/** # 002 - 잔량마스터에서 사용한 잔량을 복구 시킨다. */
    	    		workCount += sqlSession.getMapper(DrawbackDao.class).cancelDrawbackForIncmeLocalBntSm(rows);
    	    		
    	    		/** # 003 - 확정 취소한 <병>에 해당하는 데이터를 삭제합니다. */
    	    		workCount += sqlSession.getMapper(DrawbackDao.class).delete_Drwbak_Incme_Rawmtrl(rows);
    	    	}
    			if(workCount > 0) {
    				
    				List<Map<String, Object>> cancelXportList = sqlSession.getMapper(DrawbackDao.class).retrieve_cancelXport_List(loop_rows);
    				for(int ii = 0; ii < cancelXportList.size(); ii++) { 
    					Map xportMap = cancelXportList.get(ii);
    					
    					/** # 004/01 - 수출 마스터에 수량 복원   */
            			sqlSession.getMapper(DrawbackDao.class).update_CancelXportItemQty(xportMap);
    						
    				}
    				/** #  # 004/02 - 확정 취소한 <을>에 해당하는 데이터를 삭제합니다.   */
        			sqlSession.getMapper(DrawbackDao.class).delete_Drwbak_Trget_Thng(loop_rows);
        			
        			/** 해당관리번호로 생성되어 있는 <을> 데이터가  존재하는지 확인 */
        			Map countMap =  sqlSession.getMapper(DrawbackDao.class).retrieve_TrgetThngCount(loop_rows);
                    
                    if(0 == StringUtil.null2zero(countMap.get("CNT"))) {    // 모든행이 삭제된경우 갑 정보까지 모두 삭제하여 초기화합니다.
                        sqlSession.getMapper(DrawbackDao.class).init_DrawBackCmmn(loop_rows);
                    }else {
                        sqlSession.getMapper(DrawbackDao.class).refresh_DrawBackCmmn(loop_rows);
                        sqlSession.getMapper(DrawbackDao.class).refresh_Trget_DrawBackCmmn(loop_rows);
                        
                    }
    			}
    			
    		}
    	} catch (Exception e) {
    		//e.printStackTrace();
    		throw new RuntimeException("<><><><><><><><><>수출확정 취소 프로세스 수행중 오류 발생<><><><><><><><><>");
    	}
    	
    	rs.setSuccess(true);
    	rs.setMessage(DEFAULT_MESSAGE_OK);
    	
    	return rs;
    	
	}
	
	
	
	
	
	/**
	 * 수출확정버튼 클릭
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public Result confirm_DB006_xportList(Map param, List paramList){
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    	    
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"),"N");
            
            
    		boolean preCmmnExists = false; // 기생성된 신청서가 있는경우
    		
    		/** 001 - 전달받은 수출신고번호를 임시저장 테이블에 저장합니다. */ 
    		String mykey = UUID.randomUUID().toString();
    		
    		param.put("MY_KEY", mykey);
    		
    		for(int inx = 0; inx < paramList.size(); inx++) {
    			Map rowMap =  (Map)paramList.get(inx);
    			rowMap.putAll(param);
    			sqlSession.getMapper(DrawbackDao.class).create_Temp_xportList(rowMap);
    		}
    		
    		/** 002 - Check 한 목록의 Key List를 생성합니다. */
    		List<Map<String, Object>> checkedConfirm_List = sqlSession.getMapper(DrawbackDao.class).retrieve_CheckedConfirm_List(param); 
    		
    		String key_PresentnNo = "";
    		for(int inx = 0; inx < checkedConfirm_List.size(); inx++) {
    			Map rowMap =  (Map)checkedConfirm_List.get(inx);
    			rowMap.putAll(param);
    			sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    			List<Map<String, Object>> alreadyCmmnList = sqlSession.getMapper(DrawbackDao.class).retrieve_alreadyCmmnList(rowMap);
    			
    			if(alreadyCmmnList.size() == 0 ) {
    				/** 기존에 생성된 [갑]환급신청 이 없는 경우 갑지 생성*/
    				sqlSession.getMapper(DrawbackDao.class).create_Drawback_CMMN(rowMap);
    				
    				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
    				key_PresentnNo = StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO"));
    			}else {
    				preCmmnExists = true;
    				Map keyMap = alreadyCmmnList.get(0);
    				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
    			}
    			
    			/** [을] 환급신청 생성 */
    			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
    				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
    			}
    			rowMap.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			
    			sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_Thing_Temp(rowMap);
    			param.put("DIVISION_CODE", StringUtil.null2String(rowMap.get("DIVISION_CODE")));
    			//sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_THNG(rowMap);
    			//int pre_thng_seq_number = StringUtil.null2zero(rowMap.get("PRE_THNG_SEQ_NUMBER"));

    			
    			// 임시테이블에 저장한 데이터 조회 
    			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).retrivev_DrawbackData_ThingTEMP_List(rowMap);
    			int thing_create_count = 0;
    			
    			if(thingTEMP_List.size() > 0) {
    				for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
        				Map tmpRowMap = (Map)thingTEMP_List.get(ii);
        				tmpRowMap.putAll(rowMap);
        				String incme_Local_Bnt_Yn = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Incme_Local_Bnt_Yn(tmpRowMap);
        				
        				if("Y".equalsIgnoreCase(incme_Local_Bnt_Yn)) {	// 잔량이 충분한 경우
        					thing_create_count++;	// 생성 건수 카운트
        					sqlSession.getMapper(DrawbackDao.class).create_DrwBack_THNG(tmpRowMap);
        					int inserted_THNG_SEQ =  StringUtil.null2zero(tmpRowMap.get("PRE_THNG_SEQ_NUMBER"))+1;
        					// 해당 을지에 대한 병지 생성
        					tmpRowMap.put("INSERTED_THNG_SEQ", inserted_THNG_SEQ);	// 병지 생성에 사용한 시퀀스
        					List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Thing_Worktarget(tmpRowMap);
        					
        					/**** [병] 기납증 생성 시작 ****/
        					for(int ix = 0; ix < thingWrokTargetList.size(); ix++) {
        	    				Map thingWrokTargetMap = thingWrokTargetList.get(ix);
        	    				thingWrokTargetMap.putAll(param);
        	    				this.calcDrwBack_3rd(thingWrokTargetMap, logEnable_Flag);
        	    			} // for End
        					
        				}else {
        				    // TODO: 생성할 수 없는경우 사유관리에 저장합니다.
        				    tmpRowMap.put("LOCAL_BTN_RESULT", StringUtil.null2String(incme_Local_Bnt_Yn,"NULL"));
        				    
        				    sqlSession.getMapper(DrawbackDao.class).create_DoNotXportConfirmReasnon(tmpRowMap);
        				}
    				}
    			}
    			
    			/** 데이터 정리 */
    			param.put("KEY_PRESENTN_NO", key_PresentnNo);
    			if(thing_create_count == 0 && !preCmmnExists) {	// 생성할 을지가 없을경우 갑지 삭제
    				sqlSession.getMapper(DrawbackDao.class).delete_ExistsCmmn(param);
    				continue;
    			}else {
    				
    				/**
        		     * 작성된 [병]을 이용하여 환급 세액을 계산하여 [갑]에 update 한다.
        		     */
        			sqlSession.getMapper(DrawbackDao.class).update_Drwbak_Cmmn(param);	
    			}
    			
    		}
    		
      		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException();
		}finally {
			/** 임시 사용한 수출신고번호 데이터를 삭제합니다. */
			int delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_MyxportList(param);
    		
			delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    		if(delCount > 0 ) {
    			logger.debug("#### 임시데이터 삭제 : " + delCount + " 건");
    		}
    		
		}
    	
    	return rs;
    	
    }
	
	
	/**
	 * 차감할 수량이 0이 될때까지 재귀호출을 수행한다.
	 * @param p_Row
	 * @return
	 */
	@Transactional
	public int calcDrwBack_3rd(Map p_Row, String logFlag) {
		//LinkedHashSet<String> returnSet = new LinkedHashSet<>();
		
		List<Map<String, Object>> preUpdateList = sqlSession.getMapper(DrawbackDao.class).retrieve_PreUpdateData(p_Row);
		int create_IncmeRawmtrl_count = 0;
		try {
			
		    if(preUpdateList.size() > 0) {
	            Map<String, Object> preUpdateMap = preUpdateList.get(0);
	            
	            preUpdateMap.put("CREATE_BY", p_Row.get("CREATE_BY"));
	            preUpdateMap.put("UPDATE_BY", p_Row.get("UPDATE_BY"));
	            String minusValue = StringUtil.null2String(preUpdateMap.get("NEXT_MINUS_VALUE"));
	            // 잔량관리 차감
	            sqlSession.getMapper(DrawbackDao.class).minusIncme_LocalBnt_Process(preUpdateMap);
	            // [병[ 환급신청서 생성
	            sqlSession.getMapper(DrawbackDao.class).create_IncmeRawmtrl(preUpdateMap);
	            create_IncmeRawmtrl_count++;
	            if("Y".equalsIgnoreCase(logFlag)) {
	                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 저장 시작.");
	                this.create_Incme_LocalBnt_History(preUpdateMap, "01");    
	            }else {
	                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 사용 안함.");
	            }
	            
	            
	            
	            p_Row.put("TOT_REQ_QTY", minusValue);
	            
	            // 처리할 필요수량이 남은 경우 재귀호출
	            if(!"0".equalsIgnoreCase(minusValue)) {
	                this.calcDrwBack_3rd(p_Row, logFlag);    
	            }
	                
	            
	        }
        } catch (Exception e) {
            //e.printStackTrace();
            throw new RuntimeException();
        }
		
		
		return create_IncmeRawmtrl_count;
	}
	
	/**
	 * 잔량 사용 이력을 저장합니다.
	 * @param preUpdateMap
	 */
	@Transactional
	public void create_Incme_LocalBnt_History(Map preUpdateMap, String useType) {
	    
	    try {
	     // 잔량사용이력 저장 - USE_TYPE :: 사용형태(01:환급신청서, 02 기납증, 03 분증)
	        logger.debug("##### 잔량 이력 저장 [" + useType + "]");
	        preUpdateMap.put("USE_TYPE", useType);
	        preUpdateMap.put("RAWMTRL_SEQ", StringUtil.null2String(preUpdateMap.get("PRE_RAWMTRL_SEQ")));
	        sqlSession.getMapper(DrawbackDao.class).createIncme_LocalBnt_History(preUpdateMap);    
        } catch (Exception e) {
            //e.printStackTrace();
            throw new RuntimeException();
        }
        
	}

	
	/**
	 * 매출확정(내수) 정보 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB007List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB007List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 매출확정(내수) 상세 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> retrieve_DB00701List(Map<String, Object> param) throws Exception {
	    
	    GridOutputData gridData = null;
	    try {
	        List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00701List(param);
	        String pageParam = StringUtil.null2String(param.get("page"), "1");
	        String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
	        int page = Integer.parseInt(pageParam);
	        int rows = Integer.parseInt(rowsParam);
	        int total = 0;
	        int listSize = null==list ? 0 : list.size();
	        if(list != null && list.size() > 0 ){
	            total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
	        }
	        logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
	        gridData = new GridOutputData(list, page, rows, total);
	    } catch (RuntimeException e) {
	        //e.printStackTrace();
	    }
	    
	    return gridData;
	}
	
	
	/**
	 * 매출확정취소(내수) 확정 Process
	 * @param param
	 * @param createTarget_List
	 * @return
	 * @throws RuntimeException
	 */
	@Transactional
	public Result cancel_DB007_SelngList(Map param, List createTarget_List) throws RuntimeException{
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {

    		
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"),"N");
            
            
    		// 전달받은 갯수만큼 Loop
    		String key_PresentnNo = "";
    		String issueType = "";
    		boolean createKeyFlag = false;
    		for(int inx = 0; inx < createTarget_List.size(); inx++) {
    			Map rowMap = (Map)createTarget_List.get(inx);
    			issueType = StringUtil.null2String(rowMap.get("ISSUE_TYPE"));
    			
    			if(issueType == null || "".equalsIgnoreCase(issueType)) {
    				throw new RuntimeException("기납증/분증 구분이 없어 작업을 진행 할 수 없습니다.");
    			}
    			
    			
    			//001 - PRESENTN_NO(내부관리번호) 생성 또는 기존 번호 활용
    			List<Map<String, Object>> presentn_no_CheckList = sqlSession.getMapper(DrawbackDao.class).presentn_no_CheckList(rowMap);
    			
    			/** [갑] 기납/분증 생성 */
    			if(presentn_no_CheckList.size() == 0) {
    				//기존에 생성한 관리번호(기납/분증)가 없는경우 관리번호 생성과 동시에 갑지 생성
    				sqlSession.getMapper(DrawbackDao.class).create_Ctrm_CMMN(rowMap);
    				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
    				key_PresentnNo = StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO"));
    				createKeyFlag = true;
    			}else {
    				Map keyMap = presentn_no_CheckList.get(0);
    				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
    				createKeyFlag = false;
    			}
    			
    			/** [을] 기납/분증 생성 */
    			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
    				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
    			}
    			rowMap.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			// 체크한 목록에 대한 [을] 기납/분증 생성
    			sqlSession.getMapper(DrawbackDao.class).create_Ctrm_THNG_TEMP(rowMap);
    			
    			
    			
    			// 임시테이블에 저장한 데이터 조회 
    			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).thingTEMP_List(rowMap);
    			int thing_create_count = 0;
    			if(thingTEMP_List.size() > 0) {

         			for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
        				Map tmpRowMap = (Map)thingTEMP_List.get(ii);
        				//tmpRowMap.putAll(rowMap);
        				tmpRowMap.put("PRE_THNG_SEQ_NUMBER", StringUtil.null2String(rowMap.get("PRE_THNG_SEQ_NUMBER")));
        				tmpRowMap.put("KEY_PRESENTN_NO", StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO")));
        				tmpRowMap.put("ISSUE_TYPE",issueType);
        				
        				String incme_Local_Bnt_Yn = sqlSession.getMapper(DrawbackDao.class).retrieve_Incme_Local_Bnt_Yn(tmpRowMap);	
        				
        				if("Y".equalsIgnoreCase(incme_Local_Bnt_Yn)) {	//  // 잔량이 충분한 경우
        					
        					thing_create_count++;	// 생성 건수 카운트
        					if("02".equalsIgnoreCase(issueType)) {	 // 기납증인 경우
        						// 을지 생성
            					sqlSession.getMapper(DrawbackDao.class).create_Ctrm_THNG(tmpRowMap);
        						// 해당 을지에 대한 병지 생성
            					List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Thing_Worktarget(tmpRowMap);
            					/**** [병] 기납증 생성 시작 ****/
            					for(int ix = 0; ix < thingWrokTargetList.size(); ix++) {
            	    				Map thingWrokTargetMap = thingWrokTargetList.get(ix);
            	    				thingWrokTargetMap.put("ISSUE_TYPE",issueType);
            	    				thingWrokTargetMap.put("CREATE_BY", StringUtil.null2String(param.get("CREATE_BY")));
            	    				
            	    				
           	                        this.calcCtrm_3rd(thingWrokTargetMap, logEnable_Flag);
            	    				
            	    			} // for End
        					}else {
        						Map<String, Object> thingWrokTargetMap = sqlSession.getMapper(DrawbackDao.class).retrieve_Thing_Rawmtrl_Worktarget(tmpRowMap);
        						
        						thingWrokTargetMap.put("BASIS_DOC_NO", tmpRowMap.get("BASIS_DOC_NO"));
        						thingWrokTargetMap.put("SUPT_DOC_ITEM_SEQ", tmpRowMap.get("SUPT_DOC_ITEM_SEQ"));
        						thingWrokTargetMap.put("SUPT_DOC_SE", tmpRowMap.get("SUPT_DOC_SE"));
        						thingWrokTargetMap.put("ITEM_NM", tmpRowMap.get("ITEM_NM"));
        						thingWrokTargetMap.put("CSTMR_ITEM", tmpRowMap.get("CSTMR_ITEM"));
        						thingWrokTargetMap.put("STTEMNT_PC_KRW", tmpRowMap.get("STTEMNT_PC_KRW"));
        						
        						thingWrokTargetMap.put("CREATE_BY", StringUtil.null2String(param.get("CREATE_BY")));
        						
        						
        						this.calcCtrm_Thing_Rawmtrl(thingWrokTargetMap, logEnable_Flag);
        						//분증은 란행 넣는곳이 없는?  잔량이랑 맵핑해야하는데 확정취소할 때 ???
        						
        					} // if("02".equalsIgnoreCase(issueType)) End
        				} else {
        				    // TODO: 생성할 수 없는경우 사유관리에 저장합니다.
                            tmpRowMap.put("LOCAL_BTN_RESULT", StringUtil.null2String(incme_Local_Bnt_Yn,"NULL"));
                            sqlSession.getMapper(DrawbackDao.class).create_DoNotDomConfirmReasnon(tmpRowMap);
                            
        				}
        			} // 임시테이블에 저장한 데이터 조회  Loop End
        			
        			
        			if(thing_create_count == 0) {	// 생성할 을지가 없을경우 갑지 삭제
        				sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_Cmmn(rowMap);
        				continue;
        			}
        			
        			
        			
        			if("02".equalsIgnoreCase(issueType)) {	 // 기납증인 경우
        				//병지의 금액을 을지에 update
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Thing(rowMap);
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Cmmn(rowMap);
        			}else {
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Cmmn_FromThing_Rawmtrl(rowMap);
        				
        			}
    			}else {
    				// 생성할 을지가 없을경우 갑지 삭제
    			    if(createKeyFlag) {
    			        sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_Cmmn(rowMap);    
    			    }
    				
    			} // if thingTEMP_List End
    			
    		} // createTarget_List Loop End
    		
    		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException(); // Spring에 던져준다

			
		}finally {
			sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_TempData(param);
			
		}
    	
    	return rs; 
    	
    }
	
	/**
	 * 기납증 생성 대상 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieveConfrimCtrmTargetList(Map param) throws Exception {
    	
    	return sqlSession.getMapper(DrawbackDao.class).retrieveConfrimCtrmTargetList(param);
    }
	
	/**
	 * 기납증 생성
	 * @param targetMap : COMPANY_CODE, DIVISION_CODE, INVOICE_MONTH, CUSTOMER_CODE, HS_CODE
	 * @return rs
	 * @throws RuntimeException
	 */
	@Transactional
	public Result createCtrmProcess(Map targetMap) throws RuntimeException{
		Result rs = new Result();
		String logEnable_Flag = StringUtil.null2String(targetMap.get("logEnable_Flag"),"N");
		
		String key_PresentnNo = "";
		boolean preCmmnExists = false;
		
		Map<String, Object> trgetThng_Map = sqlSession.getMapper(DrawbackDao.class).retrieveCtrmTrgetThng_List(targetMap);
		
		int ableExportCtrmQty = StringUtil.null2zero(trgetThng_Map.get("ABLE_CTRM_QTY"));	// 수출물량에 대한 기납증 발급 가능 수량
		String maxWorkBomVersion = StringUtil.null2String(trgetThng_Map.get("MAX_BOM_VERSION"));
		targetMap.put("ABLE_CTRM_QTY", ableExportCtrmQty);
		targetMap.put("MAX_BOM_VERSION", maxWorkBomVersion);
		
		targetMap.putAll(trgetThng_Map);
		try {
			if(ableExportCtrmQty < 1 || maxWorkBomVersion == null) {
				//만들수 있는 기납증 수량이 없거나 사용할 bom이 없으면 수행하지 않음
				return rs;
			}
			
			// 기존에 만들어진 발급번호 건이 있는 지 확인 
			List<Map<String, Object>> alreadyCtrmCmmnList = sqlSession.getMapper(DrawbackDao.class).retrieve_alreadyCtrmCmmnList(targetMap);
			
			if(alreadyCtrmCmmnList.size() == 0 ) {
				
				/**
				 *  기존에 생성된 [갑]환급신청 이 없는 경우 갑지 생성
				 * 기납증 <갑> 새엉
				 */
				sqlSession.getMapper(DrawbackDao.class).create_Ctrm_CMMN_FromSales(targetMap);
				
				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
				key_PresentnNo = StringUtil.null2String(targetMap.get("KEY_PRESENTN_NO"));
			}else {
				preCmmnExists = true;
				Map keyMap = alreadyCtrmCmmnList.get(0);
				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
			}
			
			/** [을] 기납증 생성 임시테이블 */
			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
			}
			targetMap.put("KEY_PRESENTN_NO", key_PresentnNo);
			sqlSession.getMapper(DrawbackDao.class).createCtrmThngTemp(targetMap);
			
			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).retrivev_Ctrm_ThingTEMP_List(targetMap);
			int thing_create_count = 0;
			
			if(thingTEMP_List.size() > 0) {
				for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
					Map tmpRowMap = (Map)thingTEMP_List.get(ii);
					tmpRowMap.putAll(targetMap);
					/** 남은 잔량으로 생성할수 있는 기납증<을> 데이터의 수량을 조회*/
					String tgt_Accmlt_OrderQty = sqlSession.getMapper(DrawbackDao.class).createAble_Ctrm_THNG_OrderQty(tmpRowMap);
					
					if(tgt_Accmlt_OrderQty == null || "0".equals(tgt_Accmlt_OrderQty)) { // 셍성할 건수가 0 이면 <을> 생성하지 않고 다음 건으로 이동
						continue;
					}
					thing_create_count++;	// 생성 건수 카운트
					/** [을] 기납증 생성  */
					tmpRowMap.put("TGT_ACCMLT_ORDERQTY", tgt_Accmlt_OrderQty);
					tmpRowMap.put("EXP_ACCMLT_ORDERQTY", tgt_Accmlt_OrderQty);
					
					// tgt_Accmlt_OrderQty 수량만큼 을지 생성 
					sqlSession.getMapper(DrawbackDao.class).createCtrmThng(tmpRowMap);
					
					/** 을지에 사용한 수량만큼 매출 잔량관리 차감 */
					sqlSession.getMapper(DrawbackDao.class).update_Sales_Using_Qty(tmpRowMap);
					
					/** 을지에 사용한 수량만큼 수출 마스터에 차감 */
					this.update_Export_Ctrm_Using_Qty(tmpRowMap);
					
					
					// (대상 품목의 수출수량) * 투입수량이 적용된 을지 만들기 위한 목록
		        	List<Map<String, Object>> incmeRawmtrl_List = sqlSession.getMapper(DrawbackDao.class).retrieveCtrmIncmeRawmtrl_List(tmpRowMap);
		        	
		        	int create_IncmeRawmtrl_count = 0;
		        	for(int ix = 0; ix < incmeRawmtrl_List.size(); ix++) {
		        		Map thingWrokTargetMap = incmeRawmtrl_List.get(ix);
		        		
		        		thingWrokTargetMap.put("CREATE_BY", targetMap.get("CREATE_BY"));
		        		thingWrokTargetMap.put("UPDATE_BY", targetMap.get("UPDATE_BY"));
			            
		        		create_IncmeRawmtrl_count = create_IncmeRawmtrl_count +  this.calcCtrmIncmeRawmtrl(thingWrokTargetMap, logEnable_Flag);
		        	}
					
				}
			}
			/** 데이터 정리 */
			targetMap.put("KEY_PRESENTN_NO", key_PresentnNo);
			/** <병> 데이터가 없는 <을> 데이터를 삭제처리 */ 
			sqlSession.getMapper(DrawbackDao.class).delete_ExistsCtrmIncmeRawmtrl_Trget_thng(targetMap);
			
			/** 기존 관리번호가 없고 해당 관리번호로 생성된 <을> 데이터가 없는경우 <갑> 데이터를 삭제합니다. */
			int delCount_Cmnn = sqlSession.getMapper(DrawbackDao.class).delete_ExistsCtrmCmmn(targetMap);
			
			/** 삭제한 <갑> 데이터가 없다면 <을,병> 데이터가 정상이므로 <밥> 데이터를 갱신한다.*/
			if(delCount_Cmnn == 0) {	
				/**
			     * 작성된 [병]을 이용하여 환급 세액을 계산하여 [갑]에 update 한다.
			     */
				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Cmmn(targetMap);	
			}
			
			rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
			
		}catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException();
		}finally {
			/** 임시 사용한 수출신고번호 데이터를 삭제합니다. */
			sqlSession.getMapper(DrawbackDao.class).delete_Temp_Ctrm_Things_List(targetMap);	
			
		}
		
		return rs;
	}
	
	
	/**
	 * 수출 기납증 물량 차감
	 * @param param
	 * @return
	 * @throws RuntimeException
	 */
	public Result update_Export_Ctrm_Using_Qty(Map param) throws RuntimeException{
		Result rs = new Result();
		
		List<Map<String, Object>> preUpdateList = sqlSession.getMapper(DrawbackDao.class).retrieve_PreCtrmExportUpdateData(param);
		if(preUpdateList.size() > 0) {
			Map<String, Object> preUpdateMap = preUpdateList.get(0);
			String minusValue = StringUtil.null2String(preUpdateMap.get("NEXT_MINUS_VALUE"));
			
			/* 실제 수출 수량에서 기납증 발급 수량 차감 (선입선출)*/
			sqlSession.getMapper(DrawbackDao.class).minusExport_AbleCtrm_Process(preUpdateMap);
			
			param.put("EXP_ACCMLT_ORDERQTY", minusValue);
			
			// 처리할 필요수량이 남은 경우 재귀호출
			if(!"0".equalsIgnoreCase(minusValue)) {
                this.update_Export_Ctrm_Using_Qty(param);    
            }
			
		}
		
		
		return rs;
	}
	
	
	/**
	 * 기납증 <병> 생성
	 * @param p_Row
	 * @param logFlag
	 * @return
	 */
	@Transactional
	public int calcCtrmIncmeRawmtrl(Map thingWrokTargetMap, String logFlag) {
		
		List<Map<String, Object>> preUpdateList = sqlSession.getMapper(DrawbackDao.class).retrieve_PreCtrmUpdateData(thingWrokTargetMap);
		int create_IncmeRawmtrl_count = 0;
		try {
			
		    if(preUpdateList.size() > 0) {
	            Map<String, Object> preUpdateMap = preUpdateList.get(0);
	            
	            preUpdateMap.put("CREATE_BY", thingWrokTargetMap.get("CREATE_BY"));
	            preUpdateMap.put("UPDATE_BY", thingWrokTargetMap.get("UPDATE_BY"));
	            String minusValue = StringUtil.null2String(preUpdateMap.get("NEXT_MINUS_VALUE"));
	            
	            
	            // 잔량관리 차감
	            sqlSession.getMapper(DrawbackDao.class).minusIncme_LocalBnt_Process(preUpdateMap);
	            // [병] 기납증 생성 
	            sqlSession.getMapper(DrawbackDao.class).create_Ctrm_IncmeRawmtrl(preUpdateMap);
	            create_IncmeRawmtrl_count++;
	            if("Y".equalsIgnoreCase(logFlag)) {
	                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 저장 시작.");
	                preUpdateMap.put("THNG_SEQ", preUpdateMap.get("SEQ"));
	                this.create_Incme_LocalBnt_History(preUpdateMap, "02");    
	            }else {
	                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 사용 안함.");
	            }
	            
	            
	            
	            thingWrokTargetMap.put("TOT_REQ_QTY", minusValue);
	            
	            // 처리할 필요수량이 남은 경우 재귀호출
	            if(!"0".equalsIgnoreCase(minusValue)) {
	                this.calcDrwBack_3rd(thingWrokTargetMap, logFlag);    
	            }
	                
	            
	        }
        } catch (Exception e) {
            //e.printStackTrace();
            throw new RuntimeException();
        }
		
		
		return create_IncmeRawmtrl_count;
	}
	
	/**
	 * 매출확정(내수) 확정 Process (구매확인서 버전)
	 * @param param
	 * @param paramList
	 * @return
	 * @throws Exception 
	 */
	@Transactional
	public Result confirm_DB007_SelngList(Map param, List createTarget_List) throws RuntimeException{
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {

    	    
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"),"N");
            
            
    		// 전달받은 갯수만큼 Loop
    		String key_PresentnNo = "";
    		String issueType = "";
    		boolean createKeyFlag = false;
    		for(int inx = 0; inx < createTarget_List.size(); inx++) {
    			Map rowMap = (Map)createTarget_List.get(inx);
    			issueType = StringUtil.null2String(rowMap.get("ISSUE_TYPE"));
    			
    			if(issueType == null || "".equalsIgnoreCase(issueType)) {
    				throw new RuntimeException("기납증/분증 구분이 없어 작업을 진행 할 수 없습니다.");
    			}
    			
    			
    			//001 - PRESENTN_NO(내부관리번호) 생성 또는 기존 번호 활용
    			List<Map<String, Object>> presentn_no_CheckList = sqlSession.getMapper(DrawbackDao.class).presentn_no_CheckList(rowMap);
    			
    			/** [갑] 기납/분증 생성 */
    			if(presentn_no_CheckList.size() == 0) {
    				//기존에 생성한 관리번호(기납/분증)가 없는경우 관리번호 생성과 동시에 갑지 생성
    				sqlSession.getMapper(DrawbackDao.class).create_Ctrm_CMMN(rowMap);
    				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
    				key_PresentnNo = StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO"));
    				createKeyFlag = true;
    			}else {
    				Map keyMap = presentn_no_CheckList.get(0);
    				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
    				createKeyFlag = false;
    			}
    			
    			/** [을] 기납/분증 생성 */
    			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
    				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
    			}
    			rowMap.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			// 체크한 목록에 대한 [을] 기납/분증 생성
    			sqlSession.getMapper(DrawbackDao.class).create_Ctrm_THNG_TEMP(rowMap);
    			
    			
    			
    			// 임시테이블에 저장한 데이터 조회 
    			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).thingTEMP_List(rowMap);
    			int thing_create_count = 0;
    			if(thingTEMP_List.size() > 0) {

         			for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
        				Map tmpRowMap = (Map)thingTEMP_List.get(ii);
        				//tmpRowMap.putAll(rowMap);
        				tmpRowMap.put("PRE_THNG_SEQ_NUMBER", StringUtil.null2String(rowMap.get("PRE_THNG_SEQ_NUMBER")));
        				tmpRowMap.put("KEY_PRESENTN_NO", StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO")));
        				tmpRowMap.put("ISSUE_TYPE",issueType);
        				
        				String incme_Local_Bnt_Yn = sqlSession.getMapper(DrawbackDao.class).retrieve_Incme_Local_Bnt_Yn(tmpRowMap);	
        				
        				if("Y".equalsIgnoreCase(incme_Local_Bnt_Yn)) {	//  // 잔량이 충분한 경우
        					
        					thing_create_count++;	// 생성 건수 카운트
        					if("02".equalsIgnoreCase(issueType)) {	 // 기납증인 경우
        						// 을지 생성
            					sqlSession.getMapper(DrawbackDao.class).create_Ctrm_THNG(tmpRowMap);
        						// 해당 을지에 대한 병지 생성
            					List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Thing_Worktarget(tmpRowMap);
            					/**** [병] 기납증 생성 시작 ****/
            					for(int ix = 0; ix < thingWrokTargetList.size(); ix++) {
            	    				Map thingWrokTargetMap = thingWrokTargetList.get(ix);
            	    				thingWrokTargetMap.put("ISSUE_TYPE",issueType);
            	    				thingWrokTargetMap.put("CREATE_BY", StringUtil.null2String(param.get("CREATE_BY")));
            	    				
            	    				
           	                        this.calcCtrm_3rd(thingWrokTargetMap, logEnable_Flag);
            	    				
            	    			} // for End
        					}else {
        						Map<String, Object> thingWrokTargetMap = sqlSession.getMapper(DrawbackDao.class).retrieve_Thing_Rawmtrl_Worktarget(tmpRowMap);
        						
        						thingWrokTargetMap.put("BASIS_DOC_NO", tmpRowMap.get("BASIS_DOC_NO"));
        						thingWrokTargetMap.put("SUPT_DOC_ITEM_SEQ", tmpRowMap.get("SUPT_DOC_ITEM_SEQ"));
        						thingWrokTargetMap.put("SUPT_DOC_SE", tmpRowMap.get("SUPT_DOC_SE"));
        						thingWrokTargetMap.put("ITEM_NM", tmpRowMap.get("ITEM_NM"));
        						thingWrokTargetMap.put("CSTMR_ITEM", tmpRowMap.get("CSTMR_ITEM"));
        						thingWrokTargetMap.put("STTEMNT_PC_KRW", tmpRowMap.get("STTEMNT_PC_KRW"));
        						
        						thingWrokTargetMap.put("CREATE_BY", StringUtil.null2String(param.get("CREATE_BY")));
        						
        						
        						this.calcCtrm_Thing_Rawmtrl(thingWrokTargetMap, logEnable_Flag);
        						//분증은 란행 넣는곳이 없는?  잔량이랑 맵핑해야하는데 확정취소할 때 ???
        						
        					} // if("02".equalsIgnoreCase(issueType)) End
        				} else {
        				    // TODO: 생성할 수 없는경우 사유관리에 저장합니다.
                            tmpRowMap.put("LOCAL_BTN_RESULT", StringUtil.null2String(incme_Local_Bnt_Yn,"NULL"));
                            sqlSession.getMapper(DrawbackDao.class).create_DoNotDomConfirmReasnon(tmpRowMap);
                            
        				}
        			} // 임시테이블에 저장한 데이터 조회  Loop End
        			
        			
        			if(thing_create_count == 0) {	// 생성할 을지가 없을경우 갑지 삭제
        				sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_Cmmn(rowMap);
        				continue;
        			}
        			
        			
        			
        			if("02".equalsIgnoreCase(issueType)) {	 // 기납증인 경우
        				//병지의 금액을 을지에 update
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Thing(rowMap);
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Cmmn(rowMap);
        			}else {
        				sqlSession.getMapper(DrawbackDao.class).update_Ctrm_Cmmn_FromThing_Rawmtrl(rowMap);
        				
        			}
    			}else {
    				// 생성할 을지가 없을경우 갑지 삭제
    			    if(createKeyFlag) {
    			        sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_Cmmn(rowMap);    
    			    }
    				
    			} // if thingTEMP_List End
    			
    		} // createTarget_List Loop End
    		
    		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException(); // Spring에 던져준다

			
		}finally {
			sqlSession.getMapper(DrawbackDao.class).delete_Ctrm_TempData(param);
			
		}
    	
    	return rs; 
    	
    }
	
	/**
	 * 기납증 병지 생성 
	 * 잔량 차감 + 병지 생성 수행
	 * @param p_
	 * @return
	 * @throws RuntimeException
	 */
	public LinkedHashSet<String> calcCtrm_3rd(Map p_Row, String logFlag) throws RuntimeException{
		LinkedHashSet<String> returnSet = new LinkedHashSet<>();
		
		List<Map<String, Object>> preUpdateList = sqlSession.getMapper(DrawbackDao.class).retrieve_Ctrm_PreUpdateData(p_Row);
		if(preUpdateList.size() > 0) {
			Map<String, Object> preUpdateMap = preUpdateList.get(0);
			
			
			String minusValue = StringUtil.null2String(preUpdateMap.get("NEXT_MINUS_VALUE"));
			// 잔량관리 차감
			sqlSession.getMapper(DrawbackDao.class).minusIncme_LocalBnt_Process(preUpdateMap);
			// [병[ 기납증 생성
			sqlSession.getMapper(DrawbackDao.class).create_Ctrm_IncmeRawmtrl(preUpdateMap);
			
			preUpdateMap.put("THNG_SEQ", StringUtil.null2String(preUpdateMap.get("SEQ")));
			if("Y".equalsIgnoreCase(logFlag)) {
			    logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 저장 시작.");
			    this.create_Incme_LocalBnt_History(preUpdateMap, "02");    
			}else {
                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 사용 안함.");
            }
			
			p_Row.put("TOT_REQ_QTY", minusValue);
			
			// 처리할 필요수량이 남은 경우 재귀호출
			if(!"0".equalsIgnoreCase(minusValue)) {
 				this.calcCtrm_3rd(p_Row, logFlag);	
			}
				
			
		}
		
		return returnSet;
	}
	
	
	/**
	 * 분증 을지 생성 
	 * 잔량 차감 + 병지 생성 수행
	 * @param p_
	 * @return
	 * @throws RuntimeException
	 */
	public LinkedHashSet<String> calcCtrm_Thing_Rawmtrl(Map p_Row, String logFlag) throws RuntimeException{
		LinkedHashSet<String> returnSet = new LinkedHashSet<>();
		
		List<Map<String, Object>> preUpdateList = sqlSession.getMapper(DrawbackDao.class).retrieve_Ctrm_PreUpdateData(p_Row);
		if(preUpdateList.size() > 0) {
			Map<String, Object> preUpdateMap = preUpdateList.get(0);
			preUpdateMap.put("CHIT_FRMTRM_DATE", p_Row.get("CHIT_FRMTRM_DATE"));
			preUpdateMap.put("BASIS_DOC_NO", p_Row.get("BASIS_DOC_NO"));
			preUpdateMap.put("SUPT_DOC_ITEM_SEQ", p_Row.get("SUPT_DOC_ITEM_SEQ"));
			preUpdateMap.put("SUPT_DOC_SE", p_Row.get("SUPT_DOC_SE"));
			
			preUpdateMap.put("ITEM_NM", p_Row.get("ITEM_NM"));
			preUpdateMap.put("CSTMR_ITEM", p_Row.get("CSTMR_ITEM"));
			preUpdateMap.put("STTEMNT_PC_KRW", p_Row.get("STTEMNT_PC_KRW"));
			String minusValue = StringUtil.null2String(preUpdateMap.get("NEXT_MINUS_VALUE"));
			// 잔량관리 차감
			sqlSession.getMapper(DrawbackDao.class).minusIncme_LocalBnt_Process(preUpdateMap);
			// 분증 [을] 생성
			sqlSession.getMapper(DrawbackDao.class).create_Ctrm_IncmeThing_Rawmtrl(preUpdateMap);
			preUpdateMap.put("THNG_SEQ", StringUtil.null2String(preUpdateMap.get("SEQ")));
			
			if("Y".equalsIgnoreCase(logFlag)) {
			    logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 저장 시작.");
			    this.create_Incme_LocalBnt_History(preUpdateMap, "03");    
            }else {
                logger.debug("##### [ctrm.rawmtrl.use.log] 잔량 사용 로그 이력 사용 안함.");
            }
			
			
			
			p_Row.put("TOT_REQ_QTY", minusValue);
			
			// 처리할 필요수량이 남은 경우 재귀호출
			if(!"0".equalsIgnoreCase(minusValue)) {
 				this.calcCtrm_3rd(p_Row, logFlag);	
			}
				
			
		}
		
		return returnSet;
	}
	
	
	
	
	/**
	 * 기납/분증 조회 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB008List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB008List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 기납/분증 상세 (갑)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_DB00801_header(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00801_header(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	
	/**
	 * 기납 상세 (을)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00801_trget(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00801_trget(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 분증 상세 (을)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00802_trget(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00802_trget(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 기납 상세 (병)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB00801_rawmtrl(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00801_rawmtrl(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	
	/**
     * 기납증 확정취소
     * @param paramList
     * @return
     * @throws Exception
     */
    @Transactional
    public Result cancel_DB00801_ConfirmProcess(Map param, List paramList){
        /*
         *  common.msg.en.saveok = 저장되었습니다.
            common.msg.en.savefail = 데이터를 저장할 수 없습니다.
         */
        Result rs = new Result();
        try {
            
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"), "N");
            
            int returnDataSuccess = 0;
            for(int inx = 0; inx < paramList.size(); inx++) {   // 을 Loop
                Map rowMap = (Map)paramList.get(inx);
                rowMap.put("COMPANY_CODE", StringUtil.null2String(param.get("COMPANY_CODE")));
                
                List<Map<String, Object>> rawmtrlItem = sqlSession.getMapper(DrawbackDao.class).retrieve_CtrmRawmtrlList(rowMap);
                
                for(int jnx = 0; jnx < rawmtrlItem.size(); jnx++) {   // 병 Loop
                    Map rawmtrlMap = (Map)rawmtrlItem.get(jnx);
                    //기납증 사용잔량 반환
                    returnDataSuccess = sqlSession.getMapper(DrawbackDao.class).return_CtrmkRawmtrl(rawmtrlMap);
                    
                    if(returnDataSuccess == 0) {
                        rs = super.getResult(false, "잔량데이터에 오류가 있습니다. (반환받을 데이터가 없습니다.)", new Object[] {});
                        throw new RuntimeException();
                    }
                    
                    if("Y".equalsIgnoreCase(logEnable_Flag)) {
                        logger.debug("##### [ctrm.rawmtrl.return.log] 잔량 사용 로그 이력 저장 시작.");
                        // 잔량 사용이력 저장
                        Map<String, Object> historyMap = new HashMap<>();
                        
                        historyMap.put("COMPANY_CODE"  ,StringUtil.null2String(rawmtrlMap.get("COMPANY_CODE")));
                        historyMap.put("DIVISION_CODE" ,StringUtil.null2String(rawmtrlMap.get("DIVISION_CODE")));
                        historyMap.put("IMPDEC_NO"     ,StringUtil.null2String(rawmtrlMap.get("IMPDEC_NO")));
                        historyMap.put("LNE_NO"        ,StringUtil.null2String(rawmtrlMap.get("LNE_NO")));
                        historyMap.put("POUCH_NO"      ,StringUtil.null2String(rawmtrlMap.get("POUCH_NO")));
                        historyMap.put("ITEM_CODE"     ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_CODE")));
                        historyMap.put("USGQTY"        ,StringUtil.null2zero(rawmtrlMap.get("USGQTY")) * -1); // 반환이므로 음수처리
                        //잔량사용이력 저장 - USE_TYPE :: 사용형태(01:환급신청서, 02 기납증, 03 분증)
                        historyMap.put("USE_TYPE"      ,"02");
                        historyMap.put("PRESENTN_NO"   ,StringUtil.null2String(rawmtrlMap.get("PRESENTN_NO")));
                        historyMap.put("THNG_SEQ"      ,StringUtil.null2String(rawmtrlMap.get("SEQ")));
                        historyMap.put("RAWMTRL_SEQ"   ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_SEQ")));
                        historyMap.put("CREATE_BY"     ,StringUtil.null2String(param.get("CREATE_BY")));
                        
                        sqlSession.getMapper(DrawbackDao.class).createIncme_LocalBnt_History(historyMap);
                    }else {
                        logger.debug("##### [ctrm.rawmtrl.return.log] 잔량 사용 로그 이력 사용 안함.");
                    }
                }
                
                sqlSession.getMapper(DrawbackDao.class).delete_CtrmRawmtrl(rowMap);
                sqlSession.getMapper(DrawbackDao.class).delete_CtrmTrgetThng(rowMap);
                param.put("DIVISION_CODE", rowMap.get("DIVISION_CODE"));
                param.put("PRESENTN_NO", rowMap.get("PRESENTN_NO"));
            }
            
            
                    
            Map countMap =  sqlSession.getMapper(DrawbackDao.class).retrieve_CtrmTrgetThngCount(param);
            
            if(0 == StringUtil.null2zero(countMap.get("CNT"))) {    // 모든행이 삭제된경우 갑/병 정보까지 모두 삭제하여 초기화합니다.
                sqlSession.getMapper(DrawbackDao.class).init_CtrmRawmtrl(param);
                sqlSession.getMapper(DrawbackDao.class).init_CtrmCmmn(param);
            }else {
                sqlSession.getMapper(DrawbackDao.class).refresh_CtrmCmmn(param);    
            }
            
            rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
            
        } catch (Exception e) {
            //e.printStackTrace();
            rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
            throw new RuntimeException();
        }finally {

            
        }
        
        return rs;
        
    }
	
    
    
    /**
     * 분증 확정취소
     * @param paramList
     * @return
     * @throws Exception
     */
    @Transactional
    public Result cancel_DB00802_ConfirmProcess(Map param, List paramList){
        /*
         *  common.msg.en.saveok = 저장되었습니다.
            common.msg.en.savefail = 데이터를 저장할 수 없습니다.
         */
        Result rs = new Result();
        try {
            
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"), "N");
            
            int returnDataSuccess = 0;
            for(int inx = 0; inx < paramList.size(); inx++) {   // 을 Loop
                Map rawmtrlMap = (Map)paramList.get(inx);
                rawmtrlMap.put("COMPANY_CODE", StringUtil.null2String(param.get("COMPANY_CODE")));
                
                
                //분증 사용잔량 반환
                returnDataSuccess = sqlSession.getMapper(DrawbackDao.class).return_CtrmThingRawmtrl(rawmtrlMap);
                
                if(returnDataSuccess == 0) {
                    rs = super.getResult(false, "잔량데이터에 오류가 있습니다. (반환받을 데이터가 없습니다.)", new Object[] {});
                    throw new RuntimeException();
                }
                
                if("Y".equalsIgnoreCase(logEnable_Flag)) {
                    logger.debug("##### [ctrm.rawmtrl.return.log] 잔량 사용 로그 이력 저장 시작.");
                    // 잔량 사용이력 저장
                    Map<String, Object> historyMap = new HashMap<>();
                    
                    historyMap.put("COMPANY_CODE"  ,StringUtil.null2String(rawmtrlMap.get("COMPANY_CODE")));
                    historyMap.put("DIVISION_CODE" ,StringUtil.null2String(rawmtrlMap.get("DIVISION_CODE")));
                    historyMap.put("IMPDEC_NO"     ,StringUtil.null2String(rawmtrlMap.get("IMPDEC_NO")));
                    historyMap.put("LNE_NO"        ,StringUtil.null2String(rawmtrlMap.get("LNE_NO")));
                    historyMap.put("POUCH_NO"      ,StringUtil.null2String(rawmtrlMap.get("POUCH_NO")));
                    historyMap.put("ITEM_CODE"     ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_CODE")));
                    historyMap.put("USGQTY"        ,StringUtil.null2zero(rawmtrlMap.get("USGQTY")) * -1); // 반환이므로 음수처리
                    //잔량사용이력 저장 - USE_TYPE :: 사용형태(01:환급신청서, 02 기납증, 03 분증)
                    historyMap.put("USE_TYPE"      ,"03");
                    historyMap.put("PRESENTN_NO"   ,StringUtil.null2String(rawmtrlMap.get("PRESENTN_NO")));
                    historyMap.put("THNG_SEQ"      ,StringUtil.null2String(rawmtrlMap.get("SEQ")));
                    historyMap.put("RAWMTRL_SEQ"   ,StringUtil.null2String(rawmtrlMap.get("RAWMTRL_SEQ")));
                    historyMap.put("CREATE_BY"     ,StringUtil.null2String(param.get("CREATE_BY")));
                    
                    sqlSession.getMapper(DrawbackDao.class).createIncme_LocalBnt_History(historyMap);
                }else {
                    logger.debug("##### [ctrm.rawmtrl.return.log] 잔량 사용 로그 이력 사용 안함.");
                }
                
                sqlSession.getMapper(DrawbackDao.class).delete_CtrmThingRawmtrl(rawmtrlMap);
                param.put("DIVISION_CODE" ,rawmtrlMap.get("DIVISION_CODE"));
                param.put("PRESENTN_NO"   ,rawmtrlMap.get("PRESENTN_NO"));
            }
            
            
                    
            Map countMap =  sqlSession.getMapper(DrawbackDao.class).retrieve_CtrmTrgetThngCount(param);
            
            if(0 == StringUtil.null2zero(countMap.get("CNT"))) {    // 모든행이 삭제된경우 갑/병 정보까지 모두 삭제하여 초기화합니다.
                sqlSession.getMapper(DrawbackDao.class).init_CtrmCmmn(param);
            }else {
                sqlSession.getMapper(DrawbackDao.class).refresh_CtrmCmmn(param);    
            }
            
            rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
            
        } catch (Exception e) {
            //e.printStackTrace();
            rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
            throw new RuntimeException();
        }finally {

            
        }
        
        return rs;
        
    }
	
	
	
	
	/**
	 * 과다환급자진신고서 작성 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB009List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB009List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 과다환급금 자진신고서 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_00901Detail(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_00901Detail(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	
	/**
	 * 과다환급금 자진신고서 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Result merge_OverDrwbak_Document(Map<String, Object> param) throws Exception {
		Result rs = new Result();
		int processCount = 0;
		try {
			processCount = sqlSession.getMapper(DrawbackDao.class).merge_OverDrwbak_Document_Item(param);
			processCount += sqlSession.getMapper(DrawbackDao.class).merge_OverDrwbak_Document_Header(param);
			rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException(); // Spring에 던져준다
		}
		return rs;
	}
	
	
	/**
	 * 과다환급금 가산금액 산출(팝업) 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB009002List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		String tempStr = StringUtil.null2String(param.get("SEARCH_PRESENTN_NO"));
    		String [] tempArrStr = tempStr.split("\\^");
    		List searchPresentnNoList = new ArrayList<Map>();
    		for(int a = 0; a < tempArrStr.length; a++ ) {
    			Map rows = new HashMap<String, String>();
    			rows.put("OVER_DRWBAK_PRESENTN_NO", tempArrStr[a]);
    			searchPresentnNoList.add(rows);
    		}
    		param.put("OVER_DRWBAK_PRESENTN_NO_LIST", searchPresentnNoList);
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB009002List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	
	/**
     * 가산금액 지급신청서
     * @param param
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GridOutputData<Map<String, Object>> retrieve_DB010List(Map<String, Object> param) throws Exception {
		
		GridOutputData gridData = null;
		try {
			List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB010List(param);
			String pageParam = StringUtil.null2String(param.get("page"), "1");
			String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
			int page = Integer.parseInt(pageParam);
			int rows = Integer.parseInt(rowsParam);
			int total = 0;
			int listSize = null==list ? 0 : list.size();
			if(list != null && list.size() > 0 ){
				total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
			}
			logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
			gridData = new GridOutputData(list, page, rows, total);
		} catch (RuntimeException e) {
			//e.printStackTrace();
		}
		
		return gridData;
	}
	/**
	 * 가산금지급신청서 작성 및 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map retrieve_01001Detail(Map<String, Object> param) throws Exception {
		
		Map<String, Object> data = new HashMap();
		try {
			data = sqlSession.getMapper(DrawbackDao.class).retrieve_01001Detail(param);
		} catch (RuntimeException e) {
			//e.printStackTrace();
		}
		
		return data;
	}
	
	
	/**
	 * 제증명서 정정 취하 승인신청서 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB011List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB011List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 제증명서 정정 취하 승인신청서 제증명내역 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_DB01102Detail(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_DB01102Detail(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	
	
	
	
	/**
	 * 제증명서 정정 취하 승인신청서 작성
	 * @param param
	 * @param paramList
	 * @return
	 * @throws Exception 
	 */
	@Transactional
	public Result create_DB01102Detail(Map<String, Object> mcrtfUpdtWthdrw) throws RuntimeException{
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		
    		//정정 취하 신청서 MST 저장
    		sqlSession.getMapper(DrawbackDao.class).create_mcrtfUpdtWthdrwMst(mcrtfUpdtWthdrw);

    		//신청구분이 정정 일 경우 정정 취하 신청서 DTL 저장
    		if(mcrtfUpdtWthdrw.get("REQST_SE").equals("1")) {
    	    	ObjectMapper mapper = new ObjectMapper();
    	    	
    	    	//정정 취하 상세 기존 SEQ 조회
    	    	int seq = Integer.parseInt(sqlSession.getMapper(DrawbackDao.class).retrieve_mcrtfUpdtWthdrwDtlSeq(mcrtfUpdtWthdrw));

    	    	// 정정내용 String to List
    	    	List mcrtfUpdtWthdrwDtl = mapper.readValue((String)mcrtfUpdtWthdrw.get("dataList"), new TypeReference<List<Object>>(){});
    			
    			// 전달받은 갯수만큼 Loop
    			for(int inx = 0; inx < mcrtfUpdtWthdrwDtl.size(); inx++) {
    				Map rowMap = (Map)mcrtfUpdtWthdrwDtl.get(inx);

    				rowMap.put("COMPANY_CODE", mcrtfUpdtWthdrw.get("COMPANY_CODE"));
    				rowMap.put("DIVISION_CODE", mcrtfUpdtWthdrw.get("DIVISION_CODE"));
    				rowMap.put("KEY_MCRTF_PRESENTN_NO", mcrtfUpdtWthdrw.get("KEY_MCRTF_PRESENTN_NO"));
    				
    				if(StringUtil.isNull((String)rowMap.get("SEQ"))){
    					rowMap.put("PRE_SEQ_NUMBER", ++seq);
    				}
    				
    				sqlSession.getMapper(DrawbackDao.class).create_mcrtfUpdtWthdrwDtl(rowMap);
    				
    			}
    		}
    		
    		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException(); // Spring에 던져준다
		}
    	
    	return rs;
    	
    }
	
	
	
	
	
	
	/************************************************************************************/
	/**
	 * 수출확정버튼 클릭(가능한 수량만 만들기)
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public Result confirm_DB006_xportList_extn(Map param, List paramList){
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    	    
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"),"N");
            
            
    		boolean preCmmnExists = false; // 기생성된 신청서가 있는경우
    		
    		/** 001 - 전달받은 수출신고번호를 임시저장 테이블에 저장합니다. */ 
    		String mykey = UUID.randomUUID().toString();
    		
    		param.put("MY_KEY", mykey);
    		
    		for(int inx = 0; inx < paramList.size(); inx++) {
    			Map rowMap =  (Map)paramList.get(inx);
    			rowMap.putAll(param);
    			sqlSession.getMapper(DrawbackDao.class).create_Temp_xportList(rowMap);
    		}
    		
    		/** 002 - Check 한 목록의 Key List를 생성합니다. */
    		List<Map<String, Object>> checkedConfirm_List = sqlSession.getMapper(DrawbackDao.class).retrieve_CheckedConfirm_List(param); 
    		
    		String key_PresentnNo = "";
    		for(int inx = 0; inx < checkedConfirm_List.size(); inx++) {
    			Map rowMap =  (Map)checkedConfirm_List.get(inx);
    			rowMap.putAll(param);
    			sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    			List<Map<String, Object>> alreadyCmmnList = sqlSession.getMapper(DrawbackDao.class).retrieve_alreadyCmmnList(rowMap);
    			
    			if(alreadyCmmnList.size() == 0 ) {
    				/** 기존에 생성된 [갑]환급신청 이 없는 경우 갑지 생성*/
    				sqlSession.getMapper(DrawbackDao.class).create_Drawback_CMMN(rowMap);
    				
    				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
    				key_PresentnNo = StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO"));
    			}else {
    				preCmmnExists = true;
    				Map keyMap = alreadyCmmnList.get(0);
    				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
    			}
    			
    			/** [을] 환급신청 생성 */
    			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
    				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
    			}
    			rowMap.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			
    			sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_Thing_Temp(rowMap);
    			param.put("DIVISION_CODE", StringUtil.null2String(rowMap.get("DIVISION_CODE")));
    			//sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_THNG(rowMap);
    			//int pre_thng_seq_number = StringUtil.null2zero(rowMap.get("PRE_THNG_SEQ_NUMBER"));

    			
    			// 임시테이블에 저장한 데이터 조회 
    			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).retrivev_DrawbackData_ThingTEMP_List(rowMap);
    			int thing_create_count = 0;
    			
    			if(thingTEMP_List.size() > 0) {
     				for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
        				Map tmpRowMap = (Map)thingTEMP_List.get(ii);
        				tmpRowMap.putAll(rowMap);
        				//String incme_Local_Bnt_Yn = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Incme_Local_Bnt_Yn(tmpRowMap);
        				
        				/** 남은 잔량으로 생성할수 있는 환급신청서<을> 데이터의 수량을 조회*/
        				String tgt_Accmlt_OrderQty = sqlSession.getMapper(DrawbackDao.class).createAble_DrwBack_THNG_OrderQty(tmpRowMap);
        				if(tgt_Accmlt_OrderQty == null || "0".equals(tgt_Accmlt_OrderQty)) { // 셍성할 건수가 0 이면 <을> 생성하지 않고 다음 건으로 이동
        					continue;
        				}
        				thing_create_count++;	// 생성 건수 카운트
        				tmpRowMap.put("TGT_ACCMLT_ORDERQTY", tgt_Accmlt_OrderQty);
    					sqlSession.getMapper(DrawbackDao.class).create_DrwBack_THNG(tmpRowMap);
    					//사용한 bom version
    					sqlSession.getMapper(DrawbackDao.class).update_UsingBomVersion(tmpRowMap);
    					
    					/** 을지에 사용한 수량만큼 수출 마스터에 차감 */
    					sqlSession.getMapper(DrawbackDao.class).update_Export_Using_Qty(tmpRowMap);
    					
    					
    					int inserted_THNG_SEQ =  StringUtil.null2zero(tmpRowMap.get("PRE_THNG_SEQ_NUMBER"))+1;
    					// 해당 을지에 대한 병지 생성
    					tmpRowMap.put("INSERTED_THNG_SEQ", inserted_THNG_SEQ);	// 을지 생성에 사용한 시퀀스
    					
    					//List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Thing_Worktarget(tmpRowMap);
    					/***여기서부터 작업 ****/
    					/***여기서부터 작업 ****/
    					/***여기서부터 작업 ****/
    					/***여기서부터 작업 ****/
    					/***여기서부터 작업 ****/
    					/***여기서부터 작업 ****/
    					
    					
    					List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Thing_Worktarget_extn(tmpRowMap);
    					int create_IncmeRawmtrl_count = 0;
    					/**** [병] 기납증 생성 시작 ****/
    					for(int ix = 0; ix < thingWrokTargetList.size(); ix++) {
    	    				Map thingWrokTargetMap = thingWrokTargetList.get(ix);
    	    				thingWrokTargetMap.putAll(param);
    	    				create_IncmeRawmtrl_count = create_IncmeRawmtrl_count +  this.calcDrwBack_3rd(thingWrokTargetMap, logEnable_Flag);
    	    			} // for End
    					
    					
    					/*
        				if("Y".equalsIgnoreCase(incme_Local_Bnt_Yn)) {	// 잔량이 충분한 경우
        					
        					
        				}else {
        				    // TODO: 생성할 수 없는경우 사유관리에 저장합니다.
        				    tmpRowMap.put("LOCAL_BTN_RESULT", StringUtil.null2String(incme_Local_Bnt_Yn,"NULL"));
        				    
        				    sqlSession.getMapper(DrawbackDao.class).create_DoNotXportConfirmReasnon(tmpRowMap);
        				}
        				*/
        				
    				}
    			}
    			
    			/** 데이터 정리 */
    			param.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			
    			/** <병> 데이터가 없는 <을> 데이터를 삭제처리 */ 
    			sqlSession.getMapper(DrawbackDao.class).delete_ExistsIncmeRawmtrl_Trget_thng(param);
    			
    			/** 기존 관리번호가 없고 해당 관리번호로 생성된 <을> 데이터가 없는경우 <갑> 데이터를 삭제합니다. */
				int delCount_Cmnn = sqlSession.getMapper(DrawbackDao.class).delete_ExistsCmmn(param);
				
    			
				/** 삭제한 <갑> 데이터가 없다면 <을,병> 데이터가 정상이므로 <밥> 데이터를 갱신한다.*/
    			if(delCount_Cmnn == 0) {	
    				/**
        		     * 작성된 [병]을 이용하여 환급 세액을 계산하여 [갑]에 update 한다.
        		     */
        			sqlSession.getMapper(DrawbackDao.class).update_Drwbak_Cmmn(param);	
    			}
    			
    		}
    		
      		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
      		rs.setValue(key_PresentnNo);
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException();
		}finally {
			/** 임시 사용한 수출신고번호 데이터를 삭제합니다. */
			int delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_MyxportList(param);
    		
			delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    		if(delCount > 0 ) {
    			logger.debug("#### 임시데이터 삭제 : " + delCount + " 건");
    		}
    		
		}
    	
    	return rs;
    	
    }
	
	/**
	 * 수출확정버튼 클릭(가능한 수량만 만들기) - 일괄실행
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public Result confirm_DB006_xportList_extn2(Map param){
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    	    
            String logEnable_Flag = StringUtil.null2String(param.get("logEnable_Flag"),"N");
            
            
    		boolean preCmmnExists = false; // 기생성된 신청서가 있는경우
    		
    		/** 001 - 기간에 해당하는 수출신고번호를 임시저장 테이블에 저장합니다. */ 
    		String mykey = UUID.randomUUID().toString();
    		
    		param.put("MY_KEY", mykey);
    		sqlSession.getMapper(DrawbackDao.class).create_Temp_xport_FromToList(param);
    		
    		/*
    		for(int inx = 0; inx < paramList.size(); inx++) {
    			Map rowMap =  (Map)paramList.get(inx);
    			rowMap.putAll(param);
    			sqlSession.getMapper(DrawbackDao.class).create_Temp_xportList(rowMap);
    		}
    		*/ 
    		/** 002 - Check 한 목록의 Key List를 생성합니다. */
    		List<Map<String, Object>> checkedConfirm_List = sqlSession.getMapper(DrawbackDao.class).retrieve_CheckedConfirm_List(param); 
    		
    		String key_PresentnNo = "";
    		for(int inx = 0; inx < checkedConfirm_List.size(); inx++) {
    			Map rowMap =  (Map)checkedConfirm_List.get(inx);
    			//rowMap.putAll(param);
    			rowMap.put("MY_KEY", param.get("MY_KEY"));
    			sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    			List<Map<String, Object>> alreadyCmmnList = sqlSession.getMapper(DrawbackDao.class).retrieve_alreadyCmmnList(rowMap);
    			
    			if(alreadyCmmnList.size() == 0 ) {
    				/** 기존에 생성된 [갑]환급신청 이 없는 경우 갑지 생성*/
    				sqlSession.getMapper(DrawbackDao.class).create_Drawback_CMMN(rowMap);
    				
    				// 기존에 생성된 신청서가 없는 경우 새로 생성한 내부관리번호를 채번하여 사용
    				key_PresentnNo = StringUtil.null2String(rowMap.get("KEY_PRESENTN_NO"));
    			}else {
    				preCmmnExists = true;
    				Map keyMap = alreadyCmmnList.get(0);
    				key_PresentnNo = StringUtil.null2String(keyMap.get("PRESENTN_NO"));
    			}
    			
    			/** [을] 환급신청 생성 */
    			if("".equalsIgnoreCase(key_PresentnNo) || key_PresentnNo == null) {
    				throw new RuntimeException("내부관리번호를 사용할 수 없습니다.");
    			}
    			rowMap.put("KEY_PRESENTN_NO", key_PresentnNo);
    			
    			
    			sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_Thing_Temp(rowMap);
    			param.put("DIVISION_CODE", StringUtil.null2String(rowMap.get("DIVISION_CODE")));
    			//sqlSession.getMapper(DrawbackDao.class).create_DrawbackData_THNG(rowMap);
    			//int pre_thng_seq_number = StringUtil.null2zero(rowMap.get("PRE_THNG_SEQ_NUMBER"));

    			
    			// 임시테이블에 저장한 데이터 조회 
    			List<Map<String, Object>> thingTEMP_List = sqlSession.getMapper(DrawbackDao.class).retrivev_DrawbackData_ThingTEMP_List(rowMap);
    			int thing_create_count = 0;
    			
    			if(thingTEMP_List.size() > 0) {
    				for(int ii = 0; ii < thingTEMP_List.size(); ii++) {
        				Map tmpRowMap = (Map)thingTEMP_List.get(ii);
        				tmpRowMap.putAll(rowMap);
        				//String incme_Local_Bnt_Yn = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Incme_Local_Bnt_Yn(tmpRowMap);
        				
        				
        				/** 남은 잔량으로 생성할수 있는 환급신청서<을> 데이터의 수량을 조회*/
        				String tgt_Accmlt_OrderQty = sqlSession.getMapper(DrawbackDao.class).createAble_DrwBack_THNG_OrderQty(tmpRowMap);
        				
        				if(tgt_Accmlt_OrderQty == null || "0".equals(tgt_Accmlt_OrderQty)) { // 셍성할 건수가 0 이면 <을> 생성하지 않고 다음 건으로 이동
        					continue;
        				}
        				thing_create_count++;	// 생성 건수 카운트
        				
        				tmpRowMap.put("TGT_ACCMLT_ORDERQTY", tgt_Accmlt_OrderQty);
    					sqlSession.getMapper(DrawbackDao.class).create_DrwBack_THNG(tmpRowMap);
    					
    					//사용한 bom version
    					sqlSession.getMapper(DrawbackDao.class).update_UsingBomVersion(tmpRowMap);
    					
    					/** 을지에 사용한 수량만큼 수출 마스터에 차감 */
    					sqlSession.getMapper(DrawbackDao.class).update_Export_Using_Qty(tmpRowMap);
    					
    					    					
    					
    					int inserted_THNG_SEQ =  StringUtil.null2zero(tmpRowMap.get("PRE_THNG_SEQ_NUMBER"))+1;
    					// 해당 을지에 대한 병지 생성
    					tmpRowMap.put("INSERTED_THNG_SEQ", inserted_THNG_SEQ);	// 병지 생성에 사용한 시퀀스
    					
    					//List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Thing_Worktarget(tmpRowMap);
    					List<Map<String, Object>> thingWrokTargetList = sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_Thing_Worktarget_extn(tmpRowMap);
    					int create_IncmeRawmtrl_count = 0;
    					
    					/**** [병] 기납증 생성 시작 ****/
    					for(int ix = 0; ix < thingWrokTargetList.size(); ix++) {
    	    				Map thingWrokTargetMap = thingWrokTargetList.get(ix);
    	    				///////thingWrokTargetMap.putAll(param);
    	    				create_IncmeRawmtrl_count = create_IncmeRawmtrl_count +  this.calcDrwBack_3rd(thingWrokTargetMap, logEnable_Flag);
    	    			} // for End
    					
    					/*
        				if("Y".equalsIgnoreCase(incme_Local_Bnt_Yn)) {	// 잔량이 충분한 경우
        					
        					
        				}else {
        				    // TODO: 생성할 수 없는경우 사유관리에 저장합니다.
        				    tmpRowMap.put("LOCAL_BTN_RESULT", StringUtil.null2String(incme_Local_Bnt_Yn,"NULL"));
        				    
        				    sqlSession.getMapper(DrawbackDao.class).create_DoNotXportConfirmReasnon(tmpRowMap);
        				}
        				*/
        				
    				}
    			}
    			
    			/** 데이터 정리 */
    			param.put("KEY_PRESENTN_NO", key_PresentnNo);
    			/** <병> 데이터가 없는 <을> 데이터를 삭제처리 */ 
    			sqlSession.getMapper(DrawbackDao.class).delete_ExistsIncmeRawmtrl_Trget_thng(param);
    			
    			/** 기존 관리번호가 없고 해당 관리번호로 생성된 <을> 데이터가 없는경우 <갑> 데이터를 삭제합니다. */
				int delCount_Cmnn = sqlSession.getMapper(DrawbackDao.class).delete_ExistsCmmn(param);
				
    			
				/** 삭제한 <갑> 데이터가 없다면 <을,병> 데이터가 정상이므로 <밥> 데이터를 갱신한다.*/
    			if(delCount_Cmnn == 0) {	
    				/**
        		     * 작성된 [병]을 이용하여 환급 세액을 계산하여 [갑]에 update 한다.
        		     */
        			sqlSession.getMapper(DrawbackDao.class).update_Drwbak_Cmmn(param);	
    			}
    			
    			
    		}
    		
      		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException();
		}finally {
			/** 임시 사용한 수출신고번호 데이터를 삭제합니다. */
			int delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_MyxportList(param);
    		
			delCount = sqlSession.getMapper(DrawbackDao.class).delete_Temp_Things_List(param);
    		if(delCount > 0 ) {
    			logger.debug("#### 임시데이터 삭제 : " + delCount + " 건");
    		}
    		
		}
    	
    	return rs;
    	
    }
	/************************************************************************************/
	
	
	/**
	 * 기간별 배치 수행 시 시작 종료 로그 생성용
	 * @since 2020.05.20
	 * @param p_Row
	 * @param logFlag
	 * @return
	 */
	public int createMonthly_StartEnd_logs(Map param, String p_Work) {
		param.put("WORK", p_Work);
		return sqlSession.getMapper(DrawbackDao.class).createMonthly_StartEnd_logs(param);
	}
	
	
	
	/**
	 * 기간별 환급신청서 생성시 월단위 작업 리스트 추출
	 * @since 2020.05.20
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map<String, Object>> retrieve_Drwbak_TargetMonthList(Map<String, Object> param) throws Exception {
    	
    	return sqlSession.getMapper(DrawbackDao.class).retrieve_Drwbak_TargetMonthList(param);
    }
	
	
	
	/**
	 * 조견표 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB012List(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB012List(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }

	
	/**
	 *조견표(팝업) - 상세조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Map retrieve_DB01201DetailList(Map<String, Object> param) throws Exception {
    	
		Map<String, Object> data = new HashMap();
    	try {
    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_DB01201DetailList(param);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return data;
    }
	

	
	/**
	 * 조견표(팝업) - 기납증 or 환급신청서 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB01201RegistRceptList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB01201RegistRceptList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }
	
	/**
	 * 조견표(팝업) - 원재료 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public GridOutputData<Map<String, Object>> retrieve_DB01201RegistRcepMaterialtList(Map<String, Object> param) throws Exception {
    	
    	GridOutputData gridData = null;
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB01201RegistRcepMaterialtList(param);
    		String pageParam = StringUtil.null2String(param.get("page"), "1");
    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
    		int page = Integer.parseInt(pageParam);
    		int rows = Integer.parseInt(rowsParam);
    		int total = 0;
    		int listSize = null==list ? 0 : list.size();
    		if(list != null && list.size() > 0 ){
    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
    		}
    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
    		gridData = new GridOutputData(list, page, rows, total);
    	} catch (RuntimeException e) {
    		//e.printStackTrace();
    	}
    	
    	return gridData;
    }

	
	/**
	 * * 조견표(팝업) 저장
	 * @param param
	 * @param paramList
	 * @return
	 * @throws Exception 
	 */
	@Transactional
	public Result update_DB01201DetailList(Map<String, Object> param) throws RuntimeException{
    	/*
    	 *  common.msg.en.saveok = 저장되었습니다.
    		common.msg.en.savefail = 데이터를 저장할 수 없습니다.
    	 */
    	Result rs = new Result();
    	try {
    		
    		//조건표 HDR 저장
    		sqlSession.getMapper(DrawbackDao.class).update_DB01201DetailList_HDR(param);
    	
    		if(!StringUtil.isNull((String)param.get("PRESENTN_NO"))) {
    			//조건표 ITEM 저장
        		sqlSession.getMapper(DrawbackDao.class).delete_DB01201DetailList_ITEM(param);
        	}
    	
    		//조건표 ITEM 저장
    		List itemList = (List) param.get("ITEM_LIST");
    		
    		for( int i =0 ; i < itemList.size(); i++) {
    			Map<String, Object>  itemMap = (Map<String, Object>) itemList.get(i);
    			
    			if(StringUtil.isNull((String)param.get("PRESENTN_NO"))) {
    				itemMap.put("PRESENTN_NO", param.get("NEW_PRESENTN_NO"));
        		}else {
        			itemMap.put("PRESENTN_NO", param.get("PRESENTN_NO"));
            	}
    			itemMap.put("SEQ", i+1);
    			sqlSession.getMapper(DrawbackDao.class).update_DB01201DetailList_ITEM(itemMap);
    		    			
    		}
    		
    		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
    		
		} catch (Exception e) {
			//e.printStackTrace();
			rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
			throw new RuntimeException(); // Spring에 던져준다
		}
    	
    	return rs;
    	
    }
	
	/**
   	 * 관세청 수신 상태 유효 정보 조회
   	 * 
   	 * @param paramList
   	 * @return
   	 * @throws Exception
   	 */
       public Result get_unipass_status_count(Map<String, Object> param) throws Exception {	
    	   Result rs = null;
    	
    	try {
    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).get_unipass_status_count(param);
    		rs = super.getResult(true, "common.msg.en.saveok", new Object[] {}); // 3번째 인자 역할?
    		rs.setValue(list);
    	} catch (RuntimeException e) {
    		rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
    		throw new RuntimeException(); // Spring에 던져준다
    	}
    	
    	return rs;
     }
       
       /**
		 * 관세청 접수통보 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
	    public Map<String, Object> retrieve_unipass_status_notification(Map<String, Object> param) throws Exception {	
	    	Map<String, Object> data = null;
	    	
	    	try {
	    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_notification(param);
	    	} catch (RuntimeException e) {
	    		
	    	}
	    	
	    	return data != null? data : new HashMap<String, Object>();
	    }
	
	  /**
		 * 관세청 오류통보 master 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
	    public Map<String, Object> retrieve_unipass_status_error_master(Map<String, Object> param) throws Exception {	
	    	Map<String, Object> data = null;
	    	
	    	try {
	    		data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_error_master(param);
	    	} catch (RuntimeException e) {
	    		
	    	}
	    	
	    	return data != null? data : new HashMap<String, Object>();
	    }
	    
		/**
		 * 관세청 오류통보 detail 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
		public GridOutputData<Map<String, Object>> retrieve_unipass_status_error_details(Map<String, Object> param) throws Exception {
			GridOutputData gridData = null;

			try {
				List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_error_details(param);
				gridData = new GridOutputData(list, param);
			} catch (RuntimeException e) {

			}

			return gridData;
		}
		
		/**
		 * 관세청 보완통보 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
		public Map<String, Object> retrieve_unipass_status_complement(Map<String, Object> param) throws Exception {
			Map<String, Object> data = null;

			try {
				data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_complement(param);
			} catch (RuntimeException e) {

			}

			return data;
		}

		/**
		 * 관세청 자료제출요구통보 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
		public Map<String, Object> retrieve_unipass_status_request(Map<String, Object> param) throws Exception {
			Map<String, Object> data = null;

			try {
				data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_request(param);
			} catch (RuntimeException e) {

			}

			return data;
		}

		/**
		 * 관세청 완료통보 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
		public Map<String, Object> retrieve_unipass_status_complete(Map<String, Object> param) throws Exception {
			Map<String, Object> data = null;

			try {
				data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_complete(param);
			} catch (RuntimeException e) {

			}

			return data;
		}

		/**
		 * 관세청 지급통보 조회
		 * 
		 * @param paramList
		 * @return
		 * @throws Exception
		 */
		public Map<String, Object> retrieve_unipass_status_payment(Map<String, Object> param) throws Exception {
			Map<String, Object> data = null;

			try {
				data = sqlSession.getMapper(DrawbackDao.class).retrieve_unipass_status_payment(param);
			} catch (RuntimeException e) {

			}

			return data;
		}
		
		
		/**
	     * 
	     * @param param
	     * @return
	     * @throws Exception
	     */
	    @Transactional
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Result merge_adamtData(Map<String, Object> param) throws Exception {
			Result rs = new Result();
			int processCount = 0;
			try {
				if("I".equalsIgnoreCase(StringUtil.null2String(param.get("WORK_TYPE")))) {
					// hdr 생성후
					processCount = sqlSession.getMapper(DrawbackDao.class).merge_Adamt_MasterData(param);
					param.put("PRESENTN_NO", param.get("KEY_PRESENTN_NO"));
				}else {
					//상세 삭제 후 
					processCount = sqlSession.getMapper(DrawbackDao.class).delete_Adamt_DetailData(param);
				}
				
				// 상세 넣음
				List<Map<String,Object>> adamtList = (List<Map<String,Object>>)param.get("ADAMT_LIST");
				for(int inx = 0; inx < adamtList.size(); inx++) {
					Map rowMap = adamtList.get(inx);
					rowMap.putAll(param);
					processCount += sqlSession.getMapper(DrawbackDao.class).insert_Adamt_DetailData(rowMap);	
				}
				// 세액 업데이트
				processCount += sqlSession.getMapper(DrawbackDao.class).update_Adamt_MasterTaxData(param);
				
				
				rs = super.getResult(true, "common.msg.en.saveok", new Object[] {});
	    		
			} catch (Exception e) {
				//e.printStackTrace();
				rs = super.getResult(false, "MSG_UNSPECIFIED_EN_ERROR", new Object[] {});
				throw new RuntimeException(); // Spring에 던져준다
			}
			return rs;
		}
	       
	    
	    
	    public GridOutputData<Map<String, Object>> retrieve_adamtDetailData(Map<String, Object> param) throws Exception {	
			GridOutputData gridData = null;
	    	
	    	try {
	    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_adamtDetailData(param);
	    		gridData = new GridOutputData(list, param);
	    	} catch (RuntimeException e) {
	    		
	    	}
	    	
	    	return gridData;
	    }
	    
		/**
		 * 기납증 연관 매출 데이터 조회 
		 * @param param
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
	    public GridOutputData<Map<String, Object>> retrieve_DB00803_trget(Map<String, Object> param) throws Exception {
	    	
	    	GridOutputData gridData = null;
	    	try {
	    		List<Map<String, Object>> list = sqlSession.getMapper(DrawbackDao.class).retrieve_DB00803_trget(param);
	    		String pageParam = StringUtil.null2String(param.get("page"), "1");
	    		String rowsParam = StringUtil.null2String(param.get("rows"), String.valueOf(SystemConstant.EXCEL_MAX_ROWS));
	    		int page = Integer.parseInt(pageParam);
	    		int rows = Integer.parseInt(rowsParam);
	    		int total = 0;
	    		int listSize = null==list ? 0 : list.size();
	    		if(list != null && list.size() > 0 ){
	    			total = Integer.parseInt(list.get(0).get("TOTAL_RECORDS").toString());
	    		}
	    		logger.debug("<조회결과> total = " + total + ", 목록수 = " + listSize);
	    		gridData = new GridOutputData(list, page, rows, total);
	    	} catch (RuntimeException e) {
	    		//e.printStackTrace();
	    	}
	    	
	    	return gridData;
	    }
	
}


