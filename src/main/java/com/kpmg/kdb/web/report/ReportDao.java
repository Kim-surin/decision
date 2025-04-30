package com.kpmg.kdb.web.report;

import java.util.List;
import java.util.Map;

/**
 * 레포트 기본처리 DAO
 * 
 * @author 
 */
public interface ReportDao {
	
	
	/**
     * 기간별 환급레포트 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieve_R001List(Map param);
	
	
	/**
	 * 잔량레포트 
	 *  - 거래처별 Pie Chart Data 
	 *  - 거래처별 Bar Chart Data 
	 * @param param
	 * @return
	 */
	public List<Map> rpt002_getExporterBalanceTax(Map param);
	public List<Map> rpt002_getExporterBalanceQty(Map param);
	
	
	/**
	 * 잔량레포트 
	 *  - 자재코드별 Bar Chart Data
	 *  - 자재코드별 Pie Chart Data  
	 * @param param
	 * @return
	 */
	public List<Map> rpt002_getItemCodeBalanceTax(Map param);
	public List<Map> rpt002_getItemCodeBalanceQty(Map param);
	
	
	/**
	 * 잔량레포트 
	 *  - HS CODE별 Bar Chart Data
	 *  - HS CODE별 Pie Chart Data  
	 * @param param
	 * @return
	 */
	public List<Map> rpt002_getHsCodeBalanceTax(Map param);
	public List<Map> rpt002_getHsCodeBalanceQty(Map param);
	
	
	/**
     * 잔여수량 레포트 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieveRpt00201List(Map param);
	
	/**
	 * 잔여수량 레포트 조회
	 * 
	 * @param     param 입력파라미터맵
	 * @return    조회된 정보
	 */
	public List<Map> retrieveRpt00202List(Map param);
	
	/**
	 * 잔여수량 상세 레포트 조회
	 * @param param
	 * @return
	 */
	public List<Map> retrieveRpt00203List(Map param);
	public List<Map> retrieveRpt00204List(Map param);
	public List<Map> retrieveRpt00205List(Map param);
	
	
	/**
     * 조건표 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieve_R003List(Map param);
	
	
	/**
     * 기납증/분증 수취 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieve_R004List(Map param);
	
	/**
     * 구매확인서/기납증 비교 조회
     * 
     * @param     param 입력파라미터맵
     * @return    조회된 정보
     */
	public List<Map> retrieve_R006List(Map param);
	
	
	

	/**
	 * 환급금액 레포트
	 * 	- 거래처 별  
	 *  	- [Pie Chart Data] 수출액 대비 환급액 비율 
	 *  	- [Bar Chart Data] 환급수량별 비율
	 *  	- [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getVendorDrwbak_Rate(Map param);
	public List<Map> rpt008_getVendorDrwbakUsedQtyData(Map param);
	public List<Map> rpt008_getVendorTaxByDrwBakRate(Map param);
	
	
	/**
	 * 환급금액 레포트
	 * 	- 제품코드 별  
	 *  	- [Pie Chart Data] 수출액 대비 환급액 비율 
	 *  	- [Bar Chart Data] 환급수량별 비율
	 *  	- [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getItemCodeDrwbak_Rate(Map param);
	public List<Map> rpt008_getItemCodeDrwbakUsedQtyData(Map param);
	public List<Map> rpt008_getItemCodeTaxByDrwBakRate(Map param);
	
	
	
	/**
	 * 환급금액 레포트
	 * 	- HS Code 별  
	 *  	- [Pie Chart Data] 수출액 대비 환급액 비율 
	 *  	- [Bar Chart Data] 환급수량별 비율
	 *  	- [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getHsCodeDrwbak_Rate(Map param);
	public List<Map> rpt008_getHsCodeDrwbakUsedQtyData(Map param);
	public List<Map> rpt008_getHsCodeTaxByDrwBakRate(Map param);
	
	
	/**
	 * 환급금액 레포트
	 * 	- 목적국 별 
	 *  	- [Pie Chart Data] 수출액 대비 환급액 비율 
	 *  	- [Bar Chart Data] 환급수량별 비율
	 *  	- [Bar Chart Data] 납부세액 대비 환급비율  
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getNationCodeDrwbak_Rate(Map param);
	public List<Map> rpt008_getNationCodeDrwbakUsedQtyData(Map param);
	public List<Map> rpt008_getNationCodeTaxByDrwBakRate(Map param);
	
	
	
	/**
	 * 환급금액 레포트 상세 레포트 조회
	 * @param param
	 * @return
	 */
	public List<Map> retrieveRpt00801List(Map param);
	public List<Map> retrieveRpt0080XList_IMPDEC(Map param);
	public List<Map> retrieveRpt00802List(Map param);
	public List<Map> retrieveRpt00803List(Map param);
	
	
	/**
	 * 기납증/분증 수취금액 비율
	 *  -[Pie Chart Data]  금액
	 *  -[Pie Chart Data]  수량
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getCcpyAmountRate(Map param);
	public List<Map> rpt008_getCcpyQtyRate(Map param);
	
	
	/**
	 * 구매확인서 대비 기납증/분증 발급금액 비율
	 *  -[Pie Chart Data]  금액
	 *  -[Pie Chart Data]  수량
	 * @param param
	 * @return
	 */
	public List<Map> rpt008_getCtrmAmountRate(Map param);
	public List<Map> rpt008_getCtrmQtyRate(Map param);
	
	/**
	 * 수출입 데이터 중복 조회
	 * @param param
	 * @return
	 */
	public List<Map> retrieve_R010ImportList(Map param);
	public List<Map> retrieve_R010ExportList(Map param);
	
	

	/**
	 * 수출입 분석
	 * @param param
	 * @return
	 */
	public List<Map> retrieve_R011List(Map param);
	public List<Map> retrieve_diffHsCodeList(Map param);
	public List<Map> retrieve_diffItemNmList(Map param);
	public List<Map> retrieve_diffPriceList(Map param);
	
	/**
	 * 수출환급대상
	 * @param param
	 * @return
	 */
	public List<Map> retrieve_R012List(Map param);
	public List<Map> retrieveErrorByExportAmountRatePieChart(Map param);
	public List<Map> retrieveErrorByExportQtyRatePieChart(Map param);
	public List<Map> retrieveErrorByDrwbAmountRatePieChart(Map param);
	
	

	/**
	 * BOM 검증
	 * @param param
	 * @return
	 */
	public List<Map> retrieve_R013List(Map param);
	public List<Map> retrieve_R013DetailList(Map param);
	
}