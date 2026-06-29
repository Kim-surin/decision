package com.kpmg.kdb.web.sales;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.sales.dto.SalesRequestDto;

@Controller
public class SalesController extends GenericController {
	@Autowired
	protected SalesService salesService;

	@RequestMapping(value = "/origin/compliance/sales/sales")
	public String poledger_view(Model model, HttpSession session) {
		return "sales/sales_view";
	}

	@RequestMapping(value = "/origin/compliance/sales/salesList")
	@ResponseBody
	public Result sales_list(@RequestBody SalesRequestDto param) throws Exception {
		Result result;

		try {
			result = salesService.retrieveSales(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
