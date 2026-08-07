package com.kpmg.kdb.web.ts.basis;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface BasisDao {
	
	/**
     * @description : 
     * @since : 2025.04
     * @param param
     * @return
     */
    
	public Map start_TestSql(Map param);
	
	
	/**
	 * 회사관리 - 왼쪽 트리 목록 조회
	 * @param param
	 * @return
	 */
	public List retrieveCompanyDivisionList(Map param);
	
	
	/**
	 * 회사관리 - 회사  1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	public Map retrieveCompanyFormData(Map param);
	
	/**
	 * 회사관리 - 플렌트 1건 정보 조회 (폼데이터 용)
	 * @param param
	 * @return
	 */
	public Map retrieveDivisionFormData(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  회사
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromCompany(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  플랜트
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromDivision(Map param);
	
	
	/**
	 * 회사관리 - 회사 버퍼 설정 - 회사 버퍼 설정 기준 값 :  협정
	 * @param param
	 * @return
	 */
	public List retrieveBufferFromFTA(Map param);
	
	
	/**
	 * 회사관리 - 회사 기본정보 저장
	 * @param param
	 * @return
	 */
	public int updateCompanyFormData(Map param);
	
	
	/**
	 * 회사관리 - 플랜트 기본정보 저장
	 * @param param
	 * @return
	 */
	public int updateDivisionFormData(Map param);
	
	/**
	 * 회사관리 - 인증수출자 정보 저장
	 * @param param
	 * @return
	 */
	public int updateCertificationInfo(Map param);
	
	
	/**
	 * 회사관리 - 수불부 사용 여부 옵션 정보 저장
	 * @param param
	 * @return
	 */
	public int updateCompanyMaOption(Map param);
	
	/**
	 * 회사관리 - 회사버퍼 옵션 정보 저장
	 * @param param
	 * @return
	 */
	public int updateCompanyOptionValue(Map param);
	
	/**
	 * 회사관리 - 회사버퍼 정보 저장
	 * @param param
	 * @return
	 */
	public int updateCompanyBuffer(Map param);
	
	/**
	 * 회사관리 - 플랜트 버퍼 정보 저장
	 * @param param
	 * @return
	 */
	public int updateDivisionBuffer(Map param);
	
	/**
	 * 회사관리 - FTA 협정 버퍼 정보 저장
	 * @param param
	 * @return
	 */
	public int updateAgreementBuffer(Map param);
	
	
	/**
	 * 사용자관리 - 목록조회
	 * @param param
	 * @return
	 */
	public List retrieveUserinfoList(Map param);
	
	
	/**
	 * 서명파일 이미지 조회 img src 용도 
	 * @param param
	 * @return
	 */
	public Map getSignatureByUserId(Map param);
	
	
	/**
	 * 사용자관리 - 사용자 상세
	 * @param param
	 * @return
	 */
	public Map retrieveUserinfoDetail(Map param);
	
	/**
	 * 사용자관리 - 서명권자 정보
	 * @param param
	 * @return
	 */
	public Map retrieveSignatureInfo(Map param);
	
	
	int selectUserCount(Map<String, Object> param);
	
	
	int insertUserInfo(Map<String, Object> param);
	int updateUserInfo(Map<String, Object> param);
	int selectSignatureCount(Map<String, Object> param);
	
	
	int insertSignatureInfo(Map<String, Object> param);
	int updateSignatureInfo(Map<String, Object> param);
	
	int updateSignatureImage(Map<String, Object> param);
	int selectNextSignatureSeq(Map<String, Object> param);

	
	
	/**
	 * 사용자관리 - 서명권자 중복 체크
	 * @param param
	 * @return
	 */
	public int checkDuplicateUserId(Map param);
	
	/**
	 * 사용자관리 - 서명권자 해지
	 * @param param
	 * @return
	 */
	public int cancelUserSignatureInfo(Map param);
	
	
	/**
	 * 자재관리 - 목록조회
	 * @param param
	 * @return
	 */
	public List retrieveItemList(Map param);
	
	
	/**
	 * 사용자관리 - 목록조회
	 * @param param
	 * @return
	 */
	public Map retrieveMissingHsCodeCount(Map param);

	
	
	/**
	 * 자재관리 - 상세 - 마스터정보 조회
	 * @param param
	 * @return
	 */
	public List retrieveItemDetailMasterInfo(Map param);
	
	/**
	 * 자재관리 - 상세 - 목록조회
	 * @param param
	 * @return
	 */
	public List retrieveItemDetailList(Map param);
	
	/**
	 * 자재관리 - 상세 - 목록조회
	 * @param param
	 * @return
	 */
	public int checkHsCodeExists(Map param);
	
	/**
	 * 
	 * @param param
	 * @return
	 */
	public int updateItemHsCode(Map param);
	
	
	/**
	 * 자재관리 - 상세 - 마스터정보 조회
	 * @param param
	 * @return
	 */
	public Map retrieveHsCodeDetail(Map param);
	
	/**
	 * 자재관리 - 협정별  hscode 팝업 데이터 리스트 조회
	 * @param param
	 * @return
	 */
	public List retrieveAgreementHsCodeList(Map param);
	
	
	/**
	 * 자재관리 - 국가별 hscode 팝업 데이터 리스트 조회
	 * @param param
	 * @return
	 */
	public List retrieveNationHsCodeList(Map param);
}


