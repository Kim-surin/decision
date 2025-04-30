package com.kpmg.kdb.web.home;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author D.Cat
 */
public interface HomeDao {
	
	/**
     * @description : 사용자의 사용 가능여부를 리턴
     * @since : 2016.01.01
     * @param param
     * @return
     */
    public Map retrieveUserCheck(Map param);
	
    /**
     * 사용자 정보 1건 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
    public Map retrieveLoginUserInfo(Map param);
    
    /**
     * Menu Data를 조회한다.
     * @since : 2016.01.01
     * @param param
     * @return
     */
    public List<Map> retrieveLeftMenu(Map param);
	
    /**
     * Menu Data를 조회한다.
     * @since : 2016.01.01
     * @param param
     * @return
     */
    public List<Map> retrieveAllMenuList(Map param);

    /**
     * LOGIN LOG
     * @param param
     * @return
     */
    public int insertLogMgrMst(Map param);
    
    
    /**
     * 로그인 : 플랜트 목록 조회 
     * @param param
     * @return
     */
    public List<Map> retrieveDivisionList(Map param);
}