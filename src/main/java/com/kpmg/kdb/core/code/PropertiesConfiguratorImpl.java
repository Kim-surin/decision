package com.kpmg.kdb.core.code;

import com.kpmg.kdb.util.SystemHelper;

import java.util.MissingResourceException;
import java.util.Properties;
import java.util.ResourceBundle;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



public class PropertiesConfiguratorImpl implements PropertiesConfigurator {
	
	protected static Log log = LogFactory.getLog(PropertiesConfiguratorImpl.class);

	
	private final static String DEFAULT_APP_RESOURCE_PATH = "config";

	
	private String APP_RESOURCE_NAME = "appBatchJob";
	
	
	protected ResourceBundle appResourceBundle;
	
	/*
	private static String complianceResource;
	
	static {
		Properties prop = System.getProperties();
		complianceResource = prop.getProperty("complianceResource");
		
		if (complianceResource == null) {
			complianceResource = DEFAULT_APP_RESOURCE_PATH;
		}
		
		if (log.isDebugEnabled()) {
			log.debug("Properties's Dectory : " + complianceResource);
		}
	}
	*/
	public PropertiesConfiguratorImpl(String configName) {
		this.setPropertiesName(configName);
	}
	
	public void doConfigure() throws PropertiesConfiguratorException {
		try {
			this.clear();
			
			if(log.isDebugEnabled()) log.debug("new load file = " + DEFAULT_APP_RESOURCE_PATH + "." + APP_RESOURCE_NAME);
			
			appResourceBundle = SystemHelper.getResourceBundle(DEFAULT_APP_RESOURCE_PATH + "." + APP_RESOURCE_NAME);
			//appResourceBundle = SystemHelper.getResourceBundle("classpath:/config/appBatchJob");
		} catch (MissingResourceException e) {
			throw new PropertiesConfiguratorException("(Can not find "+ e.getClassName()+" properties.) : " + e.getMessage());
		}
	}
	
	public void setPropertiesName(String name) {
		this.APP_RESOURCE_NAME = name;
	}
	
	public String getPropertiesName() {
		return this.APP_RESOURCE_NAME;
	}
	
	public String getString(String key) throws PropertiesConfiguratorException {
		return appResourceBundle.getString(key);
	}

	public String getString(String key, String defaultValue) throws PropertiesConfiguratorException {
		return (appResourceBundle.getString(key) != null) ? this.getString(key) : defaultValue;
	}

	public int getInt(String key) throws PropertiesConfiguratorException {
		return new Integer(appResourceBundle.getString(key));
	}

	public int getInt(String key, String defaultValue) throws PropertiesConfiguratorException {
		return (appResourceBundle.getString(key) != null) ? this.getInt(key) : Integer.parseInt(defaultValue);
	}
	
	@SuppressWarnings("static-access")
	public void clear() {
		appResourceBundle.clearCache();
    }
}
