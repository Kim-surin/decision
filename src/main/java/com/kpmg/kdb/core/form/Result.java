package com.kpmg.kdb.core.form;

public class Result {
	
	private Boolean success;
	private String  message;
	private Object  value;

	public Result() {
		
	}

	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "Result [success=" + success + ", message=" + message
				+ ", value=" + value + "]";
	}


}
