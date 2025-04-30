package com.kpmg.kdb.web.drawback;

import java.util.List;
import java.util.Map;


/**
 * 거래처 관리 관련 DAO Class
 * 
 * @author D.Cat
 */
public interface DrawbackDao {
	
	/** Sample 인터페이스 스케줄 List
	public List<Map<String, Object>> retrieveInterfaceSch(Map<String, Object> param);
	 */
	
	/**
     * 환급모니터링 tab1 Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectTab1List(Map param);

    /**
     * 관세청관리 - 환급 - 환급/기납증 발급
     * @param param
     * @return
     */
	public List<Map<String, Object>> retrieveDrawbackCtrmList(Map<String, Object> param);
	
	/**
     * 환급모니터링 bom Data를 조회한다.
     * @since : 2018.07.02
     * @param param
     * @return
     */
    public List<Map> selectTab1BomList(Map param);
    
    
    /**
     * 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB005List(Map<String, Object> param);
    
    /**
     * 환급신청서(갑)
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_DB00501_header(Map<String, Object> param);
	
    /**
     * 환급신청서 수출물품 (을)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00501_trget(Map<String, Object> param);
    
    /**
     * 환급신청서 수입원재료 (병)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00501_rawmtrl(Map<String, Object> param);
    
    /**
     * 환급신청서 수입원재료 (병) - 제한규정
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00501_RestrictRawmtrl(Map<String, Object> param);
    
    
    
    
    

    /**
     * 환급신청서 삭제대상 (병) 정보
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DrawBackRawmtrlList(Map<String, Object> param);
    
    /**
     * 환급신청서 사용잔량 반환
     * @param param
     * @return
     */
    public int return_DrawBackRawmtrl(Map<String, Object> param);
    
    
    
    /**
     * 환급신청서 병지 항목 삭제
     * @param param
     * @return
     */
    public int delete_DrawBackRawmtrl(Map<String, Object> param);
    
    
    /**
     * 을지삭제대상 정보
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_DB00501_cancelXport_List(Map<String, Object> param);
    
    /**
     * 환급신청서 을지 항목 삭제
     * @param param
     * @return
     */
    public int delete_DrawBackTrgetThng(Map<String, Object> param);
    
    
    /**
     * 을지 항목 카운트
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_TrgetThngCount(Map<String, Object> param);
    
    
    
    /**
     * 병지정보 초기화
     * @param param
     * @return
     */
    public int init_DrawBackRawmtrl(Map<String, Object> param);
    
    /**
     * 갑지 정보 초기화
     * @param param
     * @return
     */
    public int init_DrawBackCmmn(Map<String, Object> param);
    
    /**
     * 환급신청서 세액정보 갱신
     * @param param
     * @return
     */
    public int refresh_DrawBackCmmn(Map<String, Object> param);
    
    
    /**
     * 환급신청서 을지정보 갱신 
     * @param param
     * @return
     */
    public int refresh_Trget_DrawBackCmmn (Map<String, Object> param);
    
    
    
    /**
     * 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB006List(Map<String, Object> param);
    
    /**
     * 환급신청서(갑)
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_DB00601_header(Map<String, Object> param);
	
    /**
     * 환급신청서 수출물품 (을)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00601_exportList(Map<String, Object> param);
    
    
    /**
     * 001 - 전달받은 수출신고번호를 임시저장 테이블에 저장합니다
     * @param param
     * @return
     */
    public int create_Temp_xportList(Map<String, Object> param);
    
    
    /**
     * 001-01 #일괄생성  - 전달받은 수출신고번호를 임시저장 테이블에 저장합니다
     * @param param
     * @return
     */
    public int create_Temp_xport_FromToList(Map<String, Object> param);
    
    
    /**
     * 002 - Check 한 목록의 Key List를 생성합니다.
     * 수출확정 체크된 대상을 기초로 한 목록
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_CheckedConfirm_List(Map<String, Object> param);
    
    
    /**
     * [갑] 환급신청 생성전 기존 존재 유무 확인
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_alreadyCmmnList(Map<String, Object> param);
    
    
    /**
     * [갑] 환급신청 생성
     * @param param
     * @return
     */
    public int create_Drawback_CMMN(Map<String, Object> param);
    
    
    /**
     * [을] 환급신청 생성
     * @param param
     * @return
     */
    public int create_DrawbackData_THNG(Map<String, Object> param);

    
    
    
    public int create_DrawbackData_Thing_Temp(Map<String, Object> param);
    public List<Map<String, Object>> retrivev_DrawbackData_ThingTEMP_List(Map<String, Object> param);
    
    
    /**
     * [을] 임시 데이터의 사용여부 가능 조회
     * @param param
     * @return
     */
    public String retrieve_Drwbak_Incme_Local_Bnt_Yn(Map<String, Object> param);
    
    
    
    
    /**
     * [을] 환급신청서의 환급신청 가능수량
     * @param param
     * @return
     */
    public String createAble_DrwBack_THNG_OrderQty(Map<String, Object> param);
    
    
    /**
     * [을] 환급신청서 생성
     * @param param
     * @return
     */
    public int create_DrwBack_THNG(Map<String, Object> param);
    
    /**
     * [을] 사용한 bom version update
     * @param param
     * @return
     */
    public int update_UsingBomVersion(Map<String, Object> param);
    
    
    /**
     * [을] 환급신청서 생성 시 사용된 수출 수량 차감
     * 
     * ABLE_ITEM_QTY = (ABLE_ITEM_QTY - ACCMLT_ORDER_QY)
       USED_ITEM_QTY = (USED_ITEM_QTY - ACCMLT_ORDER_QY)
     *  
     * @param param
     * @return
     */
    public int update_Export_Using_Qty(Map<String, Object> param);
    
    
    /**
     * [을] 제품에 대한 병지 데이터 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_Drwbak_Thing_Worktarget(Map<String, Object> param);
    
    /**
     * 을지 생성 실패 사유 등록
     * @param param
     * @return
     */
    public int create_SuccessXportConfirmReasnon(Map<String, Object> param);
    public int create_DoNotXportConfirmReasnon(Map<String, Object> param);
    
    /**
     * [을] (병)지 생성을 위한 환급신청서 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DrawbackData_THNG(Map<String, Object> param);
    
    
    /**
     * 차감 전 데이터 조회
     * */
    public List<Map<String, Object>> retrieve_PreUpdateData(Map<String, Object> param);
    
    /**
     * 잔량 차감
     */
    public int minusIncme_LocalBnt_Process(Map<String, Object> param);
    
    /**
     * 기납증 : 수출 잔량 차감
     * @param param
     * @return
     */
    public int minusExport_AbleCtrm_Process(Map<String, Object> param);
    
    /**
     * 환급신청서 (병) 생성
     * @param param
     * @return
     */
    public int create_IncmeRawmtrl(Map<String, Object> param);
    
    /**
     * 잔량 사용이력을 저장합니다.
     * @param param
     * @return
     */
    public int createIncme_LocalBnt_History(Map<String, Object> param);
    /**
     * 임시 사용한 수출신고번호 데이터를 삭제합니다.
     * @param param
     * @return
     */
    public int delete_Temp_MyxportList(Map<String, Object> param);
    public int delete_Temp_Things_List(Map<String, Object> param);
    
    
    /**
     * [병] 작성되지 않은 [갑/을]의 데이터를 삭제합니다.
     * @param param
     * @return
     */
    public int delete_ExistsIncmeRawmtrl_Trget_thng(Map<String, Object> param);
    public int delete_ExistsCmmn(Map<String, Object> param);
    
    
    /**
     * 작성된 [병]을 이용하여 환급 세액을 계산하여 [갑]에 update 한다.
     * @param param
     * @return
     */
    public int update_Drwbak_Cmmn(Map<String, Object> param);
    
    
    
    /**
     * 수출확정 취소 : # 001 - 작성된 환급신청서에서 수출신고서 단위로 확정취소를 수행함
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_cancelDrawbackTarget_List(Map<String, Object> param);
    
    
    
    /**
     * 수출확정 취소 : # 002 - 잔량마스터에서 사용한 잔량을 복구 시킨다.
     * @param param
     * @return
     */
    public int cancelDrawbackForIncmeLocalBntSm(Map<String, Object> param);
    
    /**
     * 수출확정 취소 : # 003 - 확정 취소한 <병>에 해당하는 데이터를 삭제합니다. 
     * @param param
     * @return
     */
    public int delete_Drwbak_Incme_Rawmtrl(Map<String, Object> param);
    

    /**
     * 수출확정 취소 : # 004 - 해당수출신고 번호로 작성된 을지 목록을 구한다.
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_cancelXport_List(Map<String, Object> param);
    
    
    /**
     * 수출확정 취소 : # 004/01 - 수출 마스터에 수량 복원 
     * @param param
     * @return
     */
    public int update_CancelXportItemQty(Map<String, Object> param);
    
    
    /**
     * 수출확정 취소 : # 004/02 - 확정 취소한 <을>에 해당하는 데이터를 삭제합니다. 
     * @param param
     * @return
     */
    public int delete_Drwbak_Trget_Thng(Map<String, Object> param);
    
    /**
     * 
     * @param param
     * @return
     */
    public int retrieve_Count_Drwbak_Incme_Rawmtrl(Map<String, Object> param);
    
 
    /**
     * 매출확정(내수) 정보 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB007List(Map<String, Object> param);
    
    
    
    /**
     * 매출확정(내수) 상세 목록 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00701List(Map<String, Object> param);
    
    
 
    /**
     * 매출확정(내수)
     *  - 전달받은 체크된 항목을 임시테이블에 저장한다.
     * @param param
     * @return
     */
    public int create_Temp_SellingList(Map<String, Object> param);

    
    
    
    /**
     * 기존 기납/분증 생성여부 확인
     * 생성되어 있는경우 해당 번호를 반환합니다.
     * @param param
     * @return
     */
    public List<Map<String, Object>> presentn_no_CheckList(Map<String, Object> param);
    
    
    /**
     * [갑] 기납/분증 생성
     * @param param
     * @return
     */
    public int create_Ctrm_CMMN(Map<String, Object> param);
    
    /**
     * [을] 임시 - 기납/분증 생성
     * @param param
     * @return
     */
    public int create_Ctrm_THNG_TEMP(Map<String, Object> param);
    
    
    /**
     * [을] 임시 - 기납/분증 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> thingTEMP_List(Map<String, Object> param);
    
    /**
     * [을] 임시 데이터의 사용여부 가능 조회
     * @param param
     * @return
     */
    public String retrieve_Incme_Local_Bnt_Yn(Map<String, Object> param);
    
    
    /**
     * [을] REAL - 기납/분증 생성
     * @param param
     * @return
     */
    public int create_Ctrm_THNG(Map<String, Object> param);
    
    
    /**
     * [을] (병)지 생성을 위한 기납 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_CtrmData_THNG(Map<String, Object> param);
    
    
    /**
     * [병] 작성을 위한 목록을 생성한다
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_Thing_Worktarget(Map<String, Object> param);
    
    
    /**
     * 기납/분증 차감 전 데이터 조회
     * */
    public List<Map<String, Object>> retrieve_Ctrm_PreUpdateData(Map<String, Object> param);
    
    
    /**
     * 환급신청서 (병) 생성
     * @param param
     * @return
     */
    public int create_Ctrm_IncmeRawmtrl(Map<String, Object> param);
    
    
    
    /**
     * 병지의 금액을 을지에 update
     * @param param
     * @return
     */
    public int update_Ctrm_Thing(Map<String, Object> param);
    
    
    /**
     * 을지의 금액 및 양수일자를 갑지에 update
     * @param param
     * @return
     */
    public int update_Ctrm_Cmmn(Map<String, Object> param);
    
    
    
    /**
     * 기납증/분증 갑지 삭제
     * @param param
     * @return
     */
    public int delete_Ctrm_Cmmn(Map<String, Object> param);
    
    
    
    /**
     * 임시데이터 삭제
     * @param param
     * @return
     */
    public int delete_Ctrm_TempData(Map<String, Object> param);
    
    /**
     * 분증 (을) 작성을 위한 데이터 조회 
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_Thing_Rawmtrl_Worktarget(Map<String, Object> param);
    
    
    /**
     * 기납/분증 생성 실패 사유 저장
     * @param param
     * @return
     */
    public int create_DoNotDomConfirmReasnon(Map<String, Object> param);
    /**
     * 분증 (을) 생성
     * @param param
     * @return
     */
    public int create_Ctrm_IncmeThing_Rawmtrl(Map<String, Object> param);
    
    
    /**
     * 분증 (을) 데이터를 이용하여 (갑) 데이터 update
     * @param param
     * @return
     */
    public int update_Ctrm_Cmmn_FromThing_Rawmtrl(Map<String, Object> param);
    
    
    
    
    
    /**
     * 기납/분증 조회 목록
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB008List(Map<String, Object> param);
    
    /**
     * 기납/분증 상세 (갑)
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_DB00801_header(Map<String, Object> param);
	
    /**
     * 기납/분증 상세 (을)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00801_trget(Map<String, Object> param);
    
    /**
     * 분증 상세 (을)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00802_trget(Map<String, Object> param);
    
    
    /**
     * 기납증 상세 (병)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB00801_rawmtrl(Map<String, Object> param);
    
    

    /**
     * 과다환급자진신고서 작성 목록 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB009List(Map<String, Object> param);
    
    
    /**
     * 과다환급금 자진신고서 상세조회
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_00901Detail(Map<String, Object> param);
    

    /**
     * 과다환급금 자진신고서 저장
     * @param param
     * @return
     */
    public int merge_OverDrwbak_Document_Header(Map<String, Object> param);
    public int merge_OverDrwbak_Document_Item(Map<String, Object> param);
    
    
    /**
	 * 과다환급금 가산금액 산출(팝업) 목록 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
    public List<Map<String, Object>> retrieve_DB009002List(Map<String, Object> param);
    
    
    /**
     * 가산금액 지급신청서
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB010List(Map<String, Object> param);
    
    /**
     * 가산금지급신청서 작성 및 상세조회
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_01001Detail(Map<String, Object> param);

    

    /**
     * 제증명서 정정 취하 승인신청서 목록 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB011List(Map<String, Object> param);
    
    
    /**
     * 제증명서 정정 취하 승인신청서 제증명내역 조회
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_DB01102Detail(Map<String, Object> param);
    

    /**
     * 제증명서 정정 취하 승인신청서 저장
     * @param param
     * @return
     */
    public int create_mcrtfUpdtWthdrwMst(Map<String, Object> param);
    public int create_mcrtfUpdtWthdrwDtl(Map<String, Object> param);
    

    /**
     * 제증명서 정정 취하 승인신청서 상세 SEQ 조회
     * @param param
     * @return
     */
    public String retrieve_mcrtfUpdtWthdrwDtlSeq(Map<String, Object> param);
    
    
    
    
    /**
     * 기납증 삭제대상 (병) 정보
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_CtrmRawmtrlList(Map<String, Object> param);
    
    
    /**
     * 기납증 삭제대상 잔량 반환 
     * @param param
     * @return
     */
    public int return_CtrmkRawmtrl(Map<String, Object> param);
    
    
    /**
     * 환급신청서 병지 항목 삭제
     * @param param
     * @return
     */
    public int delete_CtrmRawmtrl(Map<String, Object> param);
    
    
    /**
     * 환급신청서 을지 항목 삭제
     * @param param
     * @return
     */
    public int delete_CtrmTrgetThng(Map<String, Object> param);
    
    
    
    /**
     * 을지 항목 카운트
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_CtrmTrgetThngCount(Map<String, Object> param);
    
    
    
    /**
     * 병지정보 초기화
     * @param param
     * @return
     */
    public int init_CtrmRawmtrl(Map<String, Object> param);
    
    /**
     * 갑지 정보 초기화
     * @param param
     * @return
     */
    public int init_CtrmCmmn(Map<String, Object> param);
    
    
    /**
     * 기납증 정보 갱신
     * @param param
     * @return
     */
    public int refresh_CtrmCmmn(Map<String, Object> param);
    
    
    
    /**
     * 분증
     * 삭제대상 잔량 반환 
     * @param param
     * @return
     */
    public int return_CtrmThingRawmtrl(Map<String, Object> param);
    
    
    /**
     * 분증
     * 삭제대상 잔량 반환 
     * @param param
     * @return
     */
    public int delete_CtrmThingRawmtrl(Map<String, Object> param);
    
    
    
    /**
     * 분증
     * 을지 항목 카운트
     * @param param
     * @return
     */
    public Map<String, Object> retrieve_CtrmThingRawmtrlCount(Map<String, Object> param);
    
    

    
    /**
     * (가능한 수량만 만들기)
     * [을] 제품에 대한 병지 데이터 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_Drwbak_Thing_Worktarget_extn(Map<String, Object> param);
    
    
    /**
	 * 기간별 배치 수행 시 시작 종료 로그 생성용
	 * @param p_Row
	 * @param logFlag
	 * @return
	 */
    public int createMonthly_StartEnd_logs(Map<String, Object> param);
    

    /**
     * 기간별 환급신청서 생성시 월단위 작업 리스트 추출
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_Drwbak_TargetMonthList(Map<String, Object> param);

    
    
    
    
    /** New 기납증 시작 */
    
    /**
     * 기납증
     * 기납증 대상 목록 조회 지정된 데이터(SALES_NO)
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveConfrimCtrmTargetList(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 기납증 대상 목록 조회 FROM ~ TO
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveConfrimCtrmTargetListFromTo(Map<String, Object> param);
    

    /**
     * 기납증
     * 기존 생성번호 체크 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_alreadyCtrmCmmnList(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 기납증 <갑> 생성 
     * @param param
     * @return
     */
    public int create_Ctrm_CMMN_FromSales(Map<String, Object> param);
    

    /**
     * 기납증
     * 기납증 <을> 생성 임시테이블
     * @param param
     * @return
     */
    public int createCtrmThngTemp(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 기납증 <을> 생성 임시테이블 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrivev_Ctrm_ThingTEMP_List(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 각 기납증 대상 품목별 BOM Version MappingList
     * @param param
     * @return
     */
    public Map<String, Object> retrieveCtrmTrgetThng_List(Map<String, Object> param);
    
            
    /**
     *  기납증
     * (대상 품목의 수출수량) * 투입수량이 적용된 을지 만들기 위한 목록
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieveCtrmIncmeRawmtrl_List(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 남은 잔량으로 생성할수 있는 기납증<을> 데이터의 수량을 조회
     * @param param
     * @return
     */
    public String createAble_Ctrm_THNG_OrderQty(Map<String, Object> param);
    
    
    /**
     *기납증
     * 실제 을 생성 (매출데이터로 생성하는 버전) 
     * @param param
     * @return
     */
    public int createCtrmThng(Map<String, Object> param);
    
    
    
    /**
     * 기납증
     * 기납증 또는 분증을 발급한 수량만큼 매출 잔량관리에서 차감 
     * @param param
     * @return
     */
    public int update_Sales_Using_Qty(Map<String, Object> param);
    

    
    /**
     * 기납증
     * 수출데이터의 기납증 생성 후 잔량 차감 로직 - 대상 데이터 조회 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_PreCtrmExportUpdateData(Map<String, Object> param);
    
    /**
     * 기납증
     * 실제 수출 수량에서 기납증 발급 수량 차감 (선입선출)
     * @param param
     * @return
     */
    public int minusCtrmExport_Process(Map<String, Object> param);
    
    
    /**
     * 기납증
     *  <병> 잔량 차감 로직 - 대상 데이터 조회
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_PreCtrmUpdateData(Map<String, Object> param);
    

    /**
     * 기납증
     * <병> 생성 
     * @param param
     * @return
     */
    public int createCtrmIncmeRawmtrl(Map<String, Object> param);
    
    
    /**
     * 기납증
     * <병> 데이터가 없는 <을> 데이터를 삭제처리
     * @param param
     * @return
     */
    public int delete_ExistsCtrmIncmeRawmtrl_Trget_thng(Map<String, Object> param);
    
    
    /**
     * 기납증
     * 기존 관리번호가 없고 해당 관리번호로 생성된 <을> 데이터가 없는경우 <갑> 데이터를 삭제
     * @param param
     * @return
     */
    public int delete_ExistsCtrmCmmn(Map<String, Object> param);
    

    /**
     * 기납증
     * 기납증 임시 데이터 삭제 
     * @param param
     * @return
     */
    public int delete_Temp_Ctrm_Things_List(Map<String, Object> param);
    
    
    
    
    /**
     * 조견표 
     * @param param
     * @return
     */
    public List<Map<String, Object>> retrieve_DB012List(Map<String, Object> param);
    public List<Map<String, Object>> retrieve_DB01201RegistRceptList(Map<String, Object> param);
    public List<Map<String, Object>> retrieve_DB01201RegistRcepMaterialtList(Map<String, Object> param);
    public Map<String, Object> retrieve_DB01201DetailList(Map<String, Object> param);
    public int update_DB01201DetailList_HDR(Map<String, Object> param);
    public int delete_DB01201DetailList_ITEM(Map<String, Object> param);
    public int update_DB01201DetailList_ITEM(Map<String, Object> param);
    
    
    /**
	 * 관세청 수신 상태 유효 정보 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> get_unipass_status_count(Map<String, Object> param);
	
	/**
	 * 관세청 접수통보 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_notification(Map<String, Object> param);
	
    /**
	 * 관세청 오류통보 master 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_error_master(Map<String, Object> param);
	
	/**
	 * 관세청 오류통보 details 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> retrieve_unipass_status_error_details(Map<String, Object> param);
	
	/**
	 * 관세청 보완통보 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_complement(Map<String, Object> param);
	
	/**
	 * 관세청 자료제출요구통보 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_request(Map<String, Object> param);
	
	/**
	 * 관세청 완료통보 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_complete(Map<String, Object> param);
	
	/**
	 * 관세청 지급통보 조회
	 * @param param
	 * @return
	 */
	public Map<String, Object> retrieve_unipass_status_payment(Map<String, Object> param);
	
	

	
	/**
	 * 가산금 지급신청 마스터 저장
	 * @param param
	 * @return
	 */
	public int merge_Adamt_MasterData(Map<String, Object> param);
	
	
	/**
	 * 가산금 지급신청 기존 상세 데이터 삭제
	 * @param param
	 * @return
	 */
	public int delete_Adamt_DetailData(Map<String, Object> param);
	
	
	/**
	 * 가산금 지급신청 상세 데이터 저장
	 * @param param
	 * @return
	 */
	public int insert_Adamt_DetailData(Map<String, Object> param);
	
	/**
	 * 가산금 지급신청 마스터 세액 갱신
	 * @param param
	 * @return
	 */
	public int update_Adamt_MasterTaxData(Map<String, Object> param);
	
	
	public List<Map<String, Object>> retrieve_adamtDetailData(Map<String, Object> param);
	
	
	
	/**
	 * 기납증 연관 매출 데이터 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
    public List<Map<String, Object>> retrieve_DB00803_trget(Map<String, Object> param);
}


