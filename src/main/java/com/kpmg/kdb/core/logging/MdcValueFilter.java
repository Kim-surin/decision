package com.kpmg.kdb.core.logging;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.filter.Filter;
import ch.qos.logback.core.spi.FilterReply;

/**
 * logback appender용 필터. 로그 이벤트 발생 시점의 MDC에 mdcKey=mdcValue 가 없으면 이 appender로는
 * 내려보내지 않는다(DENY). 특정 실행 흐름(예: 월판정)에서만 별도 파일로 로그를 모으고 싶을 때, 그
 * 흐름의 진입점에서 MDC.put(mdcKey, mdcValue)를 걸어두고(종료 시 MDC.remove) 이 필터를 붙인 appender로
 * 걸러낸다. 다른 로거/appender의 기존 라우팅에는 영향을 주지 않는다(순수 추가용).
 */
public class MdcValueFilter extends Filter<ILoggingEvent> {

	private String mdcKey;
	private String mdcValue;

	@Override
	public FilterReply decide(ILoggingEvent event) {
		if (mdcKey == null || mdcValue == null) {
			return FilterReply.NEUTRAL;
		}
		return mdcValue.equals(event.getMDCPropertyMap().get(mdcKey)) ? FilterReply.NEUTRAL : FilterReply.DENY;
	}

	public void setMdcKey(String mdcKey) {
		this.mdcKey = mdcKey;
	}

	public void setMdcValue(String mdcValue) {
		this.mdcValue = mdcValue;
	}
}
