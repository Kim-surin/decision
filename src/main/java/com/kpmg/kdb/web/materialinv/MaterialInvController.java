package com.kpmg.kdb.web.materialinv;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.materialinv.dto.MaterialInvRequestDto;

@Controller
public class MaterialInvController extends GenericController {
	@Autowired
	protected MaterialInvService materialInvService;

	@RequestMapping(value = "/origin/compliance/materialinv/materialInv")
	public String materialInv_view(Model model, HttpSession session) {
		return "materialinv/materialInv_view";
	}

	@RequestMapping(value = "/origin/compliance/materialinv/materialInvList")
	@ResponseBody
	public Result materialInv_list(@RequestBody MaterialInvRequestDto param) throws Exception {
		Result result;

		try {
			result = materialInvService.retrieveMaterialInv(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
