package com.kpmg.kdb.core.code;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



public class PropertiesConfiguratorFactory {
	
	protected static Log log = LogFactory.getLog(PropertiesConfiguratorFactory.class);
			
	
    private static PropertiesConfiguratorFactory factorySingleton;
    
	
    private static PropertiesConfigurator configurator;
    
    
    private static Map<String, PropertiesConfigurator> configMap;
	
	 
    private PropertiesConfiguratorFactory() throws PropertiesConfiguratorException {
        initialize();
    }
    
    
    public synchronized static PropertiesConfiguratorFactory getInstance() throws PropertiesConfiguratorException {
    	if (factorySingleton == null) {
            factorySingleton = new PropertiesConfiguratorFactory();
        }
    	
        return factorySingleton;
    }
    
    
    public synchronized void initialize() throws PropertiesConfiguratorException {
    	if(configMap == null) {
    		configMap = new HashMap<String, PropertiesConfigurator>();
    	}
    }
    
    public synchronized static void removeInstance() {
    	if (configMap != null) {
    		configMap.clear();
    	}
    	if (factorySingleton != null) {
    		factorySingleton = null;
    	}
    }
    
    public PropertiesConfigurator getConfigurator(String configName)  throws PropertiesConfiguratorException {
    	configurator = configMap.get(configName);
    	
    	if(configurator == null) {
    		configurator = new PropertiesConfiguratorImpl(configName);
    		
    		configurator.doConfigure();
    		
    		configMap.put(configName, configurator);
    		
    		if(log.isDebugEnabled()) log.debug("create new PropertiesConfiguratorImpl class(" + configName + SystemConstant.PROPERTIES_PREFIX_NAME + ")");
    	} else {
    		if(log.isDebugEnabled()) log.debug("use Old PropertiesConfiguratorImpl class(" + configName + SystemConstant.PROPERTIES_PREFIX_NAME + ")");
    	}
    	
        return configurator;
    }
    
    public PropertiesConfigurator getConfigurator()  throws PropertiesConfiguratorException {
    	PropertiesConfigurator cf = null;
    	try {
    		cf = this.getConfigurator("appBatchJob");	
		} catch (Exception e) {
			// TODO: handle exception
			
		}
    	 
    	return cf;
    }
    
    public PropertiesConfigurator getConfiguratorByName(String configuratorName)  throws PropertiesConfiguratorException {
    	//return this.getConfigurator("app");
    	PropertiesConfigurator cf = null;
    	try {
    		cf = this.getConfigurator(configuratorName);	
		} catch (Exception e) {
			// TODO: handle exception
			
		}
    	 
    	return cf;
    }

}
