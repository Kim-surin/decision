package com.kpmg.kdb.web.ts.basis.vendorMgnt;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

/*******************************************************************************************
 *
 * FtaInfoController.class
 *
 * @since 2026.07
 *
 *         기초 정보 관리 > 협력업체
 *
 ********************************************************************************************/

@Controller
@SuppressWarnings("rawtypes")
public class VendorMgntController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(VendorMgntController.class);
	

	@Autowired
	protected VendorMgntService vendorMgntService;

	/**
	 * 기초 정보 관리 > 협력업체
	 * 
	 * @author osw
	 * @return View Path String
	 */
	@RequestMapping(value = "/origin/basis/vendorMgnt")
	public String ftaIncoterms_view(Model model, HttpSession session) {
		return "basis/vendorMgnt";
	}
	
	
	/**
	 *  기초 정보 관리 > 협력업체 > 리스트 조회(Vendor)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/vendorMgnt/retrieveVendorList")
	@ResponseBody
	public Result retrieveVendorList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = vendorMgntService.retrieveVendorList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	/**
	 *  기초 정보 관리 > 협력업체 > 리스트 조회(Vendor 담당자)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/vendorMgnt/retrieveVendorInChargeList")
	@ResponseBody
	public Result retrieveVendorInChargeList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = vendorMgntService.retrieveVendorInChargeList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	
	
	/**
	 *  기초 정보 관리 > 협력업체 > 리스트 조회(Customer)
	 * 
	 * @author osw
	 * @return 
	 */
	@RequestMapping(value="/origin/basis/vendorMgnt/retrieveCustomerList")
	@ResponseBody
	public Result retrieveCustomerList(@RequestBody Map param) {
		Result result = new Result();
		try {
			
			result = vendorMgntService.retrieveCustomerList(super.extendsMap(param));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		
		return result;
	}
	
	
	
	
	
	
}