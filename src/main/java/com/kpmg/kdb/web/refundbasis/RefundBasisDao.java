package com.kpmg.kdb.web.refundbasis;

import java.util.List;
import java.util.Map;


/**
 * 로그인처리 등 홈페이지 기본처리 DAO
 * 
 * @author Damned Cat
 */
public interface RefundBasisDao {
	
    /**
     * 수입정보 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieveRB002Grid(Map param);
	
	
	/**
     * 수입신고 상세
     * @param param
     * @return
     */
	public Map retrieveImpDetail(Map<String, Object> param);
	
	/**
	 * 수입신고 상세 란목록
	 * @param param
	 * @return
	 */
	public List<Map> retrieveImpDetail_LneList(Map param);
	
	
	/**
	 * 수입신고 상세 행목록
	 * @param param
	 * @return
	 */
	public List<Map> retrieveImpDetail_PouchList(Map param);
	
	/**
     * 수출정보  조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieveRB009Grid(Map param);
	
	/**
     * 수출신고 상세
     * @param param
     * @return
     */
	public Map retrieveExpDetail(Map<String, Object> param);
	
	/**
	 * 수출신고 데이터 상세 란/행 목록
	 * @param param
	 * @return
	 */
	public List<Map> retrieveExpDetail_Lne(Map param);
	
	/**
	 * 부산물비율  조회
	 * 
	 * @param     param 입력파라미터맵
	 * @return    조회된 정보
	 */
	public List<Map> retrieveRB010Grid(Map param);
	
	/**
	 * 생산일자  조회
	 * 
	 * @param     param 입력파라미터맵
	 * @return    조회된 정보
	 */
	public List<Map> retrieveRB011Grid(Map param);
	
	/**
	 * 월별수입물품집계  조회
	 * 
	 * @param     param 입력파라미터맵
	 * @return    조회된 정보
	 */
	public List<Map> retrieveRB012Grid(Map param);
	
	/**
	 * 연간수입물량집계  조회
	 * 
	 * @param     param 입력파라미터맵
	 * @return    조회된 정보
	 */
	public List<Map> retrieveRB013Grid(Map param);
	
	/**
     * Po Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectPoList(Map param);
	
    /**
     * Sales Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectSalesList(Map param);
    
    /**
     * Material Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectMaterialList(Map param);
    
    /**
     * BOM Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> retrieveBomList(Map param);
    
    /**
     * BOM Item Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectItemList(Map param);
    
    
    /**
     * 저장된 간이정액환급 정보를 조회한다.
     * @param param
     * @return
     */
    public List<Map> retrieveRefundBasis_014(Map param);
    
    public int mergeRefundBasis_014(Map param);
    
    public int deleteRefundBasis_014(Map param);
    
    /**
     * 저장된 간이정액환급 정보를 조회한다.
     * @param param
     * @return
     */
    public List<Map> retrieveRefundBasis_015(Map param);
    
    public List<Map> retrieve_RB015_YearCodeList(Map param);
    
    public int mergeRefundBasis_015(Map param);
    
    public int deleteRefundBasis_015(Map param);
    
    /**
     * 거래처 관리
     * @param param
     * @return
     */
    public List<Map> retrieveRefundBasis_016(Map param);
    
    
    
    /**
     * 업로드전 임시테이블 데이터 삭제
     * @param param
     * @return
     */
    public int deleteExcelUploadTemp(Map param);
    
 
    /**
     * 업로드전 기존 수출 데이터 체크
     * @param param
     * @return
     */
    public String retrievePreDataCheckForExport(Map param);
    
    /**
     * 업로드전 기존 수입 데이터 체크
     * @param param
     * @return
     */
    public String retrievePreDataCheckForImport(Map param);
    
    
    /**
     * 엑셀업로드 임시데이터 Insert
     * @param param
     * @return
     */
    public int insertTempImportExcelData(Map param);
 
    
    /**
     * 입력한 날짜 이외의 데이터가 들어있는지 체크
     * @param param
     * @return
     */
    public int updateUploadDataCheck_ImpAnotherMonth(Map param);
    public int updateUploadDataCheck_ExpAnotherMonth(Map param);
    
    
    
    /**
     * 수입 업로드 월 목록 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveExcelWorkMonthFor_Import(Map param);
    
    
    /**
     * 수출 업로드 월 목록 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveExcelWorkMonthFor_Export(Map param);
    
    
    /**
     * 자재코드 누락 체크
     * @param param
     * @return
     */
    public int updateImportEmptyItemCode(Map param);
    public int updateExportEmptyItemCode(Map param);
    
    /**
     * 신고번호 / 란 / 행 기준 중복데이터 체크
     * @param param
     * @return
     */
    public int updateUploadDataCheck_ImpDupData(Map param);
    public int updateUploadDataCheck_ExpDupData(Map param);
    
    
    /**
     * 기존 수입 데이터 삭제
     * @param param
     * @return
     */
    public int deleteImportPreHderData(Map param);
    public int deleteImportPreItemData(Map param);
    
    /**
     * 수입데이터 해더 생성
     * @param param
     * @return
     */
    public int createImportHderData(Map param);
    
    /**
     * 수입데이터 상세 생성
     * @param param
     * @return
     */
    public int createImportItemData(Map param);
    
    /**
     * 기존 잔량 데이터 삭제
     * @param param
     * @return
     */
    public int deleteIncmeLocalBntSmPreData(Map param);
    
    /**
     * 잔량데이터 생성
     * @param param
     * @return
     */
    public int createIncmeLocalBntSmData(Map param);

    /**
     * 기존 수출 데이터 삭제
     * @param param
     * @return
     */
    public int deleteExportPreData(Map param);
    
    
    /**
     * 수출 마스터 데이터 생성
     * @param param
     * @return
     */
    public int createExporteData(Map param);
    
    /**
     * 수출 마스터 데이터를 이용한 1200/ 1300 법인 bom 생성
     * @param param
     * @return
     */
    public int createExporteDataToBom(Map param);
    
    
    
    /**
     * 매각원장 목록 조회 
     * @param param
     * @return
     */
    public List<Map> retrievSalesLedgerList(Map param);
    
    
    
    /**
     * Excel upload error list
     * @param param
     * @return
     */
    public List<Map> excelUpload_ErrorList(Map param);

}