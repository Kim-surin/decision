package com.kpmg.kdb.core.procedurelog;

import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// AS-IS 프로시저 1건 실행을 감싸는 공통 골격(batchLog -> 성공 시 END+batchLogLast('N'), 실패 시 에러로그+batchLogLast('E')+재던짐).
// ProcedureLogService 자기호출은 프록시를 우회해 REQUIRES_NEW가 무력화되므로 별도 빈으로 분리했다.
@Service
public class ProcedureLogTemplate {

	@Autowired
	private ProcedureLogService procedureLogService;

	public <T> T runLogged(String procedureId, String companyCode, String inputParameter, Function<Long, T> action) {
		Long logId = procedureLogService.batchLog(procedureId, companyCode, inputParameter);
		try {
			T result = action.apply(logId);
			procedureLogService.batchLogDtl(logId, "***** END " + procedureId);
			procedureLogService.batchLogLast(logId, "N", null, null);
			return result;
		} catch (RuntimeException e) {
			procedureLogService.batchLogDtl(logId, "DBMS 에러가 발생 했습니다 " + e);
			procedureLogService.batchLogLast(logId, "E", "DBMS ERROR", null);
			throw e;
		}
	}
}
