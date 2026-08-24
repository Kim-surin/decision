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
	public int updateVendorData(Map param);	
	public int insertVendorIncharge(Map param);
	public int updateVendorIncharge(Map param);
	public int deleteVendorIncharge(Map param);
	
	public List retrieveCustomerList(Map param);
	public int updateCustomerData(Map param);
}


