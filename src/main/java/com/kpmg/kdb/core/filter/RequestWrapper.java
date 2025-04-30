package com.kpmg.kdb.core.filter;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.nhncorp.lucy.security.xss.XssFilter;

public class RequestWrapper extends HttpServletRequestWrapper {
	private byte[] b;

	public RequestWrapper(HttpServletRequest request) throws IOException {
		super(request);
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset-sax.xml", true);
		b = new String(filter.doFilter(getBody(request))).getBytes("UTF-8");
	}

	public ServletInputStream getInputStream() throws IOException {
		final ByteArrayInputStream bis = new ByteArrayInputStream(b);
		return new ServletInputStreamImpl(bis);
	}

	class ServletInputStreamImpl extends ServletInputStream {
		private InputStream is;

		public ServletInputStreamImpl(InputStream bis) {
			is = bis;
		}

		public int read() throws IOException {
			return is.read();
		}

		public int read(byte[] b) throws IOException {
			return is.read(b);
		}

		public boolean isFinished() {
			// TODO Auto-generated method stub
			return false;
		}

		public boolean isReady() {
			// TODO Auto-generated method stub
			return false;
		}

		public void setReadListener(ReadListener listener) {
			// TODO Auto-generated method stub
			
		}
	}

	public static String getBody(HttpServletRequest request) throws IOException {
		String body = null;
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = null;
		try {
			InputStream inputStream = request.getInputStream();
			if (inputStream != null) {
				bufferedReader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
				char[] charBuffer = new char[128];
				int bytesRead = -1;
				while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
					stringBuilder.append(charBuffer, 0, bytesRead);
				}
				System.out.println(stringBuilder.toString());
			} else {
				stringBuilder.append("");
			}
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch (IOException ex) {
					throw ex;
				}
			}
		}
		body = stringBuilder.toString();
		return body;
	}
}
