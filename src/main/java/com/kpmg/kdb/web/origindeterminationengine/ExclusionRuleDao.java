package com.kpmg.kdb.web.origindeterminationengine;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpmg.kdb.web.origindeterminationengine.dto.ExclusionRuleDetail;
import com.kpmg.kdb.web.origindeterminationengine.dto.ExclusionRuleHeader;

public interface ExclusionRuleDao {

	/** 레거시 CURSOR C_FTA_EXCLUSION_RULE: 현재 룰에 적용되는 예외타입 목록(타입별 결합조건/기준율) */
	List<ExclusionRuleHeader> selectExclusionRuleHeaders(@Param("ftaCode") String ftaCode,
			@Param("hsCode") String hsCode, @Param("hsCodeSubCategory") String hsCodeSubCategory,
			@Param("ruleSeq") String ruleSeq);

	/** 예외타입 1건에 대한 대상 HS코드 목록(EXCLUSION_HS_CODE) 및 개별 기준율 */
	List<ExclusionRuleDetail> selectExclusionRuleDetails(@Param("ftaCode") String ftaCode,
			@Param("hsCode") String hsCode, @Param("hsCodeSubCategory") String hsCodeSubCategory,
			@Param("ruleSeq") String ruleSeq, @Param("exclusionType") String exclusionType);
}
