package com.kpmg.kdb.web.poledger;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.division.DivisionService;
import com.kpmg.kdb.web.poledger.dto.PoLedgerRequestDto;

@Controller
public class PoledgerController extends GenericController {
	@Autowired
	protected PoledgerService poledgerService;
	
	@RequestMapping(value = "/origin/compliance/poledger/poledger")
	public String poledger_view(Model model, HttpSession session) {
		try {
		} catch(Exception e) {
			
		}
		return "poledger/poledger_view";
	}

	@RequestMapping(value = "/origin/compliance/poledger/poledgerList")
	@ResponseBody
	public Result poledger_list(@RequestBody PoLedgerRequestDto param) throws Exception {
		Result result;

		try {
			result = poledgerService.retrievePoledger(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
