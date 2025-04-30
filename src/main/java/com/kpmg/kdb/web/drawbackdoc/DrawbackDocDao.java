package com.kpmg.kdb.web.drawbackdoc;

import java.util.List;
import java.util.Map;


/**
 * 거래처 관리 관련 DAO Class
 * 
 * @author D.Cat
 */
public interface DrawbackDocDao {
	
	/**
	 * XML 생성용 <갑> 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_Drwbak_Cmmn(Map<String, Object> param);
	

	/**
	 * XML 생성용 <을> 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_Drwbak_Thng(Map<String, Object> param);
	
	
	/**
	 * XML 생성용 <병> 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_Drwbak_Rawmtrl(Map<String, Object> param);
	
	
	
	/**
	 * 환급신청서 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_drwb(Map<String, Object> param);
	
	/**
	 * 기납증/분증 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_cmmn(Map<String, Object> param);

	/**
	 * Bom 제출 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_bom(Map<String, Object> param);
	
	/**
	 * 과다환급자진신고 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_overDrwb(Map<String, Object> param);
	
	/**
	 * 조견표 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_quickRef(Map<String, Object> param);
	
	/**
	 * 가산금 지급 신청 : 제출번호 생성여부 체크 
	 * @param param
	 * @return
	 */
	public String checkNewSubmitNo_Adamt(Map<String, Object> param);
	
	
	/**
	 * 제출번호 1 증가
	 * @param param
	 * @return
	 */
	public int createNewSubmitNo(Map<String, Object> param);
	
	
	/**
	 * 제출번호 생성
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_drwb(Map<String, Object> param);
	
	
	
	/**
	 * 환급신청건 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateDrwbStatus(Map<String, Object> param);
	
	
	
	/**
	 * 분증/기납증 제출번호 생성
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_init_part(Map<String, Object> param);
	
	/**
	 * 분증 갑 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_partial(Map<String, Object> param);
	
	/**
	 * 분증 을 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_partial_thng(Map<String, Object> param);
	
	/**
	 * 기납증 갑 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_init(Map<String, Object> param);
	
	/**
	 * 기납증 을 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_init_thng(Map<String, Object> param);
	
	/**
	 * 기납증 병 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_init_incme(Map<String, Object> param);
	
	/**
	 * 분증/기납증 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateInitPartStatus(Map<String, Object> param);
	
	/**
	 * BOM 제출 송신 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateBomSubmitStatus(Map<String, Object> param);
	
	/**
	 * 오류통보 : 마스터 Merge
	 * @param param
	 * @return
	 */
	public int merge_R20_Data(Map<String, Object> param);
	
	
	/**
	 * 오류통보 : 상세 삭제
	 * @param param
	 * @return
	 */
	public int delete_R20_DetailData(Map<String, Object> param);
	
	
	/**
	 * 오류통보 : 상세 생성
	 * @param param
	 * @return
	 */
	public int insert_R20_DetailData(Map<String, Object> param);
	
	
	/**
	 * 환급신청서 상태 처리 (지급통보)
	 * @param param
	 * @return
	 */
	public int update_Drwb_ExecutStatus60(Map<String, Object> param);
	
	/**
	 * 환급신청서 상태 처리
	 * @param param
	 * @return
	 */
	public int update_Drwb_ExecutStatus(Map<String, Object> param);
	
	/**
	 * 기납/분증  상태 처리
	 * @param param
	 * @return
	 */
	public int update_Ctrm_ExecutStatus(Map<String, Object> param);
	
	
	/**
	 * 과다환급  상태 처리
	 * @param param
	 * @return
	 */
	public int update_Over_ExecutStatus(Map<String, Object> param);
	
	
	/**
	 * 조견표  상태 처리
	 * @param param
	 * @return
	 */
	public int update_QuickRef_ExecutStatus(Map<String, Object> param);
	
	/**
	 * Bom 제출  상태 처리
	 * @param param
	 * @return
	 */
	public int update_BomSubmit_ExecutStatus(Map<String, Object> param);
	
	
	/**
	 * 접수통보 데이터 저장
	 * @param param
	 * @return
	 */
	public int merge_R54_Data(Map<String, Object> param);
	
	
	/**
	 * 보완통보 데이터 저장
	 * @param param
	 * @return
	 */
	public int merge_R58_Data(Map<String, Object> param);
	
	/**
	 * 지급통보 데이터 저장
	 * @param param
	 * @return
	 */
	public int merge_381_Data(Map<String, Object> param);
	
	

	/**
	 * 자료제출요구 마스터 데이터 저장
	 * @param param
	 * @return
	 */
	public int merge_R57_Data(Map<String, Object> param);
	
	
	
	/**
	 * 자료제출요구 상세 삭제
	 * @param param
	 * @return
	 */
	public int delete_R57_DetailData(Map<String, Object> param);
	
	
	
	/**
	 * 자료제출요구 상세 저장
	 * @param param
	 * @return
	 */
	public int insert_R57_DetailData(Map<String, Object> param);
	
	
	/**
	 * 환급신청서 상태 처리 (자료제출 요구)
	 * @param param
	 * @return
	 */
	public int update_Drwb_ExecutStatus40(Map<String, Object> param);
	
	
	
	/**
	 * 환급신청서 상태 처리 (접수통보)
	 * @param param
	 * @return
	 */
	public int update_Drwb_ExecutStatus10(Map<String, Object> param);
	
	
	
	/**
	 * 기납/분증 상태 처리 (자료제출 요구)
	 * @param param
	 * @return
	 */
	public int update_Cmmn_ExecutStatus40(Map<String, Object> param);
	

	
	/**
	 * 완료통보 마스터 데이터 저장
	 * @param param
	 * @return
	 */
	public int merge_5DF_Data(Map<String, Object> param);
	

	/**
	 * 양수자 통보 기납증 /분증 저장 여부 확인
	 * @param param
	 * @return
	 */
	public String checkDuplicateCtrm(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 기납증 /분증 갑지 정보 저장
	 * @param param
	 * @return
	 */
	public int merge_An_Ctrm_Cmmn(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 기납증 <을> 정보 삭제
	 * @param param
	 * @return
	 */
	public int delete_An_Ctrm_Trget_Thng(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 기납증 <을> 정보 저장
	 * @param param
	 * @return
	 */
	public int insert_An_Ctrm_Trget_Thng(Map<String, Object> param);
	
	/**
	 * 양수자 통보 기납증 : 잔량생성 09 원본
	 * @param param
	 * @return
	 */
	public int merge_IncmeLocalBntSm_for_02_09(Map<String, Object> param);
	
	/**
	 * 양수자 통보 기납증 : 잔량 01-취하 / 35-정정 
	 * @param param
	 * @return
	 */
	public int merge_IncmeLocalBntSm_for_02_01_35(Map<String, Object> param);

	/**
	 * 양수자 통보 분증 <을> 정보 삭제
	 * @param param
	 * @return
	 */
	public int delete_An_Ctrm_Thing_Rawmtrl(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 분증 <을> 정보 저장
	 * @param param
	 * @return
	 */
	public int insert_An_Ctrm_Thing_Rawmtrl(Map<String, Object> param);

	
	/**
	 * 양수자 통보 잔량생성 09- 원본
	 * @param param
	 * @return
	 */
	public int merge_IncmeLocalBntSm_for_04_09(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 잔량생성된 분증정보 상태값 update 
	 * UPDATE IF_YN = 'Y'
	 * ISSUE_TYPE = '04'
	 * IF_YN = 'N'
	 * RECV_DOC_TYPE = '09'
	 * @param param
	 * @return
	 */
	public int update_An_CtrmCmmn(Map<String, Object> param);
	
	
	/**
	 * 양수자 통보 잔량생성 01-취하 / 35-정정
	 * @param param
	 * @return
	 */
	public int merge_IncmeLocalBntSm_for_04_01_35(Map<String, Object> param);
	
	
	/**
	 * bom submit no 입력
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_bom(Map<String, Object> param);
	
	
	
	/**
	 * bom 갑 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_bom(Map<String, Object> param);
	
	/**
	 * bom 을 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_bom_detail(Map<String, Object> param);
	
	
	/**
	 * bom 갑 데이터 조회 (기납증)
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_Initbom(Map<String, Object> param);
	
	/**
	 * bom 을 데이터 조회(기납증)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_Initbom_detail(Map<String, Object> param);
	
	/**
	 * 과다환급자진신고 제출번호 생성
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_overDrwb(Map<String, Object> param);
	
	/**
	 * 과다환급자진신고 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_overDrwb(Map<String, Object> param);
	
	/**
	 * 과다환급자진신고 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateOverDrwbStatus(Map<String, Object> param);
	
	/**
	 * 조견표 제출번호 생성
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_quickRef(Map<String, Object> param);
	
	
	/**
	 * 조견표 갑, 을 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_quickRef(Map<String, Object> param);
	
	/**
	 * 조견표 병 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_quickRef_detail(Map<String, Object> param);
	
	/**
	 * 조견표 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateQuickRefStatus(Map<String, Object> param);

	
	/**
	 * BOM제출 마스터 데이터 생성
	 * @param param
	 * @return
	 */
	public int insertBomSubmit_MasterData(Map<String, Object> param);
	public int insertInitBomSubmit_MasterData(Map<String, Object> param);
	
	
	/**
	 * BOM제출 마스터 데이터 조회
	 * @param param
	 * @return
	 */
	public Map retrieve_BomMasterData(Map<String, Object> param);
	
	
	/**
	 * BOM제출 마스터 데이터 생성
	 * @param param
	 * @return
	 */
	public int updateBomSubmit_MasterData(Map<String, Object> param);
	public int updateInitBomSubmit_MasterData(Map<String, Object> param);
	
	/**
	 * BOM제출 상세 데이터 생성
	 * @param param
	 * @return
	 */
	public int insertBomSubmit_ItemData(Map<String, Object> param);
	public int insertInitBomSubmit_ItemData(Map<String, Object> param);
	
	
	
	/**
	 * 가산금지급신청 submit no 입력
	 * @param param
	 * @return
	 */
	public int updateSubmitNo_Adamt(Map<String, Object> param);
	
	
	
	/**
	 * 가산금지급신청 갑 데이터 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_Adamt(Map<String, Object> param);
	
	/**
	 * 가산금지급신청 을 데이터 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_Adamt_detail(Map<String, Object> param);
	
	
	/**
	 * 가산금 지급 신청  송신 관세청 연계 성공 업데이트
	 * @param param
	 * @return
	 */
	public int updateAdamtSubmitStatus(Map<String, Object> param);
	
	
	
	/**
	 * 가산금 지급 신청서 (수신 상태값 처리)
	 * @param param
	 * @return
	 */
	public int update_Adamt_ExecutStatus(Map<String, Object> param);
	
}
