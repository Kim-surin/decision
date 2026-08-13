package com.kpmg.kdb.core.filter;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.nhncorp.lucy.security.xss.XssFilter;

public class RequestWrapper extends HttpServletRequestWrapper {
	private byte[] b;
	private boolean formRequest;

	public RequestWrapper(HttpServletRequest request) throws IOException {
		super(request);
		
		String contentType = request.getContentType();

		formRequest = contentType != null  && (contentType.toLowerCase().startsWith("application/x-www-form-urlencoded")
		            						|| contentType.toLowerCase().startsWith("multipart/form-data") );
		/*
		 * 일반 폼 POST 요청은 Body를 읽지 않음.
		 * 원본 request가 파라미터를 처리하도록 그대로 둠.
		 */
		if (formRequest) {
			b = new byte[0];
			return;
		}

		XssFilter filter = XssFilter.getInstance(
				"lucy-xss-superset-sax.xml",
				true
		);

		String body = getBody(request);
		String filteredBody = filter.doFilter(body);

		b = filteredBody.getBytes(StandardCharsets.UTF_8);
	}

@Override
	public ServletInputStream getInputStream() throws IOException {

		/*
		 * 폼 요청은 원본 요청의 InputStream 사용
		 */
		if (formRequest) {
			return super.getInputStream();
		}

		final ByteArrayInputStream bis = new ByteArrayInputStream(b);

		return new ServletInputStreamImpl(bis);
	}

	@Override
	public BufferedReader getReader() throws IOException {

		if (formRequest) {
			return super.getReader();
		}

		return new BufferedReader(
				new InputStreamReader(
						getInputStream(),
						StandardCharsets.UTF_8
				)
		);
	}

	class ServletInputStreamImpl extends ServletInputStream {

		private final InputStream is;

		public ServletInputStreamImpl(InputStream is) {
			this.is = is;
		}

		@Override
		public int read() throws IOException {
			return is.read();
		}

		@Override
		public int read(byte[] bytes) throws IOException {
			return is.read(bytes);
		}

		@Override
		public boolean isFinished() {
			try {
				return is.available() == 0;
			} catch (IOException e) {
				return true;
			}
		}

		@Override
		public boolean isReady() {
			return true;
		}

		@Override
		public void setReadListener(ReadListener listener) {
			// 동기 방식 사용
		}
	}

	public static String getBody(HttpServletRequest request) throws IOException {

		StringBuilder stringBuilder = new StringBuilder();

		try (
			InputStream inputStream = request.getInputStream();
			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(
							inputStream,
							StandardCharsets.UTF_8
					)
			)
		) {
			char[] charBuffer = new char[128];
			int bytesRead;

			while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
				stringBuilder.append(charBuffer, 0, bytesRead);
			}
		}

		return stringBuilder.toString();
	}
}
