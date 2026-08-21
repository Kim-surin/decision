package com.kpmg.kdb.web.origindetermination.dto;

/**
 * 레거시 CREATE_FCR "해당 사업장 BOM 존재 확인" / "타 플랜트 BOM 체크" 조회 결과.
 * 원본은 ROWNUM=1 만 사용하고 별도 정렬기준이 없어(임의의 한 행) 그대로 이관한다(FETCH FIRST 1 ROW ONLY).
 */
public class BomAvailability {

	private String divisionCode;
	private String yyyymm;

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
}
