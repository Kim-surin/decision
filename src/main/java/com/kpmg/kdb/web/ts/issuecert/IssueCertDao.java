package com.kpmg.kdb.web.ts.issuecert;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface IssueCertDao {
	
	/**
	 * 고객사 자재관리 목록 데이터 조회
	 * @param param
	 * @return
	 */
	public List retrieveCooIssueCertList(Map param);
	
	/**
	 * 선택한 판정결과를 이용하여 고객사 정보를 조회
	 * 증명서 발급버튼
	 * @param param
	 * @return
	 */
	public Map retrieveCooIssueTargetCustomerInfo(Map param);
	
	/**
	 * 선택한 판정결과를 이용하여 발급 대상 목록을 조회
	 * 증명서 발급버튼
	 * @param param
	 * @return
	 */
	public List retrieveCooIssueTargetList(Map param);
	
	/**
	 * 증명서/증명서 번호 생성
	 * @param param
	 * @return
	 */
	public String makeCooCertifyNo(Map param);
	
	
	/**
	 * 포괄증명서 마스터 등록
	 * @param param
	 * @return
	 */
	public int insertCooCertifyLedger(Map param);
	
	/**
	 * 포괄증명서 마스터 등록
	 * @param param
	 * @return
	 */
	public int insertCooCertifyLedgerDtl(Map param);
	
	
	/**
     * 매출마스터 증명서 정보 수정
     * @param param
     * @return
     */
    int updateSalesMst(Map<String, Object> param);

    /**
     * 생산매출마스터 증명서 정보 수정
     * @param param
     * @return
     */
    int updateProdSalesMst(Map<String, Object> param);

    /**
     * 매출상세 증명서 정보 수정
     * @param param
     * @return
     */
    int updateSalesDtl(Map<String, Object> param);

    /**
     * 생산매출상세 증명서 정보 수정
     * @param param
     * @return
     */
    int updateProdSalesDtl(Map<String, Object> param);
    
    /**
     * 증명서 기준 원산지 판정 마스터 삭제
     * @param param
     * @return
     */
    int deleteFcrMst(Map<String, Object> param);

    /**
     * 증명서 기준 원산지 판정 상세 삭제
     * @param param
     * @return
     */
    int deleteFcrDtl(Map<String, Object> param);

    /**
     * 증명서 기준 원산지 판정 결과 삭제
     * @param param
     * @return
     */
    int deleteFcrResult(Map<String, Object> param);

    /**
     * 증명서 기준 원산지 판정 마스터 등록
     * @param param
     * @return
     */
    int insertFcrMst(Map<String, Object> param);

    /**
     * 증명서 기준 원산지 판정 상세 등록
     * @param param
     * @return
     */
    int insertFcrDtl(Map<String, Object> param);

    /**
     * 증명서 기준 원산지 판정 결과 등록
     * @param param
     * @return
     */
    int insertResult(Map<String, Object> param);
	
    
    /**
     * 포괄 증명서 발급 > 중복체크
     * @param param
     * @return
     */
    public int checkDuplicateCertifyNo(Map param);
	
    
    
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서상세 팝업 > 그리드 데이터 조회
	 * 증명서 발급버튼
	 * @param param
	 * @return
	 */
	public List retrieveIssuedCertList(Map param);
	
	
	/**
	 * FTA C/O 발급 > 증명서 발급 > 증명서 상세 > 증명서 수정 발급 (대상 데이터 조회 포함)
	 * @param param
	 * @return
	 */
	public Map selectCooFcrMstOne(Map param);
	
	
	/**
	 * 수정발급 대상 데이터 조회 
	 * @param param
	 * @return
	 */
	public List retrieveCooModifyCertList(Map param);
	
	
    /**
     * 증명서 수정발급 후 히스토리 입력
     * @param param
     * @return
     */
    int insertIssuHistory(Map<String, Object> param);
}


