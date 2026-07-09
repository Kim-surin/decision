package com.kpmg.kdb.web.ftabom;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomDetailVendorRequestDto;
import com.kpmg.kdb.web.ftabom.dto.FtaBomMasterRequestDto;

@Controller
public class FtaBomController extends GenericController {
	@Autowired
	protected FtaBomService ftaBomService;

	@RequestMapping(value = "/origin/compliance/ftaBom/ftaBom")
	public String ftaBom_view(Model model, HttpSession session) {
		return "ftabom/ftaBom_view";
	}

	@RequestMapping(value = "/origin/compliance/ftaBom/ftaBomMasterList")
	@ResponseBody
	public Result ftaBomMaster_list(@RequestBody FtaBomMasterRequestDto param) throws Exception {
		Result result;

		try {
			result = ftaBomService.retrieveftaBomMaster(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/ftaBom/ftaBomDetailList")
	@ResponseBody
	public Result ftaBomDetail_list(@RequestBody FtaBomDetailRequestDto param) throws Exception {
		Result result;

		try {
			result = ftaBomService.retrieveftaBomDetail(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}

	@RequestMapping(value = "/origin/compliance/ftaBom/ftaBomDetailVendorList")
	@ResponseBody
	public Result ftaBomDetailVendor_list(@RequestBody FtaBomDetailVendorRequestDto param) throws Exception {
		Result result;

		try {
			result = ftaBomService.retrieveftaBomDetailVendor(param);
		} catch (Exception e) {
			e.printStackTrace();
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		return result;
	}
}
