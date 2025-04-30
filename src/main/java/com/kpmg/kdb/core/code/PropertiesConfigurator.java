package com.kpmg.kdb.core.code;

public interface PropertiesConfigurator {

	void doConfigure() throws PropertiesConfiguratorException;

	String getString(String key) throws PropertiesConfiguratorException;

	String getString(String key, String defaultValue) throws PropertiesConfiguratorException;

	int getInt(String key) throws PropertiesConfiguratorException;

	int getInt(String key, String defaultValue) throws PropertiesConfiguratorException;

	public void clear();
}
