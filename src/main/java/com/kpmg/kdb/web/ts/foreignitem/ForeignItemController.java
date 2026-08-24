package com.kpmg.kdb.web.ts.foreignitem;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

@Controller
@SuppressWarnings("rawtypes")
public class ForeignItemController extends GenericController {

	protected Logger logger = LoggerFactory.getLogger(ForeignItemController.class);

	@Autowired
	protected ForeignItemListService service;

	/**
	 * 협력업체 원산지확인서 > 수취확인서 자재내역
	 */
	@RequestMapping("/foreignitem/ForeignItem")
	public String foreignitem000_view(Model model, HttpSession session) {
		return "foreignitem/foreignitem";
	}

	/**
	 * 수취확인서 자재내역 조회
	 */
	@PostMapping("/foreignitem/retrieveForeignItem")
	@ResponseBody
	public Result retrieveForeignItem(@RequestBody Map param) {
		logger.debug("##### retrieveForeignItem START");

		Result result = new Result();

		try {
			result = service.retrieveForeignItem(super.extendsMap(param));
		} catch (Exception e) {
			logger.error("retrieveForeignItem error", e);
			result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
		}

		logger.debug("##### retrieveForeignItem END");

		return result;
	}
}