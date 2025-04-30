package com.kpmg.kdb.core.generic;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.cfg.MapperConfig;
import com.fasterxml.jackson.databind.introspect.AnnotatedField;
import com.fasterxml.jackson.databind.introspect.AnnotatedMethod;


/**
 * jackson Converter UpperCase 전략 Class
 * 
 * @author D.Cat
 * @since 2018.09.06
 */
public class JacksonUpperCaseStrategy extends PropertyNamingStrategy {
	private static final long serialVersionUID = 1L;

	@Override
	public String nameForField(MapperConfig config, AnnotatedField field, String defaultName) {
		return convert(defaultName);

	}

	@Override
	public String nameForGetterMethod(MapperConfig config, AnnotatedMethod method, String defaultName) {
		return convert(defaultName);
	}

	@Override
	public String nameForSetterMethod(MapperConfig config, AnnotatedMethod method, String defaultName) {
		String a = convert(defaultName);
		return a;
	}

	public String convert(String defaultName) {
		char[] arr = defaultName.toCharArray();
		if (arr.length != 0) {
			for (int a = 0; a < arr.length; a++) {
				if (Character.isLowerCase(arr[a])) {
					char upper = Character.toUpperCase(arr[a]);
					arr[a] = upper;
				}
			}

		}
		return new StringBuilder().append(arr).toString();
	}

}