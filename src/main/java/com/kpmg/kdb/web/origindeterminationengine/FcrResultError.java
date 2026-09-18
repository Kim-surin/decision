package com.kpmg.kdb.web.origindeterminationengine;

import com.kpmg.kdb.web.origindeterminationengine.dto.OriginDeterminationResult;

// FCR_RESULT.ERROR_CODE/ERROR_MSG로 저장되는 판정오류 사유 카탈로그.
// 동적 메시지(e.getMessage())와 같이 쓰는 경우는 code()만 꺼내 쓰면 된다.
public enum FcrResultError {

	/** 해당 HS코드에 적용 가능한 룰이 전혀 없는 경우 */
	STANDARD_NOT_EXIST("MSG_DECISION_STANDARD_NOT_EXIST", "해당 협정의 품목 HS코드에 해당하는 판정 기준(PSR)이 존재하지 않습니다"),
	/** RVC_CTC 모드에서 재료비(역내+역외)가 0원인 경우 */
	QTY_AMOUNT_ZERO("MSG_FAILED_DECISION_QTY_AMOUNT", "재료비가 0인 원재료가 존재합니다"),
	/** RVC 판정 기준금액(FOB/EXW 또는 순원가)이 0 이하인 경우 */
	RVC_BASE_AMOUNT_NOT_POSITIVE("MSG_RVC_BASE_AMOUNT_NOT_POSITIVE","RVC 판정 기준금액(FOB/EXW 또는 순원가)이 0 이하여서 비율을 계산할 수 없습니다"),
	/** CTC 판정 대상 자재의 HS코드가 누락된 경우 */
	HSCODE_INCLUDE_MISSING("TXT_HSCODE_INCLUDE_MISSING", "HS코드가 누락된 원재료가 존재합니다"),
	/** RVC 판정에 필요한 제품 중량 정보를 못 찾은 경우 */
	PRODUCT_WEIGHT_NOT_FOUND("MSG_PRODUCT_WEIGHT_NOT_FOUND", "미소기준(중량기준) 판정에 필요한 품목의 중량 정보가 존재하지 않습니다"),
	/** CREATE_FCR 단계에서 실적/표준 BOM을 모두 못 찾은 경우 */
	BOM_NOT_FOUND("BOM_NOT_FOUND", "품목의 BOM을 찾을 수 없습니다"),
	/** loadBuffer 실패(버퍼율 조회 실패). 메시지는 e.getMessage()를 그대로 씀 */
	FAILED_LOAD_BUFFER_RATE("MSG_FAILED_LOAD_BUFFER_RATE", null),
	/** CtcCriteriaOriginDeterminationService.decide() 내부 예외(메시지는 e.getMessage()를 그대로 씀) */
	CTC_ERROR("CTC ERROR", null),
	/** RvcCriteriaOriginDeterminationService.decide() 내부 예외(메시지는 e.getMessage()를 그대로 씀) */
	RVC_ERROR("RVC ERROR", null),
	/** ExclusionRuleOriginDeterminationService.decide() 내부 예외(메시지는 e.getMessage()를 그대로 씀) */
	EXCLUSION_ERROR("EXCLUSION99", null);

	private final String code;
	private final String message;

	FcrResultError(String code, String message) {
		this.code = code;
		this.message = message;
	}

	public String code() {
		return code;
	}

	public String message() {
		return message;
	}

	/** code/message가 고정값 그대로인 경우 사용. 동적 메시지(예외 메시지 등)와 같이 쓸 때는 code()만 꺼내 쓴다. */
	public void applyTo(OriginDeterminationResult rec) {
		rec.setErrorCode(code);
		rec.setErrorMsg(message);
	}
}
