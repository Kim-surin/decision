package com.kpmg.kdb.web.home;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.configuration.ConstantBox;
import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.util.HttpUtils;
import com.kpmg.kdb.util.StringUtil;



/**
 * 홈 경로 관련 처리 서비스 클래스
 *  
 * @author  Damned Cat
 * @since   2016-08-01
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class HomeService extends GeneralService {

	static Logger logger = LoggerFactory.getLogger(HomeService.class);
    
	public static final String KEY_LOG_SEQ = "LOG_SEQ";
	public static final String KEY_DEFAULT_LANGUAGE = "DEFAULT_LANGUAGE";
	public static final String KEY_SE_PRODUCT_ASSETS_TYPE = "SE_PRODUCT_ASSETS_TYPE";
	public static final String KEY_SE_PART_ASSETS_TYPE = "SE_PART_ASSETS_TYPE";
	public static final String KEY_CREATE_BY = "CREATE_BY";
	public static final String KEY_UPDATE_BY = "UPDATE_BY";
	public static final String KEY_S_CERTIFY_TYPE = "S_CERTIFY_TYPE";
	public static final String KEY_SE_DIVISION_CODE = "SE_DIVISION_CODE";
	
    /**
     * @description : 사용자의 사용 가능여부를 리턴
     * @since : 2016.01.01
     * @param param
     * @return
     */
    public Result retrieveUserCheck(Map<String, Object> param) throws Exception {
    	
    	Result result = new Result();
    	Map resultMap = sqlSession.getMapper(HomeDao.class).retrieveUserCheck(param);
    	int loginCnt = Integer.parseInt(String.valueOf(resultMap.get("login_cnt")));
    	
    	result.setValue(resultMap);
        return result;
    }
    
    /**
     * 사용자 정보 조회
     * 
     * @param    param    입력파라미터
     * @return   사용자정보(1건)
     */
    public Map retrieveLoginUserInfo(Map param) {
        return sqlSession.getMapper(HomeDao.class).retrieveLoginUserInfo(param);
    }
    

    /**
     * Menu Data를 조회한다.
     * @since : 2016.01.01
     * @param param
     * @return
     * @throws Exception 
     */
 /*   public Result retrieveLeftMenu(Map<String, Object> param) throws Exception {
    	Result result = new Result();
    	@SuppressWarnings({ "rawtypes" })  
    	List<Map> resultList = sqlSession.getMapper(HomeDao.class).retrieveLeftMenu(param);
    	
    	result.setValue(super.convertTreeJsonString(resultList, "PARENT_ID", "ID", 2));
    	
        return result;
    }*/
    /**
     * 로그인 처리
     * 
     * @param     param         화면입력파라미터맵
     * @param     session       세션객체
     * @return    로그인 결과객체(세션정보 포함됨)
     */
	public Result retrieveLoginUserInfo(Map param, HttpSession session, boolean isAutoLogin) {
        logger.debug("[LOGIN] 입력파라미터 : {}", param);
        
        //1. 사용자 조회
        Map userMap = this.retrieveLoginUserInfo(param);
        logger.debug("[LOGIN] USER INFO : {}", userMap);
        
        if (null==userMap || userMap.isEmpty()) {
            logger.warn("[LOGIN] NO USER! param : {}", param);
            return super.getResult(false, "MSG_NOT_FOUND_USER", new Object[] {} ); //
        }
        
        //login log 저장
        sqlSession.getMapper(HomeDao.class).insertLogMgrMst(param);
        String logSeq = StringUtil.null2String(param.get(KEY_LOG_SEQ));
        userMap.put(KEY_LOG_SEQ, logSeq);
        
        String defaultLanguage = StringUtil.null2String(userMap.get(KEY_DEFAULT_LANGUAGE), "ENG");
        userMap.put(KEY_DEFAULT_LANGUAGE, defaultLanguage);
        
        userMap.put(KEY_SE_PRODUCT_ASSETS_TYPE,  ConstantBox.productAssetsType); // 자가생산품
        userMap.put(KEY_SE_PART_ASSETS_TYPE,     ConstantBox.partAssetsType); // 투입자재
        userMap.put(KEY_CREATE_BY,               userMap.get("USER_ID"));
        userMap.put(KEY_UPDATE_BY,               userMap.get("USER_ID"));
        userMap.put(KEY_S_CERTIFY_TYPE,          "internal");
        
        String divisionCode = StringUtil.null2String(userMap.get("DIVISION_CODE"));
        userMap.put(KEY_SE_DIVISION_CODE, divisionCode);
        
        Locale loc = Locale.getDefault();
        userMap.put("DEFAULT_LANGUAGE", loc.toString());
        
        //00. 세션에 데이터 저장
        HttpUtils.setSessionData(session, userMap);
        
        
        
        Result result = super.getResult(true, "MSG_APPLICATION_SUCCESS", new Object[] {}); //
        result.setValue(userMap);

        return result;
    }
	
    public Result retrieveLoginUserInfo(Map param, HttpSession session) {
        return this.retrieveLoginUserInfo(param, session, false);
    }

    
    /**
     * 사용가능한 메뉴 리스트를 리턴합니다.
     * @param param
     * @return
     */
    public List<Map> retrieveAllMenuList(Map param){
    	return sqlSession.getMapper(HomeDao.class).retrieveAllMenuList(param); 
    }
}
