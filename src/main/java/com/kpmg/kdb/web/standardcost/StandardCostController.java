package com.kpmg.kdb.web.standardcost;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.standardcost.dto.StandardCostRequestDto;

@Controller
public class StandardCostController extends GenericController {
	@Autowired
	protected StandardCostService standatdCostService;

	@RequestMapping(value = "/origin/compliance/standardCost/standardCost")
	public String standardCost_view(Model model, HttpSession session) {
		return "standardcost/standardCost_view";
	}

	@RequestMapping(value = "/origin/compliance/standardCost/standardCostList")
	@ResponseBody
	public Result standardCost_list(@RequestBody StandardCostRequestDto param) throws Exception {
		Result result;

		try {
			result = standatdCostService.retrieveStandardCost(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
