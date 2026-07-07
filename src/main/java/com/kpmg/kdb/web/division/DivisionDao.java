package com.kpmg.kdb.web.division;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface DivisionDao {
	public List<Map<String,String>> retrieveDevision(@Param("company_code") String companyCode, @Param("default_language") String defaultLanguage);
}