package com.kpmg.kdb.core.procedurelog;

import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// AS-IS 프로시저 1건 실행을 감싸는 공통 골격(batchLog로 시작 -> 정상 종료 시 END 로그 + batchLogLast('N'),
// 예외 시 에러 로그 + batchLogLast('E','DBMS ERROR') 후 재던짐). ProcedureLogService 자체에 두지 않고 별도
// 빈으로 분리한 이유는, 같은 클래스 안에서 this로 batchLog/batchLogDtl/batchLogLast를 호출하면 프록시를
// 우회해 그 메서드들의 REQUIRES_NEW가 무력화되기 때문이다(ProcedureLogService의 자기호출 금지 주석 참고).
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
