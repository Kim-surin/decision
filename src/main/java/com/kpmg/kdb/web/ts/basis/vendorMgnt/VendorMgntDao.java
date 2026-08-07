package com.kpmg.kdb.web.ts.basis.vendorMgnt;

import java.util.List;
import java.util.Map;


/**
 * 
 * @author Damned Cat
 */
@SuppressWarnings("rawtypes")
public interface VendorMgntDao {
	
	public List retrieveVendorList(Map param);
	public List retrieveVendorInChargeList(Map param);
	public List retrieveCustomerList(Map param);
}


