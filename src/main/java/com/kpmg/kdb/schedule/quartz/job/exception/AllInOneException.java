package com.kpmg.kdb.schedule.quartz.job.exception;

import java.text.MessageFormat;

import com.kpmg.kdb.core.extendz.MessageResourceExtends;

public class AllInOneException extends Exception {

	private String locale;

	private static final long serialVersionUID = 7172530507104568224L;

	private Object[] params = null;

	private String formatString = null;

	public AllInOneException() {
		this(null, null, null);
	}

	public AllInOneException(String key) {
		this(key, null, null);
	}

	public AllInOneException(String key, Object[] params) {
		this(key, params, null);
	}

	public AllInOneException(String key, Object param1) {
		this(key, new Object[] { param1 }, null);
	}

	public AllInOneException(String key, Object param1, Object param2) {
		this(key, new Object[] { param1, param2 }, null);
	}

	public AllInOneException(String key, Object param1, Object param2, Object param3) {
		this(key, new Object[] { param1, param2, param3 }, null);
	}

	public AllInOneException(String key, Object param1, Object param2, Object param3, Object param4) {
		this(key, new Object[] { param1, param2, param3, param4 }, null);
	}

	public AllInOneException(String key, Throwable cause) {
		this(key, null, cause);
	}

	public AllInOneException(String key, Object param1, Throwable cause) {
		this(key, new Object[] { param1 }, cause);
	}

	public AllInOneException(String key, Object param1, Object param2, Throwable cause) {
		this(key, new Object[] { param1, param2 }, cause);
	}

	public AllInOneException(String key, Object param1, Object param2, Object param3, Throwable cause) {
		this(key, new Object[] { param1, param2, param3 }, cause);
	}

	public AllInOneException(String key, Object param1, Object param2, Object param3, Object param4, Throwable cause) {
		this(key, new Object[] { param1, param2, param3, param4 }, cause);
	}

	public AllInOneException(String key, Object[] params, Throwable cause) {
		super(key, cause);

		if (key != null) {
			this.params = params;
			this.formatString = MessageResourceExtends.getMessageInstance().getMessage(key); // 메시지
																								// 소스에서
																								// 포맷
																								// 스트링을
																								// 구한다.
		} else {
			this.params = null;
		}
	}

	public Object[] getParams() {
		return (this.params);
	}

	public Object getParam(int idx) {
		if (params == null) {
			return null;
		}

		if (idx < params.length) {
			return params[idx];
		} else {
			return null;
		}
	}

	public void setParams(Object[] params) {
		this.params = params;
	}

	public void setParams(Object param1) {
		this.params = new Object[] { param1 };
	}

	public void setParams(Object param1, Object param2) {
		this.params = new Object[] { param1, param2 };
	}

	public void setParams(Object param1, Object param2, Object param3) {
		this.params = new Object[] { param1, param2, param3 };
	}

	public void setParams(Object param1, Object param2, Object param3, Object param4) {
		this.params = new Object[] { param1, param2, param3, param4 };
	}

	public String getKey() {
		return super.getMessage();
	}

	public String getMessage() {
		String msgString = null;

		if (formatString == null) {
			msgString = getKey();
		} else {
			MessageFormat format = new MessageFormat(formatString);
			msgString = format.format(params);
		}

		return msgString;
	}

	public String toString() {
		String answer = super.toString();

		if (this.getMessage() == null) {
			return answer;
		}

		if (this.params == null) {
			return answer;
		}

		StringBuffer buf = new StringBuffer(answer);

		for (int i = 0; i < this.params.length; ++i) {
			buf.append("\n\t");
			buf.append("param{");
			buf.append(i);
			buf.append("}=");
			buf.append(this.params[i]);
		}
		buf.append("\n\t");
		buf.append("message=");
		buf.append(this.getMessage());

		return buf.toString();
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}
}