package com.kpmg.kdb.web.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.kpmg.kdb.util.HttpUtils;
import com.kpmg.kdb.util.StringUtil;

public class FileDownloadView extends AbstractView {

	public void Download() {

		setContentType("application/download; utf-8");

	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		File file = (File) model.get("downloadFile");
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());

		String fileName = StringUtil.null2String(model.get("fileName"));

		// 입력받은 파일명이 없는경우
		if ("".equalsIgnoreCase(fileName)) {
			String userAgent = request.getHeader("User-Agent");
			boolean ie = userAgent.indexOf("MSIE") > -1;
			if (ie) {
				fileName = URLEncoder.encode(file.getName(), "utf-8");
			} else {
				fileName = new String(file.getName().getBytes("utf-8"));
			} // end if;
		}

		HttpUtils.setResponseHeaderDownload(request, response, fileName);

		OutputStream out = response.getOutputStream();

		FileInputStream fis = null;

		try {

			fis = new FileInputStream(file);

			FileCopyUtils.copy(fis, out);

		} catch (Exception e) {

			

		} finally {

			if (fis != null) {

				try {
					fis.close();
				} catch (Exception e) {
				}
			}

		} // try end;

		out.flush();

	}// render() end;

}
